using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Collections.Generic;
using ExcelLibrary.SpreadSheet;
using System.IO;
using System.Web;
using System.Text;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioAtestados : System.Web.UI.Page
    {
        BDApp bd;
        private int ano = 0;
        private int ind = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();

            if (!IsPostBack)
                (new Permissoes(bd)).getAcessoResponse("relatorios", Response);

            Utils.Cultura();
            ind = Convert.ToInt32(Request.QueryString["ind"]);
            ano = Convert.ToInt32(Request.QueryString["ano"]);

            #region Preencher Menu
            bd.openConnection();
            foreach (RadMenuItem radItem in RadMenu1.Items)
            {
                try
                {
                    int valor = bd.getCountCertificadoNaoEnviado(Convert.ToInt32(radItem.Value), ano);

                    if (valor == 0)
                    {
                        valor = bd.getCountCertificadoEnviado(Convert.ToInt32(radItem.Value), ano);

                        if (valor == 0)
                            RadMenu1.Items.FindItemByValue(radItem.Value).Visible = false;
                        else
                        {
                            RadMenu1.Items.FindItemByValue(radItem.Value).ImageUrl = "http://www.asseponto.com.br/assepontocontrole/Images/16x16/TickVerde.png";
                            RadMenu1.Items.FindItemByValue(radItem.Value).Text += " - " + valor;
                        }
                    }
                    else
                    {
                        RadMenu1.Items.FindItemByValue(radItem.Value).ImageUrl = "http://www.asseponto.com.br/assepontocontrole/Images/16x16/close.png";
                        RadMenu1.Items.FindItemByValue(radItem.Value).Text += " (" + valor + ")";
                    }
                }
                catch { }
            }
            bd.closeConnection();
            #endregion
        }

        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
            if (e.Item.Value == "ano")
                ano = ano + 1;
            else
            {
                if (e.Item.Value == "anoAnterior")
                    ano = ano - 1;
                else
                    ind = Convert.ToInt32(e.Item.Value);
            }

            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioAtestados.aspx?ind={0}&ano={1}", ind, ano));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = (DateTime.Now.Year + 1).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioAtestados.aspx?ind={0}&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = (ano + 1).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();
            }
        }

        protected void RadGrid1_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioAtestados.aspx?ind={0}&ano={1}", ind, ano));
        }

        protected void chkTest_CheckedChanged(object sender, EventArgs e)
        {  
            CheckBox chkTest = sender as CheckBox;
            GridDataItem item = (GridDataItem)chkTest.NamingContainer;
            string id = item.GetDataKeyValue("CAD_IND").ToString();
            BDApp bd = new BDApp();
            bd.executeCommand(string.Format("UPDATE AssepontoClientes SET CAD_IMPRESSAO_CERTIFICADO = {0} WHERE CAD_IND = {1}", chkTest.Checked ? 1 : 0, id));
        }

        #region Assefin - Excel
        protected void ImageButton_Click(object sender, ImageClickEventArgs e)
        {
            List<string> CadInd = new List<string>();

            bd.openConnection();

            SqlCommand cmd = new SqlCommand(string.Format("SELECT CAD_IND FROM AssepontoClientes INNER JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE MONTH(IM_INICIO) = {0} AND YEAR(IM_INICIO) = {1} AND IM_ASSEPONTO4 = 1", ind, ano), bd.Conn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
                CadInd.Add(dr["CAD_IND"].ToString());

            dr.Close();

            if (CadInd.Count != 0)
                ExportarExcel(bd, CadInd);
        }

        protected void ExportarExcel(BDApp bd, List<string> ListaInd)
        {
            int i = 0;

            try
            {
                Workbook workbook = new Workbook();
                Worksheet worksheet = new Worksheet("First Sheet");

                //worksheet.Cells.ColumnWidth = 20;
                worksheet.Cells[i, 0] = new Cell("Razão Social");
                worksheet.Cells[i, 1] = new Cell("CNPJ");
                worksheet.Cells[i, 2] = new Cell("CPF");
                worksheet.Cells[i, 3] = new Cell("IE");
                worksheet.Cells[i, 4] = new Cell("Endereço");
                worksheet.Cells[i, 5] = new Cell("Número");
                worksheet.Cells[i, 6] = new Cell("Complemento");
                worksheet.Cells[i, 7] = new Cell("Cidade");
                worksheet.Cells[i, 8] = new Cell("Bairro");
                worksheet.Cells[i, 9] = new Cell("UF");
                worksheet.Cells[i, 10] = new Cell("CEP");
                worksheet.Cells[i, 11] = new Cell("DDD");
                worksheet.Cells[i, 12] = new Cell("Telefone");
                worksheet.Cells[i, 13] = new Cell("Contato");
                worksheet.Cells[i, 14] = new Cell("E-mail");
                worksheet.Cells[i, 15] = new Cell("E-mail2");

                foreach (string indice in ListaInd)
                {
                    i++;
                    SqlCommand cmd = new SqlCommand(string.Format("SELECT * FROM AssepontoClientes WHERE CAD_IND = {0}", indice), bd.Conn);
                    SqlDataReader dr = cmd.ExecuteReader();

                    dr.Read();
                    worksheet.Cells[i, 0] = new Cell(dr["CAD_RAZAOSOCIAL"].ToString());
                    worksheet.Cells[i, 1] = new Cell(dr["CAD_CNPJ"].ToString());
                    worksheet.Cells[i, 2] = new Cell(dr["CAD_CPF"].ToString());
                    worksheet.Cells[i, 3] = new Cell(dr["CAD_IE"].ToString());
                    worksheet.Cells[i, 4] = new Cell(dr["CAD_ENDERECO"].ToString());
                    worksheet.Cells[i, 5] = new Cell(dr["CAD_ENDERECO_NUMERO"].ToString());
                    worksheet.Cells[i, 6] = new Cell(dr["CAD_ENDERECO_COMPLEMENTO"].ToString());
                    worksheet.Cells[i, 7] = new Cell(dr["CAD_CIDADE"].ToString());
                    worksheet.Cells[i, 8] = new Cell(dr["CAD_BAIRRO"].ToString());
                    worksheet.Cells[i, 9] = new Cell(dr["CAD_UF"].ToString());
                    worksheet.Cells[i, 10] = new Cell(dr["CAD_CEP"].ToString());
                    worksheet.Cells[i, 11] = new Cell(dr["CAD_TELEFONE1_DDD"].ToString());
                    worksheet.Cells[i, 12] = new Cell(dr["CAD_TELEFONE1"].ToString());
                    worksheet.Cells[i, 13] = new Cell(dr["CAD_CONTATO"].ToString());
                    worksheet.Cells[i, 14] = new Cell(dr["CAD_EMAIL"].ToString());
                    worksheet.Cells[i, 15] = new Cell(dr["CAD_EMAIL2"].ToString());
                    dr.Close();
                }

                while (i < 5)
                {
                    i++;
                    worksheet.Cells[i, 0] = new Cell(" ");
                }

                workbook.Worksheets.Add(worksheet);

                MemoryStream stream = new MemoryStream();
                workbook.Save(stream);

                Response.Clear();
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("content-disposition", "C:\\Asefin_clientes.xls");

                stream.WriteTo(Response.OutputStream);

                Response.End();
            }
            finally
            {
                bd.closeConnection();
            }
        }
        #endregion

        #region Etiqueta - World
        protected void ImageWorld_Click(object sender, ImageClickEventArgs e)
        {
            List<string> CadInd = new List<string>();

            bd.openConnection();

            SqlCommand cmd = new SqlCommand(string.Format("SELECT CAD_IND FROM AssepontoClientes LEFT JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE MONTH(IM_INICIO) = {0} AND YEAR(IM_INICIO) = {1} AND IM_ASSEPONTO4 = 1", ind, ano), bd.Conn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
                CadInd.Add(dr["CAD_IND"].ToString());

            dr.Close();

            if (CadInd.Count != 0)
                ExportarWorld(CadInd);

            bd.closeConnection();
        }

        void ExportarWorld(List<string> ListaInd)
        {
            string tabela = String.Empty;
            int contador = 0;

            tabela += "<html><head><meta http-equiv=Content-Type content='text/html; charset=windows-1252'> <meta name=Generator content=1Microsoft Word 14 (filtered)1> " +
            "<style> @font-face	{font-family:Calibri; panose-1:2 15 5 2 2 2 4 3 2 4;} @font-face {font-family:'Calibri'; panose-1:2 11 5 2 4 2 4 2 2 3;} @font-face " +
            "{font-family:'Calibri'; panose-1:2 11 5 2 4 2 4 2 2 3;} p.MsoNormal, li.MsoNormal, div.MsoNormal {margin-top:0cm; margin-right:0cm; margin-bottom:10.0pt; " +
            "margin-left:0cm; line-height:115%; font-size:9.0pt; font-family:'Calibri';} span.sitecorpotitulodescricao1 {mso-style-name:sitecorpotitulodescricao1; " +
            "font-family:'Calibri'; color:gray;} .MsoChpDefault  {font-family:'Calibri';} .MsoPapDefault {margin-bottom:10.0pt; line-height:115%;} " +
            "@page WordSection1 {size:612.1pt 756.0pt; margin:36.0pt 13.6pt 0cm 13.6pt;} div.WordSection1 </style> </head> <body lang=PT-BR>";

            tabela += "<div class=WordSection1>";

            tabela += "<table class=MsoTableGrid border=0 cellspacing=0 cellpadding=0 style='border-collapse:collapse;border:none;mso-padding-top-alt:0cm; mso-padding-bottom-alt:0cm;mso-border-insideh:none;mso-border-insidev:none'> ";

            tabela += "<tr style='page-break-inside:avoid;height:72.0pt'>";

            for (int i = 0; i < ListaInd.Count; i++)
            {
                SqlCommand cmd = new SqlCommand(string.Format("SELECT * FROM AssepontoClientes WHERE CAD_IND = {0}", ListaInd[i]), bd.Conn);
                SqlDataReader dr = cmd.ExecuteReader();

                dr.Read();

                string razao = dr["CAD_RAZAOSOCIAL"].ToString().Trim().ToUpper();
                int TamanhoRazao = Convert.ToInt32(razao.Length);

                string cidade = dr["CAD_CIDADE"].ToString().Trim().ToUpper();
                int TamanhoCidade = Convert.ToInt32(cidade.Length);

                string contato = dr["CAD_CONTATO"].ToString().Trim().ToUpper();
                int TamanhoContato = Convert.ToInt32(contato.Length);

                tabela += " <td width=252 style='width:212.1pt;padding:2px .75pt 0cm .75pt;height:72.0pt;font-size:8pt'>";

                tabela += "<p class=MsoNormal style='margin-top:0cm;margin-right:20pt;margin-bottom: 0cm;margin-left:0pt;margin-bottom:.0001pt;line-height:normal'><b><span style='font-size:8pt'>";

                tabela += TamanhoRazao > 26 ? razao.Substring(0, 26) : razao.Trim();

                tabela += "<br />" + dr["CAD_ENDERECO"].ToString().Trim().ToUpper() + ", " + dr["CAD_ENDERECO_NUMERO"].ToString().Trim() + " - " + dr["CAD_BAIRRO"].ToString().Trim().ToUpper() + " - ";

                tabela += TamanhoCidade > 14 ? cidade.Substring(0, 14) : cidade;

                tabela += "<br />" + "   CEP: " + dr["CAD_CEP"].ToString().Trim() + " - " +
                    dr["CAD_UF"].ToString().Trim().ToUpper() + "<br/> A/C: ";

                tabela += TamanhoContato > 20 ? contato.Substring(0, 20) : contato;

                tabela += "</span></b></p></td>";

                dr.Close();

                contador++;

                if (contador < 3)
                {
                    tabela += "<td width=12 style='width:8.8pt;padding:0cm .75pt 0cm .75pt;height:72.0pt'> <p class=MsoNormal style='margin-top:0cm;margin-right:5pt;margin-bottom: 0cm; " +
                            "margin-left:38pt;margin-bottom:.0001pt;line-height:normal'><b><span style='font-size:9.0pt'>&nbsp;</span></b></p></td>";
                }

                if (contador >= 3)
                {
                    contador = 0;
                    tabela += "</tr>";
                    tabela += "<tr style='page-break-inside:avoid;height:72.0pt'>";
                }
            }

            tabela += "</table>";

            tabela += "<p class=MsoNormal style='margin-top:0cm;margin-right:4.75pt;margin-bottom: 10.0pt;margin-left:4.75pt'><b style='mso-bidi-font-weight:normal'><span" +
                    "style='font-size:9.0pt;line-height:115%;display:none;mso-hide:all'><o:p>&nbsp;</o:p></span></b></p> </div></body></html>";

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Buffer = true;
            //Escolha se irá exportar para Word ou Excel
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=Etiquetas" + DateTime.Now.ToString("dd/MM/yyyy") + ".doc");
            HttpContext.Current.Response.ContentType = "application/vnd.doc";

            //Define o Encoding da página
            HttpContext.Current.Response.ContentEncoding = Encoding.Default;

            //Escreva a string
            HttpContext.Current.Response.Output.Write(tabela);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
        #endregion

        protected void radioVersao_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioButton radio = sender as RadioButton;
            string value = Request.QueryString["versao"];
            string val = "0";
            if (radio.Text == "Todos")
                val = "0";
            else if (radio.Text == "AssepontoWeb")
                val = "8";
            else if (radio.Text == "Asseponto4")
                val = "2";
            else
                val = "0";
            if (value != null)
            {
                string url = Request.Url.ToString().Replace("&versao=" + value, "");

                url = url + "&versao=" + val;
                Response.Redirect(url);
            }
            else
                Response.Redirect(Request.Url + "&versao=" + val);
        }

        protected void radioVersao_Load(object sender, EventArgs e)
        {
            RadioButton radio = sender as RadioButton;
            string value = Request.QueryString["versao"];
            if (value == null)
            {
                if (radio.Text == "Todos")
                    radio.Checked = true;
            }
            else
            {
                if (value == "0" && radio.Text == "Todos")
                    radio.Checked = true;
                else if (value == "8" && radio.Text == "AssepontoWeb")
                    radio.Checked = true;
                else if (value != "0" && value != "8" && radio.Text == "Asseponto4")
                    radio.Checked = true;
                else
                    radio.Checked = false;
            }
        }
    }
}