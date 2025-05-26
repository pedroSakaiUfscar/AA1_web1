<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.web.model.Project" %>
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
            cursor: pointer;
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

        .create-btn {
            align-self: end;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>
<div class="container">
    <a href="<%= request.getContextPath() %>/home" class="back-link">
        <fmt:message key="list_back_button" />
    </a>

    <h1>Listagem de Projetos</h1>

    <p>Filtro:</p>
    <select id="FilterSelector" onchange="changeLanguage(this)" class="language-selector-custom" style="margin-right: 25px;">
        <option value="name" <c:if test="${sort == 'name'}">selected</c:if>>Ordem alfabética</option>
        <option value="date" <c:if test="${sort == 'date'}">selected</c:if>>Data de criação</option>
        <option value="" <c:if test="${sort == null}">selected</c:if>>Nenhum</option>
    </select>

    <br><br>

    <table>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Descrição</th>
                <th>Data</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Project> projects = (List<Project>) request.getAttribute("projects");
                if (projects != null && !projects.isEmpty()) {
                    for (Project project : projects) {
            %>
            <tr onclick="window.location.href='<%= request.getContextPath() %>/sessions?action=listar_session&projectId=<%= project.getId() %>'">
                <td><%= project.getName() %></td>
                <td><%= project.getDescription() %></td>
                <td><%= project.getDate().toString() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3" class="no-data">Nenhum projeto encontrado.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<script>
    function changeLanguage(selectElement) {
        const selectedSort = selectElement.value;
        if (!selectedSort) {
            window.location.href = '${pageContext.request.contextPath}/projects';
        } else {
            window.location.href = '${pageContext.request.contextPath}/projects?sort=' + selectedSort;
        }
    }
</script>

</body>
</html>
