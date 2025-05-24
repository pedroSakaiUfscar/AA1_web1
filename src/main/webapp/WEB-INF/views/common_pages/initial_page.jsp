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
      <title>AA1</title>
      <style>
         body {
         font-family: Arial, sans-serif;
         background-color: #d3e6f5;
         margin: 0;
         display: flex;
         justify-content: center;
         align-items: center;
         height: 100vh;
         }
         .container {
         background-color: #ffe8d6;
         border-radius: 15px;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
         padding: 30px;
         }
         .cards {
         display: grid;
         grid-template-columns: 1fr 1fr;
         gap: 20px;
         }
         .card {
         background-color: #d6f8d6;
         padding: 20px;
         text-align: center;
         border-radius: 10px;
         font-size: 18px;
         transition: all 0.3s ease;
         text-decoration: none;
         color: #333;
         box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
         }
         .card:hover {
         transform: translateY(-5px);
         background-color: #c8ecc8;
         box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
         }
         .card p {
         margin: 0;
         font-weight: bold;
         }
         @media (max-width: 600px) {
         .cards {
         grid-template-columns: 1fr;
         gap: 15px;
         }
         }
      </style>
   </head>
   <body>
      <div class="container">
         <div class="cards">
            <a href="<%= request.getContextPath() %>/strategies" class="card">
               <p>
                  <fmt:message key="strategy_card_description" />
               </p>
            </a>
            <a href="<%= request.getContextPath() %>/projects" class="card">
               <p>
                  <fmt:message key="project_card_description" />
               </p>
            </a>
            <c:choose>
               <%-- Se o usuário logado for ADMIN --%>
               <c:when test="${sessionScope.loggedUser != null && sessionScope.loggedUser.role == 'ADMIN'}">
                  <a href="<%= request.getContextPath() %>/register" class="card register-user-card">
                     <p>
                        <fmt:message key="register_new_user_card_title" /> <%-- Ex: "Cadastrar Novo Usuário" --%>
                     </p>
                  </a>
               </c:when>

               <%-- Se o usuário logado for TESTER--%>
               <c:when test="${sessionScope.loggedUser != null && sessionScope.loggedUser.role == 'TESTER'}">
                  <div class="card">
                     <p>
                        <fmt:message key="user_card_title" />
                        <strong>${sessionScope.loggedUser.username == null ? "-" : sessionScope.loggedUser.username}</strong>
                     </p>
                  </div>
               </c:when>

               <%-- Se o usuário não estiver logado --%>
               <c:otherwise>
                  <a href="<%= request.getContextPath() %>/" class="card login-card"> <%-- Assumindo que a rota de login é "/" --%>
                     <p>
                        Login
                     </p>
                  </a>
               </c:otherwise>
            </c:choose>
            <c:choose>
               <c:when test="${sessionScope.locale == 'pt_BR'}">
                  <a href="<%= request.getContextPath() %>/setLocale?lang=en_US" class="card">
                     <p>
                        <fmt:message key="locale_card_current_title" />
                        <br>
                        <fmt:message key="locale_card_current_description" />
                     </p>
                  </a>
               </c:when>
               <c:when test="${sessionScope.locale == 'en_US'}">
                  <a href="<%= request.getContextPath() %>/setLocale?lang=pt_BR" class="card">
                     <p>
                        <fmt:message key="locale_card_current_title" />
                        <br>
                        <fmt:message key="locale_card_current_description" />
                     </p>
                  </a>
               </c:when>
               <c:otherwise>
                  <div class="card">
                     <p>
                        <fmt:message key="locale_card_empty" />
                        <br>
                        <fmt:message key="locale_card_empty_warning" />
                     </p>
                  </div>
               </c:otherwise>
            </c:choose>
         </div>
      </div>
   </body>
</html>