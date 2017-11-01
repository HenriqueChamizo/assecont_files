using System;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioImplantacoesFinalizadasIncompleta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();

            new Permissoes(bd).getAcessoResponse("relatorio_implantacao", Response);

            Utils.Cultura();          

            int ano = Convert.ToInt32(Request.QueryString["ano"]);

            if (!Page.IsPostBack)
                Preencher_Quatidade_Pedidos(ano, bd);
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
            if (e.Item.Value == "Janeiro")
            {
                ind = 1;
            }
            if (e.Item.Value == "Fevereiro")
            {
                ind = 2;
            }
            if (e.Item.Value == "Março")
            {
                ind = 3;
            }
            if (e.Item.Value == "Abril")
            {
                ind = 4;
            }
            if (e.Item.Value == "Maio")
            {
                ind = 5;
            }
            if (e.Item.Value == "Junho")
            {
                ind = 6;
            }
            if (e.Item.Value == "Julho")
            {
                ind = 7;
            }
            if (e.Item.Value == "Agosto")
            {
                ind = 8;
            }
            if (e.Item.Value == "Setembro")
            {
                ind = 9;
            }
            if (e.Item.Value == "Outubro")
            {
                ind = 10;
            }
            if (e.Item.Value == "Novembro")
            {
                ind = 11;
            }
            if (e.Item.Value == "Dezembro")
            {
                ind = 12;
            }
            #endregion
            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioImplantacoesFinalizadasIncompleta.aspx?ind={0}&&ano={1}", ind, ano));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = DateTime.Now.Year.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioImplantacoesFinalizadasIncompleta.aspx?ind={0}&&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = ano.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();
            }
        }

        protected void Preencher_Quatidade_Pedidos(int ano, BDApp bd)
        {
            int aux;

            #region Preencher Menu
            if (!Page.IsPostBack)
            {
                bd.openConnection();
                aux = bd.getRelatorioImplantacaoIncompleto(1, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Janeiro").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(2, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Fevereiro").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(3, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Março").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(4, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Abril").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(5, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Maio").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(6, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Junho").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(7, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Julho").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(8, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Agosto").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(9, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Setembro").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(10, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Outubro").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(11, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Novembro").Text += " (" + aux + ")";

                aux = bd.getRelatorioImplantacaoIncompleto(12, ano);
                if (aux > 0)
                    RadMenu1.FindItemByText("Dezembro").Text += " (" + aux + ")";

                bd.closeConnection();
            }
            #endregion
        }
    }
}