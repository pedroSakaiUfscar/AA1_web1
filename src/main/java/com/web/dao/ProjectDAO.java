package com.web.dao;

import com.web.bd.AcessaBD;
import com.web.model.Project;
import com.web.utils.Config;

import java.sql.*;
import java.time.LocalDate;
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

    // New method to get projects associated with a user
    public List<Project> getAssociatedProjects(long userId) {
        List<Project> listProjects = new ArrayList<>();
        // SQL JOIN between Project and ProjectUser tables
        String sql = "SELECT p.* FROM Project p JOIN ProjectUser pu ON p.id = pu.projeto_id WHERE pu.usuario_id = ? ORDER BY p.name ASC";
        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setLong(1, userId); // Set the user ID parameter
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    long id = resultSet.getLong("id");
                    String name = resultSet.getString("name");
                    String description = resultSet.getString("description");
                    java.sql.Date date = resultSet.getDate("date");
                    Project project = new Project(id, name, description, date);
                    listProjects.add(project);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar projetos associados: " + e.getMessage(), e);
        }
        return listProjects;
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

    public void insert(Project project, String[] usersIds) {
        String sql = "INSERT INTO Project (name, description, date) VALUES (?, ?, ?)";

        try (Connection con = AcessaBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, project.getName());
            stmt.setString(2, project.getDescription());
            stmt.setDate(3, Date.valueOf(LocalDate.now()));

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        long projectId = generatedKeys.getLong(1);
                        project.setId(projectId);
                    }
                } catch (Exception e) {
                    throw new RuntimeException("erro custom", e);
                }

                if (usersIds != null) {
                    for (String userId : usersIds) {
                        associateUser(project, userId);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir projeto", e);
        }
    }

    public void associateUser(Project project, String userId) {
        String sql = "INSERT INTO ProjectUser (projeto_id, usuario_id) VALUES (?, ?)";

        try (Connection con = AcessaBD.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setLong(1, project.getId());
            stmt.setLong(2, Long.parseLong(userId));

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao associar usuario com projeto", e);
        }
    }
}