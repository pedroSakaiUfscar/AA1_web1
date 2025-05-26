## AA1_web1
Atividade Avaliativa 1 para a matéria de WEB1

## Integrantes:
  - Pedro dos Santos Sakai - RA 824387
  - Maria Fernanda Falcão Queiroz e Silva - RA 821032
  - Gabriel Somensi Duarte - RA 824391
  - Thiago Eidi Hamada - RA 812243

## Estrutura do projeto:

<pre>
main -> java -> com.web <br />
  |-> bd -> contém uma classe para testar a configuração com o bd e o script para criá-lo localmente <br />
  |-> model -> contém as classes entidades da aplicação <br />
  |-> servlets -> contém todos os servlets da aplicação <br />
  |-> utils <br />
        |-> Config.java: contém todas constantes relacionas as configurações da aplicação, como as de conexão com bd por exemplo <br />
        |-> Routes.java: contém todas as rotas dos servlets <br />
main -> webapp -> views -> contém as páginas JSP da aplicação <br />
main -> resources <br />
  |-> messages_en_US.properties: contém todas as strings em inglês
  |-> messages_pt_BR.properties: contém todas as strings em português
</pre>

## Como rodar o projeto:
1. Tenha o mysql instalado e configurado na máquina
2. Copie o script em src/main/java/com/web/bd/script_bd e rode no mysql para criar o database'
3. Tenha o tomcat instalado e configurado na máquina, inicie seu servido
4. Adicione o .war salvo em war/AA1.war na pasta webapps do tomcat ou no manager app dele faça deploy do .war (geralemente em http://localhost:8080/manager/html)
5. Agora é só acessar o localhost + AA1! (Provavelmente http://localhost:8080/AA1/)
