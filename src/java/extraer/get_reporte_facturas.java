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

@WebServlet(urlPatterns = {"/extraer/get_reporte_facturas"})
public class get_reporte_facturas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(get_reporte_facturas.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                String desde = request.getParameter("desde");
                String hasta = request.getParameter("hasta");

                String sql = "SELECT f.id_factura, f.fact_fecha, f.fact_total, "
                           + "c.cl_nombre, c.cl_apellido, "
                           + "e.edo_nombre, e.edo_apellido "
                           + "FROM factura f "
                           + "INNER JOIN servicio s ON f.id_servicio = s.id_servicio "
                           + "INNER JOIN clientes c ON s.id_cliente = c.id_cliente "
                           + "INNER JOIN empleado e ON s.id_profesional = e.id_empleado "
                           + "WHERE f.fact_fecha BETWEEN STR_TO_DATE('" + desde + "', '%d/%m/%Y') "
                           + "AND STR_TO_DATE('" + hasta + "', '%d/%m/%Y') "
                           + "ORDER BY f.fact_fecha";

                ResultSet rs = cn.consultar(sql);
                long totalGeneral = 0;

                while (rs.next()) {
                    long total = rs.getLong("fact_total");
                    totalGeneral += total;
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("id_factura") + "</td>");
                    out.println("<td>" + rs.getString("fact_fecha") + "</td>");
                    out.println("<td>" + rs.getString("cl_nombre") + " " + rs.getString("cl_apellido") + "</td>");
                    out.println("<td>" + rs.getString("edo_nombre") + " " + rs.getString("edo_apellido") + "</td>");
                    out.println("<td>Gs. " + String.format("%,d", total).replace(",", ".") + "</td>");
                    out.println("</tr>");
                }

                // Fila del total general
                out.println("<tr class='table-success fw-bold'>");
                out.println("<td colspan='4' class='text-end'>TOTAL GENERAL:</td>");
                out.println("<td>Gs. " + String.format("%,d", totalGeneral).replace(",", ".") + "</td>");
                out.println("</tr>");

            } catch (SQLException ex) {
                Logger.getLogger(get_reporte_facturas.class.getName()).log(Level.SEVERE, null, ex);
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
        return "Reporte de facturas por rango de fechas";
    }
}
