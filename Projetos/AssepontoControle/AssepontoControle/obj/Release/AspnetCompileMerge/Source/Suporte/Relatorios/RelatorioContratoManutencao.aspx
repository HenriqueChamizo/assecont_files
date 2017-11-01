<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="RelatorioContratoManutencao.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.RelatorioContratoManutencao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
    <style type="text/css">
        .rgExpand, .rgCollapse
        {
            display: none;
        }
    </style>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="contentplaceMenuEsquerdo" runat="server">
</asp:content>
<asp:content id="Content3" contentplaceholderid="contentplaceConteudo" runat="server">
    <table style="padding-top: 20px; padding-bottom: 30px;">
        <tr>
            <td>
                <p style="font-size: 14pt; margin: 5px 0px;min-width: 200px">Manu. Cancelada</p>
                <telerik:RadComboBox ID="ComboboxManutencao" Width="150" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ComboboxManutencao_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false">
                    <Items>
                        <telerik:RadComboBoxItem Text="Não" Value="0" />
                        <telerik:RadComboBoxItem Text="Sim" Value="1" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td>
                <p style="font-size: 14pt; margin: 5px 0px;min-width: 200px">Contrato Enviado</p>
                <telerik:RadComboBox ID="ComboboxEnviado" Width="150" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ComboboxEnviado_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false">
                    <Items>
                        <telerik:RadComboBoxItem Text="Não" Value="0" />
                        <telerik:RadComboBoxItem Text="Sim" Value="1" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td>
                <p style="font-size: 14pt; margin: 5px 0px;min-width: 200px">Contrato Recebido</p>
                <telerik:RadComboBox ID="ComboboxRecebido" Width="150" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ComboboxRecebido_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false">
                    <Items>
                        <telerik:RadComboBoxItem Text="Não" Value="0" />
                        <telerik:RadComboBoxItem Text="Sim" Value="1" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td>
                <p style="font-size: 14pt; margin: 5px 0px;min-width: 200px">UF</p>
                <telerik:RadComboBox ID="ComboboxUF" Width="150" EmptyMessage="Selecione" CausesValidation="false" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ComboboxUF_SelectedIndexChanged" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="SqlDataUF" 
                    DataValueField="CAD_UF" DataTextField="UF_COUNT">
                </telerik:RadComboBox>
            </td>
            <td style="text-align: right;padding-right: 20px;padding-top: 30px;">
                <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
            </td>
        </tr>
    </table>

    <div id="DivImpressao">
        <telerik:RadGrid ID="RadGridContrato" runat="server" DataSourceID="SqlDataContrato"
            CellSpacing="0" GridLines="None" EditItemStyle-HorizontalAlign="Justify" Width="1000" PagerStyle-AlwaysVisible="true"
            GroupingSettings-CaseSensitive="false"  SortingSettings-EnableSkinSortStyles="false"
            EnableEmbeddedSkins="false" Skin="flv"  PagerStyle-ShowPagerText="true"
            PagerTextFormat="{4} {5}">

            <PagerStyle Mode="NumericPages" PagerTextFormat="{4} {5} Clientes"></PagerStyle>

            <GroupingSettings GroupContinuesFormatString="" GroupContinuedFormatString="" GroupSplitDisplayFormat="" />

            <MasterTableView DataSourceID="SqlDataContrato"  AutoGenerateColumns="false" ItemStyle-Height="40px"
                AlternatingItemStyle-Height="40px" AlternatingItemStyle-BackColor="#F7F7F7" AllowAutomaticUpdates="true">

                <NoRecordsTemplate>Nenhum registro encontrado.</NoRecordsTemplate>

                <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldAlias="REVCLI" FieldName="REVCLI" HeaderText=" " HeaderValueSeparator=" "></telerik:GridGroupByField>
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="REVCLI" SortOrder="Ascending"></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>

                <Columns>

                    <telerik:GridTemplateColumn DataField="UF"
                        HeaderText="UF" SortExpression="UF" UniqueName="UF" >
                        <ItemTemplate>
                            <asp:Label ID="lbUF" runat="server" ForeColor="#1A4C83" Text='<%# Eval("UF") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="30px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="RAZAOSOCIAL"
                        HeaderText="Nome" SortExpression="RAZAOSOCIAL" UniqueName="RAZAOSOCIAL" FooterAggregateFormatString="Total: {0:0} Clientes">
                        <ItemTemplate>
                            <asp:Label ID="lbNome" runat="server" ForeColor="#1A4C83" Text='<%# Eval("RAZAOSOCIAL") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="420px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="CNPJ_CPF" ItemStyle-Font-Size="10pt" AllowFiltering="false"
                        HeaderText="CNPJ/CPF" SortExpression="CNPJ_CPF" UniqueName="CNPJ_CPF">
                        <ItemTemplate>
                            <asp:Label ID="lbCnpjCpf" runat="server" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="MNT_VALOR" ItemStyle-Font-Size="10pt" AllowFiltering="false"
                        HeaderText="Valor" SortExpression="MNT_VALOR" UniqueName="MNT_VALOR">
                        <ItemTemplate>
                            <asp:Label ID="lbValor" runat="server" Text='<%# Eval("MNT_VALOR", "{0:n2}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="MNT_CONTRATO_ENVIADOEM" ItemStyle-Font-Size="10pt" AllowFiltering="false"
                        HeaderText="Enviado Em" SortExpression="MNT_CONTRATO_ENVIADOEM" UniqueName="MNT_CONTRATO_ENVIADOEM">
                        <ItemTemplate>
                            <asp:Label ID="lbEnviado" runat="server" Text='<%# Eval("MNT_CONTRATO_ENVIADOEM", "{0: dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="MNT_CONTRATO_RECEBIDOEM" ItemStyle-Font-Size="10pt" AllowFiltering="false"
                        HeaderText="Recebido Em" SortExpression="MNT_CONTRATO_RECEBIDOEM" UniqueName="MNT_CONTRATO_RECEBIDOEM">
                        <ItemTemplate>
                            <asp:Label ID="lbRecebido" runat="server" Text='<%# Eval("MNT_CONTRATO_RECEBIDOEM", "{0: dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataContrato" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlDataContrato_Selecting"
        SelectCommand="SELECT DISTINCT (CASE WHEN MNT_REVENDA IS NULL THEN 'Cliente' ELSE 'Revenda' END) AS REVCLI, 
                        (CASE WHEN MNT_REVENDA IS NULL THEN A.CAD_RAZAOSOCIAL ELSE REV_RAZAOSOCIAL END) AS RAZAOSOCIAL, 
                        (CASE WHEN MNT_REVENDA IS NULL THEN dbo.fn_cliente_cnpj_cpf(A.CAD_IND) ELSE dbo.fn_revenda_cnpj_cpf(REV_IND) END) AS CNPJ_CPF, 
                        UF, MNT_VALOR, MNT_CONTRATO_ENVIADOEM, MNT_CONTRATO_RECEBIDOEM
                        FROM AssepontoClientes A
                        CROSS APPLY
                        (
	                        SELECT TOP 1 * FROM AssepontoManutencao WHERE MNT_CLIENTE = A.CAD_IND ORDER BY MNT_IND DESC
                        ) aa
                        CROSS APPLY
                        (
	                        SELECT (CASE WHEN MNT_REVENDA IS NULL THEN B.CAD_UF ELSE REV_UF END) AS UF
	                        FROM AssepontoClientes B
	                        LEFT JOIN AssepontoRevendas ON MNT_REVENDA = REV_IND
	                        WHERE B.CAD_IND = A.CAD_IND
                        ) ab
                        LEFT JOIN AssepontoRevendas ON MNT_REVENDA = REV_IND
                        WHERE MNT_CANCELADO = @MANUTENCAO AND 
	                          (UF = @UF OR @UF = '00' OR @UF IS NULL) AND
                        ((@RECEBIDO = 1 AND MNT_CONTRATO_RECEBIDOEM IS NOT NULL) OR 
                        (@RECEBIDO = 0 AND MNT_CONTRATO_RECEBIDOEM IS NULL)) AND
                        ((@ENVIADO = 1 AND MNT_CONTRATO_ENVIADOEM IS NOT NULL) OR 
                        (@ENVIADO = 0 AND MNT_CONTRATO_ENVIADOEM IS NULL))">
        <SelectParameters>
            <asp:Parameter Name="ENVIADO" Type="Int32" />
            <asp:Parameter Name="RECEBIDO" Type="Int32" />
            <asp:Parameter Name="MANUTENCAO" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UF" Type="String" DefaultValue="00" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataUF" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlDataUF_Selecting"
        SelectCommand="SELECT DISTINCT A.CAD_UF, (A.CAD_UF + ' (' + CONVERT(VARCHAR(10), COUNT_UF) + ') ') AS UF_COUNT
                        FROM AssepontoClientes A
                        CROSS APPLY(	SELECT TOP 1 * FROM AssepontoManutencao WHERE MNT_CLIENTE = A.CAD_IND ORDER BY MNT_IND DESC) aA
                        CROSS APPLY
                        (
	                        SELECT COUNT(B.CAD_UF) AS COUNT_UF
	                        FROM AssepontoClientes B 
	                        CROSS APPLY(	SELECT TOP 1 * FROM AssepontoManutencao WHERE MNT_CLIENTE = B.CAD_IND ORDER BY MNT_IND DESC) C
	                        WHERE B.CAD_UF = A.CAD_UF AND B.CAD_UF IS NOT NULL AND B.CAD_UF != '' AND
	                        MNT_CANCELADO = @MANUTENCAO AND 
	                        ((@RECEBIDO = 1 AND C.MNT_CONTRATO_RECEBIDOEM IS NOT NULL) OR 
	                        (@RECEBIDO = 0 AND C.MNT_CONTRATO_RECEBIDOEM IS NULL)) AND
	                        ((@ENVIADO = 1 AND C.MNT_CONTRATO_ENVIADOEM IS NOT NULL) OR 
	                        (@ENVIADO = 0 AND C.MNT_CONTRATO_ENVIADOEM IS NULL))
                        ) aB
                        WHERE (A.CAD_UF IS NOT NULL AND A.CAD_UF != '') AND 
	                          COUNT_UF != 0 AND 
	                          MNT_CANCELADO = @MANUTENCAO AND 
	                          ((@RECEBIDO = 1 AND MNT_CONTRATO_RECEBIDOEM IS NOT NULL) OR 
	                          (@RECEBIDO = 0 AND MNT_CONTRATO_RECEBIDOEM IS NULL)) AND
	                          ((@ENVIADO = 1 AND MNT_CONTRATO_ENVIADOEM IS NOT NULL) OR 
	                          (@ENVIADO = 0 AND MNT_CONTRATO_ENVIADOEM IS NULL))
                        ORDER BY A.CAD_UF">
        <SelectParameters>
            <asp:Parameter Name="ENVIADO" Type="Int32" />
            <asp:Parameter Name="RECEBIDO" Type="Int32" />
            <asp:Parameter Name="MANUTENCAO" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:content>
