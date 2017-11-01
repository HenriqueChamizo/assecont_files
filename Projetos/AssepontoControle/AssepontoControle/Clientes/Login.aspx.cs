using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Wr.Classes;

namespace Asseponto.Clientes
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Imagem
        protected void ImageButton1_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("~/Revenda/Arquivos/Assefin.aspx");
        }

        protected void ImageButton2_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("~/Revenda/Arquivos/Asseponto.aspx");
        }
        #endregion

        protected void lkEnviar_Click(object sender, EventArgs e)
        {
            VerificarManutencao(txtCnpjCpf.Text);
        }

        void VerificarManutencao(string CnpjCpf)
        {
            BDApp bd = new BDApp();

            bd.openConnection();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = bd.Conn;

            cmd.CommandText = "asseponto_pesquisar_cliente_manutencao";
            cmd.Parameters.AddWithValue("@P_CNPJ_CPF", CnpjCpf);

            cmd.Parameters.Add("@R_MANUNTECAO", SqlDbType.Int);
            cmd.Parameters["@R_MANUNTECAO"].Direction = ParameterDirection.Output;

            SqlDataReader dr = cmd.ExecuteReader();

            dr.Read();

            int manutencao = Convert.ToInt32(cmd.Parameters["@R_MANUNTECAO"].Value);

            dr.Close();
            bd.closeConnection();

            if (manutencao > 0)
            {
                Response.Redirect("~/Clientes/Home.aspx");
            }
            else
            {
                lbPrazo.Text = "Empresa inválida ou prazo expirado";
            }
        }
    }
}