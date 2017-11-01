using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes.Emails.FormSolicSimples;
using Wr.Classes;

namespace AssecontNovo.Teste.Formularios
{
    public partial class FormSolicitSimples : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btEnviar_Click(object sender, EventArgs e)
        {
            FormSolicSimples email = new FormSolicSimples("notificacao@assecont.com.br", null, Server.MapPath("") + "\\..\\..\\Classes\\Emails\\FormSolicSimples\\FormSolicSimples.htm");
            email.Send(((TextBox)FormViewFormulario.FindControl("txtRazaoS")).Text, ((TextBox)FormViewFormulario.FindControl("txtCnpj")).Text,
                ((TextBox)FormViewFormulario.FindControl("txtContato1")).Text, ((TextBox)FormViewFormulario.FindControl("txtTelefone1")).Text, ((TextBox)FormViewFormulario.FindControl("txtEmail1")).Text);

            Response.Redirect("~/Tecnologia/Formularios/ConfirmacaoSolicitacao.aspx");
        
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }
    }
}