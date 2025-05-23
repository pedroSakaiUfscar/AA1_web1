package com.web.servlets.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Locale;

@WebServlet(name = "ChangeLanguageServlet", urlPatterns = {"/setLocale"})
public class ChangeLanguageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String langParam = request.getParameter("lang");
        Locale locale;

        locale = switch (langParam) {
            case "en_US" -> new Locale("en", "US");
            default -> new Locale("pt", "BR");
        };

        request.getSession().setAttribute("locale", locale);
        response.setLocale(locale);
        response.sendRedirect(request.getContextPath() + "/");
    }
}
