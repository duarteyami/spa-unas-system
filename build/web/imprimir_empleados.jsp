<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="javax.swing.JOptionPane"%>
<<%@ page language="java" import="java.sql.*" %>
<%@page import= "net.sf.jasperreports.engine.*"%>
<%@page import= "net.sf.jasperreports.engine.JRException"%>
<%@page import= "net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import= "net.sf.jasperreports.engine.util.*"%>
<%@page import= "net.sf.jasperreports.engine.JasperReport"%>
<%@page import= "net.sf.jasperreports.engine.JRRuntimeException"%>
<%@page import= "net.sf.jasperreports.engine.JRResultSetDataSource"%>
<%@page import= "net.sf.jasperreports.engine.JasperRunManager"%>
<jsp:useBean id="conexion" class="prgs.bdconexion" scope="page" />
<jsp:useBean id="dataSource" class="prgs.fuentedato" scope="page"/>
<jsp:useBean id="fech" class="prgs.formatofecha" scope="page"/>

<%@include  file="/chequearsesion.jsp" %>
<%
    //String dep = request.getParameter("mar_cod"); //!= null ? request.getParameter("iddeposito") : "";
    ResultSet resultado = null;
    // Crear objeto de conexion al DB
    Connection cn = conexion.crearConexion();
    // Asignar conexion al objeto manejador de datos
    dataSource.setConexion(cn);
%>

<%
    File reporte = new File(application.getRealPath("reportes/reporte_empleados.jasper"));
    if (!reporte.exists()) {
        throw new JRRuntimeException("No se encuentra el archivo reporte.");
    } else {
        JasperReport masterReport = null;
        try {
            masterReport = (JasperReport) JRLoader.loadObject(reporte);
        } catch (JRException e) {
            System.out.println("Error cargando el reporte maestro: " + e.getMessage());
            e.printStackTrace();
            System.exit(3);
        }
    }
    try {
        Statement st = cn.createStatement();
        resultado = st.executeQuery("SELECT * FROM empleado");                       
                       
    } catch (Exception e) {
        JOptionPane.showMessageDialog(null, "error de conexion" + e);
    }
    JRResultSetDataSource jrRS = new JRResultSetDataSource(resultado);
    Map masterParams = new HashMap();
    //Aqui se envia los parametros al jasper
    //masterParams.put("anho", ano);
    byte[] bytes = JasperRunManager.runReportToPdf(reporte.getPath(), masterParams, jrRS);
    response.setContentType(
            "application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream ouputStream = response.getOutputStream();
    ouputStream.write(bytes,
            0, bytes.length);
    ouputStream.flush();
    ouputStream.close();
    //  }
%>