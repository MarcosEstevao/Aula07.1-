
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.NumberFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    </head>
    <body>
        <%@include file="WEB-INF/header.jspf"%>
        <div class="container"> 
            <div class="card-panel teal lighten-2"><b>Tabela Price</b>, também chamado de amortização francesa, tem como principal característica é apresentar prestações (ou parcelas) iguais.</div>
            <form class="col s12" action="#price">
                <div class="card row ">
                    <div class="input-field col s4">
                        <input type="text" name="vlEmprestimo" id="vlEmprestimo"  />
                        <label for="vlEmprestimo">Valor do emprestimo</label>
                    </div>
                    <div class="input-field col s2">
                        <input type="text" name="vlEntrada" id="vlEntrada"  /> <label
                            for="vlEntrada">Valor da entrada</label>
                    </div>
                    <div class="input-field col s2">
                        <input id="vlJuros" type="text" name="vlJuros"> <label
                            for="vlJuros">Taxa de Juros</label>
                    </div>
                    <div class="input-field col s2">
                        <input id="qtMeses" type="text" name="qtMeses"> <label
                            for="qtMeses">Quantidade de meses</label>
                    </div>
                    <div class="input-field col s2">
                        <button class="btn waves-effect waves-light light-blue grey darken-4"
                                type="submit" name="action">
                            Calcular <i class="material-icons right">send</i>
                        </button>
                    </div>
                </div>

            </form>
            <%
                String vlEmprestimo = request.getParameter("vlEmprestimo");
                String vlEntrada = request.getParameter("vlEntrada");
                String vlJuros = request.getParameter("vlJuros");
                String qtMeses = request.getParameter("qtMeses");

                if (request.getParameter("action") != null) {
                    if ((vlEmprestimo != "" && vlEmprestimo != null) || (vlEntrada != "" && vlEntrada != null)
                            || (vlJuros != "" && vlJuros != null) || (qtMeses != "" && qtMeses != null)) {
                        try {
                            float emprestimo = Float.parseFloat(vlEmprestimo);
                            float entrada = Float.parseFloat(vlEntrada);
                            float taxajuros = Float.parseFloat(vlJuros);
                            int meses = Integer.parseInt(qtMeses);
                            double prestacao, juros, saldodev, amort;
                            double totpres = 0;
                            double totju = 0;
                            double totamo = 0;
                            saldodev = (emprestimo - entrada);
                            prestacao = (saldodev * (((Math.pow((1 + (taxajuros / 100)), meses)) * (taxajuros / 100))
                                    / ((Math.pow((1 + (taxajuros / 100)), meses)) - 1)));
                            if ((emprestimo >= 1) && (entrada >= 0) && (taxajuros >= 1) && (meses >= 1)) {
            %>
            <%try {%>
            <%int n = Integer.parseInt(request.getParameter("n"));%>
            <hr class="my-4" />
            <table class="striped">
                <thead>
                    <tr>
                        <th>Índice</th>
                        <th>Número</th>
                    </tr>
                </thead>
                <%for (int i = 1; i <= n; i++) {%>
                <tbody>
                    <tr>
                        <th><%=i%></th>
                        <td><%=(int) (Math.random() * 1000)%></td>
                    </tr>
                </tbody>
                <%}%>
            </table>
            <%} catch (Exception ex) {%>
            <div class="container">
                <%}%>
                <hr class="my-4">
                <table class="striped responsive-table">
                    <thead>
                        <tr>
                            <th>Período</th>
                            <th>Prestação</th>
                            <th>Juros</th>
                            <th>Amortização</th>
                            <th>Saldo Devedor</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td>0</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(saldodev)%></td>
                        </tr>
                        <%
                            for (int i = 1; i <= meses; i++) {
                                juros = (saldodev * (taxajuros / 100));
                                amort = prestacao - juros;
                                saldodev = saldodev - amort;
                                totpres = totpres + prestacao;
                                totju = totju + juros;
                                totamo = totamo + amort;
                                if (saldodev < 0) {
                                    saldodev = 0;
                                }
                        %>
                        <tr>
                            <td><%=i%></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(prestacao)%></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(juros)%></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(amort)%></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(saldodev)%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td><%="TOTAL"%></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(totpres)%></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(totju)%></td>
                            <td><%=NumberFormat.getCurrencyInstance().format(totamo)%></td>
                            <td>-</td>
                        </tr>

                    </tbody>
                </table>
            </div>
            <%
        } else {%>
            <p style="background-color:tomato;">Escolha inválida.</p>

            <%
                            }
                        } catch (NumberFormatException e) { %>
            <p style="background-color:tomato;">Escolha inválida.</p>
            <%
                }
            } else {%>
            <p style="background-color:tomato;">Escolha inválida.</p>

            <%
                    }
                } 
            %>
        </div>
        <%@include file="WEB-INF/footer.jspf"%>
    </body>
</html>