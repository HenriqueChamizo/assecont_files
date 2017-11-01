using System;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioImplantacoesFinalizadasCompleta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Utils.Cultura();

            new Permissoes(new BDApp()).getAcessoResponse("relatorio_implantacao", Response);
        }

        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (e.Item.Value == "ano")
            {
                ano = ano + 1;

            }
            if (e.Item.Value == "anoAnterior")
            {
                ano = ano - 1;
            }

            #region Meses
            if (e.Item.Text == "Janeiro")
            {
                ind = 1;
            }
            if (e.Item.Text == "Fevereiro")
            {
                ind = 2;
            }
            if (e.Item.Text == "Março")
            {
                ind = 3;
            }
            if (e.Item.Text == "Abril")
            {
                ind = 4;
            }
            if (e.Item.Text == "Maio")
            {
                ind = 5;
            }
            if (e.Item.Text == "Junho")
            {
                ind = 6;
            }
            if (e.Item.Text == "Julho")
            {
                ind = 7;
            }
            if (e.Item.Text == "Agosto")
            {
                ind = 8;
            }
            if (e.Item.Text == "Setembro")
            {
                ind = 9;
            }
            if (e.Item.Text == "Outubro")
            {
                ind = 10;
            }
            if (e.Item.Text == "Novembro")
            {
                ind = 11;
            }
            if (e.Item.Text == "Dezembro")
            {
                ind = 12;
            }
            #endregion

            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioImplantacoesFinalizadasCompleta.aspx?ind={0}&&ano={1}", ind, ano));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = DateTime.Now.Year.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioImplantacoesFinalizadasCompleta.aspx?ind={0}&&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = ano.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();
            }
        }
    }
}