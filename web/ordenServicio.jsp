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
        .table-section { margin-top: 30px; }
        .btn-agregar {
            background-color: #5b9bd5;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-agregar:hover { background-color: #4a8bc2; }
        .btn-modificar {
            background-color: #f0ad4e;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-modificar:hover { background-color: #ec971f; }
        .btn-eliminar {
            background-color: #d9534f;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-eliminar:hover { background-color: #c9302c; }
        .btn-guardar {
            background-color: #5cb85c;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-guardar:hover { background-color: #4cae4c; }
        .btn-cancelar {
            background-color: #e0e0e0;
            border: none;
            color: #333;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-cancelar:hover { background-color: #d0d0d0; }
        .btn-imprimir {
            background-color: #5b9bd5;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-imprimir:hover { background-color: #4a8bc2; }
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
        .btn-action { min-width: 130px; margin: 5px; }
        .table { background-color: white; border: 1px solid #ddd; }
        .table th {
            background-color: #f5f5f5;
            color: #333;
            font-weight: 600;
            border: 1px solid #ddd;
            padding: 12px;
        }
        .table td { border: 1px solid #ddd; padding: 10px; }
        .table-hover tbody tr:hover { background-color: #f0f0f0; }
        .selected-row { background-color: #d9edf7 !important; }
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
        <a href="menu.jsp" class="btn btn-secondary btn-sm" style="margin-bottom: 20px;">&#8592; Volver</a>
        <h1 class="header-title">ORDEN DE SERVICIO</h1>

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
                    <label class="form-label">Cliente</label>
    <div class="input-group">
        <input type="text" class="form-control" id="txtBuscarCliente" placeholder="Buscar cliente...">
        <button class="btn btn-secondary" type="button" onclick="buscarCliente()">🔍</button>
    </div>
    <!--guarda el id del cliente seleccionado -->
    <input type="hidden" id="cliente">
    <small id="clienteSeleccionado" class="text-success fw-bold"></small>
</div>

<!-- Mini tabla de resultados (oculta por defecto) -->
<div class="row" id="tablaClientesDiv" style="display:none;">
    <div class="col-md-12 mb-3">
        <table class="table table-hover table-sm">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Cédula</th>
                </tr>
            </thead>
            <tbody id="resultadoClientes"></tbody>
        </table>
    </div>
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

            <div class="table-section">
                <h4 class="mb-3">Detalle de Servicios</h4>

                <div class="input-group-detalle">
                    <div class="row">
                        <div class="col-md-5 mb-2">
                            <label for="tipoServicio" class="form-label">Servicio</label>
                            <select class="form-select" id="tipoServicio">
                                <option value="">Seleccione servicio...</option>
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

                <div class="mb-3">
                    <button type="button" class="btn btn-modificar btn-action" onclick="modificarServicio()">Modificar</button>
                    <button type="button" class="btn btn-eliminar btn-action" onclick="eliminarServicio()">Borrar</button>
                </div>

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

            <div class="text-center">
                <button type="button" class="btn btn-cancelar btn-action" onclick="limpiarFormulario()">Cancelar</button>
                <button type="button" class="btn btn-guardar btn-action" onclick="guardarOrden()">Guardar</button>
               
            </div>
        </form>
    </div>

    <!-- Scripts - igual que en empleados -->
    <script src="js/jquery-1.12.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="sql_ordenservicio.js"></script>
</body>
</html>
