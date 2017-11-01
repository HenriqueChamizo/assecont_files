using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.Informativos
{
    public partial class listarInformativos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        } 

        //protected void chkAtivo_CheckedChanged(object sender, EventArgs e)
        //{
        //    CheckBox chkAtivo= sender as CheckBox;
        //    GridDataItem item = (GridDataItem)chkAtivo.NamingContainer;

        //    int ind = Convert.ToInt32(item.GetDataKeyValue("INF_IND").ToString());

        //    BDAppAssecont bd = new BDAppAssecont();
        //    bd.executeCommand(string.Format("UPDATE Informativos SET INF_ATIVO = {0} WHERE INF_IND = {1}", chkAtivo.Checked ? 1 : 0, ind));
        //}
    }
}