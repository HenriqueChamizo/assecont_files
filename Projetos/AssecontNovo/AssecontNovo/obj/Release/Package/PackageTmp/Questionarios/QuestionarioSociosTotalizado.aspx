<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="QuestionarioSociosTotalizado.aspx.cs" Inherits="AssecontNovo.Questionarios.QuestionarioSociosTotalizado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <style>
        .linha {
            border: 0px;
            border-spacing: 0px;
            margin: 0;
            padding: 0px;
        }

        .tableDados td {
            border: 0 !important;
            width: 150px;
            height: 45px;
            font-size: 11pt;
        }

        .questoes {
            width: 420px;
            border-right: 2px solid white;
            padding: 6px 31px 6px 6px;
            text-align: justify;
        }

        .tableHeader {
            border-spacing: 0px;
            font-size: 12pt;
            background-color: lightgrey;
            width: 835px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section>
        <table style="width: 835px">
            <tr>
                <td>
                    <telerik:RadComboBox ID="combobox" CausesValidation="false" Width="280" EmptyMessage="Selecione uma data" OnSelectedIndexChanged="combobox_SelectedIndexChanged"
                        runat="server" Skin="flv" EnableEmbeddedSkins="false" AutoPostBack="true">
                    </telerik:RadComboBox>
                </td>
                <td style="text-align: right">
                    <%--                <a href="QuestionarioSocios.aspx" class="sitebutton blue">Ir Relatório Detalhado</a>--%>
                </td>
            </tr>
        </table>
        <br />
        <table>
            <tr>
                <td>
                    <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td style="width: 120px;">Ruim
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("CLASSIFICACAO_RUIM") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Razoável
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("CLASSIFICACAO_RAZOAVEL") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Bom
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("CLASSIFICACAO_BOM") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Ótimo
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("CLASSIFICACAO_OTIMO") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Sim
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("BIT_SIM") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Não
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("BIT_NAO") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Total Respostas
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("TOTAL_RESPOSTAS") %>' />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding-left: 50px;">
                                        <div style="padding: 20px;background-color:#E0E0E0">
                                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("INDICE") + "%" %>' Font-Size="20" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                </td>
            </tr>
        </table>
        <asp:DataList ID="DataListQuestSocio" runat="server" DataSourceID="SqlData" BorderStyle="None" EnableTheming="True"
            RepeatColumns="1" RepeatDirection="Horizontal" ShowFooter="true" Width="835px">
            <AlternatingItemStyle BorderStyle="None" />
            <EditItemStyle BorderStyle="None" />
            <FooterStyle BorderStyle="None" />
            <HeaderStyle BorderStyle="None" CssClass="linha" />
            <ItemStyle BorderStyle="None" CssClass="linha" />
            <FooterTemplate>
                <table style="width: 100%; padding-left: 50px; font-size: 20pt;">
                    <tr>
                        <td><%# DataListQuestSocio.Items.Count == 0 ? "Nenhum questionário encontrado." : "" %></td>
                    </tr>
                </table>
            </FooterTemplate>
            <HeaderTemplate>
                <table style="border-spacing: 0px;" class="tableHeader">
                    <tr>
                        <td class="questoes" style="border-right: 2px solid white;">Perguntas</td>
                        <td style="padding-left: 10px;">Resultado</td>
                    </tr>
                </table>
            </HeaderTemplate>
            <ItemTemplate>
                <table style="border-spacing: 0px;">
                    <tr>
                        <td class="questoes">
                            <asp:Label ID="lbPergunta" runat="server" Text='<%# Eval("QUESTAO_DESCRICAO") %>'></asp:Label>
                        </td>
                        <td style="padding-left: 10px;">
                            <table class="tableDados" style="border-spacing: 0px">
                                <tr>
                                    <td>
                                        <asp:Label ID="lbSemanal" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Frequencia ? true : false %>' Text='<%# "Semanal: " + Eval("FREQUENCIA_SEMANAL").ToString() %>'></asp:Label>
                                        <asp:Label ID="lbRuim" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Qualificacao ? true : false %>' Text='<%# "Ruim: " + Eval("CLASSIFICACAO_RUIM").ToString() %>'></asp:Label>
                                        <asp:Label ID="lbSim" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Bit ? true : false  %>' Text='<%# "Sim: " + Eval("BIT_SIM").ToString() %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbDiaria" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Frequencia ? true : false %>' Text='<%# "Diaria: " + Eval("FREQUENCIA_DIARIA").ToString() %>'></asp:Label>
                                        <asp:Label ID="lbRazoavel" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Qualificacao ? true : false %>' Text='<%# "Razoavel: " + Eval("CLASSIFICACAO_RAZOAVEL").ToString() %>'></asp:Label>
                                        <asp:Label ID="lbNao" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Bit ? true : false  %>' Text='<%# "Não: " + Eval("BIT_NAO").ToString() %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbMensal" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Frequencia ? true : false %>' Text='<%# "Mensal: " + Eval("FREQUENCIA_MENSAL").ToString() %>'></asp:Label>
                                        <asp:Label ID="lbBom" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Qualificacao ? true : false %>' Text='<%# "Bom: " + Eval("CLASSIFICACAO_BOM").ToString() %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbRaramente" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Frequencia ? true : false %>' Text='<%# "Raramente: " + Eval("FREQUENCIA_RARAMENTE").ToString() %>'></asp:Label>
                                        <asp:Label ID="lbOtimo" runat="server" Visible='<%# Convert.ToInt32(Eval("QUESTAO_TIPO")) == (int)Assecontweb.Classes.Views.Type.Alternativas.Qualificacao ? true : false %>' Text='<%# "Otimo: " + Eval("CLASSIFICACAO_OTIMO").ToString() %>'></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <SelectedItemStyle BorderStyle="None" />
            <SeparatorStyle BorderStyle="None" />
        </asp:DataList>
    </section>

    <asp:SqlDataSource ID="SqlData" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlData_Selecting"
        SelectCommand="EXEC rs_questionario_totalizado @P_DATAINICIAL = @DATAINICIAL, @P_DATAFINAL = @DATAFINAL, @P_PESQUISA_TIPO = 1 ">
        <SelectParameters>
            <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
            <asp:Parameter Name="DATAFINAL" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnLoad="SqlData_Load" OnSelecting="SqlData_Selecting" ConnectionString=""
        SelectCommand="EXEC rs_questionario_socios_indice @P_DATAINICIAL = @DATAINICIAL, @P_DATAFINAL = @DATAFINAL ">
        <SelectParameters>
            <asp:Parameter Name="DATAINICIAL" Type="DateTime" />
            <asp:Parameter Name="DATAFINAL" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
