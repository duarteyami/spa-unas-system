

<%@page import="prgs.bdconexion"%>
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


<%

    String condicion = request.getParameter("condicion");
    String nombre = request.getParameter("nombre");
    String idfactura = request.getParameter("codigo");
    
    ResultSet resultado=null ;

   bdconexion bd = new bdconexion(); 
   bd.crearConexion();



%>

<%


    File Reportes = new File(application.getRealPath("/reportes/"+nombre +".jasper"));
    if (!Reportes.exists()) {
        throw new JRRuntimeException("No se encuentra el archivo reporte.");
    } else {
        JasperReport masterReport = null;
        try {
            masterReport = (JasperReport) JRLoader.loadObject(Reportes);
        } catch (JRException e) {
            System.out.println("Error cargando el reporte maestro: " + e.getMessage());
            e.printStackTrace();
            System.exit(3);
        }
    }
    try {


        Statement st = bd.conexion.createStatement();
                       
        if(condicion.equals("Listar")) 
        {
           resultado = st.executeQuery("select * from reportefactura where Nrofactura= '"+idfactura+"'"); 
           //resultado = st.executeQuery("select * from reportefactura");  
        }
         
        if(condicion.equals("Facturas")) 
        {       
           resultado = st.executeQuery("select * from reportefactura where Nrofactura= '"+idfactura+"'"); 
            
        } 
          
           
    } catch (Exception e) {
        JOptionPane.showMessageDialog(null, "error de conexion" + e);
    }
    JRResultSetDataSource jrRS = new JRResultSetDataSource(resultado);
    Map masterParams = new HashMap();
    //Aqui se envia los parametros al jasper
    //masterParams.put("anho", ano);
    byte[] bytes = JasperRunManager.runReportToPdf(Reportes.getPath(), masterParams, jrRS);

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