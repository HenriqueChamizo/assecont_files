<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TextSearch.ascx.cs"
    Inherits="Wr.WebControls.TextSearch" %>
<div class="sitecorpoboxcaixa">
    <table>
        <tr>
            <td>
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/48x48/Lupa.png" CssClass="siteimagem" />
            </td>
            <td>
                <asp:Panel ID="panelData" runat="server">
                    <table>
                        <tr>
                            <td style="padding-right: 5px;">
                                <telerik:RadDatePicker ID="RadDatePicker1" runat="server" Skin="Web20">
                                    <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False" 
                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>

                            </td>
                            <td>-
                            </td>
                            <td style="padding-left: 5px;">
                                <telerik:RadDatePicker ID="RadDatePicker2" runat="server" Skin="Web20">
                                    <Calendar Skin="Web20" UseColumnHeadersAsSelectors="False"
                                        UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                            <td style="padding-top: 15px; padding-left: 8px;">
                                <asp:LinkButton ID="RadButton1" runat="server" CssClass="sitebutton" Text="Filtrar" OnClick="RadButton1_Click">
                                </asp:LinkButton>
                                <br />
                                <br />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="panelFitro" runat="server">
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdFiltro" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdFiltro_SelectedIndexChanged">
                                    <asp:ListItem Text="Razão Social/Fantasia" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="CNPJ/CPF" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="E-mail's" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Protocolo" Value="4"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="panelAssefin" runat="server">
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButtonList ID="rdFiltroAssefin" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdFiltroAssefin_SelectedIndexChanged">
                                    <asp:ListItem Text="Razão Social/Fantasia" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="CNPJ/CPF" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="E-mail's" Value="3"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="panelTexto" runat="server">
                    <asp:TextBox ID="edPesquisa" runat="server" Width="450px" AutoPostBack="True" OnTextChanged="edPesquisa_TextChanged"></asp:TextBox>
                </asp:Panel>
            </td>
        </tr>
    </table>
</div>
