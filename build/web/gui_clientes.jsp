<%@page import="prgs.bdconexion"%>
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
       <h1 style="text-align: center;">CLIENTES</h1>
    <div class="container" style="padding-top: 15px;">
        <div class="row">
            <div class="col-md-12">

                <form id="formulario" class="form-horizontal" role="form">
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="codigo">Código</label> 
                        </div>
                        <div class="col-md-2">
                            <input type="text" name="txtcodigo" id="txtcodigo" class="form-control" placeholder="Autoincrementable" disabled/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="txtnombre">Nombre</label> 
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="txtnombre" id="txtnombre" class="form-control" placeholder="Ingrese nombre" disabled=""/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="txtapellido">Apellido</label> 
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="txtapellido" id="txtapellido" class="form-control" placeholder="Ingrese apellido" disabled=""/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="txttelefono">Teléfono</label> 
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="txttelefono" id="txttelefono" class="form-control" placeholder="Ingrese teléfono" disabled=""/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="txtdireccion">Dirección</label> 
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="txtdireccion" id="txtdireccion" class="form-control" placeholder="Ingrese dirección" disabled=""/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="txtemail">Email</label> 
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="txtemail" id="txtemail" class="form-control" placeholder="Ingrese email" disabled=""/>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="txtci">Cédula</label> 
                        </div>
                        <div class="col-md-4">
                            <input type="text" name="txtci" id="txtci" class="form-control" placeholder="Ingrese cédula" disabled=""/>
                        </div>
                    </div>
                    
                    <!-- COMBOBOX DE CIUDAD -->
                    <div class="form-group">
                        <div class="col-md-3"></div>
                        <div class="col-md-2">
                            <label class="control-label" for="cmbciudad">Ciudad</label> 
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" name="cmbciudad" id="cmbciudad" disabled>
                                <option value="">Seleccione ciudad...</option>
                                <%
                                    bdconexion cn = new bdconexion();
                                    cn.crearConexion();
                                    ResultSet rsciudad = cn.consultar("SELECT id_ciudad, ciu_descri FROM ciudad ORDER BY ciu_descri");
                                    while (rsciudad.next()) {
                                %>
                                <option value="<%= rsciudad.getString("id_ciudad")%>"><%= rsciudad.getString("ciu_descri")%></option>     
                                <%
                                    }
                                %>
                            </select>
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
                                        <th class="warning">Nombre</th>
                                        <th class="warning">Apellido</th>
                                        <th class="warning">Teléfono</th>
                                        <th class="warning">Dirección</th>
                                        <th class="warning">Email</th>
                                        <th class="warning">Cédula</th>
                                        <th class="warning">Ciudad</th>
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
    
    <script src="sql_clientes.js"></script>
    </body>
</html>
