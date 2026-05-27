package com.mysql.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.myatm.dao.AccountDAO;
import com.myatm.model.AccountinfoModel;
import java.io.IOException;

@WebServlet("/balance")
public class Balance extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        AccountinfoModel user =
                (AccountinfoModel) session.getAttribute("currentUser");

        if (user == null) {
            response.sendRedirect("atmpin.jsp");
            return;
        }

        AccountDAO ad = new AccountDAO();
        double currentBalance = ad.getBalance(user.getAccount_id());

        session.setAttribute("currentBalance", currentBalance);
        session.setAttribute("activeScreen", "balanceScreen");

        response.sendRedirect("atmsimulator.jsp");
    }
}