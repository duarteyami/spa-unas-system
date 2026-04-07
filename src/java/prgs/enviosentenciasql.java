package prgs;
/**
  * @author ANONIMO
 */
import java.sql.*;

public class enviosentenciasql 
{
    Connection conexion;

    public enviosentenciasql() 
    {
        conexion = null;
    }

    public void setConexion(Connection conexion) 
    {
        this.conexion = conexion;
    }

    public ResultSet obtenerDato(String s) throws Exception 
    {
        Statement statement = conexion.createStatement();
        ResultSet resultset = statement.executeQuery(s);
        return resultset;
    }

    public void actualizarDato(String s) throws Exception 
    {
        Statement statement = conexion.createStatement();
        statement.executeUpdate(s);
    }

    public long contarRegistro(String s) throws Exception 
    {
        Statement statement = conexion.createStatement();
        ResultSet resultset = statement.executeQuery(s);
        resultset.next();
        return (long)resultset.getInt(1);
    }
     public ResultSet ObtenerDatogrilla(String sql2) throws Exception
     {
        Statement sentencia = conexion.createStatement();
        ResultSet resultado = sentencia.executeQuery(sql2);

        return resultado;
    }
     
     public ResultSet ObtenerDatoCombo(String s1) throws Exception
    {
       Statement sentencia = conexion.createStatement();

       ResultSet resultado= sentencia.executeQuery(s1);

       return resultado;
    } 
}
