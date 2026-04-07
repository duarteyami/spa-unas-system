// =============================================
// sql_ordenservicio.js
// 
// =============================================

let servicios = [];
let filaSeleccionada = null;
let contadorServicios = 0;

// Al cargar la pagina
$(function() {
    // Fecha de hoy en formato DD/MM/AAAA
    var hoy  = new Date();
    var dia  = String(hoy.getDate()).padStart(2, '0');
    var mes  = String(hoy.getMonth() + 1).padStart(2, '0');
    var anio = hoy.getFullYear();
    $("#fecha").val(dia + '/' + mes + '/' + anio);

    // Cargar datos desde la BD
    cargarTiposServicio();
    cargarEmpleados();
  
});


// Carga los servicios desde tipo_servicio en la BD
function cargarTiposServicio() {
    $.post("extraer/get_tiposervicioorden", {})
        .done(function(data) {
            $("#tipoServicio").append(data);
        });
}

// Carga los empleados desde empleado en la BD
function cargarEmpleados() {
    $.post("extraer/get_empleado_select", {})
        .done(function(data) {
            $("#profesional").append(data);
        });
}

// Cuando se selecciona un servicio, carga el precio
$("#tipoServicio").change(function() {
    var precio = $(this).find(':selected').data('precio') || 0;
    $("#precio").val(precio);
    calcularSubtotal();
});

// Cuando cambia la cantidad, recalcula
$("#cantidad").on('input', function() {
    calcularSubtotal();
});

function calcularSubtotal() {
    var precio   = parseFloat($("#precio").val()) || 0;
    var cantidad = parseInt($("#cantidad").val()) || 0;
    $("#subtotal").val(precio * cantidad);
}

function agregarServicio() {
    var idServicio = $("#tipoServicio").val();
    var nombre     = $("#tipoServicio option:selected").text();
    var precio     = parseFloat($("#precio").val());
    var cantidad   = parseInt($("#cantidad").val());
    var subtotal   = parseFloat($("#subtotal").val());

    if (!idServicio) {
        alert('Por favor seleccione un servicio');
        return;
    }
    if (cantidad <= 0) {
        alert('La cantidad debe ser mayor a 0');
        return;
    }

    var servicio = {
        id:             ++contadorServicios,
        idTipoServicio: idServicio,
        nombre:         nombre,
        precio:         precio,
        cantidad:       cantidad,
        subtotal:       subtotal
    };

    servicios.push(servicio);
    actualizarTabla();
    limpiarCamposServicio();
    calcularTotal();
}

function modificarServicio() {
    if (filaSeleccionada === null) {
        alert('Por favor seleccione un servicio de la tabla para modificar');
        return;
    }

    var servicio = servicios[filaSeleccionada];
    $("#tipoServicio").val(servicio.idTipoServicio);
    $("#precio").val(servicio.precio);
    $("#cantidad").val(servicio.cantidad);
    $("#subtotal").val(servicio.subtotal);

    servicios.splice(filaSeleccionada, 1);
    filaSeleccionada = null;
    actualizarTabla();
    calcularTotal();
}

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

function actualizarTabla() {
    var tbody = $("#detalleServicios");

    if (servicios.length === 0) {
        tbody.html('<tr><td colspan="5" class="text-center text-muted">No hay servicios agregados</td></tr>');
        return;
    }

    var html = '';
    servicios.forEach(function(servicio, index) {
        html += '<tr onclick="seleccionarFila(' + index + ')" style="cursor: pointer;">';
        html += '<td>' + servicio.idTipoServicio + '</td>';
        html += '<td>' + servicio.nombre + '</td>';
        html += '<td>Gs. ' + servicio.precio.toLocaleString('es-PY') + '</td>';
        html += '<td>' + servicio.cantidad + '</td>';
        html += '<td>Gs. ' + servicio.subtotal.toLocaleString('es-PY') + '</td>';
        html += '</tr>';
    });
    tbody.html(html);
}

function seleccionarFila(index) {
    $("#detalleServicios tr").removeClass('selected-row');
    $("#detalleServicios tr").eq(index).addClass('selected-row');
    filaSeleccionada = index;
}

function calcularTotal() {
    var total = servicios.reduce(function(sum, s) { return sum + s.subtotal; }, 0);
    $("#totalGeneral").text(total.toLocaleString('es-PY'));
}

function limpiarCamposServicio() {
    $("#tipoServicio").val('');
    $("#precio").val('');
    $("#cantidad").val('1');
    $("#subtotal").val('');
    
}

// =============================================
// GUARDAR ORDEN
// =============================================
function guardarOrden() {
    if (!$("#fecha").val()) {
        alert('Por favor ingrese la fecha'); return;
    }
   
    if (!$("#cliente").val()) {
        alert('Por favor seleccione el cliente'); return;
    }
    if (!$("#profesional").val()) {
        alert('Por favor seleccione el profesional'); return;
    }
    if (servicios.length === 0) {
        alert('Debe agregar al menos un servicio'); return;
    }

    var precios       = servicios.map(function(s) { return s.precio; });
    var cantidades    = servicios.map(function(s) { return s.cantidad; });
    var subtotales    = servicios.map(function(s) { return s.subtotal; });
    var tiposServicio = servicios.map(function(s) { return s.idTipoServicio; });
    var total         = servicios.reduce(function(sum, s) { return sum + s.subtotal; }, 0);

    if (confirm('¿DESEA GUARDAR LA ORDEN DE SERVICIO?')) {
        $.post("guardarOrdenServlet", {
            fecha:             $("#fecha").val(),
            idCliente:         $("#cliente").val(),
            idProfesional:     $("#profesional").val(),
            total:             total,
            "precios[]":       precios,
            "cantidades[]":    cantidades,
            "subtotales[]":    subtotales,
            "tiposServicio[]": tiposServicio
        })
        .done(function(data) {
            alert(data);
            limpiarFormulario();
        });
    }
}

function imprimirOrden() {
    if (servicios.length === 0) {
        alert('No hay servicios para imprimir');
        return;
    }
    alert('Funcionalidad de impresion pendiente.');
}
function buscarCliente() {
    var filtro = $("#txtBuscarCliente").val();
    $.post("extraer/get_clientesorden", { filtro: filtro })
        .done(function(data) {
            $("#resultadoClientes").html(data);
            $("#tablaClientesDiv").show();
        });
}

function seleccionarCliente(id, nombre) {
    $("#cliente").val(id);
    $("#clienteSeleccionado").text("✔ " + nombre);
    $("#txtBuscarCliente").val(nombre);
    $("#tablaClientesDiv").hide();
}
function limpiarFormulario() {
    if (servicios.length > 0) {
        if (!confirm('se guardaron los datos')) {
            return;
        }
    }

    $("#formServicio")[0].reset();

    var hoy  = new Date();
    var dia  = String(hoy.getDate()).padStart(2, '0');
    var mes  = String(hoy.getMonth() + 1).padStart(2, '0');
    var anio = hoy.getFullYear();
    $("#fecha").val(dia + '/' + mes + '/' + anio);

    servicios         = [];
    filaSeleccionada  = null;
    contadorServicios = 0;
    actualizarTabla();
    calcularTotal();
    limpiarCamposServicio();

    // Recargar los selects desde la BD
    $("#tipoServicio").html('<option value="">Seleccione servicio...</option>');
    $("#profesional").html('<option value="">Seleccione profesional</option>');
  
    cargarTiposServicio();
    cargarEmpleados();
}
