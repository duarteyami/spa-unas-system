<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Dashboard Sistema Comercial</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
    #chatBot { position: fixed; bottom: 80px; right: 20px; width: 320px; height: 400px; border: 1px solid #ccc; background: white; display: none; flex-direction: column; box-shadow: 0 4px 15px rgba(0,0,0,0.3); border-radius: 8px; z-index: 9999; overflow: hidden; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
    #chatHeader { background: #007BFF; color: white; padding: 10px; cursor: pointer; font-weight: bold; display: flex; justify-content: space-between; align-items: center; }
    #chatBody { flex: 1; padding: 10px; overflow-y: auto; background: #f8f9fa; display: flex; flex-direction: column; }
    #chatBody p.user { background-color: #007BFF; color: white; padding: 8px 12px; border-radius: 20px 20px 0 20px; max-width: 80%; margin: 5px 0; align-self: flex-end; float: right; }
    #chatBody p.bot { background-color: #e9ecef; color: #212529; padding: 8px 12px; border-radius: 20px 20px 20px 0; max-width: 80%; margin: 5px 0; align-self: flex-start; float: left; }
    #chatInput { display: flex; border-top: 1px solid #ccc; }
    #chatInput input { flex: 1; padding: 8px; border: none; font-size: 0.9em; }
    #chatInput button { padding: 8px 12px; border: none; background: #007BFF; color: white; cursor: pointer; font-weight: bold; }
    #chatToggle { position: fixed; bottom: 20px; right: 20px; background: #007BFF; color: white; padding: 12px; border-radius: 50%; cursor: pointer; z-index: 9999; font-size: 1.3em; text-align: center; box-shadow: 0 4px 10px rgba(0,0,0,0.3); }
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
<body>

<div class="sidebar">
    <h2>Menú</h2>
    <ul>
        <li onclick="toggleSubmenu('adminSub')"><i class="fa fa-user-shield"></i> ADMINISTRADOR</li>
        <ul class="submenu" id="adminSub">
            <li onclick="loadPage('PerfilServlet')">Perfiles</li>
            <li onclick="loadPage('UsuarioServlet')">Usuarios</li>
            <li onclick="loadPage('CambiarClaveServlet')">Cambiar Contraseña</li>
        </ul>

        <li onclick="toggleSubmenu('refSub')"><i class="fa fa-database"></i> REFERENCIALES</li>
        <ul class="submenu" id="refSub">
            <li onclick="loadPage('CiudadServlet')">Ciudades</li>
            <li onclick="loadPage('TipoFacturaServlet')">Tipo de Facturas</li>           
            <li onclick="loadPage('ProductoServlet')">Productos</li>
            <li onclick="loadPage('EmpleadoServlet')">Empleados</li>
        </ul>

        <li onclick="toggleSubmenu('compraSub')"><i class="fa fa-truck"></i> COMPRAS</li>
        <ul class="submenu" id="compraSub">
            <li onclick="loadPage('ProveedorServlet')">Proveedores</li>
            <li onclick="loadPage('CompraServlet')">Compras</li>
        </ul>

        <li onclick="toggleSubmenu('ventaSub')"><i class="fa fa-shopping-cart"></i> VENTAS</li>
        <ul class="submenu" id="ventaSub">
            <li onclick="loadPage('FormaCobroServlet')">Forma de Cobros</li>
            <li onclick="loadPage('ClienteServlet')">Clientes</li>
            <li onclick="loadPage('VentaServlet')">Ventas</li>
        </ul>

        <li onclick="toggleSubmenu('infoSub')"><i class="fa fa-chart-line"></i> INFORMES</li>
        <ul class="submenu" id="infoSub">
            <li onclick="loadPage('InformeRefServlet')">Informes Referenciales</li>
            <li onclick="loadPage('InformeCompraServlet')">Informes de Compras</li>
            <li onclick="loadPage('InformeVentaServlet')">Informes de Ventas</li>
        </ul>
    </ul>
</div>

<div class="content">
    <iframe id="contentFrame" src=""></iframe>
</div>

<!-- Chat flotante -->
<div id="chatToggle" onclick="toggleChat()"><i class="fa fa-comments"></i></div>
<div id="chatBot">
    <div id="chatHeader" onclick="toggleChat()">
        <span>Chat - ElectroWeb</span>
        <i class="fa fa-times" style="float:right; cursor:pointer;"></i>
    </div>
    <div id="chatBody"></div>
    <div id="chatInput">
        <input type="text" id="pregunta" placeholder="Escribe tu pregunta...">
        <button onclick="enviarPregunta()">Enviar</button>
    </div>
</div>

</body>
</html>