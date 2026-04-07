package prgs;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

@WebServlet(name = "imprimirFacturaServlet", urlPatterns = {"/imprimirFacturaServlet"})
public class imprimirFacturaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;

        try {
            // Obtener el id de la factura
            int idFactura = Integer.parseInt(request.getParameter("idFactura"));
            
       
            // Conectar a la BD
            bdconexion bd = new bdconexion();
            conn = bd.crearConexion();

            // Ruta del archivo .jrxml
           String rutaReporte = getServletContext().getRealPath("/reportes/reportefactura.jasper");


            // Compilar el reporte
            JasperReport jasperReport = (JasperReport) net.sf.jasperreports.engine.util.JRLoader.loadObject(rutaReporte);

            // Parámetros que se pasan al reporte
            Map<String, Object> parametros = new HashMap<>();
            parametros.put("id_factura", idFactura);
            
            java.sql.PreparedStatement ps = conn.prepareStatement(
                 "SELECT f.fact_total, SUM(dp.dp_monto) as total_pagado " +
                 "FROM factura f " +
                 "JOIN detalle_pago dp ON f.id_factura = dp.id_factura " +
                 "WHERE f.id_factura = ? GROUP BY f.id_factura"
                );
                ps.setInt(1, idFactura);
                java.sql.ResultSet rs = ps.executeQuery();
                int vuelto = 0;
                if (rs.next()) {
                    int totalOrden = rs.getInt("fact_total");
                    int totalPagado = rs.getInt("total_pagado");
                    vuelto = totalPagado - totalOrden;
                }
                parametros.put("vuelto", new Integer(vuelto));
                
            // Llenar el reporte con datos
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parametros, conn);

            // Exportar como PDF y mandarlo al navegador
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=factura_" + idFactura + ".pdf");

            OutputStream out = response.getOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, out);
            out.flush();
            out.close();

        } catch (Exception ex) {
    Logger.getLogger(imprimirFacturaServlet.class.getName()).log(Level.SEVERE, null, ex);
    response.setContentType("text/html");
    response.getWriter().println("ERROR al generar reporte: " + ex.getMessage());
    response.getWriter().println("<br>Causa: " + ex.getCause());
    response.getWriter().println("<br>Clase: " + ex.getClass().getName());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) { }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Imprime factura en PDF";
    }
}
