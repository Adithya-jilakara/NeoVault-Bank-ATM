package com.mysql.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.myatm.dao.AccountDAO;
import com.myatm.model.AccountinfoModel;
import java.io.IOException;

@WebServlet("/deposit")
public class Deposit extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            int amount = Integer.parseInt(request.getParameter("amount"));

            AccountinfoModel user = (AccountinfoModel) session.getAttribute("currentUser");

            if (user == null) {
                response.sendRedirect("atmpin.jsp");
                return;
            }

            int account_id = user.getAccount_id();

            AccountDAO ad = new AccountDAO();
            String result = ad.deposit(account_id, amount);

            if (result.equals("success")) {
                double currentBalance = ad.getBalance(account_id);

                session.setAttribute("currentBalance", currentBalance);
                session.setAttribute("message", "₹" + amount + " Deposited Successfully");
                session.setAttribute("activeScreen", "depositScreen");
            } else {
                session.setAttribute("error", "Deposit failed!");
                session.setAttribute("activeScreen", "depositScreen");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Invalid amount!");
            session.setAttribute("activeScreen", "depositScreen");
        }

        response.sendRedirect("atmsimulator.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("atmsimulator.jsp");
    }
}