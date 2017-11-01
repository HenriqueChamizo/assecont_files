using System;
using System.Web.UI.WebControls;
using Wr.Classes;
using Telerik.Web.UI;
using Asseponto.Classes;

namespace Asseponto.Revenda.Cadastro
{
    public partial class CadastroDados : System.Web.UI.Page
    {
        UserApp user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = new UserApp();

           if (Convert.ToInt32(Request.QueryString["ind"]) > 0)
           {
              FormView1.ChangeMode(FormViewMode.Edit);
           }
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            //Verificando se não tiver em modo leitura, validar os campos obrigatorios.
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        protected void sqlRevendasProvisorios_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            Response.Redirect(string.Format("~/revenda/Cadastro/CadastroDados.aspx?ind={0}", user.Revenda));
        }

        protected void RadMenu2_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
        {
            //UserApp user = new UserApp();
            //int ind = user.Revenda;

            switch (e.Item.Text)
            {
                case "Dados da Empresa":
                    Response.Redirect(string.Format("~/revenda/Cadastro/CadastroDados.aspx?ind={0}", user.Revenda));
                    break;

                case "Dados do REP":
                    Response.Redirect(string.Format("~/revenda/Cadastro/CadasatroRep.aspx?ind={0}", user.Revenda));
                    break;
            }
        }
    }
}