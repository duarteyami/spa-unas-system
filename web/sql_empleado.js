function agregar() 
{
    //alertify.alert("USTED HA PULSADO BOTON AGREGAR");
    $("#txtnombre").removeAttr("disabled");
    $("#txtapellido").removeAttr("disabled");
    $("#txttelefono").removeAttr("disabled");
    $("#txtemail").removeAttr("disabled");
    $("#txtci").removeAttr("disabled");
    $("#txtdireccion").removeAttr("disabled");
    $("#txtestadociv").removeAttr("disabled");
    $("#txtuser").removeAttr("disabled");
    $("#txtpassword").removeAttr("disabled");
    $("#txtestado").removeAttr("disabled");
    $("#txtnivel").removeAttr("disabled");
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("1");
    
    $.post("solicita_gencodigo", {campo: "id_empleado", tabla: "empleado"})
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
    $("#txtemail").removeAttr("disabled");
    $("#txtci").removeAttr("disabled");
    $("#txtdireccion").removeAttr("disabled");
    $("#txtestadociv").removeAttr("disabled");
    $("#txtuser").removeAttr("disabled");
    $("#txtpassword").removeAttr("disabled");
    $("#txtestado").removeAttr("disabled");
    $("#txtnivel").removeAttr("disabled");
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
    $("#txtemail").attr("disabled", "true");
    $("#txtci").attr("disabled", "true");
    $("#txtdireccion").attr("disabled", "true");
    $("#txtestadociv").attr("disabled", "true");
    $("#txtuser").attr("disabled", "true");
    $("#txtpassword").attr("disabled", "true");
    $("#txtestado").attr("disabled", "true");
    $("#txtnivel").attr("disabled", "true");
    
    
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
    $("#txtemail").val("");
    $("#txtci").val("");
    $("#txtdireccion").val("");
    $("#txtestadociv").val("");
    $("#txtuser").val("");
    $("#txtpassword").val("");
    $("#txtestado").val("");
    $("#txtnivel").val("");
 }
 
 
function grabar() 
{
    var nombre = $.trim($("#txtnombre").val());
    var apellido = $.trim($("#txtapellido").val());
    var telefono = $.trim($("#txttelefono").val());
    var email = $.trim($("#txtemail").val());
    var ci = $.trim($("#txtci").val());
    var direccion = $.trim($("#txtdireccion").val());
    var estadociv = $.trim($("#txtestadociv").val());
    var user = $.trim($("#txtuser").val());
    var password = $.trim($("#txtpassword").val());
    var estado = $.trim($("#txtestado").val());
    var nivel = $.trim($("#txtnivel").val());
    
    if (nombre === "" || apellido === "" || ci === "" || user === "" || password === "") 
    {
        alertify.alert('DEBES LLENAR TODOS LOS CAMPOS');
    } else 
    {
        var sql = "";
        var men = "";
        var conf = "";
        
        if ($("#operacion").val() === "1") 
        {
            conf = "¿DESEA GUARDAR AL NUEVO EMPLEADO?";
            sql = "insert into empleado (id_empleado, edo_nombre, edo_apellido, edo_telefono, edo_email, edo_ci, edo_direccion, edo_esc_civil, edo_usuario, edo_contrasenia, edo_estado, edo_nivel) values(" + $("#txtcodigo").val() + ", upper('" + $("#txtnombre").val() + "'), upper('" + $("#txtapellido").val() + "'), '" + $("#txttelefono").val() + "', '" + $("#txtemail").val() + "', " + $("#txtci").val() + ", '" + $("#txtdireccion").val() + "', '" + $("#txtestadociv").val() + "', '" + $("#txtuser").val() + "', '" + $("#txtpassword").val() + "', '" + $("#txtestado").val() + "', '" + $("#txtnivel").val() + "')";
            
            men = "EL EMPLEADO FUE REGISTRADO CON EXITO";
        }
        
        if ($("#operacion").val() === "2")
        {
            sql = "update empleado set edo_nombre = upper('" + $("#txtnombre").val() + "'), edo_apellido = upper('" + $("#txtapellido").val() + "'), edo_telefono = '" + $("#txttelefono").val() + "', edo_email = '" + $("#txtemail").val() + "', edo_ci = " + $("#txtci").val() + ", edo_direccion = '" + $("#txtdireccion").val() + "', edo_esc_civil = '" + $("#txtestadociv").val() + "', edo_usuario = '" + $("#txtuser").val() + "', edo_contrasenia = '" + $("#txtpassword").val() + "', edo_estado = '" + $("#txtestado").val() + "', edo_nivel = '" + $("#txtnivel").val() + "' where id_empleado = " + $("#txtcodigo").val();
            conf = "¿DESEA MODIFICAR?";
            men = "FUE MODIFICADA CON EXITO";
        }
        
        if ($("#operacion").val() === "3") 
        {
            conf = "¿DESEA ELIMINAR ESTE EMPLEADO?";
            sql = "delete from empleado where id_empleado = " + $("#txtcodigo").val();
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
   var sql = "select * from empleado where edo_nombre like '%" + filtro + "%' or edo_apellido like '%" + filtro + "%' order by id_empleado";
    $.post("extraer/get_empleado", {sql: sql})
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
            $("#txtemail").val($(this).text());
        }
        
        if(index === 5)
        {
            $("#txtci").val($(this).text());
        }
        
        if(index === 6)
        {
            $("#txtdireccion").val($(this).text());
        }
        
        if(index === 7)
        {
            $("#txtestadociv").val($(this).text());
        }
        
        if(index === 8)
        {
            $("#txtuser").val($(this).text());
        }
        
        if(index === 9)
        {
            $("#txtpassword").val($(this).text());
        }
        
        if(index === 10)
        {
            $("#txtestado").val($(this).text());
        }
        
        if(index === 11)
        {
            $("#txtnivel").val($(this).text());
        }
    });
}

$(function () 
{
    get_datos("");
});

