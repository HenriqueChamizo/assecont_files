using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [System.Web.UI.ToolboxData("<{0}:ServerSpedFiscal runat=server></{0}:ServerSpedFiscal>")]

    public class ServerSpedFiscal : RadGrid
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        private System.Web.UI.WebControls.SqlDataSource sqlData;

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

        private Type.RelatorioSpedFiscal _RelatorioSpedFiscal = Type.RelatorioSpedFiscal.Fornecedor;
        public Type.RelatorioSpedFiscal RelatorioSpedFiscal
        {
            get { return _RelatorioSpedFiscal; }
            set { _RelatorioSpedFiscal = value; }
        }
        #endregion

        protected override void CreateChildControls()
        {
            base.CreateChildControls();

            Controls.Clear();
            this.ID = "RadGridSpedFiscal";
            this.AutoGenerateColumns = false;
            //this.ItemDataBound += new GridItemEventHandler(RadGrid1_ItemDataBound);
            sqlData = new System.Web.UI.WebControls.SqlDataSource();
            sqlData.ID = "ServerSpedFiscal";
            sqlData.ConnectionString = Global.conexaoAssecontWeb();
            sqlData.SelectCommand = string.Format("EXEC rst_sped_principais @P_MES = {0}, @P_ANO = {1}, @P_CLIENTE = {2}, @P_TIPO = {3}", Mes, Ano, Cliente, (int)RelatorioSpedFiscal);
            this.DataSource = sqlData;

            GridBoundColumn boundColumn = new GridBoundColumn();
            boundColumn.DataField = "Nome";
            boundColumn.SortExpression = "Nome";
            boundColumn.UniqueName = "Nome";
            boundColumn.HeaderText = "NOME";
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
            boundColumn.DataFormatString = "{0:N}";
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

        //protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        //{
        //    if (e.Item is GridDataItem)
        //    {
        //        //var item = rgd_grid.MasterTableView.Items[0] as GridDataItem;
        //        //if (item != null)
        //        //    string text = item["Unique"].Text;
        //        GridDataItem item = (GridDataItem)e.Item;
        //        if (!item["VALOR"].Text.Equals("&nbsp;") && !string.IsNullOrEmpty(item["VALOR"].Text))
        //            item["VALOR"].Text = "R$ " + Convert.ToDecimal(item["VALOR"].Text.Replace('.', ',')).ToString("N2", new System.Globalization.CultureInfo("pt-BR"));
        //    }
        //}

        public static DateTime getUltimoSpedFiscal(int Cliente, Type.RelatorioSpedFiscal RelatorioSpedFiscal)
        {
            BDAppLocal.BDAppAssecont bd = new BDAppLocal.BDAppAssecont();
            return Convert.ToDateTime(bd.getFieldValueDateTime(string.Format("SELECT TOP 1 NOT_DATA_EMISSAO FROM SpedNotasFiscais " +
                    "INNER JOIN SpedParticipantes ON NOT_PARTICIPANTE = PART_IND " +
                    "INNER JOIN SpedProdutos ON NOT_IND = PRO_NOTAFISCAL  " +
                    "WHERE NOT_EMPRESA = {0} " +
                    "AND (({1} = 2 OR {1} = 4) AND NOT_TIPO_DA_NOTA >= 1 OR ({1} = 1 OR {1} = 3) AND NOT_TIPO_DA_NOTA = 0)  " +
                    "ORDER BY NOT_DATA_EMISSAO DESC", Cliente, (int)RelatorioSpedFiscal)).ToString("01/MM/yyyy"));
        }
    }
}
