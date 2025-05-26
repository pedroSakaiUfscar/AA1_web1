<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.web.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title><fmt:message key="list_page_title" /></title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 80px auto 30px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        a {
            color: #6A0DAD;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #4B0082;
            text-decoration: underline;
        }

        h1 {
            color: #6A0DAD;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        button, input[type="submit"], input[type="button"] {
            background-color: #6A0DAD;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin: 5px 0;
        }

        button:hover, input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #4B0082;
        }

        button:active, input[type="submit"]:active, input[type="button"]:active {
            background-color: #2C0051;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        th {
            background-color: #6A0DAD;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            vertical-align: top;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f0e6ff;
        }

        .image-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .image-gallery img {
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: transform 0.3s ease;
        }

        .image-gallery img:hover {
            transform: scale(1.05);
        }

        .no-data {
            text-align: center;
            color: #666;
            font-style: italic;
        }
        .create-btn{
            align-self: end;
        }
        /* Estilo para a coluna de ações */
        .actions-cell {
            text-align: right;
            white-space: nowrap;
        }

        /* Ícone de lixeira */
        .delete-icon {
            color: #6A0DAD;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s ease;
            padding: 8px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .delete-icon:hover {
            background-color: #f0e6ff;
            transform: scale(1.1);
            color: #4B0082;
        }

        /* Tooltip para o ícone */
        .tooltip {
            position: relative;
            display: inline-block;
        }

        .tooltip .tooltiptext {
            visibility: hidden;
            width: 120px;
            background-color: #555;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            margin-left: -60px;
            opacity: 0;
            transition: opacity 0.3s;
            font-size: 14px;
        }

        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
        }

        #erro {
            background-color: #ffe0e0;
            border: 1px solid #ff9999;
            color: #cc0000;
            padding: 10px 20px;
            margin-bottom: 20px;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
            text-align: center;
            word-wrap: break-word;
            white-space: normal;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>
<div class="container">
    <a href="<%= request.getContextPath() %>/home" class="back-link">
        <fmt:message key="list_back_button" />
    </a>

    <h1><fmt:message key="list_user_title" /></h1>

    <c:if test="${mensagens != null && mensagens.existeErros && mensagens.erros[0] == 'DELETE'}">
        <div id="erro">
            <p><fmt:message key="list_delete_user_error" /></p>
        </div>
    </c:if>

    <table>
        <thead>
        <tr>
            <th><fmt:message key="name" /></th>
            <th>E-mail</th>
            <th><fmt:message key="user_role" /></th>
            <th class="actions-cell"><fmt:message key="actions" /></th>
        </tr>
        </thead>
        <tbody>
        <%
            List<User> users = (List<User>) request.getAttribute("users");
            if (users != null && !users.isEmpty()) {
                for (User user : users) {
        %>
        <tr>
            <td><%= user.getName()%></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getRole() %></td>
            <td class="actions-cell">
                <div class="tooltip">
                    <form action="${pageContext.request.contextPath}/users/delete" method="post"
                          onsubmit="return confirm('<fmt:message key="confirm_delete" />');">
                        <input type="hidden" name="userId" value="<%= user.getId() %>">
                        <button type="submit" style="background: none; border: none; padding: 0;">
                            <i class="fas fa-trash-alt delete-icon"></i>
                        </button>
                    </form>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="no-data">
                <fmt:message key="list_no_users" />
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
        <form action="register" method="get" style="display: flex; justify-content: flex-end; margin: 20px 0;">
            <button type="submit" class="create-btn">
                <fmt:message key="register_new_user" />
            </button>
        </form>
</div>
</body>
</html>
