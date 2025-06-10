using MySql.Data.MySqlClient;
using System;
using System.Data.SqlClient;
using AutoConcilia1;
public class Conexion
{
    public static void ProbarConexion()
    {
        string connString = "Server=127.0.0.1;Port=3306;Database=AutoConcilia;User Id=root;Password=Santiago123;";
        using (MySqlConnection conn = new MySqlConnection(connString))
        {
            try
            {
                conn.Open();
                Console.WriteLine("¡Conexión exitosa!");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error de conexión: " + ex.Message);
            }
        }
    }
}
