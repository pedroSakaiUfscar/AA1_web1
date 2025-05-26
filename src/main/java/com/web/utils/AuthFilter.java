package com.web.utils;

import com.web.model.User;
import com.web.utils.Routes;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private Set<String> publicExactRoutes; // Rotas acessíveis sem login
    private Set<String> publicPrefixRoutes; // Prefixos de rotas acessíveis sem login (ex: "/css/", "/js/")

    // Rotas que exigem LOGIN, mas qualquer usuário logado pode acessar
    private Set<String> authenticatedRoutes;

    private Map<String, List<String>> roleProtectedRoutes;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Rotas Públicas (Não exigem autenticação nem autorização) ---
        publicExactRoutes = new HashSet<>();
        publicExactRoutes.add(Routes.LOGIN_ROUTE);
        publicExactRoutes.add(Routes.INITIAL_ROUTE);
        publicExactRoutes.add(Routes.STRATEGIES_LIST_ROUTE);
        publicExactRoutes.add(Routes.ACCESS_DENIED_ROUTE);
        publicExactRoutes.add("/setLocale");

        publicPrefixRoutes = new HashSet<>();
        publicPrefixRoutes.add("/css/");
        publicPrefixRoutes.add("/js/");
        publicPrefixRoutes.add("/images/");

        // Rotas Protegidas por Role (Exigem login e uma role específica) ---
        roleProtectedRoutes = new HashMap<>();
        roleProtectedRoutes.put(Routes.REGISTER_ROUTE, Arrays.asList("ADMIN"));
        roleProtectedRoutes.put(Routes.CREATE_STRATEGY_ROUTE, Arrays.asList("ADMIN"));
        roleProtectedRoutes.put(Routes.CREATE_PROJECT_ROUTE, Arrays.asList("ADMIN"));
        roleProtectedRoutes.put(Routes.LIST_USERS_ROUTE, Arrays.asList("ADMIN"));

        // Rotas Autenticadas (Exigem login, mas qualquer role logada pode acessar) ---
        authenticatedRoutes = new HashSet<>();
        authenticatedRoutes.add(Routes.LIST_PROJECTS_ROUTE); // Exemplo
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        boolean isPublic = publicExactRoutes.contains(path);
        if (!isPublic) {
            for (String prefix : publicPrefixRoutes) {
                if (path.startsWith(prefix)) {
                    isPublic = true;
                    break;
                }
            }
        }
        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        boolean isRoleProtected = false;
        List<String> allowedRoles = null;
        for (Map.Entry<String, List<String>> entry : roleProtectedRoutes.entrySet()) {
            String protectedPath = entry.getKey();
            if (path.equals(protectedPath) || path.startsWith(protectedPath + "/")) {
                isRoleProtected = true;
                allowedRoles = entry.getValue();
                break;
            }
        }

        if (isRoleProtected) {
            HttpSession session = req.getSession(false);
            User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;
            String userRole = (loggedUser != null) ? loggedUser.getRole() : null;

            if (loggedUser == null || allowedRoles == null || !allowedRoles.contains(userRole)) {
                res.sendRedirect(req.getContextPath() + Routes.ACCESS_DENIED_ROUTE);
                return;
            }
        }

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            res.sendRedirect(req.getContextPath() + Routes.LOGIN_ROUTE);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}