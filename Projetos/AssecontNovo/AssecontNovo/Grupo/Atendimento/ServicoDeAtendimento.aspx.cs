using System;
using System.Collections;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Telerik.Web.UI;
using Wr.Classes;

namespace AssecontNovo.Grupo.Atendimento
{
    public partial class ServicoDeAtendimento : System.Web.UI.Page
    {
        private ArrayList ListProdutos;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                PreencherRadComboxProduto();
        }

        void PreencherRadComboxProduto()
        {
            listaDeProdutos();
            for (int i = 0; i < ListProdutos.Count; i++)
                ((RadComboBox)FormViewSAC.FindControl("RadComboxProduto")).Items.Add(new RadComboBoxItem(ListProdutos[i].ToString(), i.ToString()));
        }

        void listaDeProdutos()
        {
            ListProdutos = new ArrayList();
            ListProdutos.Add("Serviços Contábeis");
            ListProdutos.Add("Fiscal e Trabalhista");
            ListProdutos.Add("Serviços de Auditoria");
            ListProdutos.Add("Serviços de Abertura e Encerramento de Empresas");
            ListProdutos.Add("Serviços de Administração");
            ListProdutos.Add("Assessoria Jurídica");
            ListProdutos.Add("Softwares");
        }

        protected void lkEnviar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    EncaminharEmailAtendimento();
                }
                catch(Exception ex)
                {
                    Response.Write(ex.Message);
                    Response.Flush(); 
                }

                Response.Redirect("~/Avisos/ConfirmacaoEnvioAssecont.aspx");
            }
        }

        void EncaminharEmailAtendimento()
        {
            string produto = ((RadComboBox)FormViewSAC.FindControl("RadComboxProduto")).Text.ToString();
            string cliente = ((RadioButtonList)FormViewSAC.FindControl("RadioButtonCliente")).SelectedItem.ToString();
            string mensagem = ((RadioButtonList)FormViewSAC.FindControl("RadioButtonMensagem")).SelectedItem.ToString();
            string assunto = ((TextBox)FormViewSAC.FindControl("txtAssunto")).Text;

            EmailSac EmailSac = new EmailSac("notificacao@assecont.com.br", null, Server.MapPath("") + "/../../Classes/Emails/Sac/EmailSac.htm");
            EmailSac.Send(mensagem, cliente, produto, assunto);
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