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

@WebServlet(urlPatterns = {"/extraer/get_ordenes_pendientes"})
public class get_ordenes_pendientes extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(get_ordenes_pendientes.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                // Trae ordenes que NO tienen factura aun
              String sql = "SELECT s.id_servicio, s.serv_fecha, s.serv_total, "
           + "c.cl_nombre, c.cl_apellido, "
           + "e.edo_nombre, e.edo_apellido "
           + "FROM servicio s "
           + "INNER JOIN clientes c ON s.id_cliente = c.id_cliente "
           + "INNER JOIN empleado e ON s.id_profesional = e.id_empleado "
           + "WHERE NOT EXISTS (SELECT 1 FROM factura f WHERE f.id_servicio = s.id_servicio) "
           + "ORDER BY s.id_servicio DESC";
                ResultSet rs = cn.consultar(sql);
                while (rs.next()) {
                    out.println("<tr onclick=\"cargarOrden(" + rs.getString("id_servicio") + ")\" style=\"cursor:pointer;\">");
                    out.println("<td>" + rs.getString("id_servicio") + "</td>");
                    out.println("<td>" + rs.getString("serv_fecha") + "</td>");
                    out.println("<td>" + rs.getString("cl_nombre") + " " + rs.getString("cl_apellido") + "</td>");
                    out.println("<td>" + rs.getString("edo_nombre") + " " + rs.getString("edo_apellido") + "</td>");
                    out.println("<td>Gs. " + String.format("%,d", rs.getInt("serv_total")).replace(",", ".") + "</td>");
                    out.println("</tr>");
                }
            } catch (SQLException ex) {
                Logger.getLogger(get_ordenes_pendientes.class.getName()).log(Level.SEVERE, null, ex);
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
        return "Trae ordenes pendientes de factura";
    }
}
