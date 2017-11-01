using System;
using System.Data;
using AssecontNovo.Classes;

namespace AssecontNovo.Curriculum
{
    public partial class View: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            BDAppAssecont bd = new BDAppAssecont();

            DataTable table = bd.getDataTable(string.Format("SELECT * FROM LegalizacaoArquivos WHERE LEGARQ_IND = {0}", ind));

            foreach (DataRow dr in table.Rows)
            {
                Response.ClearContent();
                Response.ContentType = Util.getContentType(dr["LEGARQ_EXTENSAO"].ToString());
                Response.AddHeader("Content-Disposition", String.Format("filename={0}", dr["LEGARQ_NOME"]));
                Response.BinaryWrite((byte[])dr["LEGARQ_ARQUIVO"]);
            }

            bd.executeCommand("UPDATE LegalizacaoArquivos SET LEGARQ_VISUALIZADO_EM = GETDATE() WHERE LEGARQ_IND = " + ind);
        }
    }
}