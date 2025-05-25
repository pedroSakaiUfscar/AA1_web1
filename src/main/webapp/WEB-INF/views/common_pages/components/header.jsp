<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${sessionScope.locale}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sua Página</title>
    <style>
        .language-selector-custom {
            padding: 10px 30px 10px 10px;
            font-size: 14px;
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;

            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;

            background-image: url('data:image/svg+xml;utf8,<svg fill="%234b0082" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 20px auto;
        }

        .language-selector-custom:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.2);
        }

        .language-selector-custom::-ms-expand {
            display: none;
        }

        nav {
            background-color: #f8f9fa;
            padding: 15px 30px;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            width: 100%;
            position: absolute;
            top: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        nav a {
            text-decoration: none;
        }

        nav button {
            padding: 10px 16px;
            font-size: 14px;
            background-color: #6A0DAD;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>

<nav>
    <select id="languageSelector" onchange="changeLanguage(this)" class="language-selector-custom" style="margin-right: 25px;">
        <option value="pt_BR" <c:if test="${sessionScope.locale.toString() == 'pt_BR' || sessionScope.locale.toString() == 'pt'}">selected</c:if>>
            <fmt:message key="portuguese" />
        </option>
        <option value="en_US" <c:if test="${sessionScope.locale.toString() == 'en_US' || sessionScope.locale.toString() == 'en'}">selected</c:if>>
            <fmt:message key="english" />
        </option>
    </select>

    <c:if test="${not empty sessionScope.loggedUser}">
        <a href="${pageContext.request.contextPath}/logout">
            <button type="button">
                <fmt:message key="logout" />
            </button>
        </a>
    </c:if>
</nav>
<hr style="margin-top: 75px;"/>

<%-- Script JavaScript para lidar com a mudança no <select> --%>
<script>
    function changeLanguage(selectElement) {
        const selectedLanguage = selectElement.value;

        if (selectedLanguage) {
            window.location.href = '${pageContext.request.contextPath}/setLocale?lang=' + selectedLanguage;
        }
    }
</script>

</body>
</html>