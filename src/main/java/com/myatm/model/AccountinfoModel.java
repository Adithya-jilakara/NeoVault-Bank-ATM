package com.myatm.model;

public class AccountinfoModel {
	
	private int  account_id;
	private String firstname;
	private String lastname;
	private String username;
	private String pin;
	
	
	public AccountinfoModel() {
		
	}
	
	public AccountinfoModel(int account_id, String firstname, String lastname, String username, String pin) {
		
		this.account_id = account_id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.username = username;
		this.pin = pin;
	}

	public int getAccount_id() {
		return account_id;
	}

	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPin() {
		return pin;
	}

	public void setPin(String pin) {
		this.pin = pin;
	}

	@Override
	public String toString() {
		return "AccountinfoModel [account_id=" + account_id + ", firstname=" + firstname + ", lastname=" + lastname
				+ ", username=" + username + ", pin=" + pin + "]";
	}
	
	
	
	

}
