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

@WebServlet(urlPatterns = {"/extraer/get_detalle_orden"})
public class get_detalle_orden extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(get_detalle_orden.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                String idServicio = request.getParameter("idServicio");

                // Trae los servicios del detalle junto con el nombre del tipo de servicio
                String sql = "SELECT ds.ser_codigo, ts.tip_serv_descri, ds.ser_precio, "
                           + "ds.ser_cantidad, ds.ser_total "
                           + "FROM detalle_servicio ds "
                           + "INNER JOIN tipo_servicio ts ON ds.id_tip_serv = ts.id_tipo_serv "
                           + "WHERE ds.id_servicio = " + idServicio;

                ResultSet rs = cn.consultar(sql);
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("ser_codigo") + "</td>");
                    out.println("<td>" + rs.getString("tip_serv_descri") + "</td>");
                    out.println("<td>Gs. " + String.format("%,d", rs.getInt("ser_precio")).replace(",", ".") + "</td>");
                    out.println("<td>" + rs.getString("ser_cantidad") + "</td>");
                    out.println("<td>Gs. " + String.format("%,d", rs.getInt("ser_total")).replace(",", ".") + "</td>");
                    out.println("</tr>");
                }

            } catch (SQLException ex) {
                Logger.getLogger(get_detalle_orden.class.getName()).log(Level.SEVERE, null, ex);
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
        return "Trae detalle de servicios de una orden";
    }
}
