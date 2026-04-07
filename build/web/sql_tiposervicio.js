function agregar() 
{
    //alertify.alert("USTED HA PULSADO BOTON AGREGAR");
    $("#txtdescripcion").removeAttr("disabled");
     $("#txtcosto").removeAttr("disabled");
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("1");
    
    $.post("solicita_gencodigo", {campo: "id_tipo_serv", tabla: "tipo_servicio"})
            .done(function (data) {
                $("#txtcodigo").val(data);
            });
}

function modificar() 
{
    //alertify.alert("USTED HA PULSADO BOTON MODIFICAR");
    $("#txtdescripcion").removeAttr("disabled");
    $("#txtcosto").removeAttr("disabled");
    
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
     $("#txtcosto").attr("disabled", "true");
    
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
    $("#txtcosto").val("");
 }
 
 
function grabar() 
{
    var d = $.trim($("#txtdescripcion").val());
    var c = $.trim($("#txtcosto").val());

    if (d === "" || c === "") 
    {
        alertify.alert('DEBES LLENAR TODOS LOS CAMPOS');
    } else 
    {
        var sql = "";
        var men = "";
        var conf = "";
        
        if ($("#operacion").val() === "1") 
        {
            conf = "¿DESEA GUARDAR EL NUEVO SERVICIO?";
            sql = "insert into tipo_servicio (id_tipo_serv, tip_serv_descri, tip_serv_costo) values(" + $("#txtcodigo").val() + ", upper('" + $("#txtdescripcion").val() + "'), " + $("#txtcosto").val() + ")";
            
            men = "EL SERVIICO FUE REGISTRADA CON EXITO";
        }
        
        if ($("#operacion").val() === "2")
        {
            sql = "update tipo_servicio set tip_serv_descri = upper('" + $("#txtdescripcion").val() + "'), tip_serv_costo = " + $("#txtcosto").val() + " where id_tipo_serv = " + $("#txtcodigo").val();
            conf = "¿DESEA MODIFICAR?";
            men = "FUE MODIFICADA CON EXITO";
        }
        
        if ($("#operacion").val() === "3") 
        {
            conf = "¿DESEA ELIMINAR ESTE SERVICIO?";
            sql = "delete from tipo_servicio where id_tipo_serv = " + $("#txtcodigo").val();
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
   var sql = "select * from tipo_servicio where tip_serv_descri like '%"+filtro+"%' order by id_tipo_serv";
    $.post("extraer/get_tiposervicio", {sql: sql})
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
        
        if(index === 2)
        {
            $("#txtcosto").val($(this).text());
        }
    });
}

$(function () 
{
    get_datos("");
});

