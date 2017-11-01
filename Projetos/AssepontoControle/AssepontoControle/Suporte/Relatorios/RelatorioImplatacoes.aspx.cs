using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioImplatacoes : System.Web.UI.Page
    {
        private int ano;
        private int ind;
        private int rep;
        private BDApp bd;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();

            new Permissoes(bd).getAcessoResponse("relatorio_implantacao", Response);

            ano = Convert.ToInt32(Request.QueryString["ano"]);
            rep = Convert.ToInt32(Request.QueryString["rep"]);
            ind = Convert.ToInt32(Request.QueryString["ind"]);

            Utils.Cultura();

            if (comboboxRep.SelectedValue == string.Empty)
                comboboxRep.SelectedIndex = rep = 0;
            else
                rep = Convert.ToInt32(comboboxRep.SelectedValue);

            if (!Page.IsPostBack)
            {
                Preencher_Quatidade_Pedidos(ano, rep, bd);
            }
        }

        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
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

            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioImplatacoes.aspx?ind={0}&ano={1}&rep={2}", ind, ano, rep));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            int aux = 0;

            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = DateTime.Now.Year.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioImplatacoes.aspx?ind={0}&&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = ano.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();

                aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT IM_IND) FROM AssepontoClientes LEFT JOIN AssepontoImplantacoes ON IM_CLIENTE = CAD_IND WHERE (YEAR(IM_INICIO) = {0} AND CAD_REP_FABRICANTE = {1}) OR (YEAR(IM_INICIO) = {0} AND 0 = {1})", ano, rep));
                if (aux > 1)
                    RadMenu1.FindItemByValue("ano").Text += " (" + aux + ")";
            }
        }

        protected void comboboxRep_DataBound(object sender, EventArgs e)
        {
            comboboxRep.Items.Insert(0, new RadComboBoxItem("Todos", "0"));

            if (!IsPostBack)
                comboboxRep.SelectedIndex = 0;
        }

        protected void comboboxRep_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rep = Convert.ToInt32(e.Value);
            DataListPedidos.DataBind();
            FormView1.DataBind();
        }

        protected void Preencher_Quatidade_Pedidos(int ano, int rep, BDApp bd)
        { 
            int aux;

            #region Preencher Menu
            if (!Page.IsPostBack)
            {
                bd.openConnection();
                aux = bd.getRelatorioPedidosRep(1, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Janeiro").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(2, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Fevereiro").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(3, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Março").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(4, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Abril").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(5, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Maio").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(6, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Junho").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(7, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Julho").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(8, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Agosto").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(9, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Setembro").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(10, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Outubro").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(11, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Novembro").Text += " (" + aux + ")";

                aux = bd.getRelatorioPedidosRep(12, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Dezembro").Text += " (" + aux + ")";

                bd.closeConnection();
            }
            #endregion
        }

        protected void SqlData_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@rep"].Value = rep;
        }
    }
}