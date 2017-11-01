using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [System.Web.UI.ToolboxData("<{0}:ServerControlePesquisaInterna runat=server></{0}:ServerControlePesquisaInterna>")]

    public class ServerControlePesquisaInterna : RadGrid
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        private System.Web.UI.WebControls.SqlDataSource sqlData;

        #region Getters & Setters
        private DateTime dataInicial;
        public DateTime DataInicial
        {
            get { return dataInicial; }
            set { dataInicial = value; }
        }

        private DateTime dataFinal;
        public DateTime DataFinal
        {
            get { return dataFinal; }
            set { dataFinal = value; }
        }

        private Int32 login = 0;
        public Int32 Login
        {
            get { return login; }
            set { login = value; }
        }

        private Type.AssecontSetor setor;
        public Type.AssecontSetor Setor
        {
            get { return setor; }
            set { setor = value; }
        }

        private string navigateUrl;
        public string NavigateUrl
        {
            get { return navigateUrl; }
            set { navigateUrl = value; }
        }
        #endregion

        protected override void CreateChildControls()
        {
            base.CreateChildControls();

            Controls.Clear();
            this.ID = "RadGridPesquisa";
            this.AutoGenerateColumns = false;
            this.ItemDataBound += new GridItemEventHandler(RadGrid1_ItemDataBound);
            this.Width = Unit.Percentage(100);
            sqlData = new System.Web.UI.WebControls.SqlDataSource();
            sqlData.ID = "sqlPesquisa";
            sqlData.ConnectionString = Global.conexaoAssecontWeb();
            sqlData.SelectCommand = string.Format("SET DATEFORMAT DMY EXEC rs_questionario @P_TIPO_QUESTIONARIO = 3, @P_LOGININTERNO = {0} ", login);
            this.DataSource = sqlData;

            GridBoundColumn boundColumn = new GridBoundColumn();
            boundColumn.DataField = "CLI_RAZAOSOCIAL";
            boundColumn.SortExpression = "CLI_RAZAOSOCIAL";
            boundColumn.UniqueName = "CLI_RAZAOSOCIAL";
            boundColumn.HeaderText = "Empresa";
            boundColumn.HeaderStyle.Width = Unit.Pixel(300);
            this.MasterTableView.Columns.Add(boundColumn);

            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "QUERESDADOS_SETOR";
            boundColumn.SortExpression = "QUERESDADOS_SETOR";
            boundColumn.UniqueName = "QUERESDADOS_SETOR";
            boundColumn.HeaderText = "Setor";
            boundColumn.Visible = (int)setor == 0 ? true : false;
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            this.MasterTableView.Columns.Add(boundColumn);

            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "RESPONSAVEL";
            boundColumn.SortExpression = "RESPONSAVEL";
            boundColumn.UniqueName = "RESPONSAVEL";
            boundColumn.HeaderText = "Responsavel";
            boundColumn.Visible = login == 0 ? true : false;
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            this.MasterTableView.Columns.Add(boundColumn);

            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "NOTA";
            boundColumn.SortExpression = "NOTA";
            boundColumn.UniqueName = "NOTA";
            boundColumn.HeaderText = "Nota";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            this.MasterTableView.Columns.Add(boundColumn);

            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "QUERESDADOS_DATA";
            boundColumn.SortExpression = "QUERESDADOS_DATA";
            boundColumn.UniqueName = "QUERESDADOS_DATA";
            boundColumn.HeaderText = "Data";
            boundColumn.DataType = typeof(System.DateTime);
            boundColumn.DataFormatString = "{0:dd/MM/yyyy HH:mm}";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            this.MasterTableView.Columns.Add(boundColumn);

            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "QUERESDADOS_IND";
            boundColumn.SortExpression = "QUERESDADOS_IND";
            boundColumn.UniqueName = "QUERESDADOS_IND";
            boundColumn.HeaderText = "Data";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            boundColumn.Visible = false;
            this.MasterTableView.Columns.Add(boundColumn);

            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "RESPOSTA";
            boundColumn.SortExpression = "RESPOSTA";
            boundColumn.UniqueName = "RESPOSTA";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            boundColumn.Visible = false;
            this.MasterTableView.Columns.Add(boundColumn);
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                if (!item["CLI_RAZAOSOCIAL"].Text.Equals("&nbsp;") && !string.IsNullOrEmpty(item["CLI_RAZAOSOCIAL"].Text))
                    item["CLI_RAZAOSOCIAL"].Text =

                        (item["RESPOSTA"].Text.Equals("1") ? "<img id='mrc' class='tooltip' title='Cliente preencheu a observação.'  style='vertical-align: middle; padding-right: 10px;' src='" + Global.getImagem(Properties.Resources.write16x16).ImageUrl + "' Width='16'> </img>" : "") +
                        "<a href='" + string.Format(navigateUrl, item["QUERESDADOS_IND"].Text) + " ' >" + item["CLI_RAZAOSOCIAL"].Text;

                if (!item["QUERESDADOS_SETOR"].Text.Equals("&nbsp;") && !string.IsNullOrEmpty(item["QUERESDADOS_SETOR"].Text))
                    item["QUERESDADOS_SETOR"].Text = Wr.Classes.Utils.GetDescription((Type.AssecontSetor)Convert.ToInt32(item["QUERESDADOS_SETOR"].Text));

                if (!item["NOTA"].Text.Equals("&nbsp;") && !string.IsNullOrEmpty(item["NOTA"].Text))
                    item["NOTA"].Text = item["NOTA"].Text + " %";
            }
        }
    }
}
