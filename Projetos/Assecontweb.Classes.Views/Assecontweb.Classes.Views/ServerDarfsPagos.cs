using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("aspx")]
    [ToolboxData("<{0}:ServerDarfsPagos runat=\"server\"></{0}:ServerDarfsPagos>")]

    public class ServerDarfsPagos : WebControl, INamingContainer
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        private Telerik.Web.UI.RadGrid radGrid;
        private SqlDataSource sqlData;
        private BDAppLocal bd;

        #region Getters & Setters
        private int _ObrigacaoClientePeriodo;
        public int ObrigacaoClientePeriodo
        {
            get { return _ObrigacaoClientePeriodo; }
            set { _ObrigacaoClientePeriodo = value; }
        }

        private int _Cliente;
        public int Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }

        }
        #endregion

        protected override void RenderContents(HtmlTextWriter output)
        {
            bd = new BDAppLocal();
            sqlData.RenderControl(output);
            radGrid.RenderControl(output);
        }

        protected override void CreateChildControls()
        {
            base.CreateChildControls();

            Controls.Clear();

            radGrid = new Telerik.Web.UI.RadGrid();
            radGrid.ID = "RadGrid1";
            radGrid.AllowPaging = true;
            radGrid.DataSourceID = "sqlObrigacoes";
            radGrid.CellSpacing = 0;
            radGrid.GridLines = GridLines.None;
            radGrid.GroupingSettings.CaseSensitive = false;
            radGrid.AllowSorting = true;
            radGrid.AutoGenerateColumns = false;
            radGrid.MasterTableView.DataKeyNames = new string[] { "DARF_OBRIGACAOARQUIVO" };
            //radGrid.SortingSettings.EnableSkinSortStyles = false;
            //radGrid.Skin = "wr";
            radGrid.MasterTableView.Width = Unit.Percentage(100);

            //Status
            GridTemplateColumn templateColumn = new GridTemplateColumn();
            templateColumn.DataField = "PROCESSADO";
            templateColumn.SortExpression = "PROCESSADO";
            templateColumn.UniqueName = "PROCESSADO";
            templateColumn.ItemTemplate = new MyTemplate("PROCESSADO");
            //templateColumn.ItemTemplate = (new TemplateColumn(TypesTemplateColumn.templates.imgProcessado, Cliente, ObrigacaoClientePeriodo, bd));
            //"<img Visible='<%# Convert.ToInt32(Eval('PROCESSADO')) == 1 %>' id='accpet' class='tooltip icone green' alt='accpet' title='Darf Processado' src='http://www.assecont.com.br/Assecontwebnovo/images/16x16/acceptwhite.png' />"
            templateColumn.HeaderText = "";
            radGrid.MasterTableView.Columns.Add(templateColumn);



            //Arrecadacao
            templateColumn = new GridTemplateColumn();
            templateColumn.DataField = "DARFPAGO_DTA_ARRECADACAO";
            templateColumn.SortExpression = "DARFPAGO_DTA_ARRECADACAO";
            templateColumn.UniqueName = "DARFPAGO_DTA_ARRECADACAO";
            templateColumn.ItemTemplate = new MyTemplate("DARFPAGO_DTA_ARRECADACAO");
            //templateColumn.ItemTemplate = (new TemplateColumn(TypesTemplateColumn.templates.NavigacaoArrecadacao, Cliente, ObrigacaoClientePeriodo, bd));
            templateColumn.HeaderText = "Data de Arrecadação";
            templateColumn.HeaderStyle.Width = Unit.Pixel(150);
            templateColumn.ItemStyle.Width = Unit.Pixel(150);
            radGrid.MasterTableView.Columns.Add(templateColumn);


            //Vencimento
            GridBoundColumn boundColumn = new GridBoundColumn();
            boundColumn.DataField = "DARFPAGO_DTA_VENCIMENTO";
            boundColumn.SortExpression = "DARFPAGO_DTA_VENCIMENTO";
            boundColumn.UniqueName = "DARFPAGO_DTA_VENCIMENTO";
            boundColumn.HeaderText = "Vencimento";
            boundColumn.DataType = typeof(System.DateTime);
            boundColumn.DataFormatString = "{0:dd/MM/yyyy}";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            radGrid.MasterTableView.Columns.Add(boundColumn);

            //Competencia
            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "DARFPAGO_DTA_COMPETENCIA";
            boundColumn.SortExpression = "DARFPAGO_DTA_COMPETENCIA";
            boundColumn.UniqueName = "DARFPAGO_DTA_COMPETENCIA";
            boundColumn.HeaderText = "Período de Apuração";
            boundColumn.DataType = typeof(System.DateTime);
            boundColumn.DataFormatString = "{0:dd/MM/yyyy}";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            radGrid.MasterTableView.Columns.Add(boundColumn);

            //Codigo Receita
            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "DARFPAGO_CODIGO_RECEITA";
            boundColumn.SortExpression = "DARFPAGO_CODIGO_RECEITA";
            boundColumn.UniqueName = "DARFPAGO_CODIGO_RECEITA";
            boundColumn.HeaderText = "Código de Receita";
            boundColumn.DataType = typeof(System.String);
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            radGrid.MasterTableView.Columns.Add(boundColumn);

            //Documentação
            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "DARFPAGO_NUMERO_DOCUMENTO";
            boundColumn.SortExpression = "DARFPAGO_NUMERO_DOCUMENTO";
            boundColumn.UniqueName = "DARFPAGO_NUMERO_DOCUMENTO";
            boundColumn.HeaderText = "Número do Documento";
            boundColumn.DataType = typeof(System.String);
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            radGrid.MasterTableView.Columns.Add(boundColumn);

            //Valor Total
            boundColumn = new GridBoundColumn();
            boundColumn.DataField = "DARFPAGO_VALOR_TOTAL";
            boundColumn.SortExpression = "DARFPAGO_VALOR_TOTAL";
            boundColumn.UniqueName = "DARFPAGO_VALOR_TOTAL";
            boundColumn.HeaderText = "Valor Pago";
            boundColumn.DataType = typeof(System.String);
            boundColumn.DataFormatString = "{0:N}";
            boundColumn.HeaderStyle.Width = Unit.Pixel(150);
            boundColumn.ItemStyle.HorizontalAlign = HorizontalAlign.Right;
            radGrid.MasterTableView.Columns.Add(boundColumn);

            //Darf
            templateColumn = new GridTemplateColumn();
            templateColumn.DataField = "DARF_OBRIGACAOCLIENTEPERIODO";
            templateColumn.UniqueName = "DARF_OBRIGACAOCLIENTEPERIODO";
            //templateColumn.ItemTemplate = new MyTemplate("DARF_OBRIGACAOCLIENTEPERIODO");
            //templateColumn.ItemTemplate = (new TemplateColumn(TypesTemplateColumn.templates.NavigacaoDarf, Cliente, ObrigacaoClientePeriodo, bd));
            templateColumn.HeaderText = "";
            templateColumn.HeaderStyle.Width = Unit.Pixel(100);
            radGrid.MasterTableView.Columns.Add(templateColumn);

            sqlData = new SqlDataSource();
            sqlData.ID = "sqlObrigacoes";
            sqlData.ConnectionString = Global.conexaoAssecontWeb();
            sqlData.SelectCommand = string.Format("EXEC rs_darfs_pagos {0}, {1}", ObrigacaoClientePeriodo, Cliente);

            this.Controls.Add(sqlData);
            this.Controls.Add(radGrid);
        }

        //<telerik:GridTemplateColumn DataField="STATUSDESCRICAO" FilterControlAltText="Filter STATUSDESCRICAO column"
        //    HeaderText="" SortExpression="STATUSDESCRICAO" UniqueName="STATUSDESCRICAO">
        //    <ItemTemplate>
        //        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/16x16/acceptwhite.png"
        //            title='Darf Processado' Visible='<%# Convert.ToInt32(Eval("PROCESSADO")) == 1 %>' CssClass="tooltip icone green" />
        //    </ItemTemplate>
        //</telerik:GridTemplateColumn>

        //<telerik:GridTemplateColumn DataField="DARFPAGO_DTA_ARRECADACAO" FilterControlAltText="Filter DARFPAGO_DTA_ARRECADACAO column"
        //    HeaderText="Data de Arrecadação" SortExpression="DARFPAGO_DTA_ARRECADACAO" UniqueName="DARFPAGO_DTA_ARRECADACAO">
        //    <ItemTemplate>
        //        <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Convert.ToDateTime(Eval("DARFPAGO_DTA_ARRECADACAO")).ToShortDateString() %>' CssClass="title"
        //            NavigateUrl='<%# "~/app/cliente/obrigacaocliente.aspx?ind=" + Eval("DARF_OBRIGACAOCLIENTEPERIODO") %>'/>
        //    </ItemTemplate>
        //    <HeaderStyle Width="150px" />
        //    <ItemStyle Width="150px" />
        //</telerik:GridTemplateColumn>

        //<telerik:GridTemplateColumn HeaderText="">
        //    <HeaderStyle Width="100px" />
        //    <ItemTemplate>
        //        <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl='<%# String.Format("~/Visualizadores/Viewer.aspx?ind={0}&cli={1}", Eval("OBRARQ_IND"), Eval("OBRCLIPER_CLIENTE")) %>'>
        //            <asp:Image ID="Image4" runat="server" ImageUrl="~/images/20x20/clipverde.png" ImageAlign="AbsMiddle" ToolTip="Visualizar" CssClass="tooltip" Visible='<%# Eval("OBRARQ_IND") != DBNull.Value %>' />
        //        </asp:HyperLink>
        //    </ItemTemplate>
        //</telerik:GridTemplateColumn>  
    }

    public partial class MyTemplate : ITemplate
    {
        protected HyperLink ArrecadacaoColumn;
        protected HyperLink DarfColumn;
        protected Image StatusColumn;
        private string colname;
        private string  ab;
        public MyTemplate(string cName)
        {
            colname = cName;
            //ab = a;
        }

        public void InstantiateIn(System.Web.UI.Control container)
        {
            if (colname == "PROCESSADO")
            {
                StatusColumn = new Image();
                StatusColumn.Attributes.Add("style", "<%# Convert.ToInt32(Eval('PROCESSADO')) == 1 ? '' : 'display:none;' %>");
                //        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/16x16/acceptwhite.png"
                //            title='Darf Processado' Visible='<%# Convert.ToInt32(Eval("PROCESSADO")) == 1 %>' CssClass="tooltip icone green" /
                StatusColumn.ID = "imgProcessado";
                StatusColumn.ImageUrl = "http://www.assecont.com.br/Assecontwebnovo/images/16x16/acceptwhite.png";
                StatusColumn.Attributes.Add("title", "Darf Processado");
                StatusColumn.CssClass = "tooltip icone green";
                container.Controls.Add(StatusColumn);
            }

            else if (colname == "DARFPAGO_DTA_ARRECADACAO")
            {
                ArrecadacaoColumn = new HyperLink();
                ArrecadacaoColumn.ID = "HyperArrecadacao";
                ArrecadacaoColumn.DataBinding += new EventHandler(arrecadacaoColumn_DataBinding);
                ArrecadacaoColumn.Target = "_blank";
                ArrecadacaoColumn.CssClass = "title";
                container.Controls.Add(ArrecadacaoColumn);
            }

            else
            {
                DarfColumn = new HyperLink();
                DarfColumn.ID = "HyperDarfs";
                //DarfColumn.DataBinding += new EventHandler(darfColumn_DataBinding);
                DarfColumn.Target = "_blank";
                DarfColumn.CssClass = "title";
                container.Controls.Add(DarfColumn);
            }
        }

        void arrecadacaoColumn_DataBinding(object sender, EventArgs e)
        {
            HyperLink link = (HyperLink)sender;
            GridDataItem container = (GridDataItem)link.NamingContainer;

            int obrigacao = Convert.ToInt32(container.GetDataKeyValue("OBRARQ_OBRIGACAOCLIENTEPERIODO")); //FindControl("RadComboBoxVencimentos") as Label;
            //int obrigacao = Convert.ToInt32(RadComboBoxVencimentos.Text);

            link.NavigateUrl = "http://www.assecont.com.br/Assecontwebnovo/app/obrigacoes/obrigacaocliente.aspx?ind=" + obrigacao;
            link.Text = Convert.ToDateTime((((DataRowView)container.DataItem)[colname]).ToString()).ToShortDateString(); 
        }

        void darfColumn_DataBinding(object sender, EventArgs e)
        {
            HyperLink link = (HyperLink)sender;
            GridDataItem container = (GridDataItem)link.NamingContainer;

            int obrigacao = Convert.ToInt32(container.GetDataKeyValue("DARF_OBRIGACAOARQUIVO")); //FindControl("RadComboBoxVencimentos") as Label;
            //int obrigacao = Convert.ToInt32(RadComboBoxVencimentos.Text);

            link.NavigateUrl = "http://www.assecont.com.br/Assecontwebnovo/app/obrigacoes/obrigacaocliente.aspx?ind=" + obrigacao;
            link.Text = Convert.ToDateTime((((DataRowView)container.DataItem)[colname]).ToString()).ToShortDateString();

            //hyperDarf.NavigateUrl = string.Format("~/Visualizadores/Viewer.aspx?ind={0}&cli={1}", 0, 0 /* Eval("OBRARQ_IND"), Eval("OBRCLIPER_CLIENTE") */);
            //DarfColumn.Text = "<img id='Image4' alt='' src='http://www.assecont.com.br/Assecontwebnovo/images/20x20/clipverde.png' title='Visualizar' align='absmiddle'> </img>";
        }
    }
}
