<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Nova Estratégia</title>
</head>
<body>
    <div class="container">
        <h1>Cadastrar Nova Estratégia</h1>
        <form action="<%= request.getContextPath() %>/strategies/create" method="post">
            <label for="name">Nome:</label><br>
            <input type="text" id="name" name="name" required><br><br>

            <label for="description">Descrição:</label><br>
            <textarea id="description" name="description" required></textarea><br><br>

            <label for="examples">Exemplos:</label><br>
            <textarea id="examples" name="examples" required></textarea><br><br>

            <label for="tips">Dicas:</label><br>
            <textarea id="tips" name="tips" required></textarea><br><br>

            <button type="submit">Cadastrar Estratégia</button>
        </form>
        <br>
        <a href="<%= request.getContextPath() %>/strategies">Voltar para Listagem</a>
    </div>
</body>
</html>