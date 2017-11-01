<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Cliente.aspx.cs" Inherits="Asseponto.Suporte.Comercial.Cliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <%--<table style="Width: 835px; border-bottom: 1px solid lightgray; padding-bottom: 10px">
                <tr>
                    <td style="vertical-align: top;">
                        <wr:TextSearch ID="TextSearch1" runat="server" ShowTexto="false" QueryStringField="filtro" ShowDateFilter="true" />
                    </td>
                    <td style="text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadComboBox ID="ListRevendas" Width="500" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ListRevendas_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="SqlDataSourceListRevendas"
                            DataTextField="REV_RAZAOSOCIAL" DataValueField="REV_IND">
                        </telerik:RadComboBox>
                    </td>
                    <td style="text-align: right;">
                        <telerik:RadComboBox ID="ListReps" Width="200" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ListReps_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="SqlDataSourceListReps"
                            DataTextField="FABR_NOME" DataValueField="FABR_COD">
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>--%>
            <div id="DivImpressao" style="padding-top:20px">
                <center><asp:Label ID="lbTitulo" runat="server" Text=""></asp:Label></center>
                <telerik:radgrid id="radListClieComercial" runat="server" allowpaging="True" datasourceid="SqlDataSourceListClieComercial"
                    cellspacing="0" gridlines="None" pagesize="50" edititemstyle-horizontalalign="Justify"
                    groupingsettings-casesensitive="false" allowsorting="true" allowautomaticupdates="true"
                    sortingsettings-enableskinsortstyles="false" skin="flv" enableembeddedskins="false">

                    <MasterTableView DataSourceID="SqlDataSourceListClieComercial" AutoGenerateColumns="false" 
                        DataKeyNames="COM_IND" ItemStyle-Height="30px" AlternatingItemStyle-Height="30px"
                        AllowAutomaticUpdates="true">

                        <NoRecordsTemplate>
                            <div>
                                Nenhum encaminhamento encontrado.
                            </div>
                        </NoRecordsTemplate>

                        <Columns>
                            <telerik:GridTemplateColumn DataField="COM_ENVIADOEM" HeaderText="Enviado em" SortExpression="COM_ENVIADOEM" UniqueName="COM_ENVIADOEM">
                                <ItemTemplate>
                                     <p>
                                        <asp:Label ID="lbDtEnvio" runat="server" Font-Size="11pt" Text='<%# Eval("COM_ENVIADOEM" , "{0:dd/MM/yyyy}") %>'></asp:Label>
                                         <span style="font-size: 11pt;"> as </span>
                                        <asp:Label ID="lbHrEnvio" runat="server" Font-Size="11pt" Text='<%# Eval("COM_ENVIADOEM" , "{0:hh:mm}") %>'></asp:Label>
                                    </p>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="ENVIADO"
                                HeaderText="Enviado por" SortExpression="ENVIADO" UniqueName="ENVIADO">
                                <ItemTemplate>
                                    <p>
                                         <asp:HyperLink ID="HyperEnviado" runat="server" Font-Size="12pt" ForeColor="#005782" Enabled="false"
                                              Text='<%# Eval("ENVIADO") %>'></asp:HyperLink>
                                    </p>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="COM_FECHADOEM"
                                HeaderText="Fechado em" SortExpression="COM_FECHADOEM" UniqueName="COM_FECHADOEM">
                                <ItemTemplate>
                                    <p>
                                        <asp:Label ID="lbDtFechado" runat="server" Font-Size="11pt" 
                                            Text='<%# !string.IsNullOrEmpty(Eval("COM_FECHADOEM").ToString()) ? Eval("COM_FECHADOEM" , "{0:dd/MM/yyyy}") : "EM ABERTO" %>'></asp:Label>
                                        <asp:Label ID="Label1" runat="server" Text="as" Font-Size="11pt"
                                            Visible='<%# !string.IsNullOrEmpty(Eval("COM_FECHADOEM").ToString()) ? true : false %>'></asp:Label>
                                        <asp:Label ID="lbHrFechado" runat="server" Font-Size="11pt" 
                                            Text='<%# !string.IsNullOrEmpty(Eval("COM_FECHADOEM").ToString()) ? Eval("COM_FECHADOEM" , "{0:hh:mm}") : "" %>'></asp:Label>
                                    </p>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="FECHADO"
                                HeaderText="Fechado por" SortExpression="FECHADO" UniqueName="FECHADO">
                                <ItemTemplate>
                                    <p>
                                         <asp:HyperLink ID="HyperFechado" runat="server" Font-Size="12pt" ForeColor="#005782" Enabled="false"
                                              Text='<%# !string.IsNullOrEmpty(Eval("FECHADO").ToString()) ? Eval("FECHADO").ToString() : "" %>'
                                              Visible='<%# !string.IsNullOrEmpty(Eval("FECHADO").ToString()) ? true : false %>'></asp:HyperLink>
                                        <%--<asp:Label ID="Label2" runat="server" Text="EM ABERTO"
                                            Visible='<%# !string.IsNullOrEmpty(Eval("FECHADO").ToString()) ? false : true %>'></asp:Label>--%>
                                    </p>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>
                        </Columns>

                    </MasterTableView>
                </telerik:radgrid>
            </div>
            <asp:SqlDataSource ID="SqlDataSourceListClieComercial" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" 
                SelectCommand="SELECT COM_IND, COM_CLIENTE, COM_ENVIADOPOR, ENV.SUP_NOME AS ENVIADO, COM_ENVIADOEM, COM_FECHADOPOR, FEC.SUP_NOME AS FECHADO, COM_FECHADOEM 
                                FROM AssepontoClientesComercial
                                INNER JOIN AssepontoSuporte ENV ON ENV.SUP_IND = COM_ENVIADOPOR
                                LEFT JOIN AssepontoSuporte FEC ON FEC.SUP_IND = COM_FECHADOPOR
                                WHERE COM_CLIENTE = @CAD_IND ORDER BY COM_ENVIADOEM DESC">
                <SelectParameters>
                    <asp:QueryStringParameter Name="CAD_IND" Type="Int32" QueryStringField="ind" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
