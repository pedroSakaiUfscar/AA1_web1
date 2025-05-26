package com.web.model;

import java.time.LocalDateTime;

public class TestSession {
    private final long id;
    private final String testerName;
    private final long userId;
    private final long strategyId;
    private final long projetoId;
    private final int duration;
    private final String description;
    private TestSessionStatus status;
    private final LocalDateTime creationDateTime;
    private LocalDateTime startDateTime;
    private LocalDateTime finishDateTime;

    public TestSession(long id, String testerName, long userId, long strategyId, long projetoId, int duration,
                       String description, TestSessionStatus status, LocalDateTime creationDateTime,
                       LocalDateTime startDateTime, LocalDateTime finishDateTime) {
        this.id = id;
        this.testerName = testerName;
        this.userId = userId;
        this.strategyId = strategyId;
        this.projetoId = projetoId;
        this.duration = duration;
        this.description = description;
        this.status = status;
        this.creationDateTime = creationDateTime;
        this.startDateTime = startDateTime;
        this.finishDateTime = finishDateTime;
    }

    // Getters
    public long getId() {
        return id;
    }

    public String getTesterName() {
        return testerName;
    }

    public long getUserId() {
        return userId;
    }

    public long getStrategyId() {
        return strategyId;
    }

    public long getProjetoId() {
        return projetoId;
    }

    public int getDuration() {
        return duration;
    }

    public String getDescription() {
        return description;
    }

    public TestSessionStatus getStatus() {
        return status;
    }
    public String getStatusName() {
        return status.name();
    }

    public LocalDateTime getCreationDateTime() {
        return creationDateTime;
    }

    public LocalDateTime getStartDateTime() {
        return startDateTime;
    }

    public LocalDateTime getFinishDateTime() {
        return finishDateTime;
    }

    //Setters
    public void setStartDateTime(LocalDateTime startDateTime) {
        this.startDateTime = startDateTime;
    }

    public void setStatus(TestSessionStatus status) {
        this.status = status;
    }
}
