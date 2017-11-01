using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes.Emails.FormularioWorkShop;
using Wr.Classes;

namespace AssecontNovo.Teste.Formularios
{
    public partial class InscWorkshop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btEnviar_Click(object sender, EventArgs e)
        {
            FormularioWorkShop email = new FormularioWorkShop("notificacao@assecont.com.br", null, Server.MapPath("") + "\\..\\..\\Classes\\Emails\\FormularioWorkShop\\FormularioWorkShop.htm");
            email.Send(((TextBox)FormViewFormulario.FindControl("txtRazaoS")).Text, ((TextBox)FormViewFormulario.FindControl("txtCnpj")).Text,
                ((TextBox)FormViewFormulario.FindControl("txtContato1")).Text, ((TextBox)FormViewFormulario.FindControl("txtTelefone1")).Text, ((TextBox)FormViewFormulario.FindControl("txtEmail1")).Text,
                ((TextBox)FormViewFormulario.FindControl("txtContato2")).Text, ((TextBox)FormViewFormulario.FindControl("txtTelefone2")).Text, ((TextBox)FormViewFormulario.FindControl("txtEmail2")).Text,
                ((TextBox)FormViewFormulario.FindControl("txtContato3")).Text, ((TextBox)FormViewFormulario.FindControl("txtTelefone3")).Text, ((TextBox)FormViewFormulario.FindControl("txtEmail3")).Text);

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