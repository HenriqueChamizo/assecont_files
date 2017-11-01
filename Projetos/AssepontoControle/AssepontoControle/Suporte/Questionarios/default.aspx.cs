using System;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Questionarios
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            new Permissoes(new BDApp()).getAcessoResponse("questionarios", Response);
        }
    }
}