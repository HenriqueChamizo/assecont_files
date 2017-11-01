using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes.Emails.Cotacao;
using Wr.Classes;

namespace AssecontNovo.Contabilidade.Cotacao
{
    public partial class form : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void lkEnviar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    EncaminharEmailAtendimento();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                    Response.Flush();
                }

                Response.Redirect("~/Avisos/ConfirmacaoEnvioAssecont.aspx");
            }
        }

        void EncaminharEmailAtendimento()
        {
            string Nome = ((TextBox)FormViewSAC.FindControl("txtNome")).Text;
            string Email = ((TextBox)FormViewSAC.FindControl("txtEmail")).Text;
            string Telefone = ((TextBox)FormViewSAC.FindControl("txtTelefone")).Text;
            string Celular = ((TextBox)FormViewSAC.FindControl("txtCelular")).Text;
            string Constituida = ((RadioButtonList)FormViewSAC.FindControl("rbConstituida")).SelectedItem.ToString();
            string RamoAtividade = ((RadioButtonList)FormViewSAC.FindControl("rbRamoAtividade")).SelectedItem.ToString();
            string RamoExploracao = ((TextBox)FormViewSAC.FindControl("txtRamoExploracao")).Text;
            string Localizacao = ((TextBox)FormViewSAC.FindControl("txtLocalizacao")).Text;
            string Regime = ((RadioButtonList)FormViewSAC.FindControl("rbRegime")).SelectedItem.ToString();
            string NfEntrada= ((TextBox)FormViewSAC.FindControl("txtNfEntrada")).Text;
            string NfSaida = ((TextBox)FormViewSAC.FindControl("txtNfSaida")).Text;
            string FuncRegistrados = ((TextBox)FormViewSAC.FindControl("txtFuncRegistrados")).Text;
            string ProLabore = ((TextBox)FormViewSAC.FindControl("txtProLabore")).Text;
            string ChegouNos = ((RadioButtonList)FormViewSAC.FindControl("rbChegou")).SelectedItem.ToString();
            string indicacao = ((TextBox)FormViewSAC.FindControl("txtIndicacao")).Text;

            EmailCotacao emailCotacao = new EmailCotacao("notificacao@assecont.com.br", null, Server.MapPath("") + "/../../Classes/Emails/Cotacao/EmailCotacao.htm");
            emailCotacao.CorpoEmailReplace(Nome, Email, Telefone, Celular, Constituida, RamoAtividade, RamoExploracao, Localizacao, Regime, NfEntrada, NfSaida,
                                           FuncRegistrados, ProLabore, ChegouNos, indicacao);

            emailCotacao.Send();
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