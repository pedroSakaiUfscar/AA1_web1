<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bem-vindo ao Projeto AA1</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f9f9f9;
            padding-top: 50px;
        }
        h1 {
            color: #333;
        }
        p {
            color: #555;
            font-size: 18px;
        }
        button {
            background-color: #4CAF50; /* Verde */
            color: white;
            padding: 10px 20px;
            margin-top: 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Bem-vindo ao Projeto AA1</h1>
    <p>Este projeto é dedicado à gestão de estratégias de teste! Clique no botão abaixo para explorar as estratégias disponíveis.</p>

    <!-- Botão que redireciona para /strategies -->
    <form action="<%= request.getContextPath() %>/strategies" method="get">
        <button type="submit">Ver Estratégias de Teste</button>
    </form>
</body>
</html>