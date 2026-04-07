<%@include  file="chequearsesion.jsp" %>
<%
    String vusuario = (String) sesionOk.getAttribute("usuario");
%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="graficos/printer.png" rel="shortcut icon">
        
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/alertify.core.css">
        <link rel="stylesheet" type="text/css" href="css/alertify.default.css">
        
        <title>Clientes</title>
    </head>
    <body>
        <h1  style="text-align: center;"> AGREGAR FUNCIONARIO</h1>
        <div class="container" style="padding-top: 15px;">
            <div class="row">
                <div class="col-md-12">

                    <form id="formulario" class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">id</label> 
                            </div>
                            <div class="col-md-2">
                                <input type="text" name="txtcodigo" id="txtcodigo" class="form-control" placeholder="Autoincrementable" disabled/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">nombre</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtnombre" class="form-control" placeholder="Ingrese nombre" disabled=""/>
                            </div>
                        </div>
                          <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">apellido</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtapellido" class="form-control" placeholder="Ingrese apellido" disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">telefono</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txttelefono" class="form-control" placeholder="Ingrese telfono" disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">email</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtemail" class="form-control" placeholder="Ingrese direccion email" disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">cedula identidad</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtci" class="form-control" placeholder="Ingrese cedula " disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">direccion</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtdireccion" class="form-control" placeholder="Ingrese direccion" disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">estado civil</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtestadociv" class="form-control" placeholder="Ingrese estado civil" disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">usuario sistema</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtuser" class="form-control" placeholder="Ingrese usuario sistema" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">contraseña</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtpassword" class="form-control" placeholder="Ingrese contraseña en sistema" disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">estado</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtestado" class="form-control" placeholder="Ingrese estado" disabled=""/>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">nivel de usuario</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="txtdescripcion" id="txtnivel" class="form-control" placeholder="Ingrese nivel de acceso" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            
                            <div class="col-md-2">
                                <input id="btnAgregar" type="button" class="form-control btn-primary" value="Agregar" onclick="agregar();"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnModificar" type="button" class="form-control btn-warning" value="Modificar" onclick="modificar();"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnBorrar" type="button" class="form-control btn-danger" value="Borrar" onclick="borrar();"/>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <input id="btnCancelar" type="button" class="form-control btn-info" value="Cancelar" disabled="" onclick="cancelar();"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnGrabar" type="button" class="form-control btn-success" value="Grabar" disabled="" onclick="grabar();"/>
                            </div>
                            <div class="col-md-2">
                                <a href="menu.jsp"><input id="btnSalir" type="button" class="form-control btn-default" value="Salir"></a>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-4">
                                <input type="text" name="txtbuscador" id="txtbuscador" class="form-control" placeholder="Ingrese datos a buscar"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnBuscar" type="button" class="form-control btn-primary" value="Buscar" onclick="get_datos($('#txtbuscador').val());$('#txtbuscador').val('');">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-6">
                                <table class="table table-hover" id="grilla">
                                    <thead>
                                        <tr>
                                            <th class="warning">Código</th>
                                            <th class="warning">nombre</th>
                                            <th class="warning">apellido</th>
                                            <th class="warning">telefono</th>
                                            <th class="warning">email</th>
                                            <th class="warning">ci</th>
                                            <th class="warning">direccion</th>
                                            <th class="warning">est civ</th>
                                            <th class="warning">usuario</th>
                                             <th class="warning">contraseña</th>
                                            <th class="warning">estado</th>
                                            <th class="warning">nivel</th>
                                            
                                        </tr>
                                    
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <input type="hidden" id="operacion"/>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/jquery-1.12.2.min.js"></script> 
        <script src="js/bootstrap.min.js"></script> 
        <script src="js/alertify.js"></script> 
        
        <script src="sql_empleado.js"></script>
    </body>
</html>
