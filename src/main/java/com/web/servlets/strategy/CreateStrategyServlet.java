package com.web.servlets.strategy;

import com.web.utils.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "CreateStrategyServlet", urlPatterns = {Routes.CREATE_STRATEGY_ROUTE})
public class CreateStrategyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/session_pages/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get Strategy infos:
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String examples = request.getParameter("examples");
        String tips = request.getParameter("tips");
        String images = request.getParameter("images");

        try {
            // Connect to bd:
            Class.forName(Config.BD_DRIVER);
            Connection con = DriverManager.getConnection(Config.DB_URL, Config.DB_USERNAME, Config.DB_PASSWORD);

            // Execute the insert:
            String sql = "INSERT INTO Strategy (name, description, examples, tips, images) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setString(3, examples);
            stmt.setString(4, tips);
            stmt.setString(5, images);
            stmt.executeUpdate();

            stmt.close();
            con.close();

            // Redirect back to strategies list
            response.sendRedirect(request.getContextPath() + "/strategies");
        } catch (ClassNotFoundException e) {
            System.out.println("Erro ao carregar o driver JDBC!");
        } catch (SQLException e) {
            System.out.println("Erro ao executar a operação no BD!");
        }
    }
}