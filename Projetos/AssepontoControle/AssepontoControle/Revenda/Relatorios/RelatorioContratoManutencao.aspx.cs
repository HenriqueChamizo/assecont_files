using Asseponto.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Asseponto.Revenda.Relatorios
{
    public partial class RelatorioContratoManutencao : System.Web.UI.Page
    {
        private int contratoEnviado;
        public int ContratoEnviado
        {
            get { return contratoEnviado; }
            set { contratoEnviado = value; }
        }

        private int contratoRecebido;
        public int ContratoRecebido
        {
            get { return contratoRecebido; }
            set { contratoRecebido = value; }
        }

        private int contratoManutencao;
        public int ContratoManutencao
        {
            get { return contratoManutencao; }
            set { contratoManutencao = value; }
        }

        private string uf;
        public string Uf
        {
            get { return uf; }
            set { uf = value; }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                (new Permissoes(new BDApp())).getAcessoResponse("relatorios", Response);
            }

            if (ComboboxEnviado.SelectedValue == string.Empty)
                ComboboxEnviado.SelectedIndex = ContratoEnviado = 1;
            else
                ContratoEnviado = Convert.ToInt32(ComboboxEnviado.SelectedValue);

            if (ComboboxRecebido.SelectedValue == string.Empty)
                ComboboxRecebido.SelectedIndex = contratoRecebido = 1;
            else
                contratoRecebido = Convert.ToInt32(ComboboxRecebido.SelectedValue);

            if (String.IsNullOrEmpty(ComboboxManutencao.SelectedValue))
                ComboboxManutencao.SelectedIndex = ContratoManutencao = 0;
            else
                ContratoManutencao = Convert.ToInt32(ComboboxManutencao.SelectedValue);

            //if (String.IsNullOrEmpty(ComboboxUF.SelectedValue))
            //    Uf = "00";
            //else
            //    Uf = ComboboxUF.SelectedValue;
        }

        protected void ComboboxEnviado_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ContratoEnviado = Convert.ToInt32(e.Value);
            RadGridContrato.DataBind();
            //ComboboxUF.DataBind();
        }

        protected void SqlDataContrato_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@ENVIADO"].Value = ContratoEnviado;
            e.Command.Parameters["@RECEBIDO"].Value = ContratoRecebido;
            e.Command.Parameters["@MANUTENCAO"].Value = ContratoManutencao;
            e.Command.Parameters["@UF"].Value = "00";
        }

        protected void ComboboxRecebido_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ContratoRecebido = Convert.ToInt32(e.Value);
            RadGridContrato.DataBind();
            //ComboboxUF.DataBind();
        }

        protected void ComboboxUF_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Uf = e.Value.ToString();
            RadGridContrato.DataBind();
        }

        protected void SqlDataUF_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@ENVIADO"].Value = ContratoEnviado;
            e.Command.Parameters["@RECEBIDO"].Value = ContratoRecebido;
            e.Command.Parameters["@MANUTENCAO"].Value = ContratoManutencao;
        }

        protected void ComboboxManutencao_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ContratoManutencao = Convert.ToInt32(e.Value);
            RadGridContrato.DataBind();
            //ComboboxUF.DataBind();
        }
    }
}