using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;
using System.Data;

namespace Asseponto.Suporte.Atendimento
{
    public partial class Pendencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Preencher_Menu_Suporte(RadMenu3, Convert.ToInt32(Types.PendenciaTipo.Suporte));
                Preencher_Menu_Suporte(RadMenuImplantacoes, Convert.ToInt32(Types.PendenciaTipo.Implantacao));
            }
        }

        private void Preencher_Menu_Suporte(RadMenu Menu, int Tipo)
        {
            int Situacao = Convert.ToInt32(Request.QueryString["situacao"]);
            string Campo = (Situacao == 0) ? "PEN_DATAHORA" : "PEN_DATAHORASOLUCAO";

            DateTime DataInicial = (String.IsNullOrEmpty(Request.QueryString["datainicial"])) ? Convert.ToDateTime("01/01/2000") : Convert.ToDateTime(Request.QueryString["datainicial"]);
            DateTime DataFinal = (String.IsNullOrEmpty(Request.QueryString["datafinal"])) ? Convert.ToDateTime("01/01/2050") : Convert.ToDateTime(Request.QueryString["datafinal"]);

            BDApp bd = new BDApp();

            DataTable tbPendencias = bd.getDataTable(String.Format("SELECT SUP_IND, SUP_NOME, (SELECT COUNT(*) FROM AssepontoPendencias " +
                "WHERE PEN_RESPONSAVEL1 = SUP_IND AND PEN_SITUACAO = {0} AND PEN_TIPO = {1} AND CONVERT(DATE, {2}) >= '{3}' AND CONVERT(DATE, {2}) <= '{4}') AS NPENDENCIAS " +
                "FROM AssepontoSuporte WHERE SUP_ATIVO = 1 AND SUP_SETOR > 0  ORDER BY SUP_NOME", Situacao, Tipo, Campo, DataInicial.ToShortDateString(), DataFinal.ToShortDateString()));

            string situacao = Request.QueryString["situacao"];
            if (String.IsNullOrEmpty(situacao))
            {
                situacao = Convert.ToInt32(Types.PendenciaSituacao.EmAberto).ToString();
            }

            foreach(DataRow reader in tbPendencias.Rows)
            //while (reader.Read())
            {
                Menu.Items.Add(new RadMenuItem(String.Format("{0} ({1})", reader["SUP_NOME"].ToString(), reader["NPENDENCIAS"].ToString()), String.Format("~/Suporte/Atendimento/Pendencias.aspx?suporte={0}&situacao={1}&tipo={2}&datainicial={3}&datafinal={4}", reader["SUP_IND"].ToString(), situacao, Tipo, DataInicial.ToShortDateString(), DataFinal.ToShortDateString())));
            }

            Menu.Items.Add(new RadMenuItem("TODOS", String.Format("~/Suporte/Atendimento/Pendencias.aspx?suporte={0}&situacao={1}&tipo={2}", 0, situacao, Tipo)));

            //reader.Close();
            //bd.closeConnection();
        }

        protected void cmbPageSize_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadListView1.PageSize = int.Parse(e.Value);
            RadListView1.CurrentPageIndex = 0;
            RadListView1.Rebind();
        }
    }
}