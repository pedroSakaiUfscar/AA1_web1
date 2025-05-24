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


@WebServlet(urlPatterns = { Routes.LOGIN_ROUTE })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("locale") == null) {
            request.getSession().setAttribute("locale", new Locale("pt", "BR"));
        }

        Error error = new Error();
        if (request.getParameter("bOK") != null) {
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            if (email == null || email.isEmpty()) {
                error.add("Email não informado!");
            }
            if (senha == null || senha.isEmpty()) {
                error.add("Senha não informada!");
            }

            if (!error.isExisteErros()) {
                UserDAO dao = new UserDAO();
                User usuario = dao.getbyEmail(email);

                if (usuario != null) {
                    if (usuario.getSenha().equals(senha)) {
                        request.getSession().setAttribute("loggedUser", usuario);
                        String contextPath = request.getContextPath();

                        response.sendRedirect(contextPath + Routes.INITIAL_ROUTE);

                        return;
                    } else {
                        error.add("Senha inválida!");
                    }
                } else {
                    error.add("E-mail não encontrado!");
                }
            }
        }
        request.setAttribute("mensagens", error);
        String URL = "/WEB-INF/views/common_pages/users/authentication/login.jsp";
        RequestDispatcher rd = request.getRequestDispatcher(URL);
        rd.forward(request, response);
    }
}