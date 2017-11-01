<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="_default.aspx.cs" Inherits="Asseponto.Suporte.Comercial._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <table style="height: 340px;">
        <tr>
            <td valign="top">
                <asp:FormView ID="FormComercial" runat="server" DataSourceID="sqlClientes" DefaultMode="Edit" DataKeyNames="CAD_IND" OnDataBound="FormComercial_DataBound">
                    <EditItemTemplate>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <div class="fieldviewcaption">
                                        Atestado Técnico
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Data do Envio<br />
                                    <telerik:RadDatePicker ID="RadPickerAtestado" runat="server" Culture="pt-BR"
                                        DbSelectedDate='<%# Bind("CAD_DTA_CERTIFICADO") %>' Skin="Wr" EnableEmbeddedSkins="false">
                                        <Calendar ID="Calendar1" runat="server" Skin="Wr" EnableEmbeddedSkins="false" UseColumnHeadersAsSelectors="False"
                                            UseRowHeadersAsSelectors="False" ViewSelectorText="x" Width="200px">
                                        </Calendar>
                                        <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                                        </DateInput>
                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                    </telerik:RadDatePicker>
                                </td>
                                <td>Cliente recebeu?<br />
                                    <asp:RadioButtonList ID="CAD_RECEBEU_ATESTADO" runat="server" RepeatDirection="Horizontal"
                                        RepeatLayout="Flow" SelectedValue='<%# Bind("CAD_RECEBEU_ATESTADO") %>'>
                                        <asp:ListItem Value="True">Sim</asp:ListItem>
                                        <asp:ListItem Value="False">Não</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br />
                                    <div class="fieldviewcaption">
                                        Atendimento Técnico
                                    </div>
                                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                        RepeatLayout="Flow" SelectedValue='<%# Bind("CAD_ATENDIMENTO") %>'>
                                        <asp:ListItem Value="1">Ruim</asp:ListItem>
                                        <asp:ListItem Value="2">Bom</asp:ListItem>
                                        <asp:ListItem Value="3">Otimo</asp:ListItem>
                                        <asp:ListItem Value="4">Não sobe avaliar</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br />
                                    <div class="fieldviewcaption">
                                        Proposta
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lbUltimoEnvio" runat="server" Text='<%# Eval("PROP_EMAIL").ToString().Trim() == "" ? "" : "Ultimo Envio: " + Eval("PROP_CONTATO") + " |" + Eval("PROP_EMAIL") + " | " + Eval("PROP_DATA_ENVIO", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>
                <asp:UpdatePanel ID="UpdatePanelProsposta" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lkProposta" runat="server" OnClick="lkProposta_Click">Nova proposta?</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="PanelProposta" runat="server">
                                        <table>
                                            <tr>
                                                <td>Contato
                                        <br />
                                                    <asp:TextBox ID="txtContato" runat="server"></asp:TextBox>
                                                </td>
                                                <td>E-mail<br />
                                                    <asp:TextBox ID="txtEmailProposta" runat="server" Width="300px"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionEmail" runat="server" CssClass="sitevalidator"
                                                        Display="Dynamic" ControlToValidate="txtEmailProposta" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">E-mail Invalido</asp:RegularExpressionValidator>
                                                </td>
                                                <td>Data<br />
                                                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Culture="pt-BR"
                                                        Skin="Wr" EnableEmbeddedSkins="false">
                                                        <Calendar ID="Calendar2" runat="server" Skin="Wr" EnableEmbeddedSkins="false" UseColumnHeadersAsSelectors="False"
                                                            UseRowHeadersAsSelectors="False" ViewSelectorText="x" Width="200px">
                                                        </Calendar>
                                                        <DateInput ID="DateInput2" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                                                        </DateInput>
                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbAviso" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <div class="sitecorpoboxbottom">
                    <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton" OnClick="btSalvar_Click" CommandName="Update">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar
                    </asp:LinkButton>
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT TOP 1 * FROM AssepontoClientes LEFT JOIN AssepontoProposta ON CAD_IND = PROP_CLIENTE WHERE [CAD_IND] = @CAD_IND ORDER BY PROP_DATA_ENVIO DESC"
        UpdateCommand="UPDATE [AssepontoClientes] SET CAD_DTA_CERTIFICADO = @CAD_DTA_CERTIFICADO, CAD_ATENDIMENTO = @CAD_ATENDIMENTO, CAD_RECEBEU_ATESTADO = @CAD_RECEBEU_ATESTADO WHERE [CAD_IND] = @CAD_IND" OnUpdated="sqlClientes_Updated">
        <SelectParameters>
            <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CAD_DTA_CERTIFICADO" Type="DateTime" />
            <asp:Parameter Name="CAD_ATENDIMENTO" Type="Int32" />
            <asp:Parameter Name="CAD_RECEBEU_ATESTADO" Type="Boolean" />
            <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
