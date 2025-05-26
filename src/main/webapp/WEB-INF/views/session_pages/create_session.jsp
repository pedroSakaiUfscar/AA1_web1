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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            min-height: 100vh;
            box-sizing: border-box;
        }

        .back-link {
            color: #6A0DAD;
            text-decoration: none;
            font-weight: 600;
            margin: 20px 0 10px 0;
            align-self: flex-start;
            transition: color 0.3s ease;
        }
        .back-link:hover {
            color: #4B0082;
            padding: 50px;
            text-decoration: underline;
        }

        h1 {
            color: #6A0DAD;
            margin-bottom: 30px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e0d9f7;
            width: 100%;
            max-width: 420px;
            text-align: center;
        }

        form {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        label {
            color: #444;
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
            font-size: 1rem;
        }

        select, input[type="number"] {
            width: 100%;
            padding: 12px 14px;
            border: 1.8px solid #ccc;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.25s ease;
            font-family: inherit;
        }

        select:focus, input[type="number"]:focus {
            border-color: #6A0DAD;
            outline: none;
            box-shadow: 0 0 6px rgba(106, 13, 173, 0.3);
        }

        button[type="submit"] {
            background-color: #6A0DAD;
            color: #fff;
            padding: 14px 22px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-top: 15px;
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
    <%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>
    <a href="<%= request.getContextPath() %>/sessions?action=listar_session&projectId=${param.projectId}" class="back-link">
        <fmt:message key="list_back_button" />
    </a>
    <h1><fmt:message key="create_title_session" /></h1>

    <form action="<%= request.getContextPath() %>/sessions" method="post">
        <input type="hidden" name="action" value="create" />

        <label for="strategyId">
            <fmt:message key="strategy_id" />
        </label>
        <select id="strategyId" name="strategyId" required>
            <option value="" disabled selected>-- Selecione a estratégia --</option>
            <c:forEach var="strategy" items="${strategies}">
                <option value="${strategy.id}">${strategy.name}</option>
            </c:forEach>
        </select>

        <input type="hidden" id="description" name="description" />

        <label for="duration">
            <fmt:message key="duration_session" />
        </label>
        <input type="number" id="duration" name="duration" min="1" />

        <input type="hidden" id="projetoId" name="projetoId" value="${param.projectId}" />

        <button type="submit">
            <fmt:message key="create_session_submit_button" />
        </button>
    </form>

</body>
</html>
