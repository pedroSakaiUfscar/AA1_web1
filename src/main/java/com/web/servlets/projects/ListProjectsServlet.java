package com.web.servlets.projects;

import com.web.dao.ProjectDAO;
import com.web.model.Project;
import com.web.utils.Routes;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { Routes.LIST_PROJECTS_ROUTE })
public class ListProjectsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String sort = request.getParameter("sort");
            ProjectDAO dao = new ProjectDAO();

            List<Project> projects = switch (sort != null ? sort.toLowerCase() : "") {
                case "name" -> dao.getAllSortedByName();
                case "date" -> dao.getAllSortedByDate();
                default -> dao.getAll();
            };

            request.setAttribute("projects", projects);
            request.setAttribute("sort", sort);
            request.getRequestDispatcher("/WEB-INF/views/projects_pages/list.jsp").forward(request, response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
