package com.web.servlets.projects;

import com.web.dao.ProjectDAO;
import com.web.model.Project;
import com.web.model.User; // Import the User model
import com.web.utils.Routes;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { Routes.LIST_PROJECTS_ROUTE })
public class ListProjectsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String sort = request.getParameter("sort");
            ProjectDAO dao = new ProjectDAO();
            List<Project> projects;

            HttpSession session = request.getSession(false);
            User loggedUser = null;
            if (session != null) {
                loggedUser = (User) session.getAttribute("loggedUser");
            }

            switch (sort != null ? sort.toLowerCase() : "") {
                case "name":
                    projects = dao.getAllSortedByName();
                    break;
                case "date":
                    projects = dao.getAllSortedByDate();
                    break;
                case "associated":
                    if (loggedUser != null) {
                        projects = dao.getAssociatedProjects(loggedUser.getId());
                    } else {
                        projects = dao.getAll();
                        session.setAttribute("error", "Você precisa estar logado para ver seus projetos.");
                    }
                    break;
                default:
                    projects = dao.getAll();
                    break;
            }

            request.setAttribute("projects", projects);
            request.setAttribute("sort", sort);
            request.getRequestDispatcher("/WEB-INF/views/projects_pages/list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Erro ao listar projetos: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Ocorreu um erro ao carregar a lista de projetos.");
        }
    }
}