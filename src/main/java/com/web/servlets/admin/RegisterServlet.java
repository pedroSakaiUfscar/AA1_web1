package com.web.servlets.admin;

import com.web.dao.UserDAO;
import com.web.model.User;
import com.web.utils.Error;
import com.web.utils.Routes;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = { Routes.REGISTER_ROUTE })
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String URL = "/WEB-INF/views/admin/register/register.jsp";
        RequestDispatcher rd = request.getRequestDispatcher(URL);
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Error error = new Error();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha"); // Virá vazio para TESTER, preenchido para ADMIN
        String confirmarSenha = request.getParameter("confirmarSenha"); // Virá vazio para TESTER, preenchido para ADMIN
        String role = request.getParameter("role");

        // 2. Validação dos dados
        if (username == null || username.trim().isEmpty()) {
            error.add("Nome de usuário não informado!");
        } else if (username.trim().length() < 3) {
            error.add("Nome de usuário deve ter no mínimo 3 caracteres!");
        }

        if (email == null || email.trim().isEmpty()) {
            error.add("Email não informado!");
        } else if (!email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            error.add("Formato de email inválido!");
        } else {
            UserDAO dao = new UserDAO();
            if (dao.emailExists(email.trim())) {
                error.add("Este email já está em uso. Por favor, utilize outro.");
            }
        }

        // Validação da role (garantindo que seja ADMIN ou TESTER)
        if (role == null || (!role.equals("ADMIN") && !role.equals("TESTER"))) {
            error.add("Tipo de usuário inválido.");

        }

        // Lógica de senha condicional
        String finalSenha = "";

        if ("ADMIN".equals(role)) {
            // Validações de senha apenas para ADMIN
            if (senha == null || senha.isEmpty()) {
                error.add("Senha não informada para o Administrador!");
            } else if (senha.length() < 6) {
                error.add("A senha do Administrador deve ter no mínimo 6 caracteres!");
            }

            if (!senha.equals(confirmarSenha)) {
                error.add("As senhas do Administrador não coincidem!");
            }
            finalSenha = senha;
        } else if ("TESTER".equals(role)) {
            // Para TESTER, a senha é o username
            if (username != null && !username.trim().isEmpty()) {
                finalSenha = username.trim();
            } else {
                error.add("Nome de usuário não disponível para definir a senha do Testador.");
            }
        }

        // 3. Se houver erros, reenvia para o JSP com as mensagens
        if (error.isExisteErros()) {
            request.setAttribute("mensagens", error);
            request.setAttribute("param.username", username);
            request.setAttribute("param.email", email);
            request.setAttribute("param.role", role);
            if ("ADMIN".equals(role)) {
                request.setAttribute("param.senha", senha);
                request.setAttribute("param.confirmarSenha", confirmarSenha);
            }
            String URL = "/WEB-INF/views/admin/register/register.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(URL);
            rd.forward(request, response);
            return;
        }

        // 4. Se não houver erros, tenta cadastrar o usuário
        try {
            String hashedPassword = finalSenha; //substituir por hash real

            User newUser = new User(username.trim(), email.trim(), hashedPassword, role.trim());
            UserDAO dao = new UserDAO();
            dao.insert(newUser);

            request.getSession().setAttribute("successMessage", "Cadastro realizado com sucesso! Faça login para continuar.");
            response.sendRedirect(request.getContextPath() + Routes.LIST_USERS_ROUTE);
            return;
        } catch (RuntimeException e) {
            error.add("Erro ao cadastrar usuário: " + e.getMessage());
            request.setAttribute("mensagens", error);
            request.setAttribute("param.username", username);
            request.setAttribute("param.email", email);
            request.setAttribute("param.role", role);
            if ("ADMIN".equals(role)) {
                request.setAttribute("param.senha", senha);
                request.setAttribute("param.confirmarSenha", confirmarSenha);
            }
            String URL = "/WEB-INF/views/admin/register/register.jsp";
            RequestDispatcher rd = request.getRequestDispatcher(URL);
            rd.forward(request, response);
        }
    }
}