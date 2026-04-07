package prgs;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/chat")
public class ChatbotServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String pregunta = request.getParameter("pregunta");
        if (pregunta == null) pregunta = "";
        pregunta = pregunta.toLowerCase();

        String respuesta = generarRespuesta(pregunta);

        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(respuesta);
    }

    private String generarRespuesta(String pregunta) {
        switch (pregunta) { 
            
            case "hola":
            case "buenas":
                return "Hola soy tu asistente, en que puedo ayudarte?";
            case "factura":
            case "facturacion":
                return "para imprimir una factura necesitas generar una orden de servicio, luego facturar";
            case "servicios":
            case "orden":
                return "para generar una orden de servicio puedes dirigirte al modulo de servicio y seguir los pasos";
            case "clientes":
            case "cliente":
                return "puedes ver la lista preliminar de clientes y el reporte en el modulo de reportes";
            case "turnos":
            case "turno":
                return "....EL MODULO DE TURNOS SE ENCUENTRA EN LA SIGUIENTE ETAPA....";
            case "pago":
            case "medios ":
            case "pagar":
                return "puedes cargar distintos medios de pago desde la tabla referencial para medios de pago";            
            default:
                return "Lo siento, no entendí tu pregunta. Puedes consultarme sobre accesos al sistema";
        }
    }
}