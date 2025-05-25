
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
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

    #erro {
    background-color: #ffe0e0;
    border: 1px solid #ff9999;
    color: #cc0000;
    padding: 10px 20px;
    margin-bottom: 20px;
    border-radius: 5px;
    width: 100%;
    max-width: 400px;
    box-sizing: border-box;
    }

    #erro ul {
    list-style: none;
    padding: 0;
    margin: 0;
    }

    #erro li {
    margin-bottom: 5px;
    }

    form {
    background-color: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 400px;
    box-sizing: border-box;
    }

    .form-group {
        margin-bottom: 15px;
        width: 100%;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        color: #555;
        font-weight: bold;
    }

    .form-group input[type="email"],
    .form-group input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .form-actions {
        margin-top: 30px;
        text-align: center;
    }

    .form-actions input[type="submit"] {
        width: 100%;
    }

    input[type="submit"] {
    background-color: #6A0DAD;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    width: 100%;
    transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
    background-color: #4B0082;
    }

    input[type="submit"]:active {
    background-color: #2C0051;
    }

    .login-link {
        text-align: center;
        margin-top: 15px;
        color: #555;
        font-size: 0.95em;
        width: 100%;
        max-width: 400px;
        box-sizing: border-box;
    }

    .login-link a {
        color: #6A0DAD;
        text-decoration: none;
        font-weight: bold;
        transition: color 0.3s ease;
    }

    .login-link a:hover {
        color: #4B0082;
        text-decoration: underline;
    }
    </style>

</head>
<body>
<%@ include file="/WEB-INF/views/common_pages/components/header.jsp" %>
<h1>Login</h1>
<c:if test="${mensagens.existeErros}">
    <div id="erro">
        <ul>
            <c:forEach var="erro" items="${mensagens.erros}">
                <li> ${erro} </li>
            </c:forEach>
        </ul>
    </div>
</c:if>
<form method="post" action="${pageContext.request.contextPath}/">
    <div class="form-group">
        <label for="emailField">Email</label>
        <input type="email" id="emailField" name="email" value="${param.email}"/>
    </div>
    <div class="form-group">
        <label for="senhaField"><fmt:message key="password"/></label>
        <input type="password" id="senhaField" name="senha"/>
    </div>
    <div class="form-actions">
        <input type="submit" name="bOK" value=<fmt:message key="login_button"/>>
    </div>
    <div class="login-link">
        <fmt:message key="dont_have_account"/> <a href="${pageContext.request.contextPath}/home"><fmt:message key="continue_as_guest"/></a>
    </div>
</form>
</body>
</html>