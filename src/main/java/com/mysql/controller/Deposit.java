package com.mysql.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.myatm.dao.AccountDAO;
import com.myatm.model.AccountinfoModel;
import java.io.IOException;

@WebServlet("/deposit")
public class Deposit extends HttpServlet {
    
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
            String result = ad.deposit(account_id, amount);
            if(result.equals("success")) {
            	 double currentBalance = ad.getBalance(account_id);
            	    session.setAttribute("currentBalance", currentBalance);
            	    session.setAttribute("message", "Deposited ₹" + amount + ". New Balance: ₹" + currentBalance);

            } else {
                session.setAttribute("error", "Deposit failed!");
            }

            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("atmsimulator.jsp");
    }
    
    // ✅ ADDED THIS - SERVERS NEED IT
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("atmsimulator.jsp");
    }
}
