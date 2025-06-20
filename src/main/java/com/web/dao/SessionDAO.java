package com.web.dao;

import com.web.model.TestSession;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.web.bd.AcessaBD;
import com.web.model.TestSessionStatus;

public class SessionDAO {

    public void insert(TestSession session) {
        String sql = "INSERT INTO TestSession (testerName, userId, strategyId, projetoId, duration, description, status, creationDateTime, startDateTime, finishDateTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = AcessaBD.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, session.getTesterName());
            stmt.setLong(2, session.getUserId());
            stmt.setLong(3, session.getStrategyId());
            stmt.setLong(4, session.getProjetoId());
            stmt.setInt(5, session.getDuration());
            stmt.setString(6, session.getDescription());
            stmt.setString(7, session.getStatus().name());
            stmt.setTimestamp(8, Timestamp.valueOf(session.getCreationDateTime()));
            stmt.setTimestamp(9, session.getStartDateTime() != null ? Timestamp.valueOf(session.getStartDateTime()) : null);
            stmt.setTimestamp(10, session.getFinishDateTime() != null ? Timestamp.valueOf(session.getFinishDateTime()) : null);

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir TestSession", e);
        }
    }

    public List<TestSession> getAllbyProjectID(int id) {
        List<TestSession> listSessions = new ArrayList<>();

        String sql = "SELECT * FROM TestSession WHERE projetoId = ? ORDER BY id";

        try (Connection con = AcessaBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet resultSet = stmt.executeQuery()) {
                while (resultSet.next()) {
                    long id_session = resultSet.getLong("id");
                    String testerName = resultSet.getString("testerName");
                    long userId = resultSet.getLong("userId");
                    long strategyId = resultSet.getLong("strategyId");
                    long projetoId = resultSet.getLong("projetoId");
                    int duration = resultSet.getInt("duration");
                    String description = resultSet.getString("description");
                    String statusStr = resultSet.getString("status");
                    Timestamp creationTimestamp = resultSet.getTimestamp("creationDateTime");
                    Timestamp startTimestamp = resultSet.getTimestamp("startDateTime");
                    Timestamp finishTimestamp = resultSet.getTimestamp("finishDateTime");

                    TestSessionStatus status = TestSessionStatus.valueOf(statusStr);

                    TestSession session = new TestSession(
                            id_session,
                            testerName,
                            userId,
                            strategyId,
                            projetoId,
                            duration,
                            description,
                            status,
                            creationTimestamp != null ? creationTimestamp.toLocalDateTime() : null,
                            startTimestamp != null ? startTimestamp.toLocalDateTime() : null,
                            finishTimestamp != null ? finishTimestamp.toLocalDateTime() : null
                    );

                    listSessions.add(session);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar TestSessions", e);
        }

        return listSessions;
    }
    public void updateStart(long sessionId, LocalDateTime startDateTime, TestSessionStatus status) {
        String sql = "UPDATE TestSession SET startDateTime = ?, status = ? WHERE id = ?";

        try (Connection con = AcessaBD.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.valueOf(startDateTime));
            stmt.setString(2, status.name());
            stmt.setLong(3, sessionId);

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar startDateTime da TestSession", e);
        }
    }
    public void updateFinish(long sessionId, LocalDateTime finishDateTime, TestSessionStatus status) {
        String sql = "UPDATE TestSession SET finishDateTime = ?, status = ? WHERE id = ?";

        try (Connection con = AcessaBD.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.valueOf(finishDateTime));
            stmt.setString(2, status.name());
            stmt.setLong(3, sessionId);

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar finishDateTime da TestSession", e);
        }
    }

    public void updateExpiredSessionsByProject(long projectId) {
        String selectSql = "SELECT id, creationDateTime, duration, status FROM TestSession WHERE projetoId = ? AND status != ?";

        try (Connection con = AcessaBD.getConnection();
             PreparedStatement selectStmt = con.prepareStatement(selectSql)) {

            selectStmt.setLong(1, projectId);
            selectStmt.setString(2, TestSessionStatus.FINISHED.name());

            ResultSet rs = selectStmt.executeQuery();

            while (rs.next()) {
                long sessionId = rs.getLong("id");
                LocalDateTime creationDateTime = rs.getTimestamp("creationDateTime").toLocalDateTime();
                int duration = rs.getInt("duration");
                String status = rs.getString("status");

                LocalDateTime expirationTime = creationDateTime.plusMinutes(duration);
                LocalDateTime now = LocalDateTime.now();

                if (now.isAfter(expirationTime)) {
                    // Atualiza essa sessão
                    String updateSql = "UPDATE TestSession SET finishDateTime = ?, status = ? WHERE id = ?";

                    try (PreparedStatement updateStmt = con.prepareStatement(updateSql)) {
                        updateStmt.setTimestamp(1, Timestamp.valueOf(now));
                        updateStmt.setString(2, TestSessionStatus.FINISHED.name());
                        updateStmt.setLong(3, sessionId);

                        updateStmt.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar sessões expiradas do projeto", e);
        }
    }

    public void updateDescription(long sessionId, String description) {
        String sql = "UPDATE TestSession SET description = ? WHERE id = ?";

        try (Connection con = AcessaBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, description);
            stmt.setLong(2, sessionId);

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar descrição da TestSession", e);
        }
    }

    public TestSession getById(long sessionId) {
        String sql = "SELECT * FROM TestSession WHERE id = ?";
        try (Connection con = AcessaBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setLong(1, sessionId);

            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    String testerName = resultSet.getString("testerName");
                    long userId = resultSet.getLong("userId");
                    long strategyId = resultSet.getLong("strategyId");
                    long projetoId = resultSet.getLong("projetoId");
                    int duration = resultSet.getInt("duration");
                    String description = resultSet.getString("description");
                    String statusStr = resultSet.getString("status");
                    Timestamp creationTimestamp = resultSet.getTimestamp("creationDateTime");
                    Timestamp startTimestamp = resultSet.getTimestamp("startDateTime");
                    Timestamp finishTimestamp = resultSet.getTimestamp("finishDateTime");

                    TestSessionStatus status = TestSessionStatus.valueOf(statusStr);

                    return new TestSession(
                            sessionId,
                            testerName,
                            userId,
                            strategyId,
                            projetoId,
                            duration,
                            description,
                            status,
                            creationTimestamp != null ? creationTimestamp.toLocalDateTime() : null,
                            startTimestamp != null ? startTimestamp.toLocalDateTime() : null,
                            finishTimestamp != null ? finishTimestamp.toLocalDateTime() : null
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar TestSession por ID", e);
        }
        return null;
    }
}
