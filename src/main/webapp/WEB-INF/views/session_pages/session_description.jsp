<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><fmt:message key="update_description_title" /></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            box-sizing: border-box;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 600px;
            box-sizing: border-box;
        }

        h1 {
            color: #6A0DAD;
            margin-bottom: 25px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
            text-align: center;
        }

        label {
            font-weight: bold;
            margin-bottom: 8px;
            display: block;
            color: #333;
        }

        textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
            margin-bottom: 20px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        button {
            background-color: #6A0DAD;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            display: inline-block;
        }

        button:hover {
            background-color: #4B0082;
        }

        .back-link {
            margin-top: 20px;
            display: inline-block;
            color: #6A0DAD;
            text-decoration: none;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .current-description {
            background: #f1f1f1;
            padding: 15px;
            border-radius: 4px;
            white-space: pre-wrap;
            font-family: monospace, monospace;
            margin-top: 15px;
            color: #333;
        }
        .strategy-info {
            display: inline-block;
            background-color: #6A0DAD;
            color: #fff;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-top: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>

<div class="container">
    <a href="<%= request.getContextPath() %>/sessions?action=listar_session&projectId=${param.projectId}" class="back-link">
        <fmt:message key="list_back_button" />
    </a>
    <h1><fmt:message key="update_description_title" /></h1>
    <div class="strategy-info">
        <strong><fmt:message key="selected_strategy" />:</strong>
        ${strategy.description}
    </div>

    <form method="get" action="<%= request.getContextPath() %>/sessions">
        <input type="hidden" name="action" value="updateDescription" />
        <input type="hidden" name="sessionId" value="${session.id}" />
        <input type="hidden" name="projectId" value="${param.projectId}" />

        <label for="description"><fmt:message key="label_bugs" /></label>
        <textarea id="description" name="description" required>Bug: </textarea>

        <button type="submit"><fmt:message key="button_update_description" /></button>
    </form>

    <div class="current-description">
        <strong><fmt:message key="current_description" />:</strong><br />
        ${session.description}
    </div>
</div>

</body>
</html>
