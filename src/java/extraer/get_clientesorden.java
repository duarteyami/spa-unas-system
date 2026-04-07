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

@WebServlet(urlPatterns = {"/extraer/get_clientesorden"})
public class get_clientesorden extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(get_clientesorden.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                String filtro = request.getParameter("filtro");
                String sql = "SELECT id_cliente, cl_nombre, cl_apellido, cl_cedula FROM clientes "
                           + "WHERE cl_nombre LIKE '%" + filtro + "%' "
                           + "OR cl_apellido LIKE '%" + filtro + "%' "
                           + "OR cl_cedula LIKE '%" + filtro + "%' "
                           + "ORDER BY cl_nombre";
                ResultSet rs = cn.consultar(sql);
                while (rs.next()) {
                    out.println("<tr onclick=\"seleccionarCliente(" + rs.getString("id_cliente") + ", '" 
                              + rs.getString("cl_nombre") + " " + rs.getString("cl_apellido") + "')\" style=\"cursor:pointer;\">");
                    out.println("<td>" + rs.getString("id_cliente") + "</td>");
                    out.println("<td>" + rs.getString("cl_nombre") + "</td>");
                    out.println("<td>" + rs.getString("cl_apellido") + "</td>");
                    out.println("<td>" + rs.getString("cl_cedula") + "</td>");
                    out.println("</tr>");
                }
            } catch (SQLException ex) {
                Logger.getLogger(get_clientesorden.class.getName()).log(Level.SEVERE, null, ex);
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
        return "Busca clientes";
    }
}
