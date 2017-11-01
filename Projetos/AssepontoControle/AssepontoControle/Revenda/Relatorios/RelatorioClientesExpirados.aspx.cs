using Asseponto.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Asseponto.Revenda.Relatorios
{
    public partial class RelatorioClientesExpirados : System.Web.UI.Page
    {
        private BDApp bd;
        private int ano;
        private int ind;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();

            ano = Convert.ToInt32(Request.QueryString["ano"]);
            ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (!IsPostBack)
            {
                bd.openConnection();
                foreach (RadMenuItem radItem in RadMenu1.Items)
                {
                    try
                    {
                        int valor = bd.getCountEmpresasExpiradasByRevenda(Convert.ToInt32(Session["Revenda"]), Convert.ToInt32(radItem.Value), ano);
                        //RadMenu1.Items.FindItemByValue(radItem.Value).Text += " - " + valor;
                        if (valor > 0)
                            RadMenu1.Items.FindItemByValue(radItem.Value).Text += " - " + valor;
                        else
                            RadMenu1.Items.FindItemByValue(radItem.Value).Visible = false;
                    }
                    catch { }
                }
                //RadMenu1.DataBind();
                bd.closeConnection();
            }
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
                {
                    ind = Convert.ToInt32(e.Item.Value);
                }
            }

            Response.Redirect(string.Format("~/revenda/Relatorios/RelatorioClientesExpirados.aspx?ind={0}&ano={1}", ind, ano));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            if (ind == 0)
            {
                //RadMenu1.FindItemByValue("ano").Text = (DateTime.Now.Year + 1).ToString();
                //RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                bd = new BDApp();
                DateTime data = bd.getFieldValueDateTime(string.Format(@"SELECT top 1 NSE_DATA FROM AssepontoClientes
                                                            CROSS APPLY( SELECT TOP 1 * FROM AssepontoNSeries 
			                                                WHERE NSE_CLIENTE = CAD_IND AND NSE_SOLICITACAO = 1 ORDER BY NSE_DATA ) a
                                                            INNER JOIN AssepontoRevendas on REV_IND = CAD_REVENDA 
                                                            --LEFT JOIN AssepontoManutencao on CAD_IND = MNT_CLIENTE and MNT_CANCELADO = 1
                                                            WHERE REV_IND = {0} and DATEDIFF(DAY, NSE_DATA, GETDATE()) > 60 
                                                            order by NSE_DATA desc", Convert.ToInt32(Session["Revenda"])));
                Response.Redirect(string.Format("~/revenda/Relatorios/RelatorioClientesExpirados.aspx?ind={0}&ano={1}", data.Month, data.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = (ano + 1).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();
            }
        }
    }
}