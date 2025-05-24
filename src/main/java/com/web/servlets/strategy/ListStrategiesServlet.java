package com.web.servlets.strategy;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.web.model.Strategy;
import com.web.utils.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { Routes.STRATEGIES_LIST_ROUTE })
public class ListStrategiesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        Statement stmt = null;
        ResultSet strategyQuery = null;

        try {
            // Connect to bd:
            Class.forName(Config.BD_DRIVER);
            con = DriverManager.getConnection(Config.DB_URL, Config.DB_USERNAME, Config.DB_PASSWORD);

            // Execute select:
            stmt = con.createStatement();
            strategyQuery = stmt.executeQuery("SELECT * FROM Strategy");

            // Create a list with every line of the select result:
            List<Strategy> strategies = new ArrayList<>();
            while (strategyQuery.next()) {
                long id = strategyQuery.getLong("id");
                String name = strategyQuery.getString("name");
                String description = strategyQuery.getString("description");
                String examples = strategyQuery.getString("examples");
                String tips = strategyQuery.getString("tips");
                String images = strategyQuery.getString("images");

                strategies.add(new Strategy(id, name, description, examples, tips, images));
            }

            // Set the list as attribute and redirect to strategies list
            request.setAttribute("strategies", strategies);
            request.getRequestDispatcher("/WEB-INF/views/strategy_pages/list.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            System.out.println("A classe do driver de conexão não foi encontrada!");
        } catch (SQLException e) {
            System.out.println("O comando SQL não pode ser executado!");
        } finally {
            // Close bd:
            try {
                if (strategyQuery != null) strategyQuery.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Erro ao fechar os recursos!");
            }
        }
    }
}