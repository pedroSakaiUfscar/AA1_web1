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
        <fmt:message key="list_sessions_title" />
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

        table {
            width: 100%;
            max-width: 800px;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #6A0DAD;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        a.button {
            background-color: #6A0DAD;
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        a.button:hover {
            background-color: #4B0082;
        }
    </style>
</head>
<body>

    <h1><fmt:message key="list_sessions_title" /></h1>

    <table>
        <thead>
            <tr>
                <th><fmt:message key="session_id" /></th>
                <th><fmt:message key="tester_name" /></th>
                <th><fmt:message key="status" /></th>
                <th><fmt:message key="description_session" /></th>
                <th><fmt:message key="duration_session" /></th>
                <th><fmt:message key="creation_date" /></th>
                <th><fmt:message key="actions" /></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="session" items="${sessions}">
                <tr>
                    <td>${session.id}</td>
                    <td>${session.testerName}</td>
                    <td>${session.status}</td>
                    <td>${session.description}</td>
                    <td>${session.duration}</td>
                    <td>${session.creationDateTime}</td>
                    <td>
                        <a class="button" href="<%= request.getContextPath() %>/sessions?action=details&sessionId=${session.id}">
                            <fmt:message key="view_details" />
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
