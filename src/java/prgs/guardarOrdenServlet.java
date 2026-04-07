package prgs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "guardarOrdenServlet", urlPatterns = {"/guardarOrdenServlet"})
public class guardarOrdenServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // Recibir los parámetros que manda el JSP
            String fecha         = request.getParameter("fecha");
            String idCliente     = request.getParameter("idCliente");
            String idProfesional = request.getParameter("idProfesional");
            String total         = request.getParameter("total");

            // Los detalles vienen como arrays (uno por cada servicio agregado)
            String[] precios       = request.getParameterValues("precios[]");
            String[] cantidades    = request.getParameterValues("cantidades[]");
            String[] subtotales    = request.getParameterValues("subtotales[]");
            String[] tiposServicio = request.getParameterValues("tiposServicio[]");

            bdconexion cn = new bdconexion();

            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(guardarOrdenServlet.class.getName()).log(Level.SEVERE, null, ex);
                out.println("ERROR AL CONECTAR: " + ex.getMessage());
                return;
            }

            try {
                // 1. Insertar cabecera en tabla servicio
               String sqlServicio = "INSERT INTO servicio (serv_fecha, id_cliente, id_profesional, serv_total) "
                   + "VALUES (STR_TO_DATE('" + fecha + "', '%d/%m/%Y'), "
                   + idCliente + ", "
                   + idProfesional + ", "
                   + total + ")";

                cn.st = cn.conexion.createStatement();
                cn.st.executeUpdate(sqlServicio, Statement.RETURN_GENERATED_KEYS);

                // Obtener el id_servicio generado automaticamente
                int idServicio = 0;
                ResultSet rsKeys = cn.st.getGeneratedKeys();
                if (rsKeys.next()) {
                    idServicio = rsKeys.getInt(1);
                }

                // 2. Insertar cada linea de detalle
                for (int i = 0; i < precios.length; i++) {
                    String sqlDetalle = "INSERT INTO detalle_servicio (ser_precio, ser_cantidad, ser_total, id_tip_serv, id_servicio) "
                                     + "VALUES ("
                                     + precios[i] + ", "
                                     + cantidades[i] + ", "
                                     + subtotales[i] + ", "
                                     + tiposServicio[i] + ", "
                                     + idServicio + ")";
                    cn.actualizar(sqlDetalle);
                }

                out.println("ORDEN GUARDADA CON EXITO - CODIGO: " + idServicio);

            } catch (Exception ex) {
                Logger.getLogger(guardarOrdenServlet.class.getName()).log(Level.SEVERE, null, ex);
                out.println("ERROR AL GUARDAR: " + ex.getMessage());
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
        return "Guarda Orden de Servicio";
    }
}
