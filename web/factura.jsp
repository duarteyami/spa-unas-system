

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Factura - Spa de Uñas</title>
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
        .btn-agregar:hover { background-color: #4a8bc2; color: white; }
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
        .btn-eliminar {
            background-color: #d9534f;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-eliminar:hover { background-color: #c9302c; }
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
        .input-group-detalle {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 4px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }
        .info-cliente {
            background-color: #f0f7ff;
            padding: 15px;
            border-radius: 4px;
            border: 1px solid #c8e0f7;
            margin-bottom: 20px;
        }
        .saldo-restante {
            color: #d9534f;
            font-weight: bold;
        }
        .saldo-ok {
            color: #5cb85c;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container-main">
        <a href="menu.jsp" class="btn btn-secondary btn-sm" style="margin-bottom: 20px;">&#8592; Volver</a>
        <h1 class="header-title">FACTURA</h1>

        <form id="formFactura">

            <!-- Buscar orden -->
            <div class="row">
                <div class="col-md-3 mb-3">
                    <label for="idFactura" class="form-label">Nro. Factura</label>
                    <input type="text" class="form-control" id="idFactura" placeholder="Autoincremental" readonly>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="fecha" class="form-label">Fecha</label>
                    <input type="text" class="form-control" id="fecha" placeholder="DD/MM/AAAA" readonly>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="nroOrden" class="form-label">Nro. Orden</label>
                    <div class="input-group">
                        <input type="number" class="form-control" id="nroOrden" placeholder="Ingrese nro orden">
                        <button class="btn btn-secondary" type="button" onclick="buscarOrden()">🔍</button>
                    </div>
                </div>
            </div>
            <!-- Ordenes pendientes de factura -->
<div class="row mt-3">
    <div class="col-md-12">
        <h5>Órdenes pendientes de factura</h5>
        <div class="table-responsive">
            <table class="table table-hover table-sm">
                <thead>
                    <tr>
                        <th>Nro. Orden</th>
                        <th>Fecha</th>
                        <th>Cliente</th>
                        <th>Profesional</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody id="ordenesPendientes"></tbody>
            </table>
        </div>
    </div>
</div>

            <!-- Datos del cliente y profesional (se llenan solos) -->
            <div class="info-cliente" id="infoOrden" style="display:none;">
                <div class="row">
                    <div class="col-md-6">
                        <strong>Cliente:</strong> <span id="nombreCliente"></span><br>
                        <strong>Cédula:</strong> <span id="cedulaCliente"></span>
                    </div>
                    <div class="col-md-6">
                        <strong>Profesional:</strong> <span id="nombreProfesional"></span><br>
                        <strong>Fecha Orden:</strong> <span id="fechaOrden"></span>
                    </div>
                </div>
            </div>

            <hr style="margin: 30px 0;">

            <!-- Servicios de la orden -->
            <div class="table-section" id="seccionServicios" style="display:none;">
                <h4 class="mb-3">Servicios</h4>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th width="8%">Código</th>
                                <th width="40%">Servicio</th>
                                <th width="17%">Precio</th>
                                <th width="17%">Cantidad</th>
                                <th width="18%">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody id="detalleServicios"></tbody>
                    </table>
                </div>

                <!-- Total de la orden -->
                <div class="total-section">
                    <div class="row">
                        <div class="col-md-8 d-flex align-items-center">
                            <h5 class="mb-0">TOTAL A PAGAR:</h5>
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="total-amount">Gs. <span id="totalGeneral">0</span></span>
                        </div>
                    </div>
                </div>

                <hr style="margin: 30px 0;">

                <!-- Sección de medios de pago -->
                <h4 class="mb-3">Medios de Pago</h4>
                <div class="input-group-detalle">
                    <div class="row">
                        <div class="col-md-6 mb-2">
                            <label for="tipoPagoDetalle" class="form-label">Tipo de Pago</label>
                            <select class="form-select" id="tipoPagoDetalle">
                                <option value="">Seleccione tipo de pago...</option>
                            </select>
                        </div>
                        <div class="col-md-4 mb-2">
                            <label for="montoPago" class="form-label">Monto</label>
                            <input type="number" class="form-control" id="montoPago" placeholder="0" min="1">
                        </div>
                        <div class="col-md-2 mb-2 d-flex align-items-end">
                            <button type="button" class="btn btn-agregar w-100" onclick="agregarPago()">+</button>
                        </div>
                    </div>
                </div>

                <!-- Tabla de pagos -->
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th width="60%">Tipo de Pago</th>
                                <th width="40%">Monto</th>
                            </tr>
                        </thead>
                        <tbody id="detallePagos">
                            <tr>
                                <td colspan="2" class="text-center text-muted">No hay pagos agregados</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="mb-3">
                    <button type="button" class="btn btn-eliminar btn-action" onclick="eliminarPago()">Borrar</button>
                </div>

                <!-- Resumen de pagos -->
                <div class="total-section">
                    <div class="row mb-2">
                        <div class="col-md-8"><h5 class="mb-0">TOTAL PAGADO:</h5></div>
                        <div class="col-md-4 text-end">
                            <span class="total-amount">Gs. <span id="totalPagado">0</span></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8"><h5 class="mb-0">SALDO RESTANTE:</h5></div>
                        <div class="col-md-4 text-end">
                            <span class="total-amount" id="saldoRestante">Gs. 0</span>
                        </div>
                        <div class="alert alert-success">
                      <strong>VUELTO:</strong> <span id="vuelto">Gs. 0</span>
                      </div>
                    </div>
                </div>

                <hr style="margin: 30px 0;">

                <!-- Botones -->
                <div class="text-center">
                    <button type="button" class="btn btn-cancelar btn-action" onclick="limpiarFormulario()">Cancelar</button>
                    <button type="button" class="btn btn-guardar btn-action" onclick="guardarFactura()">Guardar</button>
                    <button type="button" class="btn btn-imprimir btn-action" onclick="imprimirFactura()">Imprimir</button>
                </div>
            </div>

        </form>
    </div>

    <script src="js/jquery-1.12.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="sql_factura.js"></script>
</body>
</html>
