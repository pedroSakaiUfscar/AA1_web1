package com.web.servlets.admin;

import com.web.model.User;
import com.web.dao.UserDAO;
import com.web.utils.Routes;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { Routes.LIST_USERS_ROUTE })
public class ListUsersServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<User> users = userDAO.getAll();

            request.setAttribute("users", users);

//            response.setContentType("text/html;charset=UTF-8");

            request.getRequestDispatcher("/WEB-INF/views/admin/listUsers.jsp").forward(request, response);

        } catch (Exception e) {
            log("Erro ao listar usuários", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Ocorreu um erro ao carregar a lista de usuários");
        }
    }
}
