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

@WebServlet("/changepin")
public class Changepin extends HttpServlet {
	//private static final long serialVersionUID = 1L;

	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    HttpSession session = request.getSession();
	    
	    // ✅ GET FROM currentUser (you ALREADY have this!)
	    AccountinfoModel user = (AccountinfoModel) session.getAttribute("currentUser");
	    if(user == null) {
	        request.setAttribute("error", "Please login first!");
	        request.getRequestDispatcher("atmpin.jsp").forward(request, response);
	        return;
	    }
	    
	    int accountId = user.getAccount_id();  // Get from your model!
	    
	    String oldPin = request.getParameter("oldPin");
	    String newPin = request.getParameter("newPin");
	    
	    AccountDAO dao = new AccountDAO();
	    boolean success = dao.changepin(accountId, oldPin, newPin);
	    
	    request.setAttribute("message", success ? "PIN changed successfully!" : "Wrong old PIN!");
	    request.getRequestDispatcher("atmsimulator.jsp").forward(request, response);
	}


}
