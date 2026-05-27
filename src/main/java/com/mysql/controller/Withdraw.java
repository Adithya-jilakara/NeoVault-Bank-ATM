package com.mysql.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.myatm.dao.AccountDAO;
import com.myatm.model.AccountinfoModel;
import java.io.IOException;

@WebServlet("/withdraw")
public class Withdraw extends HttpServlet {

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
            String result = ad.withdraw(account_id, amount);

            if (result.equals("success")) {
                double currentBalance = ad.getBalance(account_id);

                session.setAttribute("currentBalance", currentBalance);
                session.setAttribute("message", "₹" + amount + " Withdrawn Successfully");
                session.setAttribute("activeScreen", "withdrawScreen");

            } else if (result.equals("insufficient")) {
                session.setAttribute("error", "Insufficient balance!");
                session.setAttribute("activeScreen", "withdrawScreen");

            } else {
                session.setAttribute("error", "Withdraw failed!");
                session.setAttribute("activeScreen", "withdrawScreen");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Invalid amount!");
            session.setAttribute("activeScreen", "withdrawScreen");
        }

        response.sendRedirect("atmsimulator.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("atmsimulator.jsp");
    }
}