package com.web.servlets.strategy;

import java.io.IOException;
import java.util.List;

import com.web.dao.StrategyDAO;
import com.web.model.Strategy;
import com.web.utils.*;
import com.web.utils.Error;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { Routes.STRATEGIES_LIST_ROUTE })
public class ListStrategiesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            StrategyDAO dao = new StrategyDAO();
            List<Strategy> strategies = dao.getAll();

            request.setAttribute("strategies", strategies);

            Error error = new Error();
            String errorType = request.getParameter("errorType");
            if (errorType != null && errorType.equals("DELETE")) {
                error.add(errorType);
                request.getSession().setAttribute("mensagens", error);
            } else {
                request.getSession().setAttribute("mensagens", null);
            }

            request.getRequestDispatcher("/WEB-INF/views/strategy_pages/list.jsp").forward(request, response);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}