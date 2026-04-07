<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes - Spa de Uñas</title>
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
        .form-control {
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        .table { background-color: white; border: 1px solid #ddd; }
        .table th {
            background-color: #FA8FD6;
            color: white;
            font-weight: 600;
            border: 1px solid #FCBBE6;
            padding: 12px;
        }
        .table td { border: 1px solid #ddd; padding: 10px; }
        .btn-buscar {
            background-color: #FA8FD6;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-buscar:hover { background-color: #FCBBE6; color: white; }
        .btn-imprimir {
            background-color: #FA8FD6;
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-imprimir:hover { background-color: #FCBBE6; color: white; }
        .filtros-section {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 4px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }
        @media print {
            .no-print { display: none !important; }
            body { background-color: white; padding: 0; }
            .container-main { box-shadow: none; padding: 10px; }
        }
    </style>
</head>
<body>
    <div class="container-main">
        <a href="menu.jsp" class="btn btn-secondary btn-sm no-print" style="margin-bottom: 20px;">&#8592; Volver</a>
        <h1 class="header-title">REPORTES</h1>

        <!-- Pestañas -->
        <ul class="nav nav-tabs no-print" id="tabReportes">
            <li class="nav-item">
                <a class="nav-link active" onclick="mostrarTab('facturas')" href="#">Reporte de Facturas</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" onclick="mostrarTab('servicios')" href="#">Reporte de Servicios</a>
            </li>
        </ul>

        <!-- TAB FACTURAS -->
        <div id="tabFacturas">
            <div class="filtros-section mt-3 no-print">
                <div class="row align-items-end">
                    <div class="col-md-3 mb-2">
                        <label class="form-label">Desde</label>
                        <input type="date" class="form-control" id="desdeFacturas">
                    </div>
                    <div class="col-md-3 mb-2">
                        <label class="form-label">Hasta</label>
                        <input type="date" class="form-control" id="hastaFacturas">
                    </div>
                    <div class="col-md-3 mb-2">
                        <button class="btn btn-buscar" onclick="buscarFacturas()">🔍 Buscar</button>
                    </div>
                    <div class="col-md-3 mb-2">
                        <button class="btn btn-imprimir" onclick="window.print()">🖨️ Imprimir</button>
                    </div>
                </div>
            </div>

            <div id="tituloFacturas" style="display:none;" class="mb-3">
                <h5 class="text-center">Reporte de Facturas - <span id="periodoFacturas"></span></h5>
            </div>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Nro. Factura</th>
                            <th>Fecha</th>
                            <th>Cliente</th>
                            <th>Profesional</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody id="tablaFacturas">
                        <tr>
                            <td colspan="5" class="text-center text-muted">Seleccione un rango de fechas para ver el reporte</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- TAB SERVICIOS -->
        <div id="tabServicios" style="display:none;">
            <div class="filtros-section mt-3 no-print">
                <div class="row align-items-end">
                    <div class="col-md-3 mb-2">
                        <label class="form-label">Desde</label>
                        <input type="date" class="form-control" id="desdeServicios">
                    </div>
                    <div class="col-md-3 mb-2">
                        <label class="form-label">Hasta</label>
                        <input type="date" class="form-control" id="hastaServicios">
                    </div>
                    <div class="col-md-3 mb-2">
                        <button class="btn btn-buscar" onclick="buscarServicios()">🔍 Buscar</button>
                    </div>
                    <div class="col-md-3 mb-2">
                        <button class="btn btn-imprimir" onclick="window.print()">🖨️ Imprimir</button>
                    </div>
                </div>
            </div>

            <div id="tituloServicios" style="display:none;" class="mb-3">
                <h5 class="text-center">Reporte de Servicios - <span id="periodoServicios"></span></h5>
            </div>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Cliente</th>
                            <th>Servicio</th>
                            <th>Cantidad</th>
                            <th>Precio</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody id="tablaServicios">
                        <tr>
                            <td colspan="6" class="text-center text-muted">Seleccione un rango de fechas para ver el reporte</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script src="js/jquery-1.12.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="sql_reportes.js"></script>
</body>
</html>
