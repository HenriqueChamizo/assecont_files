using System;
using Asseponto.Classes;

namespace Asseponto.Suporte.Relatorios
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            UserApp user = new UserApp();

            VerificarAcesso Acesso = new VerificarAcesso(bd, user);

            if (Acesso.getAcesso("relatorios"))
                Response.RedirectPermanent("~/suporte/default.aspx");
        }
    }
}