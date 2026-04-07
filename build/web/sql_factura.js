// =============================================
// sql_factura.js
// Lógica de la Factura
// =============================================

let pagos = [];
let filaSeleccionada = null;
let totalOrden = 0;

// Al cargar la pagina
$(function() {
    var hoy  = new Date();
    var dia  = String(hoy.getDate()).padStart(2, '0');
    var mes  = String(hoy.getMonth() + 1).padStart(2, '0');
    var anio = hoy.getFullYear();
    $("#fecha").val(dia + '/' + mes + '/' + anio);
    cargarOrdenesPendientes();

    cargarTiposPago();
});

function cargarOrdenesPendientes() {
    $.post("extraer/get_ordenes_pendientes", {})
        .done(function(data) {
            $("#ordenesPendientes").html(data);
        });
}

function cargarOrden(idOrden) {
    $("#nroOrden").val(idOrden);
    buscarOrden();
}

function cargarTiposPago() {
    $.post("extraer/get_tipopago", {})
        .done(function(data) {
            $("#tipoPagoDetalle").append(data);
        });
}

// Buscar orden por ID y cargar todos sus datos
function buscarOrden() {
    var idOrden = $("#nroOrden").val();
    if (!idOrden) {
        alert('Por favor ingrese el número de orden');
        return;
    }

    $.post("extraer/get_orden", { idServicio: idOrden })
        .done(function(data) {
            var orden;
            // Si ya viene como objeto no hace falta parsear
            if (typeof data === 'string') {
                orden = JSON.parse(data);
            } else {
                orden = data;
            }

            if (orden.error) {
                alert('Orden no encontrada: ' + orden.error);
                return;
            }

            $("#nombreCliente").text(orden.cl_nombre + ' ' + orden.cl_apellido);
            $("#cedulaCliente").text(orden.cl_cedula);
            $("#nombreProfesional").text(orden.edo_nombre + ' ' + orden.edo_apellido);
            $("#fechaOrden").text(orden.serv_fecha);

            totalOrden = parseInt(orden.serv_total);
            $("#totalGeneral").text(totalOrden.toLocaleString('es-PY'));

            $("#infoOrden").show();
            $("#seccionServicios").show();
            actualizarSaldo();

            $.post("extraer/get_detalle_orden", { idServicio: idOrden })
                .done(function(detalle) {
                    $("#detalleServicios").html(detalle);
                });
        });
}

// Agregar medio de pago
function agregarPago() {
    var idTipoPago = $("#tipoPagoDetalle").val();
    var nombrePago = $("#tipoPagoDetalle option:selected").text();
    var monto      = parseInt($("#montoPago").val());

    if (!idTipoPago) {
        alert('Por favor seleccione un tipo de pago');
        return;
    }
    if (!monto || monto <= 0) {
        alert('Por favor ingrese un monto válido');
        return;
    }

    // Verificar que no supere el total
    var totalPagado = pagos.reduce(function(sum, p) { return sum + p.monto; }, 0);
   if (monto <= 0) {
    alert('Por favor ingrese un monto válido');
    return;
}

    var pago = {
        idTipoPago: idTipoPago,
        nombre:     nombrePago, 
        monto:      monto
    };

    pagos.push(pago);
    actualizarTablaPagos();
    actualizarSaldo();

    // Limpiar campos
    $("#tipoPagoDetalle").val('');
    $("#montoPago").val('');
}

function eliminarPago() {
    if (filaSeleccionada === null) {
        alert('Por favor seleccione un pago para eliminar');
        return;
    }
    if (confirm('¿Está seguro de eliminar este pago?')) {
        pagos.splice(filaSeleccionada, 1);
        filaSeleccionada = null;
        actualizarTablaPagos();
        actualizarSaldo();
    }
} 

function actualizarTablaPagos() {
    var tbody = $("#detallePagos");

    if (pagos.length === 0) {
        tbody.html('<tr><td colspan="2" class="text-center text-muted">No hay pagos agregados</td></tr>');
        return;
    }

    var html = '';
    pagos.forEach(function(pago, index) {
        html += '<tr onclick="seleccionarFilaPago(' + index + ')" style="cursor:pointer;">';
        html += '<td>' + pago.nombre + '</td>';
        html += '<td>Gs. ' + pago.monto.toLocaleString('es-PY') + '</td>';
        html += '</tr>';
    });
    tbody.html(html);
}

function seleccionarFilaPago(index) {
    $("#detallePagos tr").removeClass('selected-row');
    $("#detallePagos tr").eq(index).addClass('selected-row');
    filaSeleccionada = index;
}

function actualizarSaldo() {
    var totalPagado = pagos.reduce(function(sum, p) { return sum + p.monto; }, 0);
    var saldo = totalOrden - totalPagado;

    $("#totalPagado").text(totalPagado.toLocaleString('es-PY'));

    if (saldo <= 0) {
        $("#saldoRestante").html('Gs. 0').removeClass('saldo-restante').addClass('saldo-ok');
    } else {
        $("#saldoRestante").html('Gs. ' + saldo.toLocaleString('es-PY')).removeClass('saldo-ok').addClass('saldo-restante');
    }
    var vuelto = totalPagado - totalOrden;
        if (vuelto > 0) {
    $('#vuelto').text('Gs. ' + vuelto.toLocaleString());
        } else {
    $('#vuelto').text('Gs. 0');  
    }
    }

// Guardar factura
function guardarFactura() {
    if (!$("#nroOrden").val()) {
        alert('Por favor busque una orden primero'); return;
    }
    if (pagos.length === 0) {
        alert('Debe agregar al menos un medio de pago'); return;
    }

    var totalPagado = pagos.reduce(function(sum, p) { return sum + p.monto; }, 0);
    if (totalPagado < totalOrden) {
       alert('El total pagado (Gs. ' + totalPagado.toLocaleString('es-PY') + ') es menor al total de la orden (Gs. ' + totalOrden.toLocaleString('es-PY') + ')');
        return;
    }

    var tiposPago = pagos.map(function(p) { return p.idTipoPago; });
    var montos    = pagos.map(function(p) { return p.monto; });

    if (confirm('¿DESEA GUARDAR LA FACTURA?')) {
        $.post("guardarFacturaServlet", {
            fecha:        $("#fecha").val(),
            idServicio:   $("#nroOrden").val(),
            total:        totalOrden,
            "tiposPago[]": tiposPago,
            "montos[]":    montos
        })
        .done(function(data) {
           if (data.indexOf('ERROR') !== -1 || data.indexOf('Duplicate') !== -1) {
        alert('ESTA ORDEN YA FUE FACTURADA');
    } else {
        
        var partes = data.split(':');
        var idFactura = partes[partes.length - 1].trim();
        $("#idFactura").val(idFactura);
        alert(data);
        cargarOrdenesPendientes();
    }
        });
    }
}

function imprimirFactura() {
    if (!$("#idFactura").val()) {
        alert('Debe guardar la factura antes de imprimir');
        return;
    }
    window.open('imprimirFacturaServlet?idFactura=' + $("#idFactura").val(), '_blank');
}

function limpiarFormulario() {
    $("#formFactura")[0].reset();

    var hoy  = new Date();
    var dia  = String(hoy.getDate()).padStart(2, '0');
    var mes  = String(hoy.getMonth() + 1).padStart(2, '0');
    var anio = hoy.getFullYear();
    $("#fecha").val(dia + '/' + mes + '/' + anio);

    pagos            = [];
    filaSeleccionada = null;
    totalOrden       = 0;

    $("#infoOrden").hide();
    $("#seccionServicios").hide();
    $("#detalleServicios").html('');
    $("#detallePagos").html('<tr><td colspan="2" class="text-center text-muted">No hay pagos agregados</td></tr>');
    $("#totalGeneral").text('0');
    $("#totalPagado").text('0');
    $("#saldoRestante").text('Gs. 0').removeClass('saldo-restante saldo-ok');

    // Recargar tipo de pago
    $("#tipoPagoDetalle").html('<option value="">Seleccione tipo de pago...</option>');
    cargarTiposPago();
     cargarOrdenesPendientes();
}
