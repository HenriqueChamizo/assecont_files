using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.Curriculum
{
    public partial class TodosCurriculum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //BDApp bd = new BDAppAssecont();
            //bd.openConnection();

            //SqlCommand cmd = bd.Conn.CreateCommand();
            //cmd.CommandText = "SELECT CUR_ARQUIVO FROM Curriculum WHERE CUR_IND = 2";
            //byte[] binaryData = (byte[])cmd.ExecuteScalar();
            //File.WriteAllBytes("algo.pdf", binaryData);
            //string s = Encoding.UTF8.GetString(binaryData);

            //FileStream aFile = new FileStream(Request.ServerVariables["APPL_PHYSICAL_PATH"].ToString() + "\\ImagensTemp\\" + "Documento" + doc.TipoArquivo, FileMode.Create);

            //try
            //{
            //    aFile.Seek(0, SeekOrigin.Begin);
            //    aFile.Write(doc.ConteudoArquivo, 0, doc.ConteudoArquivo.Length);
            //}
            //catch (Exception ex)
            //{
            //    litMensagem.Text = "<b>Não foi possível converter o documento.</b><br> Erro: " + ex.Message;
            //    modalMensagens.Show();
            //}
            //finally
            //{
            //    aFile.Close();
            //}
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            SqlData.ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void chkTest_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkTest = sender as CheckBox;
            GridDataItem item = (GridDataItem)chkTest.NamingContainer;
            string id = item.GetDataKeyValue("CUR_IND").ToString();
            (new BDAppAssecont()).executeCommand(string.Format("UPDATE Curriculum SET CUR_ATIVO = {0} WHERE CUR_IND = {1}", chkTest.Checked ? 1 : 0, id));
            Response.RedirectPermanent("~/Curriculum/TodosCurriculum.aspx");
        }       
    }
}