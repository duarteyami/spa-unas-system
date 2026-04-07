<%@page contentType="text/html; charset=iso-8859-1"
session="true" language="java" import="java.util.*" %>

<html >
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link href="imagenes/mundito.png" rel="shortcut icon">
 <title>VENTANA DE ACCESO</title>
 
<style>

body {
   font-family: Arial, Helvetica, sans-serif;
   background-color:#FCBBE6;
};
form {border: 3px solid #f1f1f1;}


input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}


button {
  background-color: #F52AB2;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
}

error{
  color: red;
  }

button:hover {
  opacity: 0.8;
}

.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
}

img.avatar {
  width: 40%;
  border-radius: 30%;
}

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
.container,.container-fluid {
  margin-right: auto;
  margin-left: auto;
  padding-left: 15px;
  padding-right: 15px;
}
@media (min-width: 650px) {
  .container {
    width: 600px;
  }
}

</style>

</head>
<body>
<div class="container">
<center><h2>SPA PARA UÑAS</h2>

<form action="sql_acceso.jsp"  method="post"  class="container-fluid" style="background-color: appworkspace"> 
  <div class="imgcontainer"> 
      <img src="imagenes/acceso.png" alt="Avatar" class="avatar">
  </div>
 

     <font color="red">
     <td align="center" style="color: red" colspan="2">
                        <%=request.getParameter("error") != null ? request.getParameter("error") : ""%></td><br><br> <br> 
      
      </font>
      
    <label for="usuario"><b>Usuario</b></label>
    <input type="text" placeholder="Ingrese Usuario" name="usuario" required>

    <label for="clave"><b>password</b></label>
    <input type="password" placeholder="Ingrese Contraseña" name="clave" required>
        
    <button type="submit" value="Ingresar">ACCEDER</button>
  
</form></center>
  </div>
</body>
</html>

