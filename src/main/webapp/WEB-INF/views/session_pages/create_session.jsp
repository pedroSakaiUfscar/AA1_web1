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
   </head>
   <body>
      <div>
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
                <input type="text" id="projetoId" name="projetoId" />

                <button type="submit">
                    <fmt:message key="create_session_submit_button" />
                </button>
            </form>
      </div>
   </body>
</html>