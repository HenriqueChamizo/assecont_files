<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="Asseponto.Suporte.Comercial.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script src="../../JQuery/Impressao.js"></script>
    <style>
        .ckbFechado input[type=checkbox]{
            -ms-transform: scale(2);
            -moz-transform: scale(2);
            -webkit-transform: scale(2);
            -o-transform: scale(2);
            margin-right: 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table style="Width: 835px; border-bottom: 1px solid lightgray; padding-bottom: 10px">
                <tr>
                    <td style="vertical-align: top;">
                        <wr:TextSearch ID="TextSearch1" runat="server" ShowTexto="false" QueryStringField="filtro" ShowDateFilter="true" />
                    </td>
                    <td>
                        <asp:CheckBox ID="ckbFechado" runat="server" Text="Fechados" OnLoad="ckbFechado_Load" OnCheckedChanged="ckbFechado_CheckedChanged" />
                    </td>
                    <td style="text-align: right;">
                        <input type="button" value="Imprimir Relatório" onclick="JavaScript: imprimePanel('DivImpressao');" class="sitebutton" />
                    </td>
                </tr>
                <%--<tr>
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
                </tr>--%>
            </table>
            <div id="DivImpressao" style="padding-top:20px">
                <center><asp:Label ID="lbTitulo" runat="server" Text=""></asp:Label></center>
                <asp:DataList ID="dtListClieComercial" runat="server" DataSourceID="SqlDataSourceListClieComercial" CssClass="listExpansive" BorderStyle="None" 
                    CellSpacing="5" EnableTheming="True" RepeatColumns="2" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False" Width="835px" >
                    <AlternatingItemStyle BorderStyle="None" />
                    <EditItemStyle BorderStyle="None" />
                    <FooterStyle BorderStyle="None" />
                    <HeaderStyle BorderStyle="None" />
                    <ItemStyle BorderStyle="None" />
                    <ItemTemplate>
                        <table>
                            <%--<div class="listExpansiveItem">--%>
                            <fieldset class="sitelistviewfieldsetitemtemplate">
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Convert.ToInt32(Eval("COM_IND")) %>' />
                                <b>
                                    <asp:HyperLink ID="HyperLink" runat="server" CssClass="listExpansiveItemComp sitelinkpadraoazul" 
                                        Text='<%# Eval("CAD_RAZAOSOCIAL") %>' 
                                        NavigateUrl='<%# "~/Suporte/Comercial/Cliente.aspx?ind=" + Eval("CAD_IND").ToString() %>' ></asp:HyperLink></b><br />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="lbDetalhes" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("ENVIADONOME").ToString()) ? false : true %>'
                                    Text='<%# "Enviado: " + Eval("ENVIADONOME").ToString() + " em " + 
                                        Convert.ToDateTime(Eval("COM_ENVIADOEM")).ToString("dd/MM/yy hh:mm") %>' />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="lbQtdeFunc" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("CAD_QTD_FUNCIONARIO").ToString()) ? false : true %>'
                                    Text='<%# "Funcionários: " + Eval("CAD_QTD_FUNCIONARIO") %>' />
                                
                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="lbContato" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("CAD_CONTATO").ToString()) ? false : true %>'
                                    Text='<%# "Contato: " + Eval("CAD_CONTATO") + 
                                                "(" + Eval("CAD_TELEFONE1_DDD").ToString() + Eval("CAD_TELEFONE1").ToString() + ")" %>' />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="lcContato2" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("CAD_CONTATO2").ToString()) ? false : true %>'
                                    Text='<%# "Contato2: " + Eval("CAD_CONTATO2") + 
                                                (!string.IsNullOrEmpty(Eval("CAD_TELEFONE2_DDD").ToString()) && !string.IsNullOrEmpty(Eval("CAD_TELEFONE2").ToString()) ? 
                                                    ("(" + Eval("CAD_TELEFONE2_DDD").ToString() + Eval("CAD_TELEFONE2").ToString() + ")") : "") %>' />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="lbContato3" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("CAD_CONTATO3").ToString()) ? false : true %>'
                                    Text='<%# "Contato3: " + Eval("CAD_CONTATO3") + 
                                                (!string.IsNullOrEmpty(Eval("CAD_TELEFONE2_DDD").ToString()) && !string.IsNullOrEmpty(Eval("CAD_TELEFONE2").ToString()) ? 
                                                    ("(" + Eval("CAD_TELEFONE3_DDD").ToString() + Eval("CAD_TELEFONE3").ToString() + ")") : "") %>' />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="label5" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL").ToString()) ? false : true %>'
                                    Text='<%# "Email: " + Eval("CAD_EMAIL") %>' />

                                <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="label1" runat="server" 
                                    Visible='<%# string.IsNullOrEmpty(Eval("CAD_EMAIL2").ToString()) ? false : true %>'
                                    Text='<%# "Email2: " + Eval("CAD_EMAIL2") %>' />

                                <div id="fechado">
                                    <b>
                                    <asp:Label CssClass="listExpansiveItemDesc sitelistviewfields" ID="Label2" runat="server" 
                                        Visible='<%# string.IsNullOrEmpty(Eval("FECHADONOME").ToString()) ? false : true %>'
                                        Text='<%# "Fechado: " + Eval("ENVIADONOME").ToString() + " em " + 
                                            Convert.ToDateTime(Eval("COM_FECHADOEM")).ToString("dd/MM/yy hh:mm") %>' /></b>
                                </div>

                                <br />
                                <div id="aberto">
                                    <asp:Button ID="btnFinalizar" runat="server" Text='<%# "Finalizar: " + Eval("COM_IND").ToString() %>'
                                        OnClick="btnFinalizar_Click" CssClass="sitebutton" Visible='<%# string.IsNullOrEmpty(Eval("FECHADONOME").ToString()) ? true : false %>' />
                                </div>
                            </fieldset>
                            <%--</div>--%>
                        </table>
                    </ItemTemplate>
                    <SelectedItemStyle BorderStyle="None" />
                    <SeparatorStyle BorderStyle="None" />
                </asp:DataList>
            </div>
            <asp:SqlDataSource ID="SqlDataSourceListClieComercial" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" 
                SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, CAD_CONTATO, CAD_TELEFONE1_DDD, CAD_TELEFONE1, CAD_CONTATO2, CAD_TELEFONE2_DDD, CAD_TELEFONE2, 
                                CAD_CONTATO3, CAD_TELEFONE3_DDD, CAD_TELEFONE3, CAD_EMAIL, CAD_EMAIL2, CAD_QTD_FUNCIONARIO, 
                                A.COM_IND, A.ENVIADONOME, A.FECHADONOME, A.COM_ENVIADOEM, A.COM_FECHADOEM 
                                FROM AssepontoClientes 
                                OUTER APPLY(
	                                SELECT TOP 1 ENV.SUP_NOME AS ENVIADONOME, 
                                    (case when FEC.SUP_NOME is null
                                          then ''
                                          else FEC.SUP_NOME
                                    end) AS FECHADONOME, COM_ENVIADOEM, 
                                    (case when COM_FECHADOEM is null
                                          then ''
                                          else COM_FECHADOEM
                                    end) as COM_FECHADOEM, COM_IND
	                                FROM AssepontoClientesComercial
	                                INNER JOIN AssepontoSuporte ENV ON ENV.SUP_IND = COM_ENVIADOPOR
	                                LEFT JOIN AssepontoSuporte FEC ON FEC.SUP_IND = COM_FECHADOPOR
	                                WHERE COM_CLIENTE = CAD_IND AND 
		                                  ((@DATAINICIAL IS NULL AND @DATAFINAL IS NULL) OR
		                                   (@DATAINICIAL = '' AND @DATAFINAL = '') OR
		                                   (CONVERT(DATE, COM_ENVIADOEM) &gt;= @DATAINICIAL AND CONVERT(DATE, COM_ENVIADOEM) &lt;= @DATAFINAL))
	                                ORDER BY COM_ENVIADOEM DESC
                                ) A
                                WHERE A.COM_IND IS NOT NULL AND 
	                                  ((@FECHADO = 1 AND A.FECHADONOME IS NOT NULL AND A.FECHADONOME != '') OR
	                                   (@FECHADO = 0 AND A.FECHADONOME IS NULL OR A.FECHADONOME = ''))
                                ORDER BY A.COM_ENVIADOEM, A.COM_FECHADOEM DESC">
                <SelectParameters>
                    <asp:QueryStringParameter Name="DATAINICIAL" Type="DateTime" QueryStringField="DATAINICIAL" DefaultValue="" />
                    <asp:QueryStringParameter Name="DATAFINAL" Type="DateTime" QueryStringField="DATAFINAL" DefaultValue="" />
                    <asp:QueryStringParameter Name="FECHADO" Type="Int32" QueryStringField="FECHADO" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
