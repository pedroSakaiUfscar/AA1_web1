    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
    <%@ page import="com.web.model.Strategy" %>
    <!DOCTYPE html>
    <html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listagem de Estratégias</title>
    </head>
    <body>
        <div class="container">
            <br>
            <a href="<%= request.getContextPath() %>/">Voltar</a>
            <br>
            <br>
            <form action="strategies/create" method="get">
                <button type="submit">Cadastrar Nova Estratégia</button>
            </form>

            <h1>Listagem de Estratégias</h1>
            <table border="1" style="width: 100%; text-align: left; border-collapse: collapse;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Descrição</th>
                        <th>Exemplos</th>
                        <th>Dicas</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Recupera a lista de estratégias passada pelo servlet
                        List<Strategy> strategies = (List<Strategy>) request.getAttribute("strategies");

                        // Valida se a lista está nula ou vazia
                        if (strategies != null && !strategies.isEmpty()) {
                            for (Strategy strategy : strategies) {
                    %>
                    <tr>
                        <td><%= strategy.getId() %></td>
                        <td><%= strategy.getName() %></td>
                        <td><%= strategy.getDescription() %></td>
                        <td><%= strategy.getExamples() %></td>
                        <td><%= strategy.getTips() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center;">Nenhuma estratégia encontrada.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
    </html>