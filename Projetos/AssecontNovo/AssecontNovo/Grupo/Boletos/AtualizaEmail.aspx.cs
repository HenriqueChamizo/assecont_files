using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using AssecontNovo.Classes.Emails.AtualizarAssefin;
using Telerik.Web.UI;
using Wr.Classes;

namespace AssecontNovo.Grupo.Boletos
{
    public partial class AtualizaEmail : System.Web.UI.Page
    {
        private string ind;
        protected void Page_Load(object sender, EventArgs e)
        {
            ind = Request.QueryString["ind"];
        }

        protected void lbAtualizarEmail_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    ///Panel Panel1 = (Panel)FV_ATUALIZAR_DADOS.FindControl("Panel1");
                    FV_ATUALIZAR_DADOS.Visible = false;

                    panelSucesso.Visible = true;
                }
                catch 
                {
                    FV_ATUALIZAR_DADOS.Visible = false;
                    panelFalha.Visible = true;
                }
            }
        }

        protected void FV_ATUALIZAR_DADOS_DataBound(object sender, EventArgs e)
        {
            //Verificando se não tiver em modo leitura, validar os campos obrigatorios.
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        protected void CAD_ESTADO_DataBinding(object sender, EventArgs e)
        {
            RadComboBox txtEstado = (RadComboBox)FV_ATUALIZAR_DADOS.FindControl("txtEstado");
            txtEstado.DataSourceID = "sqlEstados";
            txtEstado.DataTextField = "EST_SIGLA";
            txtEstado.DataValueField = "EST_SIGLA";
        }

        protected void SqlDataAssefin_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssefin()).Conn.ConnectionString;
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlCadastro_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                string query = "SELECT CAD_ENDERECO, CAD_ENDERECO_NUMERO, CAD_COMPLEMENTO, CAD_BAIRRO, CAD_CIDADE, CAD_CEP, CAD_ESTADO, " +
                    "CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_TELEFONE1_DDD, CAD_FINANCEIRO_TELEFONE1, CAD_FINANCEIRO_TELEFONE2_DDD, CAD_FINANCEIRO_TELEFONE2, " +
                    "CAD_FINANCEIRO_CELULAR1_DDD, CAD_FINANCEIRO_CELULAR1, CAD_CELULAR_ACEITA, CAD_CADASTRO_ATUALIZADO_EM,  " +
                    "(CASE WHEN CAD_CNPJ IS NULL THEN CAD_CPF ELSE CAD_CNPJ END) AS CNPJ_CPF FROM Cadastros WHERE CAD_IND = {0}";

                DataTable tbDados = (new BDAppAssefin()).getDataTable(string.Format(query, ind));

                if (tbDados.Rows.Count > 0)
                {
                    AtualizarAsseponto(tbDados);
                    AtualizarAssecontWeb(tbDados);
                }
            }
        }

        void AtualizarAsseponto(DataTable tbDados)
        {
            try
            {
                string comando = "UPDATE AssepontoClientes SET CAD_ENDERECO = '@ENDERECO', CAD_ENDERECO_NUMERO = '@NUMERO', CAD_ENDERECO_COMPLEMENTO = '@COMPLEMENTO', CAD_CIDADE = '@CIDADE', " +
                    "CAD_BAIRRO = '@BAIRRO', CAD_UF = '@UF', CAD_CEP = '@CEP', CAD_TELEFONE1_DDD = '@TELEFONE_DDD1', CAD_TELEFONE1 = '@TELEFONE1', CAD_TELEFONE2_DDD = '@TELEFONE_DDD2', CAD_TELEFONE2 = '@TELEFONE2', " +
                    "CAD_FINANCEIRO_EMAIL = '@EMAIL_FINANCEIRO1', CAD_FINANCEIRO_EMAIL2 = '@EMAIL_FINANCEIRO2', CAD_CELULAR_DDD = '@CELULAR_DDD', CAD_CELULAR = '@CELULAR', CAD_CELULAR_ACEITA = '@CELULAR_ACEITA' " +
                    "WHERE dbo.fn_trim_cnpj(CAD_CNPJ) = dbo.fn_trim_cnpj(@CNPJ_CPF) OR dbo.fn_trim_cnpj(CAD_CPF) = dbo.fn_trim_cnpj(@CNPJ_CPF)";

                comando = comando.Replace("@ENDERECO", tbDados.Rows[0]["CAD_ENDERECO"].ToString().Trim());
                comando = comando.Replace("@NUMERO", tbDados.Rows[0]["CAD_ENDERECO_NUMERO"].ToString().Trim());
                comando = comando.Replace("@COMPLEMENTO", tbDados.Rows[0]["CAD_COMPLEMENTO"].ToString().Trim());
                comando = comando.Replace("@CIDADE", tbDados.Rows[0]["CAD_CIDADE"].ToString().Trim());
                comando = comando.Replace("@BAIRRO", tbDados.Rows[0]["CAD_BAIRRO"].ToString().Trim());
                comando = comando.Replace("@UF", tbDados.Rows[0]["CAD_ESTADO"].ToString());
                comando = comando.Replace("@CEP", tbDados.Rows[0]["CAD_CEP"].ToString().Trim());

                comando = comando.Replace("@TELEFONE_DDD1", tbDados.Rows[0]["CAD_FINANCEIRO_TELEFONE1_DDD"].ToString().Trim());
                comando = comando.Replace("@TELEFONE1", tbDados.Rows[0]["CAD_FINANCEIRO_TELEFONE1"].ToString().Trim());
                comando = comando.Replace("@TELEFONE_DDD2", tbDados.Rows[0]["CAD_FINANCEIRO_TELEFONE2_DDD"].ToString().Trim());
                comando = comando.Replace("@TELEFONE2", tbDados.Rows[0]["CAD_FINANCEIRO_TELEFONE2"].ToString().Trim());

                comando = comando.Replace("@EMAIL_FINANCEIRO1", tbDados.Rows[0]["CAD_FINANCEIRO_EMAIL"].ToString().Trim());
                comando = comando.Replace("@EMAIL_FINANCEIRO2", tbDados.Rows[0]["CAD_FINANCEIRO_EMAIL2"].ToString().Trim());

                comando = comando.Replace("@CELULAR_DDD", tbDados.Rows[0]["CAD_FINANCEIRO_CELULAR1_DDD"].ToString().Trim());
                comando = comando.Replace("@CELULAR_ACEITA", Convert.ToBoolean(tbDados.Rows[0]["CAD_CELULAR_ACEITA"]) ? "1" : "0" );
                comando = comando.Replace("@CELULAR", tbDados.Rows[0]["CAD_FINANCEIRO_CELULAR1"].ToString().Trim());

                comando = comando.Replace("@CNPJ_CPF", tbDados.Rows[0]["CNPJ_CPF"].ToString());

                (new BDAppTecnologia()).executeCommand(comando);
            }
            catch
            { }
        }

        void AtualizarAssecontWeb(DataTable tbDados)
        {
            try
            {
                string comando = "UPDATE Clientes SET CLI_ENDERECO = '@ENDERECO', CLI_ENDERECO_NUMERO = '@NUMERO', CLI_ENDERECO_COMPLEMENTO = '@COMPLEMENTO', CLI_ENDERECO_MUNICIPIO = '@CIDADE', " +
                    "CLI_ENDERECO_BAIRRO = '@BAIRRO', CLI_ENDERECO_UF = '@UF', CLI_ENDERECO_CEP = '@CEP' " +
                    "WHERE dbo.fn_trim_cnpj(CLI_CNPJ) = dbo.fn_trim_cnpj(@CNPJ_CPF) OR dbo.fn_trim_cnpj(CLI_CPF) = dbo.fn_trim_cnpj(@CNPJ_CPF)";

                comando = comando.Replace("@ENDERECO", tbDados.Rows[0]["CAD_ENDERECO"].ToString());
                comando = comando.Replace("@NUMERO", tbDados.Rows[0]["CAD_ENDERECO_NUMERO"].ToString());
                comando = comando.Replace("@COMPLEMENTO", tbDados.Rows[0]["CAD_COMPLEMENTO"].ToString());
                comando = comando.Replace("@CIDADE", tbDados.Rows[0]["CAD_CIDADE"].ToString());
                comando = comando.Replace("@BAIRRO", tbDados.Rows[0]["CAD_BAIRRO"].ToString());
                comando = comando.Replace("@UF", tbDados.Rows[0]["CAD_ESTADO"].ToString());
                comando = comando.Replace("@CEP", tbDados.Rows[0]["CAD_CEP"].ToString());

                comando = comando.Replace("@CNPJ_CPF", tbDados.Rows[0]["CNPJ_CPF"].ToString());

                (new BDAppAssecont()).executeCommand(comando);
            }
            catch
            { }
        }
    }
}