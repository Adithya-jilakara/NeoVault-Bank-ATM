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

@WebServlet("/AtmSimulator")
public class AtmSimulator extends HttpServlet {
	//private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		 String pin = request.getParameter("pin");
	        AccountDAO dao = new AccountDAO();
	        AccountinfoModel user = dao.findaccount(pin);
	        System.out.println("PIN: '" + pin + "' → User: " + (user != null ? user.getFirstname() : "NULL"));
	        if(user != null) {
	            HttpSession session = request.getSession();
	            session.setAttribute("currentUser", user);
	            System.out.println("Session set: " + session.getId());
	            response.sendRedirect("atmsimulator.jsp");
	        } else {
	            System.out.println("Redirect to PIN - no user");
	            response.sendRedirect("atmpin.jsp");
	        }

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}
