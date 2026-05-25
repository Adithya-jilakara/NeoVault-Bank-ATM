package com.mysql.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.myatm.dao.AccountDAO;
import com.myatm.model.AccountinfoModel;

@WebServlet("/CreateAccount")
public class CreateAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CreateAccount() {
     
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//Retrieving the values which user entered in web page of index.html
		String firstname=request.getParameter("firstname");
		String lastname=request.getParameter("lastname");
		String username=request.getParameter("username");
		String pin=request.getParameter("pin");
		System.out.println("users data :"+firstname+":"+lastname+":"+username+":"+"pin");
		
		 // Basic validation
	    if(firstname.isEmpty() || lastname.isEmpty() || username.isEmpty() || 
	       pin == null || pin.length() != 4) {
	        request.setAttribute("message", "All fields required. PIN must be 4 digits.");
	        request.setAttribute("status", "error");
	        request.getRequestDispatcher("index.jsp").forward(request, response);
	        return;
	    }
		
		//model object  creation to insert values of F.E---->model class
		AccountinfoModel a=new AccountinfoModel();
		a.setFirstname(firstname);
		a.setLastname(lastname);
		a.setUsername(username);
		a.setPin(pin);
		System.out.println(a);
		
		//calling DAO
		AccountDAO ad=new AccountDAO();
		int result=ad.createaccount(a);
		
		
        if(result>0) {
			
        	 request.setAttribute("message", "Account created successfully!");
             request.setAttribute("status", "success");
			
		}
		else {
			request.setAttribute("message", "Username may already exist. Try another.");
	        request.setAttribute("status", "error");
			
			
		}
		
		
        request.getRequestDispatcher("index.jsp").forward(request, response);
		
		
		
		
		
		
		
	}

}
