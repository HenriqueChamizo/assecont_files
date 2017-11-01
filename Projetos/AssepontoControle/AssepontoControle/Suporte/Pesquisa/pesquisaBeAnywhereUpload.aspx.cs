using System;
using System.Data;
using System.IO;
using Asseponto.Classes;

namespace Asseponto.Suporte.Pesquisa
{
    public partial class pesquisaBeAnywhereUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ltUltimoEnvio.Text = "Ultimo dia enviado " + (new BDApp()).getUltimoEnvioBAA().ToString("dd/MM/yyyy");

            if (Convert.ToBoolean(Request.QueryString["importado"]))
                ltError.Text = "Arquivo importado com <b>sucesso!</b>";
        }

        protected void btnImportarPlanilha_Click(object sender, EventArgs e)
        {
            try
            {
                if (fupArquivo.HasFile)
                {
                    string Excela = AppDomain.CurrentDomain.BaseDirectory + fupArquivo.FileName;
                    string Extension = Path.GetExtension(Excela);
                    fupArquivo.SaveAs(Excela);
                    // Recebe o arquivo em array de bytes
                    byte[] buffer = fupArquivo.FileBytes;
                    // Criar o arquivo em memoria
                    System.IO.MemoryStream stream = new System.IO.MemoryStream(buffer);
                    // Carrega o WorkBook do Excel
                    ExcelLibrary.SpreadSheet.Workbook workbook = ExcelLibrary.SpreadSheet.Workbook.Load(stream);
                    // Recupera o primeiro WorkSheet
                    ExcelLibrary.SpreadSheet.Worksheet worksheet = workbook.Worksheets[0];

                    // Cria uma tabela para armazenar o Excel
                    System.Data.DataTable dtExcel = new System.Data.DataTable();
                    ExcelLibrary.SpreadSheet.Row newColumn = worksheet.Cells.GetRow(0);
                    dtExcel = ExcelLibrary.DataSetHelper.CreateDataTable(Excela, worksheet.Name);

                    import(dtExcel);
                    Response.Redirect(Request.RawUrl + "?importado=true");
                }
            }
            catch (Exception ex)
            {
                ltError.Text = ex.Message;
            }

            #region Codigo Antigo (Comentado)
            //try
            //{
            //    if (fupArquivo.HasFile)
            //    {
            //        string Excela = AppDomain.CurrentDomain.BaseDirectory + fupArquivo.FileName;
            //        string Extension = Path.GetExtension(Excela);
            //        fupArquivo.SaveAs(Excela);

            //        DataTable dt = (new Excel(Excela, Extension, "Yes")).getDataTable();
            //        //dt.Columns.Add("Enviado");
            //        //GridView1.DataSource = dt;
            //        //GridView1.DataBind();

            //        import(dt);
            //        Response.Redirect(Request.RawUrl + "?importado=true");
            //    }
            //}
            //catch (Exception ex)
            //{
            //    ltError.Text = ex.Message;
            //}
            #endregion
        }

        public void import(DataTable dt)
        {
            BDApp bd = new BDApp();
            string allll = string.Empty;

            // string sql = "SELECT BAA_ID_SESSION, BAA_NAME, BAA_CUSTOMER, BAA_TECNICO, BAA_DATAINICIO_SESSION, " +
            //"BAA_DATAFINAL_SESSION , BAA_OBS_PEDIDO FROM BeAnywhereAtendimento WHERE ";

            foreach (DataRow a in dt.Rows)
            {
                try
                {
                    string execute = "EXEC ba_atendimento_import @ID_SESSION = '{0}', @NAME = '{1}', @CUSTOMER = '{2}', " +
                      "@TECNICO = '{3}', @DATAINICIO_SESSION = '{4}', @DATAFINAL_SESSION = '{5}', @OBS_PEDIDO = '{6}' ";
                    DateTime inicio = Convert.ToDateTime(a[0]);
                    int intDuration = Convert.ToInt32(a[8]);
                    DateTime fim = inicio.AddSeconds(intDuration);// + ((intDuration / 1440) / 60);

                    bd.executeCommand(string.Format(execute, Convert.ToInt32(a[1]), a[5], a[2], a[3], inicio, fim, a[14]));
                }
                catch (Exception e)
                {
                    allll = e.Message;
                }
            }
        }
    }
}