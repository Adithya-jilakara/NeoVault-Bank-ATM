package com.myatm.dao;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.myatmDB.utility.DBConnection;
import com.myatm.model.AccountinfoModel;

public class AccountDAO implements DAOInterface{
	
	Connection con=null;
	
	@Override
	
	public int createaccount(AccountinfoModel a) {
		
         try {
			
			DBConnection d=new DBConnection();
			con=d.getConnection();
			con.setAutoCommit(false); // "Wait, don't save anything yet"
			
			
			
			// STEP 1: Insert account → get ID and INSERT account  // Step 1 (not saved yet)
			PreparedStatement p1=con.prepareStatement("insert into accountinfo (firstname,lastname,username,pin) values(?,?,?,?)",  Statement.RETURN_GENERATED_KEYS);
			
			
			
			  /*WITHOUT RETURN_GENERATED_KEYS:
				INSERT accountinfo           // MySQL creates ID=5 secretly
				?account_id = ???           // YOU DON'T KNOW! 

				WITH RETURN_GENERATED_KEYS:
				INSERT accountinfo           // MySQL creates ID=5
				pstmt.getGeneratedKeys()    // MySQL: "Hey, I created ID=5!"*/
			
			p1.setString(1, a.getFirstname());
			p1.setString(2, a.getLastname());
			p1.setString(3, a.getUsername());
			p1.setString(4, a.getPin());

	        int rows = p1.executeUpdate();
	        if (rows == 0) return -1;
	        
	        
	        
	        // STEP 2: Get generated account_id // Step 2 (not saved yet) 
	        ResultSet rs=p1.getGeneratedKeys();
	        int account_id=0;
	        if(rs.next()) {
	        	account_id=rs.getInt(1);
	        }
	        
	        // STEP 3: Insert first transaction (balance=0)
	        PreparedStatement p2=con.prepareStatement("insert into transactioninfo (account_id,balance) values(?,0.00)");
	        p2.setInt(1,account_id);
	        p2.executeUpdate();  
	        
	        con.commit();
	        return account_id; 
	        
		}
		
		
		catch(Exception e) {
			System.out.println(e);
		}
		return 0;
		
		
		
	}
	
	
	
	@Override
	public AccountinfoModel findaccount(String pin) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
	    	DBConnection d=new DBConnection();
			con=d.getConnection();
	        
	        
	       
	        ps = con.prepareStatement("SELECT * FROM accountinfo WHERE pin = ?");
	        ps.setString(1, pin);  
	        
	        rs = ps.executeQuery();
	        
	        if(rs.next()) {
	            AccountinfoModel user = new AccountinfoModel();
	            user.setAccount_id(rs.getInt("account_id"));
	            user.setFirstname(rs.getString("firstname"));
	            user.setLastname(rs.getString("lastname"));
	            user.setUsername(rs.getString("username"));
	            user.setPin(rs.getString("pin"));
	            return user;
	        }
	        
	    } catch(Exception e) {
	        System.out.println("Find account error: " + e.getMessage());
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(ps != null) ps.close();
	            if(con != null) con.close();
	        } catch(Exception e) {}
	    }
	    
	    return null;
	}



	@Override
	public String deposit(int account_id, int amount) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    String result = "fail";
	    
	    try {
	        DBConnection d = new DBConnection();
	        con = d.getConnection();
	        con.setAutoCommit(false);
	        
	        // ✅ Get LATEST balance using transaction_id (your PK)
	        ps = con.prepareStatement("SELECT balance FROM transactioninfo WHERE account_id = ? ORDER BY transaction_id DESC LIMIT 1");
	        ps.setInt(1, account_id);
	        ResultSet rs = ps.executeQuery();
	        
	        double currentBalance = 0.0;
	        if(rs.next()) {
	            currentBalance = rs.getDouble("balance");
	        }
	        rs.close();
	        ps.close();
	        
	        // ✅ INSERT new balance row
	        double newBalance = currentBalance + amount;
	        ps = con.prepareStatement("INSERT INTO transactioninfo (account_id, balance) VALUES (?, ?)");
	        ps.setInt(1, account_id);
	        ps.setDouble(2, newBalance);
	        
	        int val = ps.executeUpdate();
	        con.commit();
	        
	        if(val > 0) {
	            result = "success";
	        }
	        
	    } catch(Exception e) {
	        System.out.println("Deposit error: " + e.getMessage());
	        try { if(con != null) con.rollback(); } catch(Exception ex) {}
	    } finally {
	        try { 
	            if(ps != null) ps.close(); 
	            if(con != null) con.close(); 
	        } catch(Exception e) {}
	    }
	    return result;
	}

	@Override
	public String withdraw(int account_id, int amount) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    String result = "fail";
	    
	    try {
	        DBConnection d = new DBConnection();
	        con = d.getConnection();
	        con.setAutoCommit(false);
	        
	        // ✅ Get LATEST balance using transaction_id (your PK)
	        ps = con.prepareStatement("SELECT balance FROM transactioninfo WHERE account_id = ? ORDER BY transaction_id DESC LIMIT 1");
	        ps.setInt(1, account_id);
	        ResultSet rs = ps.executeQuery();
	        
	        double currentBalance = 0.0;
	        if(rs.next()) {
	            currentBalance = rs.getDouble("balance");
	        }
	        rs.close();
	        ps.close();
	        
	        // ✅ Check funds + INSERT new balance
	        if(currentBalance >= amount && amount >= 100) {
	            double newBalance = currentBalance - amount;
	            ps = con.prepareStatement("INSERT INTO transactioninfo (account_id, balance) VALUES (?, ?)");
	            ps.setInt(1, account_id);
	            ps.setDouble(2, newBalance);
	            
	            int val = ps.executeUpdate();
	            con.commit();
	            
	            if(val > 0) {
	                result = "success";
	            } else {
	                result = "fail";
	            }
	        } else {
	            result = "insufficient";
	        }
	        
	    } catch(Exception e) {
	        System.out.println("Withdraw error: " + e.getMessage());
	        try { if(con != null) con.rollback(); } catch(Exception ex) {}
	    } finally {
	        try { 
	            if(ps != null) ps.close(); 
	            if(con != null) con.close(); 
	        } catch(Exception e) {}
	    }
	    return result;
	}



	@Override
	public boolean changepin(int account_id, String oldpin, String newpin) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    
	    try {
	        DBConnection d = new DBConnection();
	        con = d.getConnection();
	        ps = con.prepareStatement("UPDATE accountinfo SET pin = ? WHERE account_id = ? AND pin = ?");
	        ps.setString(1, newpin);
	        ps.setInt(2, account_id);
	        ps.setString(3, oldpin);
	        
	        int result = ps.executeUpdate();
	        return result > 0;  // Returns true if row updated
	        
	    } catch (Exception e) {
	        System.out.println("Change PIN Error: " + e.getMessage());
	        return false;
	    } finally {
	        // CLEANUP - Very important!
	        try {
	            if (ps != null) ps.close();
	            if (con != null) con.close();
	        } catch (Exception e) {
	            System.out.println("Close error: " + e.getMessage());
	        }
	    }
	}


	@Override
	public double getBalance(int account_id) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    double balance = 0.0;
	    
	    try {
	        DBConnection d = new DBConnection();
	        con = d.getConnection();
	        
	        // ✅ Same query as deposit/withdraw - gets LATEST balance
	        ps = con.prepareStatement("SELECT balance FROM transactioninfo WHERE account_id = ? ORDER BY transaction_id DESC LIMIT 1");
	        ps.setInt(1, account_id);
	        rs = ps.executeQuery();
	        
	        if(rs.next()) {
	            balance = rs.getDouble("balance");
	        }
	        
	    } catch(Exception e) {
	        System.out.println("Get balance error: " + e.getMessage());
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(ps != null) ps.close();
	            if(con != null) con.close();
	        } catch(Exception e) {}
	    }
	    return balance;
	}






	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
