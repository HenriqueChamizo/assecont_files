<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true" CodeBehind="Cliente.aspx.cs" Inherits="Asseponto.Revenda.Clientes.Cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Histórico de Pendências" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="CAD_IND" DataSourceID="sqlClientes" DefaultMode="Edit">
                <EditItemTemplate>
                    <table class="formviewtable">
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Razão Social</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_RAZAOSOCIALLabel" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>'
                                                    Width="340px" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">Fantasia</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_FANTASIALabel" runat="server" Text='<%# Eval("CAD_FANTASIA") %>'
                                                    Width="200px" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">CNPJ</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_CNPJLabel" runat="server" Text='<%# Eval("CAD_CNPJ") %>' Width="150px" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">Inscrição Estadual</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_IELabel" runat="server" Text='<%# Eval("CAD_IE") %>' Width="150px" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Telefone</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_TELEFONE1Label" runat="server" Text='<%# Eval("CAD_TELEFONE1") %>'
                                                    Width="130px" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">SKYPE/MSN</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_SKYPELabel" runat="server" Text='<%# Eval("CAD_SKYPE") %>'
                                                    Width="130px" />
                                            </div>
                                        </td>
                        <%--                <td>
                                            <div class="fieldviewcaption">MSN</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="MSNLabel" runat="server" Text='<%# Eval("MSN") %>'
                                                    Width="240px" />
                                            </div>
                                        </td>--%>

                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">E-mail</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_EMAILLabel" runat="server" Text='<%# Eval("CAD_EMAIL") %>'
                                                    Width="240px" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">E-mail 2</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("CAD_EMAIL2") %>'
                                                    Width="240px" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Endereço</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_ENDERECOLabel" runat="server" Text='<%# Eval("CAD_ENDERECO") %>'
                                                    Width="240px" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">Bairro</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_BAIRROLabel" runat="server" Text='<%# Eval("CAD_BAIRRO") %>'
                                                    Width="180px" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Cidade</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_CIDADELabel" runat="server" Text='<%# Eval("CAD_CIDADE") %>'
                                                    Width="200px" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">UF</div>
                                            <div class="fieldviewtext">
                                                <asp:Label runat="server" Text='<%# Eval("CAD_UF") %>'></asp:Label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">CEP</div>
                                            <div class="fieldviewtext">
                                                <asp:Label ID="CAD_CEPLabel" runat="server" Text='<%# Eval("CAD_CEP") %>' Width="100px" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <wr:Alerta ID="Alerta1" runat="server" 
                                                ImageUrl="~/Images/48x48/WarningRed.png" Text="Cliente Bloqueado" 
                                                cnpj_cpf='<%# Eval("CAD_CNPJ") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">Contato</div>
                                <div class="fieldviewtext">
                                    <asp:Label ID="CAD_CONTATOLabel" runat="server" Text='<%# Eval("CAD_CONTATO") %>'
                                        Width="130px" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>


            <asp:SqlDataSource ID="sqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT CAD_IND, CAD_RAZAOSOCIAL, CAD_FANTASIA, CAD_CNPJ, CAD_IE, CAD_TELEFONE1, CAD_EMAIL, CAD_SKYPE, CAD_ENDERECO, CAD_BAIRRO, CAD_CIDADE, CAD_UF, CAD_CEP, CAD_CONTATO, CAD_EMAIL2, dbo.fn_asseponto_cliente_cnpj_bloqueado(AssepontoClientes.CAD_CNPJ) AS BLOQUEADO FROM [AssepontoClientes] WHERE ([CAD_IND] = @CAD_IND) AND CAD_REVENDA = @CAD_REVENDA">
                <SelectParameters>
                    <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
                    <asp:SessionParameter Name="CAD_REVENDA" SessionField="Revenda" />
                </SelectParameters>
            </asp:SqlDataSource>
            <wr:ManutencaoStatus ID="ManutencaoStatus1" runat="server" />
        </div>
    </div>
</asp:Content>
