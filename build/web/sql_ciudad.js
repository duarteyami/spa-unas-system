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
    
    $.post("solicita_gencodigo", {campo: "id_ciudad", tabla: "ciudad"})
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
            conf = "¿DESEA GUARDAR LA NUEVA CIUDAD?";
            sql = "insert into ciudad (id_ciudad,ciu_descri) values(" + $("#txtcodigo").val() + ",upper('" + $("#txtdescripcion").val() + "'))";
            
            men = "LA CIUDAD FUE REGISTRADA CON EXITO";
        }
        
        if ($("#operacion").val() === "2")
        {
            sql = "update ciudad set ciu_descri = '" + $("#txtdescripcion").val() + "' where id_ciudad = " + $("#txtcodigo").val();
            conf = "¿DESEA MODIFICAR?";
            men = "FUE MODIFICADA CON EXITO";
        }
        
        if ($("#operacion").val() === "3") 
        {
            conf = "¿DESEA ELIMINAR ESTA CIUDAD?";
            sql = "delete from ciudad where id_ciudad = " + $("#txtcodigo").val();
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
    var sql = "select * from ciudad where ciu_descri like '%"+filtro+"%' order by id_ciudad";
    $.post("extraer/get_ciudad", {sql: sql})
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

