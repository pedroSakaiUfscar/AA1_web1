package com.web.servlets.session;

import com.web.dao.SessionDAO;
import com.web.model.TestSession;
import com.web.model.TestSessionStatus;
import com.web.model.User;
import com.web.utils.Routes;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "SessionControler", urlPatterns = {Routes.SESSION_ROUTE})
public class SessionControler extends HttpServlet {

    private SessionDAO sessionDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        sessionDAO = new SessionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("projectId".equals(action)) {
            String projectIdParam = request.getParameter("projectId");
            listSessionsByProject(request, response, projectIdParam);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/session_pages/create_session.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação não informada");
            return;
        }

        if (action.equals("create")) {
            createSession(request, response);
        } else if (action.equals("start")) {
            startSession(request, response);
        } else if (action.equals("finish")) {
            finishSession(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida");
        }
    }


    private void createSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Object obj = request.getSession().getAttribute("loggedUser");
        long idUsuario = 0;
        String testerName = "";
        if (obj instanceof User) {
            User user = (User) obj;
            idUsuario = user.getId();
            testerName = user.getUsername();
        }

        long strategyId = Long.parseLong(request.getParameter("strategyId"));
        long projetoId = Long.parseLong(request.getParameter("projetoId"));
        int duration = Integer.parseInt(request.getParameter("duration"));
        String description = request.getParameter("description");

        TestSessionStatus status = TestSessionStatus.CREATED;
        LocalDateTime creationDateTime = LocalDateTime.now();

        TestSession session = new TestSession(0, testerName, idUsuario, strategyId, projetoId, duration, description, status, creationDateTime, null, null);

        sessionDAO.insert(session);

        response.sendRedirect(request.getContextPath() + Routes.SESSION_ROUTE + "?action=projectId&projectId=" + projetoId);
    }

    private void startSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        long sessionId = Long.parseLong(request.getParameter("sessionId"));
        LocalDateTime startDateTime = LocalDateTime.now();
        TestSessionStatus newStatus = TestSessionStatus.IN_EXECUTION;

        sessionDAO.updateStart(sessionId, startDateTime, newStatus);

        String projectId = request.getParameter("projectId");
        response.sendRedirect(request.getContextPath() + "/sessions?action=projectId&projectId=" + projectId);
    }

    private void finishSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        long sessionId = Long.parseLong(request.getParameter("sessionId"));
        LocalDateTime finishDateTime = LocalDateTime.now();
        TestSessionStatus newStatus = TestSessionStatus.FINISHED;

        sessionDAO.updateFinish(sessionId, finishDateTime, newStatus);

        String projectId = request.getParameter("projectId");
        response.sendRedirect(request.getContextPath() + "/sessions?action=projectId&projectId=" + projectId);
    }

    private void listSessionsByProject(HttpServletRequest request, HttpServletResponse response, String projectIdParam) throws ServletException, IOException {

        long projectId;
        try {
            projectId = Long.parseLong(projectIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "projectId inválido");
            return;
        }

        sessionDAO.updateExpiredSessionsByProject((int) projectId);

        List<TestSession> sessions = sessionDAO.getAllbyProjectID((int) projectId);



        request.setAttribute("sessions", sessions);
        request.setAttribute("projectId", projectId);

        request.getRequestDispatcher("/WEB-INF/views/session_pages/list_sessions.jsp").forward(request, response);
    }

}
