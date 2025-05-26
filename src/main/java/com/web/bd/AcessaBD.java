package com.web.bd;

import com.web.utils.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AcessaBD {

    public static void main(String[] args) {
        try {
            // Setup:
            Class.forName(Config.BD_DRIVER);
            Connection con = DriverManager.getConnection(Config.DB_URL, Config.DB_USERNAME, Config.DB_PASSWORD);

            // Print tables:
            Statement stmt = con.createStatement();
            printTablesNames(stmt);
            printTablesDescriptions(stmt, con);

            // Closes:
            stmt.close();
            con.close();
        } catch (ClassNotFoundException e) {
            System.out.println("A classe do driver de conexão não foi encontrada!");
        } catch (SQLException e) {
            System.out.println("O comando SQL não pode ser executado!");
        }
    }

    public static void printTablesNames(Statement stmt) {
        try {
            ResultSet firstQuery = stmt.executeQuery("SHOW TABLES");

            System.out.println("+-----------------+");
            System.out.printf("| %-15s |\n", "Tables");
            System.out.println("+-----------------+");

            while (firstQuery.next()) {
                String tableName = firstQuery.getString(1);
                System.out.printf("| %-15s |\n", tableName);
            }
            System.out.println("+-----------------+");
        } catch (SQLException e) {
            System.out.println("O comando SQL não pode ser executado!");
        }
    }

    public static void printTablesDescriptions(Statement stmt, Connection con) {
        try {
            ResultSet rs = stmt.executeQuery("SHOW TABLES");

            while (rs.next()) {
                String tableName = rs.getString(1); // Pegar o nome da tabela
                System.out.println("\nTabela: " + tableName);

                Statement descStmt = con.createStatement();
                ResultSet descRs = descStmt.executeQuery("DESCRIBE " + tableName);

                System.out.println("+------------+----------------------------+------+-----+---------+----------------+");
                System.out.printf("| %-10s | %-24s | %-4s | %-4s | %-7s | %-14s |\n", "Field", "Type", "Null", "Key", "Default", "Extra");
                System.out.println("+------------+----------------------------+------+-----+---------+----------------+");

                while (descRs.next()) {
                    System.out.printf(
                            "| %-10s | %-24s | %-4s | %-4s | %-7s | %-14s |\n",
                            descRs.getString("Field"),
                            descRs.getString("Type"),
                            descRs.getString("Null"),
                            descRs.getString("Key"),
                            descRs.getString("Default"),
                            descRs.getString("Extra")
                    );
                }

                System.out.println("+------------+----------------------------+------+-----+---------+----------------+");

                descRs.close();
                descStmt.close();
            }
        } catch (SQLException e) {
            System.out.println("O comando SQL não pode ser executado!");
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(Config.BD_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver não encontrado", e);
        }
        return DriverManager.getConnection(
                Config.DB_URL,
                Config.DB_USERNAME,
                Config.DB_PASSWORD
        );
    }
}