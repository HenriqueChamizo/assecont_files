using System;

namespace AssecontNovo.Holerite
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("~/holerite/ProcurarHolerite.aspx?ind={0}", Convert.ToInt32(txtID.Text)));
        }

        protected void lkClientes_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Format("~/holerite/HoleriteClientes.aspx?ind={0}", Convert.ToInt32(txtID.Text)));
        }
    }
}