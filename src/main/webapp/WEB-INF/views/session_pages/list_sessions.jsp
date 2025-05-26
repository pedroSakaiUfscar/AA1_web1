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
    <title><fmt:message key="list_sessions_title" /></title>
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
            text-align: center;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f0e6ff;
            cursor: pointer;
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
    <a href="<%= request.getContextPath() %>/projects" class="back-link">
        <fmt:message key="list_back_button" />
    </a>

    <h1><fmt:message key="list_sessions_title" /></h1>
    <a href="<%= request.getContextPath() %>/sessions?projectId=${param.projectId}" class="button">
        <fmt:message key="create_session_button" />
    </a>

    <table>
        <thead>
            <tr>
                <th><fmt:message key="session_id" /></th>
                <th><fmt:message key="tester_name" /></th>
                <th><fmt:message key="status" /></th>
                <th><fmt:message key="description_session" /></th>
                <th><fmt:message key="duration_session" /></th>
                <th><fmt:message key="creation_date" /></th>
                <th><fmt:message key="start_date" /></th>
                <th><fmt:message key="finish_time" /></th>
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
                        <c:choose>
                            <c:when test="${not empty session.startDateTime}">
                                ${session.startDateTime}
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty session.finishDateTime}">
                                ${session.finishDateTime}
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${session.statusName == 'CREATED'}">
                                <form method="post" action="<%= request.getContextPath() %>/sessions">
                                    <input type="hidden" name="projectId" value="${param.projectId}" />
                                    <input type="hidden" name="action" value="start"/>
                                    <input type="hidden" name="sessionId" value="${session.id}"/>
                                    <button type="submit">
                                        <fmt:message key="start" />
                                    </button>
                                </form>
                            </c:when>
                            <c:when test="${session.statusName == 'IN_EXECUTION'}">
                                <form method="post" action="<%= request.getContextPath() %>/sessions">
                                    <input type="hidden" name="projectId" value="${param.projectId}" />
                                    <input type="hidden" name="action" value="finish"/>
                                    <input type="hidden" name="sessionId" value="${session.id}"/>
                                    <button type="submit">
                                        <fmt:message key="finish" />
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <span><fmt:message key="finished" /></span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty sessions}">
                <tr>
                    <td colspan="9" class="no-data">
                        <fmt:message key="no_sessions_found" />
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<script>
    function fetchSessions() {
        window.location.reload();
    }
    setInterval(fetchSessions, 10000);
</script>

</body>
</html>
