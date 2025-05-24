package com.web.servlets.common; // Seu pacote de servlets

import com.web.utils.Routes;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = { Routes.ACCESS_DENIED_ROUTE }) // Mapeie este servlet para uma URL pública, por exemplo, "/noAuth"
public class NoAuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // O caminho para o JSP *dentro* de WEB-INF
        String URL_NOAUTH_JSP = "/WEB-INF/views/common_pages/users/authentication/noAuth.jsp";
        RequestDispatcher rd = request.getRequestDispatcher(URL_NOAUTH_JSP);
        rd.forward(request, response); // Encaminha internamente para o JSP
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Permite que POSTs também sejam tratados
    }
}