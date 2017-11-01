using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Util
{
    public partial class DescadastrarEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int indice = Convert.ToInt32(Request.QueryString["ind"]);

                descadastrar(indice);
            }
            catch
            {
                Response.Redirect("http://www.assecont.com.br/avisos/ErroTela.aspx");
            }
        }

        void descadastrar(int indice)
        {
            (new BDApp()).executeCommand(string.Format("UPDATE AssepontoClientes SET CAD_EMAIL_ENVIAR = 0, CAD_EMAIL2_ENVIAR = 0, CAD_EMAIL3_ENVIAR = 0 WHERE CAD_IND = {0}", indice));
        }
    }
}