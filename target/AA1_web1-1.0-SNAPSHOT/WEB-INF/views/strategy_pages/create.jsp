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
         <fmt:message key="create_title" />
      </title>
   </head>
   <body>
      <div class="container">
         <h1>
            <fmt:message key="create_title" />
         </h1>
         <form action="<%= request.getContextPath() %>/strategies/create" method="post">
            <label for="name">
               <fmt:message key="create_label_name" />
            </label>
            <br>
            <input type="text" id="name" name="name" required><br><br>
            <label for="description">
               <fmt:message key="create_label_description" />
            </label>
            <br>
            <textarea id="description" name="description" required></textarea>
            <br><br>
            <label for="examples">
               <fmt:message key="create_label_examples" />
            </label>
            <br>
            <textarea id="examples" name="examples" required></textarea>
            <br><br>
            <label for="tips">
               <fmt:message key="create_label_tips" />
            </label>
            <br>
            <textarea id="tips" name="tips" required></textarea>
            <br><br>
            <button type="submit">
               <fmt:message key="create_submit_button" />
            </button>
         </form>
         <br>
         <a href="<%= request.getContextPath() %>/strategies">
            <fmt:message key="create_back_to_list" />
         </a>
      </div>
   </body>
</html>