using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("aspx")]
    [ToolboxData("<{0}:ServerSpedFiscalClientes runat=\"server\"></{0}:ServerSpedFiscalClientes>")]

    public class ServerSpedFiscalClientes : RadGrid
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        //private Telerik.Web.UI.RadGrid radGrid;
        private SqlDataSource sqlData;

        #region Getters & Setters
        private int _Mes = DateTime.Now.Month;
        public int Mes
        {
            get { return _Mes; }
            set { _Mes = value; }
        }

        private int _Ano = DateTime.Now.Year;
        public int Ano
        {
            get { return _Ano; }
            set { _Ano = value; }
        }

        private int _Cliente;
        public int Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }
        }

        private Type.NotaFiscalTipo _NotaFiscalTipo = Type.NotaFiscalTipo.Fornecedor;
        public Type.NotaFiscalTipo NotaFiscalTipo
        {
            get { return _NotaFiscalTipo; }
            set { _NotaFiscalTipo = value; }
        }
        #endregion

        protected override void CreateChildControls()
        {

            base.CreateChildControls();

            Controls.Clear();
            this.ID = "RadGridSpedFiscalCliente";
            this.AutoGenerateColumns = false;
            this.ItemDataBound += new GridItemEventHandler(RadGrid1_ItemDataBound);
            sqlData = new System.Web.UI.WebControls.SqlDataSource();
            sqlData.ID = "SqlDataSpedFiscalCliente";
            sqlData.ConnectionString = Global.conexaoAssecontWeb();
            sqlData.SelectCommand = string.Format("EXEC rst_sped_principais @P_MES = {0}, @P_ANO = {1}, @P_CLIENTE = {2}, @P_RELATORIO = 2, @P_FORNECEDOR = {3}", Mes, Ano, Cliente, (int)NotaFiscalTipo);
            this.DataSource = sqlData;
            this.MasterTableView.Width = Unit.Percentage(100);

            //Empresa
            GridBoundColumn boundColumn = new GridBoundColumn();
            boundColumn.DataField = "EMPRESA";
            boundColumn.SortExpression = "EMPRESA";
            boundColumn.UniqueName = "EMPRESA";
            boundColumn.HeaderText = "EMPRESA";
            //boundColumn.DataType = string;
            boundColumn.HeaderStyle.Width = Unit.Pixel(300);
            this.MasterTableView.Columns.Add(boundColumn);

            //Quantidade
            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "QTE";
            boundColumn.SortExpression = "QTE";
            boundColumn.UniqueName = "QTE";
            boundColumn.HeaderText = "QTE";
            //boundColumn.DataType = typeof(System.DateTime);
            //boundColumn.DataFormatString = "{0:dd/MM/yyyy}";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            this.MasterTableView.Columns.Add(boundColumn);

            //VALOR
            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "VALOR";
            boundColumn.SortExpression = "VALOR";
            boundColumn.UniqueName = "VALOR";
            boundColumn.HeaderText = "VALOR";
            boundColumn.DataType = typeof(System.Decimal);
            //boundColumn.DataFormatString = "R$ {0:N}";
            //boundColumn.EmptyDataText = string.Empty;
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            this.MasterTableView.Columns.Add(boundColumn);

            //%
            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "%";
            boundColumn.SortExpression = "%";
            boundColumn.UniqueName = "%";
            boundColumn.HeaderText = "%";
            //boundColumn.DataType = typeof(System.Single);
            //boundColumn.DataFormatString = "{0:n2c}";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            this.MasterTableView.Columns.Add(boundColumn);
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                //var item = rgd_grid.MasterTableView.Items[0] as GridDataItem;
                //if (item != null)
                //    string text = item["Unique"].Text;

                GridDataItem item = (GridDataItem)e.Item;
                item["VALOR"].Text = "R$ " + Convert.ToDecimal(item["VALOR"].Text.Replace('.', ',')).ToString("N2", new System.Globalization.CultureInfo("pt-BR"));
            }
        }
    }
}
