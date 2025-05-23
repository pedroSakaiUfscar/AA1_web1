package com.web.servlets.common;

import com.web.utils.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Locale;

@WebServlet(urlPatterns = {Routes.INITIAL_ROUTE})
public class MainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("locale") == null) {
            request.getSession().setAttribute("locale", new Locale("pt", "BR"));
        }

        request.getRequestDispatcher("/WEB-INF/views/common_pages/initial_page.jsp").forward(request, response);
    }
}
