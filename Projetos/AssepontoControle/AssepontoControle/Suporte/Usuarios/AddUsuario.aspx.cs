using System;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Suporte.Usuarios
{
    public partial class AddUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sqlUsuario_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            Response.RedirectPermanent("~/suporte/usuarios/default.aspx?aux=1&ativo=1");
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            //if (FormView1.CurrentMode == FormViewMode.Insert)
            // {
            FormUtils formutils = new FormUtils();
            formutils.InitializePageControls();
            // }
        }
    }
}