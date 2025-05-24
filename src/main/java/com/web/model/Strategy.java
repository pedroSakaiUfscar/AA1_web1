package com.web.model;

public class Strategy {
    private final long id;
    private final String name;
    private final String description;
    private final String examples;
    private final String tips;
    private final String images;

    public Strategy(long id, String name, String description, String examples, String tips, String images) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.examples = examples;
        this.tips = tips;
        this.images = images;
    }

    // Getters
    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getExamples() {
        return examples;
    }

    public String getTips() {
        return tips;
    }

    public String getImages() {
        return images == null ? "" : images;
    }
}

