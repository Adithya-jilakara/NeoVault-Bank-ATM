package com.mysql.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.myatm.dao.AccountDAO;
import com.myatm.model.AccountinfoModel;


@WebServlet("/withdraw")
public class Withdraw extends HttpServlet {
	//private static final long serialVersionUID = 1L;
   
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    try {
	        String amt = request.getParameter("amount");
	        int amount = Integer.parseInt(amt);
	        
	        HttpSession session = request.getSession();
	        AccountinfoModel user = (AccountinfoModel) session.getAttribute("currentUser");
	        if(user == null) {
	            response.sendRedirect("atmpin.jsp");
	            return;
	        }
	        
	        int account_id = user.getAccount_id();
	        AccountDAO ad = new AccountDAO();
	        String result = ad.withdraw(account_id, amount);
	        if(result.equals("success")) {
	            // Update session balance (load latest from DB for accuracy)
	            Double currentBalance = getLatestBalance(account_id, session);  // Implement helper below
	            session.setAttribute("message", "Withdrawn ₹" + amount + ". New Balance: ₹" + currentBalance);
	        } else {
	            session.setAttribute("error", result.equals("insufficient") ? "Insufficient balance (min ₹100)!" : "Withdraw failed!");
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	        request.getSession().setAttribute("error", "Invalid amount!");
	    }
	    
	    response.sendRedirect("atmsimulator.jsp");
	}

	private Double getLatestBalance(int account_id, HttpSession session) {
	    AccountDAO ad = new AccountDAO();
	    // Reuse your DAO logic or add getBalance method to return latest balance
	    // For now, query DB as in deposit/withdraw
	    return 0.0;  // Replace with actual query
	}

}
