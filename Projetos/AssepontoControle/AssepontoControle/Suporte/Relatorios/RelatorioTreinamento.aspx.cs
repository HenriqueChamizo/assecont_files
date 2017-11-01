using System;
using System.Web.UI;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioTreinamento : System.Web.UI.Page
    {
        #region Getters & setters
        private int compareceu;

        public int Compareceu
        {
            get { return compareceu; }
            set { compareceu = value; }
        }

        private string dataHora;

        public string DataHora
        {
            get { return dataHora; }
            set { dataHora = value; }
        }

        private int mes;

        public int Mes
        {
            get { return mes; }
            set { mes = value; }
        }

        private int ano;

        public int Ano
        {
            get { return ano; }
            set { ano = value; }
        }
        #endregion

        BDApp bd;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            if (!IsPostBack)
            {
                (new Permissoes(bd)).getAcessoResponse("relatoriotreinamento", Response);
                Utils.Cultura();
            }
            Mes = Convert.ToInt32(Request.QueryString["ind"]);
            Ano = Convert.ToInt32(Request.QueryString["ano"]);

            if (ComboboxCompareceu.SelectedValue == string.Empty)
                ComboboxCompareceu.SelectedIndex = Compareceu = 2;
            else
                Compareceu = Convert.ToInt32(ComboboxCompareceu.SelectedValue);

            if (comboboxDataHora.SelectedValue == string.Empty)
            {
                comboboxDataHora.SelectedIndex = 0;
                DataHora = "01/01/2001";
            }
            else
                DataHora = comboboxDataHora.SelectedValue;

            if (Mes == 0)
            {
                Mes = DateTime.Now.Month;
                Ano = DateTime.Now.Year;
            }

            #region Preencher Menu
            if (!Page.IsPostBack)
            {
                bd.openConnection();

                foreach (RadMenuItem radItem in RadMenu1.Items)
                {
                    try
                    {
                        int valor = bd.getCountTreinamentoCliente(Convert.ToInt32(radItem.Value), ano);

                        if (valor > 0)
                        {
                            RadMenu1.Items.FindItemByValue(radItem.Value).ImageUrl = "http://www.asseponto.com.br/assepontocontrole/Images/16x16/TickVerde.png";
                            RadMenu1.Items.FindItemByValue(radItem.Value).Text += " - " + valor;
                        }
                        else
                            RadMenu1.Items.FindItemByValue(radItem.Value).Visible = false;
                    }
                    catch
                    {

                    }
                }

                bd.closeConnection();

                ((System.Web.UI.WebControls.Label)FormView1.FindControl("lbMesAno")).Text = Asseponto.Classes.Utils.getMesAnoFormat(Mes, Ano);

            }
            #endregion
        }

        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (e.Item.Value == "ano")
            {
                ano = ano + 1;
            }
            else
            {
                if (e.Item.Value == "anoAnterior")
                    ano = ano - 1;
                else
                    ind = Convert.ToInt32(e.Item.Value);
            }

            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioTreinamento.aspx?ind={0}&ano={1}", ind, ano));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = (DateTime.Now.Year + 1).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();

                Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioTreinamento.aspx?ind={0}&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = (ano + 1).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();
            }
        }

        protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@DATAHORA"].Value = DataHora;
            e.Command.Parameters["@COMPARECEU"].Value = Compareceu;
            e.Command.Parameters["@IND"].Value = Mes;
            e.Command.Parameters["@ANO"].Value = Ano;
        }

        protected void SqlAgendaAdmin_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@IND"].Value = Mes;
            e.Command.Parameters["@ANO"].Value = Ano;
        }

        protected void comboboxDataHora_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DataHora = e.Value;
            RadGrid1.DataBind();
            FormView1.DataBind();
        }

        protected void ComboboxCompareceu_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Compareceu = Convert.ToInt32(e.Value);
            RadGrid1.DataBind();
            FormView1.DataBind();
        }

        protected void comboboxDataHora_DataBound(object sender, EventArgs e)
        {
            comboboxDataHora.Items.Insert(0, new RadComboBoxItem("Todos", "01/01/2001"));

            if (!IsPostBack)
                comboboxDataHora.SelectedIndex = 0;
        }
    }
}