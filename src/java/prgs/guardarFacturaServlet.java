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

@WebServlet(name = "guardarFacturaServlet", urlPatterns = {"/guardarFacturaServlet"})
public class guardarFacturaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            String fecha      = request.getParameter("fecha");
            String idServicio = request.getParameter("idServicio");
            String total      = request.getParameter("total");
            

            // Arrays de medios de pago
            String[] tiposPago = request.getParameterValues("tiposPago[]");
            String[] montos    = request.getParameterValues("montos[]");

            bdconexion cn = new bdconexion();
            try {
                cn.crearConexion();
            } catch (Exception ex) {
                Logger.getLogger(guardarFacturaServlet.class.getName()).log(Level.SEVERE, null, ex);
                out.println("ERROR AL CONECTAR: " + ex.getMessage());
                return;
            }

            try {
                // 1. Insertar cabecera en tabla factura
                String sqlFactura = "INSERT INTO factura (fact_fecha, id_servicio, fact_total) "
                                  + "VALUES (STR_TO_DATE('" + fecha + "', '%d/%m/%Y'), "
                                  + idServicio + ", "
                                  + total + ")";

                cn.st = cn.conexion.createStatement();
                cn.st.executeUpdate(sqlFactura, Statement.RETURN_GENERATED_KEYS);

                // Obtener id_factura generado
                int idFactura = 0;
                ResultSet rsKeys = cn.st.getGeneratedKeys();
                if (rsKeys.next()) {
                    idFactura = rsKeys.getInt(1);
                }

                // 2. Insertar cada medio de pago en detalle_pago
                for (int i = 0; i < tiposPago.length; i++) {
                    String sqlPago = "INSERT INTO detalle_pago (id_factura, id_tipo_pago, dp_monto) "
                                   + "VALUES ("
                                   + idFactura + ", "
                                   + tiposPago[i] + ", "
                                   + montos[i] + ")";
                    cn.actualizar(sqlPago);
                }

                out.println("FACTURA GUARDADA CON EXITO - CODIGO: " + idFactura);
             
            } catch (Exception ex) {
                Logger.getLogger(guardarFacturaServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        return "Guarda Factura";
    }
}
