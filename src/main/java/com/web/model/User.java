package com.web.model;

import java.io.Serializable;

public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String name;
    private String email;
    private String senha;
    private String role;

    public User(Long id) {
        this.id = id;
    }

    public User(String username, String email, String senha, String role) {
        this.name = username;
        this.email = email;
        this.senha = senha;
        this.role = role;
    }

    public User(Long id, String name, String email, String senha, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.senha = senha;
        this.role = role;
    }

    // --- Getters e Setters ---
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() { // <-- Alterado
        return name;
    }

    public void setUsername(String username) { // <-- Alterado
        this.name = name;
    }

    public String getEmail() { // <-- Alterado
        return email;
    }

    public void setEmail(String email) { // <-- Alterado
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getRole() { // <-- Alterado
        return role;
    }

    public void setRole(String role) { // <-- Alterado
        this.role = role;
    }

}