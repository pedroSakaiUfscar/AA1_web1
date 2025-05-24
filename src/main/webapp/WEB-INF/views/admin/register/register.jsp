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
    <title>Cadastro de Usuário</title>
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

        .form-group input[type="text"],
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
        .form-actions {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }


        .form-actions input[type="submit"] {
            flex-grow: 1;
        }

        .form-group select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: #fff;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%234b0082" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px top 50%;
            background-size: 20px auto;
        }

        .form-group select:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
        }
        .password-fields {
            display: none;
        }

    </style>
</head>
<body>
<h1><fmt:message key="register_title" /></h1>

<c:if test="${mensagens.existeErros}">
    <div id="erro">
        <ul>
            <c:forEach var="erro" items="${mensagens.erros}">
                <li> ${erro} </li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/register">
    <div class="form-group">
        <label for="usernameField"><fmt:message key="username" /></label>
        <input type="text" id="usernameField" name="username" value="${param.username}" required/>
    </div>
    <div class="form-group">
        <label for="emailField">E-mail</label>
        <input type="email" id="emailField" name="email" value="${param.email}" required/>
    </div>
    <div class="form-group">
        <label for="roleField"><fmt:message key="user_role" /></label>
        <select id="roleField" name="role" required>
            <option value=""><fmt:message key="register_role_select" /></option>
            <option value="TESTER" <c:if test="${param.role == 'TESTER'}">selected</c:if>><fmt:message key="tester"/></option>
            <option value="ADMIN" <c:if test="${param.role == 'ADMIN'}">selected</c:if>><fmt:message key="admin"/></option>
        </select>
    </div>
    <div class="password-fields" id="passwordFields">
        <div class="form-group">
            <label for="senhaField"><fmt:message key="password"/></label>
            <input type="password" id="senhaField" name="senha" required/>
        </div>
        <div class="form-group">
            <label for="confirmarSenhaField"><fmt:message key="confirm_password"/></label>
            <input type="password" id="confirmarSenhaField" name="confirmarSenha" required/>
        </div>
    </div>

    <div class="form-actions">
        <input type="submit" name="bOK" value="<fmt:message key="register_button"/>"/>
    </div>

</form>
<%--logica para rederizar os campos de senha apenas se o role selecionado for ADMIN--%>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const roleSelect = document.getElementById('roleField');
        const passwordFieldsContainer = document.getElementById('passwordFields');
        const senhaInput = document.getElementById('senhaField');
        const confirmarSenhaInput = document.getElementById('confirmarSenhaField');

        function togglePasswordFields() {
            if (roleSelect.value === 'ADMIN') {
                passwordFieldsContainer.style.display = 'block'; /
                senhaInput.setAttribute('required', 'required');
                confirmarSenhaInput.setAttribute('required', 'required');
            } else {
                passwordFieldsContainer.style.display = 'none';
                senhaInput.removeAttribute('required');
                confirmarSenhaInput.removeAttribute('required');
                senhaInput.value = '';
                confirmarSenhaInput.value = '';
            }
        }

        roleSelect.addEventListener('change', togglePasswordFields);

        togglePasswordFields();

        <c:if test="${param.role == 'ADMIN'}">
        passwordFieldsContainer.style.display = 'block';
        senhaInput.setAttribute('required', 'required');
        confirmarSenhaInput.setAttribute('required', 'required');
        </c:if>
    });
</script>
</body>
</html>
