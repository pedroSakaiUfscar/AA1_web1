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
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            box-sizing: border-box;
        }

        h1 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }

        form {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
        }

        label {
            margin-top: 10px;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button[type="submit"] {
            background-color: #6A0DAD;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #4B0082;
        }

        button[type="submit"]:active {
            background-color: #2C0051;
        }
    </style>
</head>
<body>

    <h1><fmt:message key="create_title_session" /></h1>

    <form action="<%= request.getContextPath() %>/sessions" method="post">
        <input type="hidden" name="action" value="create" />

        <label for="strategyId">
            <fmt:message key="strategy_id" />
        </label>
        <input type="text" id="strategyId" name="strategyId" />

        <label for="description">
            <fmt:message key="description_session" />
        </label>
        <input type="text" id="description" name="description" />

        <label for="duration">
            <fmt:message key="duration_session" />
        </label>
        <input type="number" id="duration" name="duration" />

        <label for="projetoId">
            <fmt:message key="projeto_id" />
        </label>
        <input type="text" id="projetoId" name="projetoId" value="${param.projectId}" readonly />

        <button type="submit">
            <fmt:message key="create_session_submit_button" />
        </button>
    </form>

</body>
</html>
