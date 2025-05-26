<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="pt-BR">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>AA1 - Página Principal</title>
   <style>
      :root {
         --primary-color: #6A0DAD;
         --primary-hover: #5a0c9d;
         --secondary-color: #f8f9fa;
         --card-bg: #ffffff;
         --text-color: #333333;
         --light-text: #777777;
         --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
         --transition: all 0.3s ease;
      }

      * {
         margin: 0;
         padding: 0;
         box-sizing: border-box;
      }

      body {
         font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
         background-color: #f5f7fa;
         color: var(--text-color);
         min-height: 100vh;
         display: flex;
         flex-direction: column;
      }

      .main-content {
         flex: 1;
         display: flex;
         flex-direction: column;
         justify-content: center;
         padding: 2rem;
         margin-top: 80px;
      }

      .dashboard-container {
         max-width: 1200px;
         margin: 0 auto;
         width: 100%;
      }

      h1 {
         color: var(--primary-color);
         font-size: 3.5rem;
         text-align: center;
         margin-bottom: 5rem;
      }

      .cards-grid {
         display: grid;
         grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
         gap: 1.5rem;
         align-items: stretch;
      }

      .card {
         background: var(--card-bg);
         border-radius: 12px;
         padding: 1.8rem;
         text-align: center;
         box-shadow: var(--shadow);
         transition: var(--transition);
         display: flex;
         flex-direction: column;
         justify-content: center;
         align-items: center;
         min-height: 180px;
         border: 1px solid rgba(0, 0, 0, 0.05);
         height: 100%;
         width: 100%;
      }

      .card-link {
         text-decoration: none;
         color: inherit;
         height: 100%;
         display: flex;
      }

      .card-link:hover .card {
         transform: translateY(-5px);
         box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
         border-color: var(--primary-color);
      }

      .card-icon {
         font-size: 2.5rem;
         margin-bottom: 1rem;
         color: var(--primary-color);
      }

      .card-title {
         font-size: 1.2rem;
         font-weight: 600;
         margin-bottom: 0.5rem;
      }

      .card-description {
         color: var(--light-text);
         font-size: 0.9rem;
      }

      .user-info {
         font-weight: normal;
         color: var(--primary-color);
         display: block;
         margin-top: 0.3rem;
      }

      .locale-card {
         grid-column: span 2;
      }

      @media (max-width: 768px) {
         .cards-grid {
            grid-template-columns: 1fr;
         }

         .locale-card {
            grid-column: span 1;
         }

         .welcome-message h1 {
            font-size: 1.8rem;
         }
      }

      .card:hover {
         background: #f8f5ff;
      }

      .register-user-card {
         background: #f0e6ff;
      }

      .register-user-card:hover {
         background: #e6d6ff;
      }

      .login-card {
         background: #e6f7ff;
      }

      .login-card:hover {
         background: #d6f2ff;
      }
   </style>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>

<main class="main-content">
   <div class="dashboard-container">
         <h1><fmt:message key="welcome_title" /></h1>

      <div class="cards-grid">
         <a href="<%= request.getContextPath() %>/strategies" class="card-link">
            <div class="card">
               <div class="card-icon">
                  <i class="fas fa-chess-knight"></i>
               </div>
               <h3 class="card-title"><fmt:message key="strategy_card_title" /></h3>
               <p class="card-description"><fmt:message key="strategy_card_description" /></p>
            </div>
         </a>

        <c:if test="${sessionScope.loggedUser != null}">
            <a href="<%= request.getContextPath() %>/projects" class="card-link">
                <div class="card">
                   <div class="card-icon">
                      <i class="fas fa-project-diagram"></i>
                   </div>
                   <h3 class="card-title"><fmt:message key="project_card_title" /></h3>
                   <p class="card-description"><fmt:message key="project_card_description" /></p>
                </div>
            </a>
        </c:if>

         <c:choose>
            <%-- ADMIN --%>
            <c:when test="${sessionScope.loggedUser != null && sessionScope.loggedUser.role == 'ADMIN'}">
               <a href="<%= request.getContextPath() %>/list-users" class="card-link">
                  <div class="card register-user-card">
                     <div class="card-icon">
                        <i class="fas fa-user-cog"></i>
                     </div>
                     <h3 class="card-title"><fmt:message key="users_management_card_title" /></h3>
                     <p class="card-description"><fmt:message key="admin_privileges" /></p>
                  </div>
               </a>
            </c:when>

            <%-- TESTER --%>
            <c:when test="${sessionScope.loggedUser != null && sessionScope.loggedUser.role == 'TESTER'}">
               <div class="card">
                  <div class="card-icon">
                     <i class="fas fa-user-tie"></i>
                  </div>
                  <h3 class="card-title"><fmt:message key="user_card_title" /></h3>
                  <p class="user-info">${sessionScope.loggedUser.name}</p>
               </div>
            </c:when>

            <%-- Não logado --%>
            <c:otherwise>
               <a href="<%= request.getContextPath() %>/" class="card-link">
                  <div class="card login-card">
                     <div class="card-icon">
                        <i class="fas fa-sign-in-alt"></i>
                     </div>
                     <h3/>Login</h3>
                     <p class="card-description"><fmt:message key="login_card_description" /></p>
                  </div>
               </a>
            </c:otherwise>
         </c:choose>

         <%-- Card de Idioma --%>
         <c:choose>
            <c:when test="${sessionScope.locale == 'pt_BR'}">
               <a href="<%= request.getContextPath() %>/setLocale?lang=en_US" class="card-link">
                  <div class="card locale-card">
                     <div class="card-icon">
                        <i class="fas fa-language"></i>
                     </div>
                     <h3 class="card-title"><fmt:message key="locale_card_current_title" /></h3>
                     <p class="card-description"><fmt:message key="locale_card_current_description" /></p>

                  </div>
               </a>
            </c:when>
            <c:when test="${sessionScope.locale == 'en_US'}">
               <a href="<%= request.getContextPath() %>/setLocale?lang=pt_BR" class="card-link">
                  <div class="card locale-card">
                     <div class="card-icon">
                        <i class="fas fa-language"></i>
                     </div>
                     <h3 class="card-title"><fmt:message key="locale_card_current_title" /></h3>
                     <p class="card-description"><fmt:message key="locale_card_current_description" /></p>
                  </div>
               </a>
            </c:when>
            <c:otherwise>
               <div class="card locale-card">
                  <div class="card-icon">
                     <i class="fas fa-language"></i>
                  </div>
                  <h3 class="card-title"><fmt:message key="locale_card_empty" /></h3>
                  <p class="card-description"><fmt:message key="locale_card_empty_warning" /></p>
               </div>
            </c:otherwise>
         </c:choose>
      </div>
   </div>
</main>
</body>
</html>