using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Wr.Classes;

namespace Asseponto.WebControls
{
    public partial class SenhaControl : System.Web.UI.UserControl
    {
        #region Properties
        int _Cliente = 0;
        int _Suporte = 0;

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

        public int Suporte
        {
            get
            {
                return _Suporte;
            }
            set
            {
                _Suporte = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
           
   
        }

        protected void sqlAssepontoNSeries_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                Response.Redirect(String.Format("~/suporte/atendimento/senhas.aspx?cliente={0}", Cliente));
            }
        }

        protected void sqlAssepontoNSeries_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            e.Command.Parameters["@P_CLIENTE"].Value = Cliente;
            e.Command.Parameters["@P_SUPORTE"].Value = Suporte;
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