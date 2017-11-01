using System;
using Asseponto.Classes;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Asseponto.WebControls
{
    public partial class ManutencaoStatus : System.Web.UI.UserControl
    {
        private int _Cliente = 0;

        #region Properties
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

        public int getDiasCorridos()
        {
            string lbDias = ((Label)FormView1.FindControl("lbDiasCorridos")).Text;

            if (string.IsNullOrEmpty(lbDias))
                return -1;
            else
                return Convert.ToInt32(lbDias);
        }

        public int getManuntecaoAtiva(){
            return Convert.ToInt32(((HiddenField)FormView1.FindControl("lbManuntencao")).Value);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void sqlManutencao_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            if (Cliente > 0)
                e.Command.Parameters["@CLIENTE"].Value = Cliente;
        }

        protected void sqlManutencaoAssefin_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            if (Cliente > 0)
            {
                BDApp bd = new BDApp();
                e.Command.Parameters["@CNPJ"].Value = bd.getClienteOrRevendaCnpjCpf(Cliente);
            }
        }

        protected void ckbSendFor_CheckedChanged(object sender, EventArgs e)
        {
            BDApp bdapp = new BDApp();
            
        }

        //protected void sqlManutencaoAssefin_Selected(object sender, SqlDataSourceStatusEventArgs e)
        //{
        //    if (Cliente > 0)
        //    {
        //        BDApp bd = new BDApp();
        //        e.Command.Parameters["@CNPJ"].Value = bd.getClienteCnpjCpf(Cliente);
        //    }
        //}
    }
}