using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Clientes
{
    public partial class Manutencoes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();

            if (!IsPostBack)
                (new Permissoes(bd)).getAcessoResponse("Manutencao", Response);

            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int rep = Convert.ToInt32(Request.QueryString["rep"]);

            if (!Page.IsPostBack)
            {
                Preencher_Menu_REP(RadMenuREP);
                Preencher_Quatidade_Pedidos(ano, rep, bd);
            }

            if (rep != 0)
            {
                lbrep.Text = "Pesquisa: " + bd.getFieldValueString(string.Format("SELECT FABR_NOME FROM AssepontoRepFabricantes WHERE FABR_COD = {0}", rep));
            }
            else
            {
                lbrep.Text = "Pesquisa: Todos";
            }
        }

        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            int rep = Convert.ToInt32(Request.QueryString["rep"]);


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

            Response.Redirect(string.Format("~/suporte/Clientes/Manutencoes.aspx?ind={0}&&ano={1}&&rep={2}", ind, ano, rep));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            int rep = Convert.ToInt32(Request.QueryString["rep"]);
            int aux;

            BDApp bd = new BDApp();

            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = DateTime.Now.Year.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                Response.Redirect(string.Format("~/suporte/Clientes/Manutencoes.aspx?ind={0}&&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = ano.ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();

                aux = bd.getFieldValueInteger(String.Format("SELECT COUNT(CAD_IND) FROM AssepontoManutencao INNER JOIN AssepontoClientes ON CAD_IND = MNT_CLIENTE LEFT JOIN AssepontoVersoes ON VER_COD = MNT_VERSAO_ASSEPONTO WHERE (YEAR(MNT_DATA) = {0} AND CAD_REP_FABRICANTE = {1}) OR (YEAR(MNT_DATA) = {0} AND {1} = 0)", ano, rep));
                if (aux > 0)
                    RadMenu1.FindItemByValue("ano").Text += " (" + aux + ")";
            }
        }

        private void Preencher_Menu_REP(RadMenu Menu)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            int rep = Convert.ToInt32(Request.QueryString["rep"]);

            if (ano > 0)
            {
                BDApp bd = new BDApp();
                DataTable tbREP = bd.getDataTable(String.Format("SELECT * FROM AssepontoRepFabricantes"));

                foreach (DataRow reader in tbREP.Rows)
                //while (reader.Read())
                {
                    Menu.Items.Add(new RadMenuItem(String.Format("{0}", reader["FABR_NOME"].ToString()), String.Format("~/suporte/Clientes/Manutencoes.aspx?ind={0}&ano={1}&rep={2}", ind, ano, reader["FABR_COD"].ToString())));
                }

                Menu.Items.Add(new RadMenuItem("Todos", String.Format("~/suporte/Clientes/Manutencoes.aspx?ind={0}&ano={1}&rep={2}", ind, ano, 0)));

                //reader.Close();
                //bd.closeConnection();
            }
        }

        protected void Preencher_Quatidade_Pedidos(int ano, int rep, BDApp bd)
        {
            int aux;

            #region Preencher Menu
            if (!Page.IsPostBack)
            {
                bd.openConnection();
                aux = bd.getRelatorioManuntecaoRep(1, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Janeiro").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(2, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Fevereiro").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(3, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Março").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(4, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Abril").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(5, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Maio").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(6, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Junho").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(7, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Julho").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(8, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Agosto").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(9, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Setembro").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(10, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Outubro").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(11, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Novembro").Text += " (" + aux + ")";

                aux = bd.getRelatorioManuntecaoRep(12, ano, rep);
                if (aux > 0)
                    RadMenu1.FindItemByText("Dezembro").Text += " (" + aux + ")";

                bd.closeConnection();
            }
            #endregion
        }
    }
}