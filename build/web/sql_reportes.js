// =============================================
// sql_reportes.js
// Lógica de los Reportes
// =============================================

function mostrarTab(tab) {
    // Ocultar todos
    $("#tabFacturas").hide();
    $("#tabServicios").hide();

    // Quitar activo de todos los links
    $("#tabReportes .nav-link").removeClass("active");

    // Mostrar el seleccionado
    if (tab === 'facturas') {
        $("#tabFacturas").show();
        $("#tabReportes .nav-link:first").addClass("active");
    } else {
        $("#tabServicios").show();
        $("#tabReportes .nav-link:last").addClass("active");
    }
}

function formatearFecha(fechaInput) {
    // Convierte de YYYY-MM-DD a DD/MM/YYYY
    var partes = fechaInput.split('-');
    return partes[2] + '/' + partes[1] + '/' + partes[0];
}

function buscarFacturas() {
    var desde = $("#desdeFacturas").val();
    var hasta = $("#hastaFacturas").val();

    if (!desde || !hasta) {
        alert('Por favor seleccione el rango de fechas');
        return;
    }

    if (desde > hasta) {
        alert('La fecha desde no puede ser mayor a la fecha hasta');
        return;
    }

    $.post("extraer/get_reporte_facturas", {
        desde: formatearFecha(desde),
        hasta: formatearFecha(hasta)
    })
    .done(function(data) {
        $("#tablaFacturas").html(data);
        $("#periodoFacturas").text(formatearFecha(desde) + " al " + formatearFecha(hasta));
        $("#tituloFacturas").show();
    });
}

function buscarServicios() {
    var desde = $("#desdeServicios").val();
    var hasta = $("#hastaServicios").val();

    if (!desde || !hasta) {
        alert('Por favor seleccione el rango de fechas');
        return;
    }

    if (desde > hasta) {
        alert('La fecha desde no puede ser mayor a la fecha hasta');
        return;
    }

    $.post("extraer/get_reporte_servicios", {
        desde: formatearFecha(desde),
        hasta: formatearFecha(hasta)
    })
    .done(function(data) {
        $("#tablaServicios").html(data);
        $("#periodoServicios").text(formatearFecha(desde) + " al " + formatearFecha(hasta));
        $("#tituloServicios").show();
    });
}
