using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.Suporte.Pesquisa
{
    public partial class pesquisaBeAnywhere1 : System.Web.UI.Page
    {
        private DateTime dataInicial;
        private DateTime dataFinal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                new Permissoes((new BDApp())).getAcessoResponse("pesquisa", Response);

            dataInicial = String.IsNullOrEmpty(Request.QueryString["datainicial"]) ? Convert.ToDateTime("01/01/2000") : Convert.ToDateTime(Request.QueryString["datainicial"]);
            dataFinal = String.IsNullOrEmpty(Request.QueryString["datafinal"]) ? DateTime.Now : Convert.ToDateTime(Request.QueryString["datafinal"]);
        
        }

        protected void combobox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            DataList1.DataBind();
        }

        protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@DATAINICIAL"].Value = dataInicial;
            e.Command.Parameters["@DATAFINAL"].Value = dataFinal;
        }   
    }
}