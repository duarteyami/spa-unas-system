function agregar() 
{
    //alertify.alert("USTED HA PULSADO BOTON AGREGAR");
   $("#txtnombre").removeAttr("disabled");
    $("#txtapellido").removeAttr("disabled");
    $("#txttelefono").removeAttr("disabled");
    $("#txtdireccion").removeAttr("disabled");
    $("#txtemail").removeAttr("disabled");
    $("#txtci").removeAttr("disabled");
    $("#cmbciudad").removeAttr("disabled");  // ← COMBOBOX en lugar de input
    
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("1");
    
    $.post("solicita_gencodigo", {campo: "id_cliente", tabla: "clientes"})
            .done(function (data) {
                $("#txtcodigo").val(data);
            });
}

function modificar() 
{
    //alertify.alert("USTED HA PULSADO BOTON MODIFICAR");
    $("#txtnombre").removeAttr("disabled");
    $("#txtapellido").removeAttr("disabled");
    $("#txttelefono").removeAttr("disabled");
    $("#txtdireccion").removeAttr("disabled");
    $("#txtemail").removeAttr("disabled");
    $("#txtci").removeAttr("disabled");
    $("#cmbciudad").removeAttr("disabled");  // ← COMBOBOX
    
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("2");
    $("#txtnombre").select();
}
function borrar() 
{
    //alertify.alert("USTED HA PULSADO BOTON AGREGAR");
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("3");
    grabar();
}

function cancelar() 
{
    clear_text();
    
    $("#txtnombre").attr("disabled", "true");
    $("#txtapellido").attr("disabled", "true");
    $("#txttelefono").attr("disabled", "true");
    $("#txtdireccion").attr("disabled", "true");
    $("#txtemail").attr("disabled", "true");
    $("#txtci").attr("disabled", "true");
    $("#cmbciudad").attr("disabled", "true");  // ← COMBOBOX
    
    $("#btnGrabar").attr("disabled", "true");
    $("#btnCancelar").attr("disabled", "true");
    $("#btnAgregar").removeAttr("disabled");
    $("#btnModificar").removeAttr("disabled");
    $("#btnBorrar").removeAttr("disabled");
    $("#btnSalir").removeAttr("disabled");
    
    
    get_datos("");
}

 function clear_text()
 {
    $("#txtcodigo").val("");
    $("#txtnombre").val("");
    $("#txtapellido").val("");
    $("#txttelefono").val("");
    $("#txtdireccion").val("");
    $("#txtemail").val("");
    $("#txtci").val("");
    $("#cmbciudad").val("");  // ← COMBOBOX (resetea a "Seleccione ciudad...")
 }
 
 
function grabar() 
{
   var nombre = $.trim($("#txtnombre").val());
    var apellido = $.trim($("#txtapellido").val());
    var telefono = $.trim($("#txttelefono").val());
    var direccion = $.trim($("#txtdireccion").val());
    var email = $.trim($("#txtemail").val());
    var ci = $.trim($("#txtci").val());
    var ciudad = $("#cmbciudad").val();  // ← ID de la ciudad seleccionada
    
    if (nombre === "" || apellido === "" || ci === "" || ciudad === "")  
    {
        alertify.alert('DEBES LLENAR TODOS LOS CAMPOS');
    } else 
    {
        var sql = "";
        var men = "";
        var conf = "";
        
        if ($("#operacion").val() === "1") 
        {
            conf = "¿DESEA GUARDAR AL NUEVO CLIENTE?";
            sql = "insert into clientes (id_cliente, cl_nombre, cl_apellido, cl_telefono, cl_direccion, cl_email, cl_cedula, id_ciudad) values(" + $("#txtcodigo").val() + ", upper('" + $("#txtnombre").val() + "'), upper('" + $("#txtapellido").val() + "'), '" + $("#txttelefono").val() + "', '" + $("#txtdireccion").val() + "', '" + $("#txtemail").val() + "', '" + $("#txtci").val() + "', " + $("#cmbciudad").val() + ")";
            
            men = "EL CLIENTE FUE REGISTRADO CON EXITO";
        }
        
        if ($("#operacion").val() === "2")
        {
            sql = "update clientes set cl_nombre = upper('" + $("#txtnombre").val() + "'), cl_apellido = upper('" + $("#txtapellido").val() + "'), cl_telefono = '" + $("#txttelefono").val() + "', cl_direccion = '" + $("#txtdireccion").val() + "', cl_email = '" + $("#txtemail").val() + "', cl_cedula = '" + $("#txtci").val() + "', id_ciudad = " + $("#cmbciudad").val() + " where id_cliente = " + $("#txtcodigo").val();
            conf = "¿DESEA MODIFICAR CLIENTE?";
            men = "FUE MODIFICADA CON EXITO";
        }
        
        if ($("#operacion").val() === "3") 
        {
            conf = "¿DESEA ELIMINAR ESTE CLIENTE?";
            sql = "delete from clientes where id_cliente = " + $("#txtcodigo").val();
            men = "FUE ELIMINADO CON EXITO";
        }
        
        alertify.confirm(conf, function (e) 
        {
            if (e) 
            {
                $.post("enviosqlBoot", {sql: sql, men: men})
                        .done(function (data) {
                            alertify.alert(data);
                            cancelar();
                        });
            }
        });
    }
}

function get_datos(filtro)
{
    var sql = "select c.id_cliente, c.cl_nombre, c.cl_apellido, c.cl_telefono, c.cl_direccion, c.cl_email, c.cl_cedula, c.id_ciudad, ci.ciu_descri from clientes c left join ciudad ci on c.id_ciudad = ci.id_ciudad where c.cl_nombre like '%" + filtro + "%' or c.cl_apellido like '%" + filtro + "%' order by c.id_cliente";
    $.post("extraer/get_cliente", {sql: sql})
        .done(function (data) {
            $("#grilla tbody").html(data);
        });
   }

function seleccion(parent) 
{
    parent.find("td").each(function(index)
    {
         if(index === 0)
        {
            $("#txtcodigo").val($(this).text());
        }
        
        if(index === 1)
        {
            $("#txtnombre").val($(this).text());
        }
        
        if(index === 2)
        {
            $("#txtapellido").val($(this).text());
        }
        
        if(index === 3)
        {
            $("#txttelefono").val($(this).text());
        }
        
        if(index === 4)
        {
            $("#txtdireccion").val($(this).text());
        }
        
        if(index === 5)
        {
            $("#txtemail").val($(this).text());
        }
        
        if(index === 6)
        {
            $("#txtci").val($(this).text());
        }
        
        if(index === 7)
        {
            // Toma el ID del atributo data-id, no el texto
            $("#cmbciudad").val($(this).attr("data-id"));
        }
   
    });
}

$(function () 
{
    get_datos("");
});

