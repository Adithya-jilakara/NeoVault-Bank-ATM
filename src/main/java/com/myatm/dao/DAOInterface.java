package com.myatm.dao;

import com.myatm.model.AccountinfoModel;

public interface DAOInterface {
	
	
	public int createaccount(AccountinfoModel a);
	public AccountinfoModel findaccount(String pin);
	public String withdraw(int account_id,int amount);
	public String deposit(int account_id,int amount);
	public boolean changepin(int account_id,String oldpin,String newpin);
	public double getBalance(int account_id);
	
	
	
	
	
	

}
