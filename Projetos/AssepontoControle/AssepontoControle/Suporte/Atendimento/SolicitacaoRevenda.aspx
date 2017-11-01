<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="SolicitacaoRevenda.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.SolicitacaoRevenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript" id="telerikClientEvents1">
        //<![CDATA[

        function RadMenu2_ItemClicking(sender, args) {
            var item = args.get_item().get_text();

            if (item == "Excluir Solicitação") {
                args.set_cancel(!window.confirm("Excluir a solicitação?"));
            }
        }
        //]]>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="False"
            Width="100%" OnItemClick="RadMenu2_ItemClick" OnClientItemClicking="RadMenu2_ItemClicking">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Excluir Solicitação" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataSourceID="sqlAssepontoRevendas" OnDataBound="FormView1_DataBound"
                DataKeyNames="CADP_REV_IND">
                <ItemTemplate>
                    <table class="formviewtable">
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                <asp:Label ID="Label2" runat="server" ForeColor="#000066" Font-Bold="true" Text='<%# Convert.ToInt32(Eval("CADP_REV_STATUS")) == 0 ? "REVENDA GOLD" : "REVENDA PREMIUM" %>' />
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
                                            <br />
                                            <div class="fieldviewcaption">
                                                Razão Social
                                            </div>
                                            <asp:Label ID="CADP_REV_RAZAOSOCIAL" runat="server" Text='<%# Eval("CADP_REV_RAZAOSOCIAL") %>'
                                                Width="250px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                CNPJ
                                            </div>
                                            <asp:Label ID="CADP_REV_CNPJ" runat="server" Text='<%# Eval("CADP_REV_CNPJ") %>'
                                                Width="115px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                CPF
                                            </div>
                                            <asp:Label ID="Lbcpf" runat="server" Text='<%# Eval("CADP_REV_CPF") %>'
                                                Width="115px" />
                                        </td>
                                        <td>
                                            <br />
                                            <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Pedido já aceito"
                                                CssClass="sitevalidator2" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
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
                                            <div class="fieldviewcaption">
                                                Fantasia
                                            </div>
                                            <asp:Label ID="CADP_REV_FANTASIA" runat="server" Text='<%# Eval("CADP_REV_FANTASIA") %>'
                                                Width="250px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Distribuidora
                                            </div>
                                            <asp:Label ID="REV_DISTRIBUIDORA" runat="server" Text='<%# Eval("CADP_REV_DISTRIBUIDORA") %>'
                                                Width="300px" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Inscrição Estadual
                                </div>
                                <asp:Label ID="CAD_FANTASIATextBox" runat="server" Text='<%# Eval("CADP_REV_IE") %>'
                                    Width="130px" />
                            </td>
                        </tr>
                        </tr>
                        <td>
                            <table class="formviewtableinner">
                                <tr>
                                    <td>
                                        <div class="fieldviewcaption">
                                            Endereço
                                        </div>
                                        <asp:Label ID="REV_LOGRADOURO" runat="server" Text='<%# Eval("CADP_REV_LOGRADOURO") %>'
                                            Width="250px" />
                                    </td>
                                    <td>
                                        <div class="fieldviewcaption">
                                            Nº
                                        </div>
                                        <asp:Label ID="CADP_REV_NUMERO" runat="server" Text='<%# Eval("CADP_REV_NUMERO") %>'
                                            Width="50px" />
                                    </td>
                                    <td>
                                        <div class="fieldviewcaption">
                                            Complemento
                                        </div>
                                        <asp:Label ID="REV_COMPLEMENTO" runat="server" Text='<%# Eval("CADP_REV_COMPLEMENTO") %>'
                                            Width="150px" />
                                    </td>
                                    <td>
                                        <div class="fieldviewcaption">
                                            CEP
                                        </div>
                                        <asp:Label ID="CADP_REV_CEP" runat="server" Text='<%# Eval("CADP_REV_CEP") %>' Width="150px" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Bairro
                                            </div>
                                            <asp:Label ID="TextBox4" runat="server" Text='<%# Eval("CADP_REV_BAIRRO") %>' Width="250px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Cidade
                                            </div>
                                            <asp:Label ID="CADP_REV_CIDADE" runat="server" Text='<%# Eval("CADP_REV_CIDADE") %>'
                                                Width="215px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                UF
                                            </div>
                                            <asp:Label ID="CADP_REV_UF" runat="server" Text='<%# Eval("CADP_REV_UF") %>' Widht="70px" />
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
                                            <div class="fieldviewcaption">
                                                Contato
                                            </div>
                                            <asp:Label ID="CADP_REV_CONTATO" runat="server" Text='<%# Eval("CADP_REV_CONTATO") %>'
                                                Width="250px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                DDD
                                            </div>
                                            <asp:Label ID="CADP_REV_DDD" runat="server" Text='<%# Eval("CADP_REV_DDD") %>' Width="50px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Telefone
                                            </div>
                                            <asp:Label ID="CADP_REV_TELEFONE" runat="server" Text='<%# Eval("CADP_REV_TELEFONE") %>'
                                                Width="135px" />
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
                                            <div class="fieldviewcaption">
                                                Skype
                                            </div>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("CADP_REV_SKYPE") %>' Width="250px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                E-mail
                                            </div>
                                            <asp:Label ID="TextBox9" runat="server" Text='<%# Eval("CADP_REV_EMAIL") %>' Width="250px" />
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
                                            <div class="fieldviewcaption">
                                                LOGIN
                                            </div>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("CADP_REV_LOGIN") %>' Width="250px" />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                E-mail2
                                            </div>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("CADP_REV_EMAIL2") %>' Width="250px" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <div class="sitecorpoboxcaixa" runat="server" id="divVersao">
                <asp:Button ID="btDesbloquearAcesso" runat="server" Text="Desbloquear acesso" CssClass="sitebutton blue" OnClick="btDesbloquearAcesso_Click" />
            </div>
            <asp:SqlDataSource ID="sqlAssepontoRevendas" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                DeleteCommand="DELETE FROM [AssepontoRevendasProvisorios] WHERE [CADP_REV_IND] = @CADP_REV_IND"
                SelectCommand="SELECT * FROM [AssepontoRevendasProvisorios] WHERE ([CADP_REV_IND] = @CADP_REV_IND)">
                <DeleteParameters>
                    <asp:QueryStringParameter Name="CADP_REV_IND" QueryStringField="ind" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="CADP_REV_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
