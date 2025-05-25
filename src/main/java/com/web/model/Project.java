package com.web.model;

public class Project {
    private long id;
    private String name;
    private String description;
    private java.sql.Date date;

    public Project(long id, String name, String description, java.sql.Date date) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.date = date;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public java.sql.Date getDate() {
        return date;
    }
}
