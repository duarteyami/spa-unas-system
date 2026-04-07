<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="conexion" class="prgs.bdconexion" scope="page" />
<%
Connection cn = conexion.crearConexion();

String usu = request.getParameter("usuario");
String cla = request.getParameter("clave");

String sql = "SELECT edo_nombre, edo_nivel FROM empleado WHERE edo_usuario = ? AND edo_contrasenia = ? AND edo_estado = 'activo'";
PreparedStatement ps = cn.prepareStatement(sql);
ps.setString(1, usu);
ps.setString(2, cla);

ResultSet rs = ps.executeQuery();

if (rs.next()) {
    HttpSession sesionOk = request.getSession(true);
    sesionOk.setAttribute("usuario", rs.getString("edo_nombre"));
    sesionOk.setAttribute("nivel", rs.getString("edo_nivel"));
    response.sendRedirect("menu.jsp");
} else {
%>
<jsp:forward page="gui_acceso.jsp">
    <jsp:param name="error" value="Usuario y/o clave incorrectos-- usuaario INACTIVO"/>
</jsp:forward>
<%
}

rs.close();
ps.close();
cn.close();
%>
