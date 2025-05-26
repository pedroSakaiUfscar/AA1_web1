package com.web.servlets.admin;

import com.web.model.User;
import com.web.dao.UserDAO;
import com.web.utils.Routes;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(Routes.DELETE_USER_ROUTE)
public class DeleteUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        User loggedUser = (User) request.getSession().getAttribute("loggedUser");
        if (loggedUser == null || !"ADMIN".equals(loggedUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String errorType = "";
        try {
            long userId = Long.parseLong(request.getParameter("userId"));
            userDAO.delete(userId);
            session.setAttribute("message", "User deleted successfully");
            response.sendRedirect(request.getContextPath() + "/list-users");
            return;
        } catch (RuntimeException e) {
            errorType = "?errorType=DELETE";
        }

        response.sendRedirect(request.getContextPath() + "/list-users" + errorType);
    }
}