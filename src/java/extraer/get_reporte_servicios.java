package extraer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prgs.bdconexion;

@WebServlet(urlPatterns = {"/extraer/get_reporte_servicios"})
public class get_reporte_servicios extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(get_reporte_servicios.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                String desde = request.getParameter("desde");
                String hasta = request.getParameter("hasta");

                String sql = "SELECT s.serv_fecha, ts.tip_serv_descri, "
                           + "ds.ser_cantidad, ds.ser_precio, ds.ser_total, "
                           + "c.cl_nombre, c.cl_apellido "
                           + "FROM detalle_servicio ds "
                           + "INNER JOIN servicio s ON ds.id_servicio = s.id_servicio "
                           + "INNER JOIN tipo_servicio ts ON ds.id_tip_serv = ts.id_tipo_serv "
                           + "INNER JOIN clientes c ON s.id_cliente = c.id_cliente "
                           + "WHERE s.serv_fecha BETWEEN STR_TO_DATE('" + desde + "', '%d/%m/%Y') "
                           + "AND STR_TO_DATE('" + hasta + "', '%d/%m/%Y') "
                           + "ORDER BY s.serv_fecha";

                ResultSet rs = cn.consultar(sql);
                long totalGeneral = 0;

                while (rs.next()) {
                    long total = rs.getLong("ser_total");
                    totalGeneral += total;
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("serv_fecha") + "</td>");
                    out.println("<td>" + rs.getString("cl_nombre") + " " + rs.getString("cl_apellido") + "</td>");
                    out.println("<td>" + rs.getString("tip_serv_descri") + "</td>");
                    out.println("<td>" + rs.getString("ser_cantidad") + "</td>");
                    out.println("<td>Gs. " + String.format("%,d", rs.getInt("ser_precio")).replace(",", ".") + "</td>");
                    out.println("<td>Gs. " + String.format("%,d", total).replace(",", ".") + "</td>");
                    out.println("</tr>");
                }

                // Fila del total general
                out.println("<tr class='table-success fw-bold'>");
                out.println("<td colspan='5' class='text-end'>TOTAL GENERAL:</td>");
                out.println("<td>Gs. " + String.format("%,d", totalGeneral).replace(",", ".") + "</td>");
                out.println("</tr>");

            } catch (SQLException ex) {
                Logger.getLogger(get_reporte_servicios.class.getName()).log(Level.SEVERE, null, ex);
            }
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
        return "Reporte de servicios por rango de fechas";
    }
}
