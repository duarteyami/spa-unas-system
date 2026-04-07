<%@ page session="true" %>
<%@include  file="chequearsesion.jsp" %>

<%
    String usuariodelacceso = (String) sesionOk.getAttribute("usuario");
    String nivel = (String) sesionOk.getAttribute("nivel");
 %>
 

<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MENU</title>
        <link href="graficos/unidad.ico" rel="shortcut icon">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/menuresponsive.css"/>
        <style>
    body {
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-image: url('images/fondo.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        height: 100vh;
    }

    /* Sidebar */
    .sidebar { position: fixed; width: 220px; height: 100%; background-color: rgba(52, 58, 64, 0.95); color: white; overflow-y: auto; padding-top: 20px; }
    .sidebar h2 { text-align: center; color: #ffc107; margin-bottom: 20px; }
    .sidebar ul { list-style: none; padding: 0; }
    .sidebar ul li { padding: 12px 20px; cursor: pointer; transition: 0.2s; }
    .sidebar ul li:hover { background-color: #495057; }
    .sidebar ul li i { margin-right: 10px; }
    .submenu { display: none; list-style: none; padding-left: 20px; }
    .submenu li { padding: 8px 20px; font-size: 0.95em; background-color: #495057; }
    .submenu li:hover { background-color: #6c757d; }

    /* Content */
    .content { margin-left: 220px; padding: 20px; height: 100vh; background: rgba(255,255,255,0.85); border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.2); overflow: hidden; }
    iframe { width: 100%; height: 100%; border: none; background: transparent; }

    /* Chat flotante */
    #chatBot { position: fixed; bottom: 200px; right: 20px; width: 320px; height: 400px; border: 1px solid #ccc; background: white; display: none; flex-direction: column; box-shadow: 0 4px 15px rgba(0,0,0,0.3); border-radius: 10px; z-index: 9999; overflow: hidden; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    #chatHeader { background: #C6275E; color: white; padding: 10px; cursor: pointer; font-weight: bold; display: flex; justify-content: space-between; align-items: center; }
    #chatBody { flex: 1; padding: 10px; overflow-y: auto; background: #f8f9fa; display: flex; flex-direction: column; }
    #chatBody p.user { background-color: #FF69B4; color: white; padding: 8px 12px; border-radius: 20px 20px 0 20px; max-width: 80%; margin: 5px 0; align-self: flex-end; float: right; }
    #chatBody p.bot { background-color: #DA0E85; color: #FFB6C1; padding: 8px 12px; border-radius: 20px 20px 20px 0; max-width: 80%; margin: 5px 0; align-self: flex-start; float: left; }
    #chatInput { display: flex; border-top: 1px solid #ccc; }
    #chatInput input { flex: 1; padding: 8px; border: none; font-size: 0.9em; }
    #chatInput button { padding: 8px 12px; border: none; background: #DA0E85; color: white; cursor: pointer; font-weight: bold; }
    #chatToggle { position: fixed; bottom: 20px; right: 20px; background: #DA0E85; color: white; padding: 12px; border-radius: 50%; cursor: pointer; z-index: 9999; font-size: 1.3em; text-align: center; box-shadow: 0 4px 10px rgba(0,0,0,0.3); }
    #chatToggle:hover { background: #0056b3; }
</style>

<script>
function toggleSubmenu(id) { const submenu = document.getElementById(id); submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block'; }
function loadPage(url) { document.getElementById('contentFrame').src = url; }

/* Chat JS */
function toggleChat() { const chat = document.getElementById("chatBot"); chat.style.display = chat.style.display === "flex" ? "none" : "flex"; }

function enviarPregunta() {
    var pregunta = document.getElementById("pregunta").value.trim();
    if(pregunta === "") return;

    appendMessage("Tú", pregunta);

    fetch('chat', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'pregunta=' + encodeURIComponent(pregunta)
    })
    .then(response => response.text())
    .then(data => appendMessage("Bot", data))
    .catch(err => appendMessage("Bot", "Error al enviar la pregunta."));

    document.getElementById("pregunta").value = "";
}

function appendMessage(sender, message) {
    const chatBody = document.getElementById("chatBody");
    const p = document.createElement("p");
    p.classList.add(sender === "Tú" ? "user" : "bot");
    p.textContent = message;
    chatBody.appendChild(p);
    chatBody.scrollTop = chatBody.scrollHeight;
}
</script>
</head>
        
    </head>
    
    
    <body>
    <img class="navbar-bg-img" src="imagenes/unha.png"/>
        <div class="container">
            <header>
                <nav class="navbar">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#menu"  aria-expanded="false">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="menu.jsp"><img src="imagenes/unha.png" alt="Logo unias"/></a>
                        </div>
                        <div class="collapse navbar-collapse" id="menu">
                            <ul class="navbar-nav"> 
                                <!-- MENU DE Reportes -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span>REFERENCIALES<b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                             
                                         
                                         <li><a href="gui_clientes.jsp">CLIENTES</a></li>
                                              
                                            <% if(nivel.equals("1")){ %>            
                                         <li><a href="gui_empleados.jsp">EMPLEADOS</a></li>
                                          <% } %>  
                                         <li><a href="gui_ciudad.jsp">CIUDAD</a></li>
                                         <li><a href="gui_tipo_servicio.jsp">TIPO DE SERVICIO</a></li>
                                         <li><a href="gui_forma_pago.jsp">TIPO DE PAGO</a></li>
                                    </ul>
                                </li> 
                                                                                                
                            </ul>
                              <ul class="navbar-nav"> 
                                <!-- MENU MOV -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span>SERVICIOS<b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="ordenServicio.jsp">orden de servicio</a></li>
                                         
                              
                                    </ul>
                                </li> 
                                                                                                
                            </ul>
                                          <ul class="navbar-nav"> 
                                <!-- fact MOV -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span>FACTURACION<b class="caret"></b></a>
                                    <% if(nivel.equals("1")){ %> 
                                    <ul class="dropdown-menu">
                                        <li><a href="factura.jsp">FACTURACION</a></li>
                                           <% } %>
                              
                                    </ul>
                                </li> 
                                                                                                
                            </ul>
                            <ul class="navbar-nav"> 
                                <!-- MENU MOV -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span>INFORMES<b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="listar_ciudad.jsp">CIUDADES</a></li>
                                        <li><a href="listar_clientes.jsp">CLIENTES</a></li>
                                        <li><a href="listar_tipopago.jsp">TIPO DE PAGO</a></li>
                                        <li><a href="listar_tiposervicio.jsp">TIPO DE SERVICIOS</a></li>
                                        <li><a href="listar_empleados.jsp">FUNCIONARIOS</a></li>
                                        <li><a href="reportes.jsp">REPORTE DE FACTURAS Y SERVICIOS</a></li>
        
        
                                    </ul>
                                </li> 
                                                                                                
                            </ul>
                      
                              <ul class="navbar-nav"> 
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span> AYUDA <b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a title="INTERACTIVA" href="ayuda/ayudainteractiva.chm"><img src="imagenes/manual.png" width="20px" height="20px" background-position="left"/>INTERACTIVA</a></li> 
                                        <li><a title="MANUAL" href="ayuda/ManualUsuario.pdf"><img src="imagenes/manual.png" width="20px" height="20px" background-position="left"/>MANUAL</a></li> 
                                    </ul>
                                </li>
                              </ul>  
                 
                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#">
                                        <span class="glyphicon glyphicon-user"></span> 
                                         <%= usuariodelacceso %>
                                        <b class="caret"></b>
                                    </a>
                                        <ul class="dropdown-menu">
                                               <li><a href="cerrarsesion.jsp"><span class="glyphicon glyphicon-arrow-left"> Cerrar Sesion</span> </a></li>
                                        </ul>
                                </li>
                            </ul>
                            
                        </div>
                    </div>
                </nav>
            </header>
            
            <!-- -->
            <!-- Chat flotante -->
<div id="chatToggle" onclick="toggleChat()"><i class="fa fa-comments"></i></div>
<div id="chatBot">
    <div id="chatHeader" onclick="toggleChat()">
        <span>Chat del spa</span>
        <i class="fa fa-times" style="float:right; cursor:pointer;"></i>
    </div>
    <div id="chatBody"></div>
    <div id="chatInput">
        <input type="text" id="pregunta" placeholder="Escribe tu pregunta...">
        <button onclick="enviarPregunta()">Enviar</button>
    </div>
</div>
        </div>
                                        
        <script src="js/jquery-1.12.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/menuresponsive.js"></script>
        
    </body>
</html>
