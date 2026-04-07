function agregar() 
{
    //alertify.alert("USTED HA PULSADO BOTON AGREGAR");
    $("#txtdescripcion").removeAttr("disabled");
    
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("1");
    
    $.post("solicita_gencodigo", {campo: "id_tipo_pago", tabla: "tipo_pago"})
            .done(function (data) {
                $("#txtcodigo").val(data);
            });
}

function modificar() 
{
    //alertify.alert("USTED HA PULSADO BOTON MODIFICAR");
    $("#txtdescripcion").removeAttr("disabled");
    
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    
    $("#operacion").val("2");
    $("#txtdescripcion").select();
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
    
    $("#txtdescripcion").attr("disabled", "true");
    
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
    $("#txtdescripcion").val("");      
 }
 
 
function grabar() 
{
    var d = $.trim($("#txtdescripcion").val());

    if (d === "") 
    {
        alertify.alert('DEBES LLENAR TODOS LOS CAMPOS');
    } else 
    {
        var sql = "";
        var men = "";
        var conf = "";
        
        if ($("#operacion").val() === "1") 
        {
            conf = "¿DESEA GUARDAR LA NUEVA FORMA DE PAGO?";
            sql = "insert into tipo_pago (id_tipo_pago,tp_descripcion) values(" + $("#txtcodigo").val() + ",upper('" + $("#txtdescripcion").val() + "'))";
            
            men = "LA FORMA FUE REGISTRADA CON EXITO";
        }
        
        if ($("#operacion").val() === "2")
        {
            sql = "update tipo_pago set tp_descripcion = '" + $("#txtdescripcion").val() + "' where id_tipo_pago = " + $("#txtcodigo").val();
            conf = "¿DESEA MODIFICAR?";
            men = "FUE MODIFICADA CON EXITO";
        }
        
        if ($("#operacion").val() === "3") 
        {
            conf = "¿DESEA ELIMINAR ESTA FORMA DE PAGO?";
            sql = "delete from tipo_pago where id_tipo_pago = " + $("#txtcodigo").val();
            men = "FUE ELIMINADA CON EXITO";
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
    var sql = "select * from tipo_pago where tp_descripcion like '%"+filtro+"%' order by id_tipo_pago";
    $.post("extraer/get_forma_pago", {sql: sql})
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
                    $("#txtdescripcion").val($(this).text());
                }
               
     });
}

$(function () 
{
    get_datos("");
});

