using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

using System.Collections;
using System.Configuration;
using System.Data;
using System.IO;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioRevenda : System.Web.UI.Page
    {
        private int ind;
        private int rep;
        private int ano;
        //private int rev_ind;
        private bool etiqueta;
        private BDApp bd;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();

            ano = Convert.ToInt32(Request.QueryString["ano"]);
            ind = Convert.ToInt32(Request.QueryString["ind"]);
            rep = Convert.ToInt32(Request.QueryString["rep"]);

            //if (!Page.IsPostBack)
            //{
            //    RadGrid2.EditIndexes.Add(0);
            //}

            if (!IsPostBack)
            {
                new Permissoes(new BDApp()).getAcessoResponse("relatorios", Response);

                Utils.Cultura();

                bd.openConnection();
                foreach (RadMenuItem radItem in RadMenu1.Items)
                {
                    try
                    {
                        int valor = bd.getCountRevendaCadastradas(Convert.ToInt32(radItem.Value), ano);

                        if (valor > 0)
                            RadMenu1.Items.FindItemByValue(radItem.Value).Text += " - " + valor;
                        else
                            RadMenu1.Items.FindItemByValue(radItem.Value).Visible = false;
                    }
                    catch { }
                }
                //if (ind != 0)
                //{
                //    try
                //    {
                //        string query = "SELECT DISTINCT REV_IND " +
                //                       "FROM AssepontoRevendas " +
                //                       "INNER JOIN AssepontoRevendasReps ON REVREP_REVENDA = REV_IND " +
                //                       "WHERE (MONTH(REV_DATA_CADASTRO) = {0} AND " +
                //                       "YEAR(REV_DATA_CADASTRO) = {1}  AND " +
                //                       "REVREP_REP = {2}) OR " +
                //                       "(MONTH(REV_DATA_CADASTRO) = {0} AND " +
                //                       "YEAR(REV_DATA_CADASTRO) = {1}  AND " +
                //                       "{2} = 0)";
                //        rev_ind = Convert.ToInt32(bd.getFieldValueString(string.Format(query, ind, ano, rep)));
                //    }
                //    catch
                //    {
                //        rev_ind = 0;
                //    }
                //}
                bd.closeConnection();
            }

            if (comboboxRep.SelectedValue == string.Empty)
                comboboxRep.SelectedIndex = rep = 0;
            else
                rep = Convert.ToInt32(comboboxRep.SelectedValue);
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

            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioRevenda.aspx?ind={0}&ano={1}&rep={2}", ind, ano, rep));
        }

        protected void comboboxRep_DataBound(object sender, EventArgs e)
        {
            comboboxRep.Items.Insert(0, new RadComboBoxItem("Todos", "0"));

            if (!IsPostBack)
                comboboxRep.SelectedIndex = 0;
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = (DateTime.Now.Year).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioRevenda.aspx?ind={0}&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = (ano).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();
            }

            int aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT REV_RAZAOSOCIAL) AS NOME FROM AssepontoRevendas INNER JOIN AssepontoRevendasReps ON REVREP_REVENDA = REV_IND WHERE YEAR(REV_DATA_CADASTRO) = {0} ", ano));
            if (aux > 1)
                RadMenu1.FindItemByValue("ano").Text += " ( " + aux + " )";
        }

        protected void comboboxRep_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rep = Convert.ToInt32(e.Value);
            RadGridGoldPremium.DataBind();
            FormView1.DataBind();
        }

        #region Etiqueta - World
        protected void ImageWorld_Click(object sender, ImageClickEventArgs e)
        {
            List<string> CadInd = new List<string>();

            bd.openConnection();

            SqlCommand cmd = new SqlCommand(string.Format("SELECT REV_IND FROM AssepontoRevendas WHERE MONTH(REV_DATA_CADASTRO) = {0} AND YEAR(REV_DATA_CADASTRO) = {1}", ind, ano), bd.Conn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                CadInd.Add(dr["REV_IND"].ToString());
            }

            dr.Close();

            if (CadInd.Count != 0)
            {
                ExportarWorld(CadInd);
            }

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
                SqlCommand cmd = new SqlCommand(string.Format("SELECT * FROM AssepontoRevendas WHERE REV_IND = {0}", ListaInd[i]), bd.Conn);
                SqlDataReader dr = cmd.ExecuteReader();

                dr.Read();

                string razao = dr["REV_RAZAOSOCIAL"].ToString().Trim().ToUpper();
                int TamanhoRazao = Convert.ToInt32(razao.Length);

                string cidade = dr["REV_CIDADE"].ToString().Trim().ToUpper();
                int TamanhoCidade = Convert.ToInt32(cidade.Length);

                string contato = dr["REV_CONTATO"].ToString().Trim().ToUpper();
                int TamanhoContato = Convert.ToInt32(contato.Length);

                tabela += " <td width=252 style='width:212.1pt;padding:2px .75pt 0cm .75pt;height:72.0pt;font-size:8pt'>";

                tabela += "<p class=MsoNormal style='margin-top:0cm;margin-right:20pt;margin-bottom: 0cm;margin-left:0pt;margin-bottom:.0001pt;line-height:normal'><b><span style='font-size:8pt'>";

                tabela += TamanhoRazao > 26 ? razao.Substring(0, 26) : razao.Trim();

                tabela += "<br />" + dr["REV_LOGRADOURO"].ToString().Trim().ToUpper() + "," + dr["REV_NUMERO"].ToString().Trim().ToUpper() + " - " + dr["REV_BAIRRO"].ToString().Trim().ToUpper() + " - ";

                tabela += TamanhoCidade > 14 ? cidade.Substring(0, 14) : cidade;

                tabela += "<br />" + "   CEP: " + dr["REV_CEP"].ToString().Trim() + " - " +
                    dr["REV_UF"].ToString().Trim().ToUpper() + "<br/> A/C: ";

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

                //bd.executeCommand(string.Format("UPDATE AssepontoRevendas SET REV_ETIQUETA = 1 WHERE REV_IND = '{0}'", ListaInd[i]));
            }

            tabela += "</table>";

            tabela += "<p class=MsoNormal style='margin-top:0cm;margin-right:4.75pt;margin-bottom: 10.0pt;margin-left:4.75pt'><b style='mso-bidi-font-weight:normal'><span" +
                    "style='font-size:9.0pt;line-height:115%;display:none;mso-hide:all'><o:p>&nbsp;</o:p></span></b></p> </div></body></html>";

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Buffer = true;
            //Escolha se irá exportar para Word ou Excel
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=Etiquetas Revenda" + DateTime.Now.ToString("dd/MM/yyyy") + ".doc");
            HttpContext.Current.Response.ContentType = "application/vnd.doc";

            //Define o Encoding da página
            HttpContext.Current.Response.ContentEncoding = Encoding.Default;

            //Escreva a string
            HttpContext.Current.Response.Output.Write(tabela);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
        #endregion

        protected void SqlData_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@rep"].Value = rep;
        }

        protected void RadGridGoldPremium_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            //Pega item selecionado e "seta" em item
            var item = ((GridEditableItem)e.Item);
            //Separa a identificação do item em item_ind
            var item_ind = (int)item.GetDataKeyValue("REV_IND");

            //Extrai o valor de REV_ETIQUETA editado
            Hashtable values = new Hashtable();
            item.ExtractValues(values);
            etiqueta = (bool)values["REV_ETIQUETA"];

            //Confere se a identificação existe no banco
            string query = "SELECT DISTINCT REV_IND " +
                            "FROM AssepontoRevendas " +
                            "WHERE REV_IND = {0}";
            var ind_rev = bd.getFieldValueString(string.Format(query, item_ind));
            if (ind_rev != null)
            {
                //Edita o REV_ETIQUETA no banco
                try
                {
                    string update = "UPDATE AssepontoRevendas " +
                                    "SET REV_ETIQUETA = " + (etiqueta ? "1 " : "0 ") +
                                    "WHERE REV_IND = " + ind_rev.ToString();
                    bd.executeCommand(update);
                }
                catch { }
                RadGridGoldPremium.Rebind();
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}