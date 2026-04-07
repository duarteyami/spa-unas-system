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

@WebServlet(urlPatterns = {"/extraer/get_empleado_select"})
public class get_empleado_select extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(get_empleado_select.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                String sql = "SELECT id_empleado, edo_nombre, edo_apellido FROM empleado ORDER BY edo_nombre";
                ResultSet rs = cn.consultar(sql);
                while (rs.next()) {
                    out.println("<option value='" + rs.getString("id_empleado") + "'>"
                              + rs.getString("edo_nombre") + " " + rs.getString("edo_apellido") + "</option>");
                }
            } catch (SQLException ex) {
                Logger.getLogger(get_empleado_select.class.getName()).log(Level.SEVERE, null, ex);
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
        return "Trae empleados para select";
    }
}
