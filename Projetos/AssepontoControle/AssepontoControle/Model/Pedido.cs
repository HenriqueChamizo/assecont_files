
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using Asseponto.Classes;
namespace Asseponto.Model
{
    public class Pedido
    {
        private int indice;
        private string fileName;
        private byte[] arquivo;
        private string extensao;

        public Pedido(int indice)
        {
            this.indice = indice;
        }

        public Pedido(int indice, byte[] arquivo, string extensao)
        {
            this.indice = indice;
            this.arquivo = arquivo;
            this.extensao = extensao;
        }

        public int Indice
        {
            get { return indice; }
            set { indice = value; }
        }

        public string FileName
        {
           get { return fileName; }
           set { fileName = value; }
        }

        public byte[] Arquivo
        {
            get { return arquivo; }
            set { arquivo = value; }
        }

        public string Extensao
        {
            get { return extensao; }
            set { extensao = value; }
        }

        public void setPlanilha(FileUpload file)
        {
            fileName = file.PostedFile.FileName;
            extensao = Path.GetExtension(fileName).Replace(".", string.Empty).ToLower();

            arquivo = new byte[file.PostedFile.InputStream.Length + 1];
            file.PostedFile.InputStream.Read(arquivo, 0, arquivo.Length);
        }

        public void insertPlanilhaRevenda(BDApp bd)
        {
            string queryPlanilha = "UPDATE AssepontoPedidosRevendas SET PED_PLANILHA_EXCEL = @ARQUIVO, PED_PLANILHA_EXTENSAO = @EXTENSAO WHERE PED_IND = {0}";

            SqlCommand cmd = new SqlCommand(string.Format(queryPlanilha, indice), bd.Conn);
            cmd.Parameters.Add("@ARQUIVO", SqlDbType.Binary).Value = arquivo;
            cmd.Parameters.Add("@EXTENSAO", SqlDbType.NChar).Value = extensao;

            cmd.ExecuteNonQuery();
        }

        public void insertPlanilhaAssecont(int Usuario, BDApp bd)
        {
            string query = "EXEC asseponto_pedido_finalizar @P_PEDIDO = @PEDIDO, @P_TECNICO =  @TECNICO , @P_ARQUIVO = @ARQUIVO, @P_EXTENSAO = @EXTENSAO";

            SqlCommand cmd = new SqlCommand(query, bd.Conn);
            cmd.Parameters.Add("@PEDIDO", SqlDbType.Int).Value = indice;
            cmd.Parameters.Add("@TECNICO", SqlDbType.Int).Value = Usuario;
            cmd.Parameters.Add("@ARQUIVO", SqlDbType.Binary).Value = arquivo;
            cmd.Parameters.Add("@EXTENSAO", SqlDbType.NChar).Value = extensao;

            cmd.ExecuteNonQuery();
        }

        public void selectPlanilha()
        {
            string query = "SELECT PED_PLANILHA_EXCEL, PED_PLANILHA_EXTENSAO FROM AssepontoPedidosRevendas WHERE PED_IND = {0}";

            BDApp bd = new BDApp();
            DataTable table = bd.getDataTable(string.Format(query, indice));

            foreach (DataRow reader in table.Rows)
            {
                extensao = reader["PED_PLANILHA_EXTENSAO"].ToString().Trim();

                if (reader["PED_PLANILHA_EXCEL"] != DBNull.Value)
                    arquivo = (byte[])reader["PED_PLANILHA_EXCEL"];
            }
        }
    }
}