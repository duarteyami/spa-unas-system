
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
        <title>Listar empleados</title>
        
        <%
            bdconexion bd = new bdconexion();
            bd.crearConexion();
            bd.listar_datos("SELECT * FROM empleado");
            
         %>
    </head>

    <body>

    <center>
        <h1>EMPLEADOS REGISTRADOS</h1>
        <br>
        <table border="0" width="60%">
            
            <tr>
                
                <td>
                    <a href="menu.jsp">
                        <input type="image" src="imagenes//printer.png">
                        Volver a Menu Principal
                    </a> 
                </td>

                <td>
                    <a href="imprimir_empleados.jsp">
                        <input type="image" src="imagenes/printer.png">
                        Imprimir Lista de Empleados
                    </a> 
                </td>
            </tr>
        </table>
        
      <!--  <table border = "1" width="80%"> -->
            <div class="panel panel-success" id="panelBuscador">
                            <div class="panel-heading"><strong>Empleados</strong></div>
                            <div class="panel-body">
                                
                                
                                <table class="table table-hover" id="grillabuscador">
                                    <thead>
                                        <tr class="warning">
            <tr> 
                <th>NOMBRE</th> 
                <th>APELLIDO</th> 
                <th>CEDULA</th>
                <th>ESTADO</th>
            </tr>
            <%
                try {
                    while (bd.rs.next()) {
                        out.println("<tr>");

                        out.println("<td>");
                        out.println(bd.rs.getString("edo_nombre"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("edo_apellido"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("edo_ci"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("edo_estado"));
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
