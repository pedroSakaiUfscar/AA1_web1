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
      <style>
         body {
         font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
         margin: 0;
         padding: 0;
         background-color: #f8f9fa;
         color: #333;
         }
         .container {
         max-width: 800px;
         margin: 80px auto 30px;
         padding: 10px 30px 30px 30px;
         background-color: white;
         border-radius: 8px;
         box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
         }
         h1 {
         color: #6A0DAD;
         margin-bottom: 30px;
         padding-bottom: 10px;
         border-bottom: 2px solid #f0f0f0;
         }
         label {
         display: block;
         margin-bottom: 8px;
         font-weight: 600;
         color: #555;
         }
         input[type="text"], textarea {
         width: 100%;
         padding: 12px;
         border: 1px solid #ddd;
         border-radius: 4px;
         font-family: inherit;
         font-size: 14px;
         transition: border-color 0.3s ease;
         box-sizing: border-box;
         }
         input[type="text"]:focus, textarea:focus {
         border-color: #6A0DAD;
         outline: none;
         box-shadow: 0 0 0 2px rgba(106, 13, 173, 0.2);
         }
         textarea {
         min-height: 100px;
         resize: vertical;
         }
         button {
         background-color: #6A0DAD;
         color: white;
         padding: 12px 24px;
         border: none;
         border-radius: 4px;
         cursor: pointer;
         font-size: 16px;
         font-weight: 600;
         transition: background-color 0.3s ease;
         }
         button:hover {
         background-color: #4B0082;
         }
         button:active {
         background-color: #2C0051;
         }
         a {
         display: inline-block;
         margin-top: 20px;
         color: #6A0DAD;
         text-decoration: none;
         transition: color 0.3s ease;
         }
         a:hover {
         color: #4B0082;
         text-decoration: underline;
         }
         .form-group {
         margin-bottom: 20px;
         }
         .required-field::after {
         content: " *";
         color: #e74c3c;
         }
      </style>
   </head>
   <body>
      <%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>
      <div class="container">
         <a href="<%= request.getContextPath() %>/projects">
            <fmt:message key="create_back_to_list" />
         </a>

         <h1>
            <fmt:message key="create_project_title" />
         </h1>

         <form action="<%= request.getContextPath() %>/projects/create" method="post">
            <div class="form-group">
               <label for="name" class="required-field">
                  <fmt:message key="create_label_name" />
               </label>
               <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
               <label for="description" class="required-field">
                  <fmt:message key="create_label_description" />
               </label>
               <textarea id="description" name="description" required></textarea>
            </div>

            <div class="form-group">
               <label for="users" class="required-field">
                  <fmt:message key="create_project_label_users" />
               </label>
               <c:forEach var="user" items="${users}">
                  <div style="display: flex; align-items: center; margin-bottom: 8px;">
                     <input
                        type="checkbox"
                        id="user-${user.id}"
                        name="users"
                        value="${user.id}"
                        style="margin-right: 8px; transform: scale(1.2);" />
                     <label for="user-${user.id}" style="margin: 0;">${user.name}</label>
                  </div>
               </c:forEach>
            </div>

            <button type="submit">
               <fmt:message key="create_project_submit_button" />
            </button>

         </form>
      </div>
   </body>
</html>