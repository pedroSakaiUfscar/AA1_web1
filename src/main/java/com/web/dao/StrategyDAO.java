package com.web.dao;

import com.web.model.Strategy;
import com.web.model.User;
import com.web.utils.Config;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StrategyDAO {
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName(Config.BD_DRIVER);
            return DriverManager.getConnection(Config.DB_URL, Config.DB_USERNAME, Config.DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC não encontrado", e);
        }
    }

    public List<Strategy> getAll() {
        List<Strategy> strategies = new ArrayList<>();
        String sql = "SELECT * from Strategy";
        try (Connection conn = this.getConnection();
             Statement statement = conn.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                long id = resultSet.getLong("id");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                String examples = resultSet.getString("examples");
                String tips = resultSet.getString("tips");
                String images = resultSet.getString("images");

                strategies.add(new Strategy(id, name, description, examples, tips, images));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar estratégias: " + e.getMessage(), e);
        }
        return strategies;
    }

    public boolean deleteById(long id) {
        String sql = "DELETE FROM Strategy WHERE id = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            int rowsAffected = stmt.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar estratégia: " + e.getMessage(), e);
        }
    }

    public Strategy getById(long id) {
        String sql = "SELECT * FROM Strategy WHERE id = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    String name = resultSet.getString("name");
                    String description = resultSet.getString("description");
                    String examples = resultSet.getString("examples");
                    String tips = resultSet.getString("tips");
                    String images = resultSet.getString("images");

                    return new Strategy(id, name, description, examples, tips, images);
                } else {
                    return null;  // Não encontrado
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar estratégia: " + e.getMessage(), e);
        }
    }

}
