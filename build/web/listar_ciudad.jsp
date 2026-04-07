
<%@page import="prgs.bdconexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/alertify.core.css">
        <link rel="stylesheet" type="text/css" href="css/alertify.default.css">
        <link rel="stylesheet" type="text/css" href="css/chosenselect.css">
        <title> Listar ciudad</title>
        
        <%
            bdconexion bd = new bdconexion();
            bd.crearConexion();
            bd.listar_datos("SELECT * FROM ciudad");
            
         %>
    </head>

    <body>

    <center>
        <h1>ciudades registradas</h1>
        <br>
        <table border="0" width="60%">
            
            <tr>
                
                <td>
                    <a href="menu.jsp">
                        <input type="image" src="imagenes/printer.png">
                        Volver a Menu Principal
                    </a> 
                </td>

                <td>
                    <a href="imprimir_ciudad.jsp">
                        <input type="image" src="imagenes/printer.png">
                        Imprimir Lista de ciudades
                    </a> 
                </td>
            </tr>
        </table>
        
      <!--  <table border = "1" width="80%"> -->
            <div class="panel panel-success" id="panelBuscador">
                            <div class="panel-heading"><strong>ciudades</strong></div>
                            <div class="panel-body">
                                
                                
                                <table class="table table-hover" id="grillabuscador">
                                    <thead>
                                        <tr class="warning">
            <tr> 
                <th>CODIGO</th> 
                <th>Nombre</th> 
                
            </tr>
            <%
                try {
                    while (bd.rs.next()) {
                        out.println("<tr>");

                        out.println("<td>");
                        out.println(bd.rs.getString("id_ciudad"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("ciu_descri"));
                        out.println("</td>");
                   
                                                
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    out.println(e);
                }

            %>

        </table>
    </center>
<script src="js/jquery-1.12.2.min.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/alertify.js"></script> 
<script src="js/chosenselect.js"></script> 
</body>

</html>
