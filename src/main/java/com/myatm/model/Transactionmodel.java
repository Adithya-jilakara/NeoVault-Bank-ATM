package com.myatm.model;

public class Transactionmodel {
	private int  transaction_id;
	private int account_id;
	private double balance;
	
	public Transactionmodel() {
		
	}
	public Transactionmodel(int transaction_id, int account_id, double balance) {
		super();
		this.transaction_id = transaction_id;
		this.account_id = account_id;
		this.balance = balance;
	}
	public int getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}
	public int getAccount_id() {
		return account_id;
	}
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	@Override
	public String toString() {
		return "Transactionmodel [transaction_id=" + transaction_id + ", account_id=" + account_id + ", balance="
				+ balance + "]";
	}
	
	
	
	
	

}
