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

    public Project(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
