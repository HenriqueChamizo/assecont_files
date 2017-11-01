<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Legalizacao.Master" AutoEventWireup="true" CodeBehind="Intranet.aspx.cs" Inherits="AssecontNovo.Legalizacao.Intranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <link href="../Skins/Menu.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div class="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" OnLoad="RadMenu1_Load" Skin="Wr"
            EnableEmbeddedSkins="false" Width="150px">
        </telerik:RadMenu>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <div class="AjaxLoadCenter">
                <asp:Image ID="ImgAjaxLoad" runat="server" ImageUrl="~/Imagens/Site/ajaxLoader.gif" /><br />
                <br />
                <asp:Label ID="lbAjaxLoad" runat="server" Font-Size="20pt">                
                    processando...
                </asp:Label>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div class="sitecorpobox">
        Filtro do status<br />
        <telerik:RadComboBox ID="ComboboxStatus" runat="server" DataSourceID="SDS_ETAPAS"
            AutoPostBack="true" Skin="flv" EnableEmbeddedSkins="false" EmptyMessage="Selecione" Width="280"
            DataTextField="LEGETA_NOME" DataValueField="LEGETA_IND" />
        <br />
        <br />
        <telerik:RadGrid ID="RadGridBoletos" runat="server" DataSourceID="SDS_Cadastro" DataKeyNames="LEGCLI_IND"
            CellSpacing="0" GridLines="None" PageSize="24" PagerStyle-AlwaysVisible="true"
            EnableEmbeddedSkins="false" Skin="flv" PagerStyle-ShowPagerText="true" PagerTextFormat="{4} {5}">

            <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5}"></PagerStyle>

            <MasterTableView DataSourceID="SDS_Cadastro" AllowPaging="true" AutoGenerateColumns="false"
                DataKeyNames="LEGCLI_IND" ItemStyle-Height="50px" AlternatingItemStyle-Height="50px"
                AlternatingItemStyle-BackColor="#F7F7F7">

                <Columns>
                    <telerik:GridTemplateColumn DataField="LEGPED_DATA_ENTRADA" HeaderText="Pedido">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td  style="border: 0">
                                        <asp:Image ID="imgIcon" runat="server" CssClass="imgEtapas" BackColor='<%# AssecontNovo.Classes.UtilLegalizacao.getColorEtapaStatus(Eval("LPETA_STATUS")) %>' ImageUrl='<%#  "~/Imagens/24x24/" + Eval("LEGETA_IMAGEM") %>' />
                                    </td>
                                    <td  style="border: 0">
                                        <asp:HyperLink ID="lbProtocolo" runat="server" Font-Size="12pt" CssClass="font_blue" NavigateUrl='<%# "~/Legalizacao/IntranetPedido.aspx?p=" +  Eval("LEGPED_IND") %>'>
                                            <%#  Eval("LEGPED_PROTOCOLO") + " - " + Eval("LEGCLI_RAZAOSOCIAL") %>
                                        </asp:HyperLink>
                                        <br />
                                        <asp:Label ID="lbPedidoIniciado" runat="server" Text='<%# "Iniciado em " + Eval("LEGPED_DATA_ENTRADA", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="ULTIMO_STATUS" HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lbStatus" runat="server" Text='<%# Eval("LEGETA_NOME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>
                </Columns>

                <NoRecordsTemplate>
                    <div>
                        <table style="margin: 20px;">
                            <tr>
                                <td>
                                    <img src="http://www.assecont.com.br/Imagens/Site/Error.png" width="50" />
                                </td>
                                <td>
                                    <div class="tituloSecundario font_gray">
                                        <b>Nenhum registro encontrado.</b>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </NoRecordsTemplate>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SDS_Cadastro" runat="server" OnLoad="SqlData_Load"
        SelectCommand="SELECT * FROM legalizacaoPedidos INNER JOIN LegalizacaoClientes ON LEGPED_CADASTRO = LEGCLI_IND
                        OUTER APPLY
                        (
                            SELECT TOP 1 LEGETA_NOME, LPETA_STATUS, LEGETA_IMAGEM FROM LegalizacaoPedidosEtapas 
                                INNER JOIN LegalizacaoEtapas ON LEGETA_IND = LPETA_ETAPA
                                WHERE LPETA_PEDIDO = LEGPED_IND AND LPETA_STATUS &lt; 2 ORDER BY LEGETA_ORDEM ASC
                        ) a
                        WHERE LEGPED_SERVICO = @Servico">
        <SelectParameters>
            <asp:ControlParameter ControlID="ComboboxStatus" Type="Int32" DefaultValue="0" Name="STATUS" />
            <asp:QueryStringParameter Type="Int32" DefaultValue="0" Name="Servico" QueryStringField="p" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SDS_ETAPAS" runat="server" OnLoad="SqlData_Load"
        SelectCommand="SELECT LEGETA_IND, LEGETA_NOME FROM LegalizacaoEtapas ORDER BY LEGETA_ORDEM"></asp:SqlDataSource>
</asp:Content>
