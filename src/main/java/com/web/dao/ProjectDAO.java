package com.web.dao;

import com.web.model.Project;
import com.web.utils.Config;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName(Config.BD_DRIVER);
            return DriverManager.getConnection(Config.DB_URL, Config.DB_USERNAME, Config.DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC não encontrado", e);
        }
    }

    public List<Project> getAll() {
        return getAllByQuery("SELECT * from Project");
    }

    public List<Project> getAllSortedByName() throws SQLException {
        return getAllByQuery("SELECT * FROM Project ORDER BY name ASC");
    }

    public List<Project> getAllSortedByDate() throws SQLException {
        return getAllByQuery("SELECT * FROM Project ORDER BY date ASC");

    }

    private List<Project> getAllByQuery(String sql) {
        List<Project> listProjects = new ArrayList<>();
        try (Connection conn = this.getConnection();
             Statement statement = conn.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                long id = resultSet.getLong("id");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                java.sql.Date date = resultSet.getDate("date");
                Project project = new Project(id, name, description, date);
                listProjects.add(project);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar projetos: " + e.getMessage(), e);
        }
        return listProjects;
    }

    public boolean isUserAssociatedWithProject(long userId, long projectId) {
        String sql = "SELECT COUNT(*) FROM ProjectUser WHERE usuario_id = ? AND projeto_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            stmt.setLong(2, projectId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
