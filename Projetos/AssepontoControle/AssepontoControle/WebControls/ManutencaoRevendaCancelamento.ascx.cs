using System;
using System.Data;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.WebControls
{
    public partial class ManutencaoRevendaCancelamento : System.Web.UI.UserControl
    {
        #region Properties
        int _Revenda = 0;

        public int Revenda
        {
            get
            {
                return _Revenda;
            }
            set
            {
                _Revenda = value;
            }
        }
        #endregion

        private string Motivo;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Cancelar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                BDApp bd = new BDApp();
                UserApp user = new UserApp();

                Motivo = txtMotivo.Text;

                string sql = "INSERT INTO AssepontoManutencao (MNT_CLIENTE, MNT_DATA, MNT_MOTIVO_CANCELAMENTO, MNT_CANCELADO, MNT_REALIZADO_POR, MNT_REVENDA) " +
                    "VALUES ({0}, GETDATE(), '{1}', 1, {2}, {3})";

                try
                {
                    foreach (GridDataItem item in RadGrid1.Items)
                    {
                        CheckBox chkSelecionar = (CheckBox)item["selecionar"].FindControl("CheckRealizado");
                        int cliente = Convert.ToInt32(item.GetDataKeyValue("CAD_IND").ToString());

                        if (chkSelecionar.Checked)
                        {
                            bd.executeCommand(string.Format(sql, cliente, Motivo, UserApp.UserId, Revenda));
                        }
                    }
                    Response.Redirect(string.Format("~/Suporte/Revendas/Manuntecao.aspx?revenda={0}", Revenda));
                }
                catch { }
            }
        }
    }
}