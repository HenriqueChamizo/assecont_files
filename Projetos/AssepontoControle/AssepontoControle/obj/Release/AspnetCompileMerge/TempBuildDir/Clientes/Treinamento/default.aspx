<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Clientes.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Clientes.Treinamento._default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <style>
        .campos
        {
            padding: 8px 0px 0px 0px;
            _background-color: #F5F5F5;
        }

        .title
        {
            padding-bottom: 5px;
            display: -webkit-box;
            letter-spacing: 0.8px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">

    <img src="../../Images/Site/treinamentoAsseponto4.png" />

    <table style="width: 100%; padding-top: 20px;">
        <tr>
            <td id="AvisoTd" runat="server" valign="top" style="text-align: center;" colspan="2">

                <div style="padding: 2px 10px 5px 10px; border-top: 1px solid gray;">
                    <table style="margin: 0 auto; width: 200px;">
                        <tr>
                            <td>
                                <img src="../../Images/Site/Aviso.png" width="100" /></td>
                            <td style="font-size: 25pt; color: #C01919; padding-top: 50px;">Aviso</td>
                        </tr>
                    </table>
                </div>
                <asp:Label ID="lbAviso" runat="server" Font-Size="18pt" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td id="AgendarTd" runat="server" valign="top" style="text-align: center; width: 65%;">
                <div style="font-size: 16pt; width: 300px; padding: 2px 10px 5px 10px; border-bottom: 1px solid gray;">Agendar Treinamento</div>

                <asp:FormView ID="FormView2" runat="server" DataSourceID="SqlDataCadastro" OnDataBound="FormView2_DataBound">
                    <ItemTemplate>
                        <table style="width: 300px; text-align: left; height: 120px; border-collapse: collapse; border-spacing: 0;">
                            <tr>
                                <td class="campos" colspan="2">
                                    <asp:Label ID="lbCliente" runat="server" Font-Size="16pt" Font-Bold="true" ForeColor="Orange" Text='<%# Wr.Classes.Strings.capitalizeWords(Eval("CAD_RAZAOSOCIAL").ToString()) %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="campos" colspan="2"><span class="title">Data/Horário</span>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadComboBox ID="comboboxTreinamento" DataSourceID="SqlDataTreinamento" Width="310" EmptyMessage="Selecione uma Data - Horário" CausesValidation="false"
                                                DataTextField="DATAHORA" DataValueField="AGE_IND" notnull="true" runat="server" Skin="flv" DataTextFormatString="{0:dd/MM/yyyy HH:mm}" EnableEmbeddedSkins="false" AutoPostBack="true">
                                            </telerik:RadComboBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="campos" colspan="2"><span class="title">Nome</span>
                                    <asp:TextBox ID="txtNome" Width="300" notnull="true" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="campos" colspan="2"><span class="title">E-mail</span>
                                    <asp:TextBox ID="txtEmail" Width="300" notnull="true" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="campos"><span class="title">Telefone</span>
                                    <asp:TextBox ID="txtTelefone" runat="server"></asp:TextBox>
                                </td>
                                <td class="campos">
                                    <br />
                                    <asp:LinkButton ID="lkConfirmar" runat="server" CssClass="sitebutton" OnClick="lkConfirmar_Click">Confirmar</asp:LinkButton>
                                </td>
                                </tr>
                            <tr>
                                <td class="campos" colspan="2">
                                    <asp:Label ID="lbErro" runat="server" Text="" ForeColor="Red"></asp:Label><br />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
            </td>
            <td id="AgendadoTd" runat="server" valign="top" style="text-align: center;">
                <div style="width: 300px; padding: 2px 10px 5px 10px; border-bottom: 1px solid gray; font-size: 18pt;">Agenda</div>

                <asp:DataList ID="DataListTreinamentos" runat="server" DataSourceID="SqlDataAgendada">
                    <ItemTemplate>
                        <table style="width: 300px; font-size: 12pt; text-align: center; border-top: 5px solid white; background: whitesmoke;">
                            <tr>
                                <td>
                                    <asp:Label ID="lbData" runat="server" Font-Bold="true" ForeColor="crimson" Text='<%# Eval("AGE_DATA_HORA", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbNome" runat="server" Font-Bold="true" Text='<%# "Participante " + Eval("AGECLI_CONTATO") %>'></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("AGECLI_CONTATO_EMAIL") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlDataTreinamento" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT *, (RTRIM(AGE_SEMANA) + ' - ' + CONVERT(NVARCHAR, AGE_DATA_HORA, 103) + ' ' + SUBSTRING(CONVERT(NVARCHAR, AGE_DATA_HORA, 108), 0, 6)) AS DATAHORA 
                FROM AssepontoAgendaTreinamentos WHERE AGE_DATA_HORA &gt;= GETDATE() AND 
                (SELECT COUNT(*) FROM AssepontoAgendaClientes WHERE AGE_IND = AGECLI_AGENDA) &lt; 15 AND AGE_ASSEPONTO4 = 1"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataAgendada" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlDataAgendada_Selecting"
        SelectCommand="SELECT * FROM AssepontoAgendaTreinamentos 
                        INNER JOIN AssepontoAgendaClientes ON AGE_IND = AGECLI_AGENDA        
                        WHERE AGE_DATA_HORA &gt;= GETDATE() AND AGECLI_CLIENTE = @cliente">
        <SelectParameters>
            <asp:QueryStringParameter Name="cliente" QueryStringField="cliente" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataCadastro" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelecting="SqlDataAgendada_Selecting"
        SelectCommand="SELECT * FROM AssepontoClientes WHERE CAD_IND = @cliente">
        <SelectParameters>
            <asp:QueryStringParameter Name="cliente" QueryStringField="cliente" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
