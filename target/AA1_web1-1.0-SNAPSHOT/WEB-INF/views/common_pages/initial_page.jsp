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
      <title>
         <fmt:message key="welcome_title" />
      </title>
      <style>
         body {
         font-family: Arial, sans-serif;
         text-align: center;
         background-color: #f9f9f9;
         padding-top: 50px;
         }
         h1 {
         color: #333;
         }
         p {
         color: #555;
         font-size: 18px;
         }
         button {
         background-color: #4CAF50; /* Verde */
         color: white;
         padding: 10px 20px;
         margin-top: 20px;
         border: none;
         border-radius: 5px;
         font-size: 16px;
         cursor: pointer;
         }
         button:hover {
         background-color: #45a049;
         }
      </style>
   </head>
   <body>
      <h1>
         <fmt:message key="welcome_title" />
      </h1>
      <p>
         <fmt:message key="welcome_description" />
      </p>
      <form action="<%= request.getContextPath() %>/strategies" method="get">
         <button type="submit">
            <fmt:message key="strategies_list_redirect" />
         </button>
      </form>
      <a href="<%= request.getContextPath() %>/setLocale?lang=pt_BR">
         <fmt:message key="set_portuguese" />
      </a>
      <br>
      <a href="<%= request.getContextPath() %>/setLocale?lang=en_US">
         <fmt:message key="set_english" />
      </a>
   </body>
</html>