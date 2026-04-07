<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orden de Servicio - Spa de Uñas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e8e8e8;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        .container-main {
            background: white;
            padding: 40px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 1100px;
            margin: 0 auto;
        }
        .header-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 40px;
            letter-spacing: 2px;
        }
        .form-control, .form-select {
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
        }
        .form-control:focus, .form-select:focus {
            background-color: white;
            border-color: #5b9bd5;
            box-shadow: none;
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
            font-size: 0.95rem;
        }
        .table-section {
            margin-top: 30px;
        }
        /* Botones con los colores de tu interfaz */
        .btn-agregar {
            background-color: #5b9bd5;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-agregar:hover {
            background-color: #4a8bc2;
        }
        .btn-modificar {
            background-color: #f0ad4e;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-modificar:hover {
            background-color: #ec971f;
        }
        .btn-eliminar {
            background-color: #d9534f;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-eliminar:hover {
            background-color: #c9302c;
        }
        .btn-guardar {
            background-color: #5cb85c;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-guardar:hover {
            background-color: #4cae4c;
        }
        .btn-cancelar {
            background-color: #e0e0e0;
            border: none;
            color: #333;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-cancelar:hover {
            background-color: #d0d0d0;
        }
        .btn-imprimir {
            background-color: #5b9bd5;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-imprimir:hover {
            background-color: #4a8bc2;
        }
        .total-section {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 4px;
            margin-top: 20px;
            border: 1px solid #ddd;
        }
        .total-amount {
            font-size: 1.8rem;
            font-weight: bold;
            color: #333;
        }
        .btn-action {
            min-width: 130px;
            margin: 5px;
        }
        .table {
            background-color: white;
            border: 1px solid #ddd;
        }
        .table th {
            background-color: #f5f5f5;
            color: #333;
            font-weight: 600;
            border: 1px solid #ddd;
            padding: 12px;
        }
        .table td {
            border: 1px solid #ddd;
            padding: 10px;
        }
        .table-hover tbody tr:hover {
            background-color: #f0f0f0;
        }
        .selected-row {
            background-color: #d9edf7 !important;
        }
        .input-group-detalle {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 4px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container-main">
        <!-- Header -->
        <a href="menu.jsp" class="btn btn-secondary btn-sm" style="margin-bottom: 20px;">&#8592; Volver</a>
        <h1 class="header-title">ORDEN DE SERVICIO</h1>

        <!-- Formulario de Cabecera -->
        <form id="formServicio">
            <div class="row">
                <div class="col-md-3 mb-3">
                    <label for="nroOrden" class="form-label">Código</label>
                    <input type="text" class="form-control" id="nroOrden" placeholder="Autoincremental" readonly>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="fecha" class="form-label">Fecha</label>
                    <input type="text" class="form-control" id="fecha" placeholder="DD/MM/AAAA" required>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="tipoPago" class="form-label">Tipo de Pago</label>
                    <select class="form-select" id="tipoPago" required>
                        <option value="">Seleccione tipo de pago</option>
                        <option value="1">Efectivo</option>
                        <option value="2">Tarjeta</option>
                        <option value="3">giros</option>
                        <option value="3">qr</option>
                    </select>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="cliente" class="form-label">Clientes</label>
                    <select class="form-select" id="cliente" required>
                        <option value="">cliente</option>
                        <!-- Cargar clientes desde BD -->
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="profesional" class="form-label">Profesional (Empleado)</label>
                    <select class="form-select" id="profesional" required>
                        <option value="">Seleccione profesional</option>
                        <!-- Cargar empleados desde BD -->
                    </select>
                </div>
            </div>

            <hr style="margin: 30px 0;">

            <!-- Sección de Detalle de Servicios -->
            <div class="table-section">
                <h4 class="mb-3">Detalle de Servicios</h4>
                
                <!-- Formulario para agregar servicios -->
                <div class="input-group-detalle">
                    <div class="row">
                        <div class="col-md-5 mb-2">
                            <label for="tipoServicio" class="form-label">Servicio</label>
                            <select class="form-select" id="tipoServicio">
                                <option value="">Seleccione servicio...</option>
                                <!-- Cargar servicios desde BD -->
                            </select>
                        </div>
                        <div class="col-md-2 mb-2">
                            <label for="precio" class="form-label">Precio</label>
                            <input type="number" class="form-control" id="precio" placeholder="0" readonly>
                        </div>
                        <div class="col-md-2 mb-2">
                            <label for="cantidad" class="form-label">Cantidad</label>
                            <input type="number" class="form-control" id="cantidad" min="1" value="1" placeholder="1">
                        </div>
                        <div class="col-md-2 mb-2">
                            <label for="subtotal" class="form-label">Subtotal</label>
                            <input type="number" class="form-control" id="subtotal" placeholder="0" readonly>
                        </div>
                        <div class="col-md-1 mb-2 d-flex align-items-end">
                            <button type="button" class="btn btn-agregar w-100" onclick="agregarServicio()">+</button>
                        </div>
                    </div>
                </div>

                <!-- Tabla de servicios -->
                <div class="table-responsive">
                    <table class="table table-hover" id="tablaServicios">
                        <thead>
                            <tr>
                                <th width="8%">Código</th>
                                <th width="40%">Servicio</th>
                                <th width="17%">Precio</th>
                                <th width="17%">Cantidad</th>
                                <th width="18%">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody id="detalleServicios">
                            <tr>
                                <td colspan="5" class="text-center text-muted">No hay servicios agregados</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Botones de acción para la grilla -->
                <div class="mb-3">
                    <button type="button" class="btn btn-modificar btn-action" onclick="modificarServicio()">Modificar</button>
                    <button type="button" class="btn btn-eliminar btn-action" onclick="eliminarServicio()">Borrar</button>
                </div>

                <!-- Total -->
                <div class="total-section">
                    <div class="row">
                        <div class="col-md-8 d-flex align-items-center">
                            <h5 class="mb-0">TOTAL:</h5>
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="total-amount">Gs. <span id="totalGeneral">0</span></span>
                        </div>
                    </div>
                </div>
            </div>

            <hr style="margin: 30px 0;">

            <!-- Botones principales -->
            <div class="text-center">
                <button type="button" class="btn btn-cancelar btn-action" onclick="limpiarFormulario()">Cancelar</button>
                <button type="button" class="btn btn-guardar btn-action" onclick="guardarOrden()">Guardar</button>
                <button type="button" class="btn btn-imprimir btn-action" onclick="imprimirOrden()">Imprimir</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Array para almacenar los servicios agregados
        let servicios = [];
        let filaSeleccionada = null;
        let contadorServicios = 0;

        // Datos de ejemplo para los servicios (en producción vendrían de la BD)
        const serviciosDisponibles = [
            {id: 1, nombre: "esculpidas", precio: 100000},
            {id: 2, nombre: "semipermanente", precio: 90000},
            {id: 3, nombre: "acrilicas", precio: 120000},
            {id: 4, nombre: "kapping", precio: 120000},
            {id: 5, nombre: "pies", precio: 50000},
           
        ];

        // Inicializar la página
        window.onload = function() {
            // Establecer fecha actual
          //  document.getElementById('fecha').valueAsDate = new Date();
            
            // Generar número de orden automático
            //document.getElementById('nroOrden').value = Date.now();
            
            // Cargar servicios en el select
            cargarServicios();
        };

        // Cargar servicios disponibles en el select
        function cargarServicios() {
            const select = document.getElementById('tipoServicio');
            serviciosDisponibles.forEach(servicio => {
                const option = document.createElement('option');
                option.value = servicio.id;
                option.textContent = servicio.nombre;
                option.dataset.precio = servicio.precio;
                select.appendChild(option);
            });
        }

        // Actualizar precio cuando se selecciona un servicio
        document.getElementById('tipoServicio').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const precio = selectedOption.dataset.precio || 0;
            document.getElementById('precio').value = precio;
            calcularSubtotal();
        });

        // Calcular subtotal cuando cambia la cantidad
        document.getElementById('cantidad').addEventListener('input', calcularSubtotal);

        function calcularSubtotal() {
            const precio = parseFloat(document.getElementById('precio').value) || 0;
            const cantidad = parseInt(document.getElementById('cantidad').value) || 0;
            document.getElementById('subtotal').value = precio * cantidad;
        }

        // Agregar servicio a la tabla
        function agregarServicio() {
            const selectServicio = document.getElementById('tipoServicio');
            const precio = parseFloat(document.getElementById('precio').value);
            const cantidad = parseInt(document.getElementById('cantidad').value);
            const subtotal = parseFloat(document.getElementById('subtotal').value);

            if (!selectServicio.value) {
                alert('Por favor seleccione un servicio');
                return;
            }

            if (cantidad <= 0) {
                alert('La cantidad debe ser mayor a 0');
                return;
            }

            const servicio = {
                id: ++contadorServicios,
                idTipoServicio: selectServicio.value,
                nombre: selectServicio.options[selectServicio.selectedIndex].text,
                precio: precio,
                cantidad: cantidad,
                subtotal: subtotal
            };

            servicios.push(servicio);
            actualizarTabla();
            limpiarCamposServicio();
            calcularTotal();
        }

        // Modificar servicio seleccionado
        function modificarServicio() {
            if (filaSeleccionada === null) {
                alert('Por favor seleccione un servicio de la tabla para modificar');
                return;
            }

            const servicio = servicios[filaSeleccionada];
            
            // Cargar datos en los campos
            document.getElementById('tipoServicio').value = servicio.idTipoServicio;
            document.getElementById('precio').value = servicio.precio;
            document.getElementById('cantidad').value = servicio.cantidad;
            document.getElementById('subtotal').value = servicio.subtotal;

            // Eliminar el servicio actual para que pueda ser agregado nuevamente
            servicios.splice(filaSeleccionada, 1);
            filaSeleccionada = null;
            actualizarTabla();
            calcularTotal();
        }

        // Eliminar servicio seleccionado
        function eliminarServicio() {
            if (filaSeleccionada === null) {
                alert('Por favor seleccione un servicio de la tabla para eliminar');
                return;
            }

            if (confirm('¿Está seguro de eliminar este servicio?')) {
                servicios.splice(filaSeleccionada, 1);
                filaSeleccionada = null;
                actualizarTabla();
                calcularTotal();
            }
        }

        // Actualizar la tabla de servicios
        function actualizarTabla() {
            const tbody = document.getElementById('detalleServicios');
            
            if (servicios.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No hay servicios agregados</td></tr>';
                return;
            }

            let html = '';
            servicios.forEach((servicio, index) => {
                html += `
                    <tr onclick="seleccionarFila(${index})" style="cursor: pointer;">
                        <td>${servicio.idTipoServicio}</td>
                        <td>${servicio.nombre}</td>
                        <td>Gs. ${servicio.precio.toLocaleString('es-PY')}</td>
                        <td>${servicio.cantidad}</td>
                        <td>Gs. ${servicio.subtotal.toLocaleString('es-PY')}</td>
                    </tr>
                `;
            });
            tbody.innerHTML = html;
        }

        // Seleccionar fila de la tabla
        function seleccionarFila(index) {
            // Remover selección anterior
            const rows = document.querySelectorAll('#detalleServicios tr');
            rows.forEach(row => row.classList.remove('selected-row'));

            // Agregar selección a la nueva fila
            rows[index].classList.add('selected-row');
            filaSeleccionada = index;
        }

        // Calcular total general
        function calcularTotal() {
            const total = servicios.reduce((sum, servicio) => sum + servicio.subtotal, 0);
            document.getElementById('totalGeneral').textContent = total.toLocaleString('es-PY');
        }

        // Limpiar campos de servicio
        function limpiarCamposServicio() {
            document.getElementById('tipoServicio').value = '';
            document.getElementById('precio').value = '';
            document.getElementById('cantidad').value = '1';
            document.getElementById('subtotal').value = '';
        }

        // Guardar orden de servicio
        function guardarOrden() {
            // Validar campos obligatorios
            if (!document.getElementById('fecha').value) {
                alert('Por favor ingrese la fecha');
                return;
            }
            if (!document.getElementById('tipoPago').value) {
                alert('Por favor seleccione el tipo de pago');
                return;
            }
            if (!document.getElementById('cliente').value) {
                alert('Por favor seleccione el cliente');
                return;
            }
            if (!document.getElementById('profesional').value) {
                alert('Por favor seleccione el profesional');
                return;
            }
            if (servicios.length === 0) {
                alert('Debe agregar al menos un servicio');
                return;
            }

            // Preparar datos para enviar
            const orden = {
                nroOrden: document.getElementById('nroOrden').value,
                fecha: document.getElementById('fecha').value,
                tipoPago: document.getElementById('tipoPago').value,
                cliente: document.getElementById('cliente').value,
                profesional: document.getElementById('profesional').value,
                servicios: servicios,
                total: servicios.reduce((sum, s) => sum + s.subtotal, 0)
            };

            console.log('Orden a guardar:', orden);

            // Aquí iría el código para enviar al servlet/controlador
            alert('Orden guardada exitosamente!\n\nCódigo: ' + orden.nroOrden + '\nTotal: Gs. ' + orden.total.toLocaleString('es-PY'));
            
            // TODO: Implementar el guardado real en la base de datos
            /*
            fetch('GuardarOrdenServlet', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(orden)
            })
            .then(response => response.json())
            .then(data => {
                alert('Orden guardada exitosamente!');
                limpiarFormulario();
            })
            .catch(error => {
                alert('Error al guardar: ' + error);
            });
            */
        }

        // Imprimir orden de servicio
        function imprimirOrden() {
            if (servicios.length === 0) {
                alert('No hay servicios para imprimir');
                return;
            }

            // Aquí iría la lógica para generar el reporte
            alert('Funcionalidad de impresión.\nAquí conectarás con tu generador de reportes.');
            
            // TODO: Implementar la generación del reporte
            // window.open('ImprimirOrdenServlet?id=' + ordenId, '_blank');
        }

        // Limpiar formulario completo
        function limpiarFormulario() {
            if (servicios.length > 0) {
                if (!confirm('¿Está seguro de cancelar? Se perderán todos los datos.')) {
                    return;
                }
            }

            document.getElementById('formServicio').reset();
            document.getElementById('fecha').valueAsDate = new Date();
            document.getElementById('nroOrden').value = Date.now();
            servicios = [];
            filaSeleccionada = null;
            contadorServicios = 0;
            actualizarTabla();
            calcularTotal();
            limpiarCamposServicio();
        }
    </script>
</body>
</html>
