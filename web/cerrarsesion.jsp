<%@ page session="true" %>
<%
HttpSession sesionOk = request.getSession();
sesionOk.invalidate();
%>

<jsp:forward page="gui_acceso.jsp"/>