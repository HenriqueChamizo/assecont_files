using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using AssecontNovo.Classes.Emails.AtualizarAssefin;
using Telerik.Web.UI;
using Wr.Classes;

namespace AssecontNovo.Grupo.Boletos
{
    public partial class AtualizaCelular : System.Web.UI.Page
    {
        private string ind;
        private BDAppAssefin bd;
        protected void Page_Load(object sender, EventArgs e)
        {
            ind = Request.QueryString["ind"];
            bd = new BDAppAssefin();

            ///if (!IsPostBack)
            //{
                //FV_ATUALIZAR_DADOS.Visible = false;
            //}
        }

        protected void lbAtualizarEmail_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    Panel Panel1 = (Panel)FV_ATUALIZAR_DADOS.FindControl("Panel1");
                    Panel1.Visible = false;

                    panelSucesso.Visible = true;
                }
                catch 
                {
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
            ((SqlDataSource)sender).ConnectionString = bd.Conn.ConnectionString;
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void btnCadastrar_Click(object sender, EventArgs e)
        {
            //panelChamadaAssecontCelular.Visible = false;
            FV_ATUALIZAR_DADOS.Visible = true;
        }

        protected void btnNaoCadastrar_Click(object sender, EventArgs e)
        {            
            //bd.executeCommand("UPDATE Cadastros SET CAD_CELULAR_ACEITA = 0, CAD_CADASTRO_ATUALIZADO_EM = GETDATE() WHERE CAD_IND = " + ind);
        } 
    }
}