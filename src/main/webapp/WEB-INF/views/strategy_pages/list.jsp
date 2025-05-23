<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.web.model.Strategy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="pt-BR">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>
         <fmt:message key="list_page_title" />
      </title>
   </head>
   <body>
      <div class="container">
         <br>
         <a href="<%= request.getContextPath() %>/">
            <fmt:message key="list_back_button" />
         </a>
         <br>
         <br>
         <form action="strategies/create" method="get">
            <button type="submit">
               <fmt:message key="list_create_strategy_button" />
            </button>
         </form>
         <h1>
            <fmt:message key="list_page_title" />
         </h1>
         <table border="1" style="width: 100%; text-align: left; border-collapse: collapse;">
            <thead>
               <tr>
                  <th>
                     <fmt:message key="list_strategy_name" />
                  </th>
                  <th>
                     <fmt:message key="list_strategy_description" />
                  </th>
                  <th>
                     <fmt:message key="list_strategy_examples" />
                  </th>
                  <th>
                     <fmt:message key="list_strategy_tips" />
                  </th>
               </tr>
            </thead>
            <tbody>
               <%
                  List<Strategy> strategies = (List<Strategy>) request.getAttribute("strategies");
                  if (strategies != null && !strategies.isEmpty()) {
                      for (Strategy strategy : strategies) {
                  %>
               <tr>
                  <td><%= strategy.getName() %></td>
                  <td><%= strategy.getDescription() %></td>
                  <td><%= strategy.getExamples() %></td>
                  <td><%= strategy.getTips() %></td>
               </tr>
               <%
                  }
                  } else {
                  %>
               <tr>
                  <td colspan="4" style="text-align: center;">
                     <fmt:message key="list_no_strategies" />
                  </td>
               </tr>
               <% } %>
            </tbody>
         </table>
      </div>
   </body>
</html>