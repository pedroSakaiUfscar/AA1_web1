package com.web.servlets.projects;

import com.web.dao.ProjectDAO;
import com.web.dao.UserDAO;
import com.web.model.Project;
import com.web.model.User;
import com.web.utils.Routes;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CreateProjectServlet", urlPatterns = {Routes.CREATE_PROJECT_ROUTE})
public class CreateProjectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        List<User> users = dao.getAll();
        List<User> filteredUsers = users.stream()
                .filter(user -> "TESTER".equals(user.getRole()))
                .toList();

        request.setAttribute("users", filteredUsers);
        request.getRequestDispatcher("/WEB-INF/views/projects_pages/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] selectedUsers = request.getParameterValues("users");

        try {
            ProjectDAO dao = new ProjectDAO();
            dao.insert(new Project(name, description), selectedUsers);

            response.sendRedirect(request.getContextPath() + "/projects");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
