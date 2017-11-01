using System;
using System.Data;
using AssecontNovo.Classes;

namespace AssecontNovo.Curriculum
{
    public partial class ViewCurriculum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            BDAppAssecont bd = new BDAppAssecont();

            DataTable tableCurriculum = bd.getDataTable(string.Format("SELECT * FROM Curriculum WHERE CUR_IND = {0}", ind));

            foreach (DataRow dr in tableCurriculum.Rows)
            {
                Response.ClearContent();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", String.Format("filename={0}", dr["CUR_NOME"]));
                Response.BinaryWrite((byte[])dr["CUR_ARQUIVO"]);
            }

            bd.executeCommand("UPDATE Curriculum SET CUR_VISTO_EM = GETDATE() WHERE CUR_IND = " + ind);
        }
    }
}