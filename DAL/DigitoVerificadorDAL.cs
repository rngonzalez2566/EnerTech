using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DigitoVerificadorDAL : Acceso
    {
        UsuarioDAL user = new UsuarioDAL(); 
        public int AltaDVV(string xTabla)
        {
            try
            {

                int dvv = existeDVV(xTabla);

                int dvh = CalcularDVH(xTabla);


                if (dvv == 0) xCommandText = Querys.DVQuerys.alta_DVV;
                else xCommandText = Querys.DVQuerys.actualizar_DVV;

                xParameters.Parameters.Clear();
                xParameters.Parameters.AddWithValue("@tabla", xTabla);
                xParameters.Parameters.AddWithValue("@dvv", dvh);

                return ExecuteNonEscalar();
            }
            catch
            {
                throw new Exception("Error en la base de datos.");
            }
        }

        public int CalcularDVH(string xTabla)
        {
            int xDVH = 0;

            xCommandText = String.Format(Querys.DVQuerys.get_DVH, xTabla);

            DataSet ds = new DataSet();
            ds = ExecuteReader();

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                xDVH = int.Parse(ds.Tables[0].Rows[0]["DVH"].ToString());
            }

            return xDVH;
        }

       

        public void RecalcularDigitos()
        {
            Services.DigitoVerificador dv = new Services.DigitoVerificador();

            try
            {
                xCommandText = Querys.DVQuerys.get_Tabla_Digitos;

                DataSet ds = new DataSet();
                ds = ExecuteReader(); // Método para obtener un DataSet en lugar de un DataTable
                string tabla;
                string xQuery;

                if (ds.Tables[0].Rows.Count > 0) // Acceder a la primera tabla del DataSet
                {
                    foreach (DataRow fila in ds.Tables[0].Rows)
                    {
                        tabla = fila[0].ToString();
                        if (tabla == "Usuario")
                        {
                            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
                            DataSet dsU = new DataSet();
                            dsU = ExecuteReader();
                            if (dsU.Tables[0].Rows.Count > 0)
                            {
                                foreach (DataRow fila1 in dsU.Tables[0].Rows)
                                {
                                    int xid = 0;
                                    UsuarioBE usuario = new BE.UsuarioBE();
                                    xid = int.Parse(fila1[0].ToString());
                                    usuario = user.GetUsuarioID(xid);
                                   
                                    usuario.DVH = dv.CalcularDV(usuario);

                                    xQuery = "update usuario set DVH = {0} where id_usuario = {1}";
                                    xCommandText = String.Format(xQuery, usuario.DVH, usuario.id_usuario);
                                    executeNonQuery();
                                    AltaDVV("Usuario");
                                }
                            }
                        }
                        else if (tabla == "Bitacora")
                        {
                            xCommandText = String.Format(Querys.DVQuerys.get_Recalcula_Digitos, tabla);
                            DataSet dsB = new DataSet();
                            dsB = ExecuteReader();

                            if (dsB.Tables[0].Rows.Count > 0)
                            {
                                foreach (DataRow fila2 in dsB.Tables[0].Rows)
                                {

                                    BitacoraBE bit = new BitacoraBE();
                                    UsuarioBE us = new UsuarioBE();

                                    bit.id_bitacora = int.Parse(fila2[0].ToString());
                                    bit.DVH = dv.CalcularDV(bit);

                                    xQuery = "update Bitacora set DVH = {0} where id_bitacora = {1}";
                                    xCommandText = String.Format(xQuery, bit.DVH, bit.id_bitacora);
                                    executeNonQuery();

                                    AltaDVV("Bitacora");
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                throw new Exception("Error al recalcular digitos verificadores");
            }
        }

        public int existeDVV(string xTabla)
        {
            int xDVV = 0;

            xCommandText = Querys.DVQuerys.exist_DVV;
            xParameters.Parameters.Clear();
            xParameters.Parameters.AddWithValue("@tabla", xTabla);

            DataSet ds = new DataSet();
            ds = ExecuteReader();

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                xDVV = int.Parse(ds.Tables[0].Rows[0]["DVV"].ToString());
            }

            return xDVV;
        }

        public List<String> VerificarDV()
        {
            UsuarioBE usuario = new UsuarioBE();
            usuario.id_usuario = 1;
            usuario.Nombre = "Sistema";
            var lista = new List<String>();


            string xConsulta = "SELECT D.nombre_tabla TABLA, D.valorDVV DV FROM DigitoVerificador D";
            xCommandText = xConsulta;
            DataSet tb = new DataSet();
            tb = ExecuteReader();

            foreach (DataRow fila in tb.Tables[0].Rows)
            {
                int xDV = int.Parse(fila[1].ToString());
                string xTabla = fila[0].ToString();



                string xConsulta1 = "SELECT ISNULL(SUM(DVH),0) DVH FROM {0}";
                xCommandText = String.Format(xConsulta1, xTabla);
                DataSet tb1 = new DataSet();
                tb1 = ExecuteReader();

                int xValor = int.Parse(tb1.Tables[0].Rows[0]["DVH"].ToString());

                if (xValor != xDV)
                {

                    lista.Add("Error en la validacion de la suma de digitos horizontales con el Digito Vertical de la tabla: " + xTabla);
                }

            }
            return lista;
        }
    }
}
