using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.WebControls
{
    public partial class ManutencaoCancelamento : System.Web.UI.UserControl
    {
        #region Properties
        int _Cliente = 0;

        public int Cliente
        {
            get
            {
                return _Cliente;
            }
            set
            {
                _Cliente = value;
            }
        }
        #endregion 

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sqlAssepontoManutencao_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@MNT_CLIENTE"].Value = Cliente;
            e.Command.Parameters["@MNT_REALIZADO_POR"].Value = UserApp.UserId;
        }

        protected void sqlAssepontoManutencao_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                Response.Redirect(Request.RawUrl, false);
            }
        }
    }
}