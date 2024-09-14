using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Acceso : Conexion
    {
        SqlConnection con = new SqlConnection();
        private string xTextCommand;
        private SqlCommand parameters = new SqlCommand();

        protected string xCommandText
        {
            get { return xTextCommand; }
            set { xTextCommand = value; }
        }


        protected SqlCommand xParameters
        {
            get { return parameters; }
            set { parameters = value; }
        }

        private void Conectar()
        {
            con.ConnectionString = conexion;
            con.Open();
        }
        private void Desconectar()
        {
            con.Close();
        }

        public void executeNonQuery()
        {

            Conectar();

            SqlTransaction TR = con.BeginTransaction();
            SqlCommand command = new SqlCommand(xCommandText, con, TR);

            command.CommandType = CommandType.Text;
            command.Parameters.Clear();


            foreach (SqlParameter p in xParameters.Parameters)
            {
                command.Parameters.AddWithValue(p.ParameterName, p.SqlValue);
            }

            try
            {

                command.ExecuteNonQuery();
                TR.Commit();
            }

            catch (SqlException exc)
            {

                TR.Rollback();
                throw new Exception("ocurrio un Error en BD:" + exc.Message);
            }
            //otros errores
            catch (Exception exc2)
            {

                TR.Rollback();
                throw new Exception("ocurrio un Error :" + exc2.Message);
            }
            finally
            {
                Desconectar();
            }
        }


        public DataSet ExecuteReader()
        {

            Conectar();
            SqlTransaction TR = con.BeginTransaction();
            SqlCommand comando = new SqlCommand(xCommandText, con, TR);

            comando.CommandType = CommandType.Text;
            comando.Parameters.Clear();


            foreach (SqlParameter p in xParameters.Parameters)
            {
                comando.Parameters.AddWithValue(p.ParameterName, p.SqlValue);
            }

            try
            {
                // Crear un DataSet y un SqlDataAdapter
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(comando);

                // Asignar la transacción al adaptador
                da.SelectCommand.Transaction = TR;

                // Llenar el DataSet con los resultados de la consulta
                da.Fill(ds);

                // Confirmar la transacción
                TR.Commit();

                // Retornar el DataSet
                return ds;
            }

            catch (SqlException exc)
            {

                TR.Rollback();
                throw new Exception("ocurrio un Error en BD:" + exc.Message);
            }

            catch (Exception exc2)
            {

                TR.Rollback();
                throw new Exception("ocurrio un Error :" + exc2.Message);
            }
            finally
            {

                Desconectar();

            }

        }

        public virtual int ExecuteNonEscalar()
        {
            Conectar();
            SqlTransaction transaction = con.BeginTransaction();
            SqlCommand command = new SqlCommand(xCommandText, con, transaction);

            command.CommandType = CommandType.Text;
            command.Parameters.Clear();

            foreach (SqlParameter p in xParameters.Parameters)
            {
                command.Parameters.AddWithValue(p.ParameterName, p.SqlValue);
            }

            SqlParameter sp_return = new SqlParameter();
            sp_return.Direction = ParameterDirection.ReturnValue;
            command.Parameters.Add(sp_return);

            int outputId = 0;

            try
            {
                outputId = (int)command.ExecuteScalar();
                transaction.Commit();
            }
            catch (SqlException exc)
            {
                transaction.Rollback();
                throw new Exception("Ocurrió un error en BD: " + exc.Message);
            }
            catch (Exception exc2)
            {
                transaction.Rollback();
                throw new Exception("Ocurrió un error: " + exc2.Message);
            }
            finally
            {
                Desconectar();
            }

            return outputId;
        }



        public virtual void ExecuteNonQueryNonTransaction()
        {
            Conectar();

            SqlCommand command = new SqlCommand(xCommandText, con);

            command.CommandType = CommandType.Text;
            command.Parameters.Clear();

            foreach (SqlParameter p in xParameters.Parameters)
            {
                command.Parameters.AddWithValue(p.ParameterName, p.SqlValue);
            }

            try
            {
                command.ExecuteNonQuery();
            }
            catch (SqlException exc)
            {
                throw new Exception("Ocurrió un error en BD: " + exc.Message);
            }
            catch (Exception exc2)
            {
                throw new Exception("Ocurrió un Error: " + exc2.Message);
            }
            finally
            {
                Desconectar();
            }
        }
    }
}
