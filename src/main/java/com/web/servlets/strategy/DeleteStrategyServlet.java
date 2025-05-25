package com.web.servlets.strategy;

import com.web.dao.StrategyDAO;
import com.web.utils.Routes;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = { Routes.STRATEGY_DELETE_ROUTE })
public class DeleteStrategyServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            long id = Long.parseLong(idParam);

            StrategyDAO dao = new StrategyDAO();
            dao.deleteById(id);

            response.sendRedirect(request.getContextPath() + Routes.STRATEGIES_LIST_ROUTE);

        } catch (Exception e) {
            throw new RuntimeException("Erro ao deletar estratégia", e);
        }
    }
}
