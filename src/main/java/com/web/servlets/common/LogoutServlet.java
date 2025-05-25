package com.web.servlets.common;

import com.web.dao.UserDAO;
import com.web.model.User;

import com.web.utils.Routes;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Locale;

import com.web.utils.Error;


@WebServlet("/logout") // Mesma URL usada no header.jsp
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalida a sessão atual
        request.getSession().invalidate();

        // Redireciona para a página de login
        response.sendRedirect(request.getContextPath() + Routes.LOGIN_ROUTE); // Use sua rota de login
    }
}