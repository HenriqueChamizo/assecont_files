using System;
using System.Web.UI.WebControls;
using Wr.Classes;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Revenda.Cadastro
{
    public partial class CadasatroRep : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            //Verificando se não tiver em modo leitura, validar os campos obrigatorios.
            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                BDApp bd = new BDApp();
                int ind = Convert.ToInt32(Request.QueryString["ind"]);

                int id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
                bd.executeCommand(String.Format("DELETE FROM AssepontoRevendasReps WHERE REVREP_IND = {0}", id));

                Response.Redirect(String.Format("~/revenda/Cadastro/CadasatroRep.aspx?ind={0}", ind));
            }
        }

        protected void lbAdd_Click1(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();

            RadComboBox RadComboBox1 = (RadComboBox)FormView1.FindControl("RadComboBox1");
            string rep = RadComboBox1.SelectedValue;

            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            bd.executeCommand(String.Format("INSERT INTO AssepontoRevendasReps (REVREP_REVENDA, REVREP_REP) VALUES ({0}, {1})", ind, rep));

            Response.Redirect(String.Format("~/revenda/Cadastro/CadasatroRep.aspx?ind={0}", ind));
        }

        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            BDApp bd = new BDApp();

            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            if (ind != 0)
            {
                int id = bd.getFieldValueInteger(String.Format("SELECT COUNT (*) FROM AssepontoRevendasReps Where REVREP_REVENDA = {0}", ind));
                if (id == 1)
                {
                    args.IsValid = false;
                }
            }
            else
                args.IsValid = true;
        }

        protected void RadMenu2_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
        {
            UserApp user = new UserApp();
            int ind = user.Revenda;

            switch (e.Item.Text)
            {
                case "Dados da Empresa":
                    Response.Redirect(string.Format("~/revenda/Cadastro/CadastroDados.aspx?ind={0}", ind));
                    break;

                case "Dados do REP":
                    Response.Redirect(string.Format("~/revenda/Cadastro/CadasatroRep.aspx?ind={0}", ind));
                    break;
            }
        }
    }
}