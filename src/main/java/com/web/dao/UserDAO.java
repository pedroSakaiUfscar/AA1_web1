package com.web.dao;

import com.web.model.User;
import com.web.bd.AcessaBD;

import java.sql.*;
import com.web.utils.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName(Config.BD_DRIVER);
            return DriverManager.getConnection(Config.DB_URL, Config.DB_USERNAME, Config.DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC não encontrado", e);
        }
    }

    public void insert(User usuario) {
        String sql = "INSERT INTO User (username, email, senha, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, usuario.getUsername());
            statement.setString(2, usuario.getEmail());
            statement.setString(3, usuario.getSenha());
            statement.setString(4, usuario.getRole());
            statement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir usuário: " + e.getMessage(), e);
        }
    }

    public List<User> getAll() {
        List<User> listaUsuarios = new ArrayList<>();
        String sql = "SELECT * from User u";
        try (Connection conn = this.getConnection();
             Statement statement = conn.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                long id = resultSet.getLong("id");
                String username = resultSet.getString("username"); // <-- Ajustado
                String email = resultSet.getString("email");       // <-- Ajustado
                String senha = resultSet.getString("senha");
                String role = resultSet.getString("role");         // <-- Ajustado
                User usuario = new User(id, username, email, senha, role);
                listaUsuarios.add(usuario);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar usuários: " + e.getMessage(), e);
        }
        return listaUsuarios;
    }

    public void delete(User usuario) {
        String sql = "DELETE FROM User where id = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setLong(1, usuario.getId());
            statement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar usuário: " + e.getMessage(), e);
        }
    }

    public void update(User usuario) {
        String sql = "UPDATE User SET username = ?, email = ?, senha = ?, role = ? WHERE id = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, usuario.getUsername());
            statement.setString(2, usuario.getEmail());
            statement.setString(3, usuario.getSenha());
            statement.setString(4, usuario.getRole());
            statement.setLong(5, usuario.getId());
            statement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar usuário: " + e.getMessage(), e);
        }
    }

    public User getbyID(Long id) {
        User usuario = null;
        String sql = "SELECT * from User WHERE id = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setLong(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String username = resultSet.getString("username");
                    String email = resultSet.getString("email");
                    String senha = resultSet.getString("senha");
                    String role = resultSet.getString("role");
                    usuario = new User(id, username, email, senha, role);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar por ID: " + e.getMessage(), e);
        }
        return usuario;
    }

    public User getbyEmail(String email) {
        User usuario = null;
        String sql = "SELECT * from User WHERE email = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Long id = resultSet.getLong("id");
                    String username = resultSet.getString("username");
                    String senha = resultSet.getString("senha");
                    String role = resultSet.getString("role");
                    usuario = new User(id, username, email, senha, role);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar por Email: " + e.getMessage(), e);
        }
        return usuario;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM User WHERE email = ?";
        try (Connection conn = this.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao verificar email existente: " + e.getMessage(), e);
        }
        return false;
    }

}