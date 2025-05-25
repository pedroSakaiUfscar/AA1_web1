<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
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

        .delete-btn {
            background: none;
            color: #ff4d4f;
            border: none;
            cursor: pointer;
            font-size: 18px;
            transition: transform 0.2s ease;
        }

        .delete-btn:hover {
            color: #e60000;
            transform: scale(1.1);
        }

        .delete-btn:active {
            transform: scale(0.9);
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>
<div class="container">
    <a href="<%= request.getContextPath() %>/home" class="back-link">
        <fmt:message key="list_back_button" />
    </a>

    <h1><fmt:message key="list_page_title" /></h1>

    <table>
        <thead>
        <tr>
            <th><fmt:message key="list_strategy_name" /></th>
            <th><fmt:message key="list_strategy_description" /></th>
            <th><fmt:message key="list_strategy_examples" /></th>
            <th><fmt:message key="list_strategy_tips" /></th>
            <th><fmt:message key="list_strategy_images" /></th>
            <c:if test="${sessionScope.loggedUser != null && sessionScope.loggedUser.role == 'ADMIN'}">
                <th><fmt:message key="list_strategy_delete" /></th>
            </c:if>
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
            <td>
                <div class="image-gallery">
                    <%
                        String images = strategy.getImages();
                        if (images != null && !images.isEmpty()) {
                            String[] imageArray = images.split(",");
                            for (String imageUrl : imageArray) {
                                if (!imageUrl.trim().isEmpty()) {
                    %>
                    <img src="<%= imageUrl.trim() %>" alt="Strategy image" style="width: 100px; height: auto;">
                    <%
                            }
                        }
                    } else {
                    %>
                    <span class="no-data"><fmt:message key="list_no_images" /></span>
                    <%
                        }
                    %>
                </div>
            </td>
            <c:if test="${sessionScope.loggedUser != null && sessionScope.loggedUser.role == 'ADMIN'}">
                <td>
                    <form action="<%= request.getContextPath() %>/strategies/delete" method="post" style="display: inline;" onsubmit="return confirmDelete();">
                        <input type="hidden" name="id" value="<%= strategy.getId() %>">
                        <button type="submit" class="delete-btn" title="Delete">
                            🗑️
                        </button>
                    </form>
                </td>
            </c:if>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" class="no-data">
                <fmt:message key="list_no_strategies" />
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <c:if test="${sessionScope.loggedUser != null && sessionScope.loggedUser.role == 'ADMIN'}">
        <form action="strategies/create" method="get" style="display: flex; justify-content: flex-end; margin: 20px 0;">
            <button type="submit" class="create-btn">
                <fmt:message key="list_create_strategy_button" />
            </button>
        </form>
    </c:if>
</div>

<script>
    function confirmDelete() {
        return confirm("<fmt:message key='list_confirmation_delete' />");
    }
</script>

</body>
</html>