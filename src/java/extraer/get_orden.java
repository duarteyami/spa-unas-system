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

@WebServlet(urlPatterns = {"/extraer/get_orden"})
public class get_orden extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(get_orden.class.getName()).log(Level.SEVERE, null, ex);
                out.println("{\"error\":\"Error de conexion\"}");
                return;
            }
            try {
                String idServicio = request.getParameter("idServicio");

                // Trae datos de la orden junto con cliente y profesional
                String sql = "SELECT s.id_servicio, s.serv_fecha, s.serv_total, "
                           + "s.id_tipo_pago, "
                           + "c.id_cliente, c.cl_nombre, c.cl_apellido, c.cl_cedula, "
                           + "e.id_empleado, e.edo_nombre, e.edo_apellido "
                           + "FROM servicio s "
                           + "INNER JOIN clientes c ON s.id_cliente = c.id_cliente "
                           + "INNER JOIN empleado e ON s.id_profesional = e.id_empleado "
                           + "WHERE s.id_servicio = " + idServicio;

                ResultSet rs = cn.consultar(sql);
                if (rs.next()) {
                    // Devuelve los datos en formato JSON
                    out.println("{"
                        + "\"id_servicio\": \"" + rs.getString("id_servicio") + "\","
                        + "\"serv_fecha\": \"" + rs.getString("serv_fecha") + "\","
                        + "\"serv_total\": \"" + rs.getString("serv_total") + "\","
                        + "\"id_cliente\": \"" + rs.getString("id_cliente") + "\","
                        + "\"cl_nombre\": \"" + rs.getString("cl_nombre") + "\","
                        + "\"cl_apellido\": \"" + rs.getString("cl_apellido") + "\","
                        + "\"cl_cedula\": \"" + rs.getString("cl_cedula") + "\","
                        + "\"id_empleado\": \"" + rs.getString("id_empleado") + "\","
                        + "\"edo_nombre\": \"" + rs.getString("edo_nombre") + "\","
                        + "\"edo_apellido\": \"" + rs.getString("edo_apellido") + "\""
                        + "}");
                } else {
                    out.println("{\"error\":\"Orden no encontrada\"}");
                }

            } catch (SQLException ex) {
                Logger.getLogger(get_orden.class.getName()).log(Level.SEVERE, null, ex);
                out.println("{\"error\":\"" + ex.getMessage() + "\"}");
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
        return "Trae datos de una orden por ID";
    }
}
