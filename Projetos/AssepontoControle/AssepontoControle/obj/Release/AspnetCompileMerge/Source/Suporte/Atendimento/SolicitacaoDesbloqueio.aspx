<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="SolicitacaoDesbloqueio.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.SolicitacaoDesbloqueio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript" id="telerikClientEvents1">
        //<![CDATA[
        function RadMenu2_ItemClicking(sender, args) {
            var item = args.get_item().get_text();

            if (item == "Excluir Solicitação") {
                args.set_cancel(!window.confirm("Excluir a solicitação?"));
            }

            if (item == "Liberado Manualmente") {
                args.set_cancel(!window.confirm("Marcar a solicitação como liberada manualmente?"));
            }

            if (item == "E-mail cliente dentro 365") {
                args.set_cancel(!window.confirm("Encaminhar e-mail para o comercial ? \n\nMensagem: Senha liberada para cliente dentro de 365 dias."));
            }

            if (item == "E-mail 365 expirado") {
                args.set_cancel(!window.confirm("Encaminhar e-mail para o comercial ? \n\nMensagem: Senha não liberada, cliente fora do prazo de 365 dias. "));
            }

            if (item == "E-mail sem contrato") {
                args.set_cancel(!window.confirm("Encaminhar e-mail para o comercial ? \n\nMensagem: Cliente sem contrato."));
            }

            if (item == "E-mail bloqueado") {
                args.set_cancel(!window.confirm("Encaminhar e-mail para financeiro ? \n\nMensagem: Cliente Bloqueado."));
            }

            if (item == "E-mail em implantação") {
                args.set_cancel(!window.confirm("Encaminhar e-mail para implantação ? \n\nMensagem: Cliente em processo de implantação."));
            }

            if (item == "E-mail sem cadastro") {
                args.set_cancel(!window.confirm("Encaminhar e-mail para o comercial ? \n\nMensagem: Cliente sem contrato."));
            }
        }
        //]]>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo" runat="server" class="sitemenuesquerdo">
        <div>
            <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="False"
                Width="100%" OnItemClick="RadMenu2_ItemClick" OnClientItemClicking="RadMenu2_ItemClicking">
                <Items>
                    <telerik:RadMenuItem runat="server" Text="Excluir Solicitação" NavigateUrl="#" />
                    <telerik:RadMenuItem runat="server" Text="Liberado Manualmente" NavigateUrl="#" />
                    <telerik:RadMenuItem runat="server" Text="Ir para o Cadastro" NavigateUrl="#" />
                </Items>
            </telerik:RadMenu>
        </div>
        <div class="divMenuTitle">
            E-mail
        </div>
        <div id="MenuEmails" runat="server">
            <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="False"
                Width="100%" OnItemClick="RadMenu2_ItemClick" OnClientItemClicking="RadMenu2_ItemClicking">
                <Items>
                    <telerik:RadMenuItem runat="server" Text="E-mail cliente dentro 365" NavigateUrl="#" />
                    <telerik:RadMenuItem runat="server" Text="E-mail sem contrato" NavigateUrl="#" />
                    <telerik:RadMenuItem runat="server" Text="E-mail 365 expirado" NavigateUrl="#" />
                    <telerik:RadMenuItem runat="server" Text="E-mail bloqueado" NavigateUrl="#" />
                    <telerik:RadMenuItem runat="server" Text="E-mail em implantação" NavigateUrl="#" />
                    <telerik:RadMenuItem runat="server" Text="E-mail sem cadastro" NavigateUrl="#" />
                </Items>
            </telerik:RadMenu>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataSourceID="sqlAssepontoSolicitacoes"
                OnDataBound="FormView1_DataBound">
                <ItemTemplate>
                    <table class="formviewtable">
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Razão Social
                                </div>
                                <asp:Label ID="TextBox1" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td style='<%# String.IsNullOrEmpty(Eval("CAD_CNPJ").ToString()) ? "display: none;": "" %>'>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                CNPJ
                                            </div>
                                            <asp:Label ID="CAD_CNPJ" runat="server" Text='<%# Wr.Classes.Validadores.ValidaCnpj(Eval("CAD_CNPJ").ToString()) ? Eval("CAD_CNPJ") : Eval("CAD_CNPJ")  + " CNPJ INVALIDO ! "  %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                IE
                                            </div>
                                            <asp:Label ID="CAD_FANTASIATextBox" runat="server" Text='<%# Eval("CAD_IE") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style='<%# String.IsNullOrEmpty(Eval("CAD_CPF").ToString()) ? "display: none;": "" %>'>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                CPF
                                            </div>
                                            <asp:Label ID="CAD_CPF" runat="server" Text='<%# Eval("CAD_CPF") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Endereço
                                </div>
                                <asp:Label ID="TextBox2" runat="server" Text='<%# Eval("CAD_ENDERECO") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Cidade
                                            </div>
                                            <asp:Label ID="TextBox3" runat="server" Text='<%# Eval("CAD_CIDADE") %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                CEP
                                            </div>
                                            <asp:Label ID="TextBox6" runat="server" Text='<%# Eval("CAD_CEP") %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Bairro
                                            </div>
                                            <asp:Label ID="TextBox4" runat="server" Text='<%# Eval("CAD_BAIRRO") %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                UF
                                            </div>
                                            <asp:Label ID="TextBox5" runat="server" Text='<%# Eval("CAD_UF") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Responsável
                                </div>
                                <asp:Label ID="TextBox8" runat="server" Text='<%# Eval("CAD_CONTATO") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Telefone
                                            </div>
                                            <asp:Label ID="TextBox7" runat="server" Text='<%# Eval("CAD_TELEFONE1") %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                E-mail
                                            </div>
                                            <asp:Label ID="TextBox9" runat="server" Text='<%# Eval("CAD_EMAIL") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption" style='<%# String.IsNullOrEmpty(Eval("ASOL_ORIGEM").ToString()) ? "visibility:hidden;position:absolute;": "" %>'>
                                    Origem
                                </div>
                                <asp:Label ID="TextBox10" runat="server" Text='<%# Eval("ASOL_ORIGEM") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style='<%# String.IsNullOrEmpty(Eval("ASOL_LIBERADO_MANUAL_SUPORTE_POR").ToString()) ? "visibility:hidden;position:absolute;": "" %>'>
                                    <div class="fieldviewcaption">
                                        Liberado manualmente por
                                    </div>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ASOL_LIBERADO_MANUAL_SUPORTE_POR") %>' />
                                </div>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>

            <asp:Label ID="lbObservacao" runat="server" Text=""></asp:Label>

            <wr:Alerta runat="server" ID="Alerta" />
            <wr:ManutencaoStatus runat="server" ID="ManutencaoStatus1" ViewStateMode="Inherit" EnableViewState="False" />

            <asp:Label ID="lbSemCadastro" runat="server" Font-Size="16pt" ForeColor="Red" />

            <div class="siteseparador" id="siteseparador" runat="server">
            </div>

            <div class="sitecorpoboxcaixa" runat="server" id="divVersao">
                <telerik:RadComboBox ID="comboboxAsseponto4Versoes" runat="server" DataSourceID="sqlAsseponto4Versoes"
                    DataTextField="VERS4_DESCRICAO" DataValueField="VERS4_COD" Skin="flv" Width="300px" notnull="true"
                    EnableEmbeddedSkins="false" EmptyMessage="Selecione a Versão">
                </telerik:RadComboBox>

                <asp:SqlDataSource ID="sqlAsseponto4Versoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                    SelectCommand="SELECT [VERS4_COD], [VERS4_DESCRICAO] FROM [Asseponto4Versoes] WHERE VERS4_ATIVO = 1 ORDER BY [VERS4_COD]"></asp:SqlDataSource>

                <asp:Button ID="btDesbloquearAcesso" runat="server" Text="Desbloquear Acesso" OnClick="btDesbloquearAcesso_Click" CssClass="sitebutton blue" />
            </div>
            <asp:SqlDataSource ID="sqlAssepontoSolicitacoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                DeleteCommand="DELETE FROM [AssepontoSolicitacoes] WHERE [ASOL_IND] = @ASOL_IND"
                SelectCommand="SELECT ASOL_IND, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_RAZAOSOCIAL ELSE (SELECT CADP_RAZAOSOCIAL FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_RAZAOSOCIAL, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_CNPJ ELSE (SELECT CADP_CNPJ FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_CNPJ, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_CPF ELSE (SELECT CADP_CPF FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_CPF, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_IE ELSE (SELECT CADP_IE FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_IE, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_ENDERECO ELSE (SELECT CADP_ENDERECO FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_ENDERECO, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_CIDADE ELSE (SELECT CADP_CIDADE FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_CIDADE, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_CEP ELSE (SELECT CADP_CEP FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_CEP, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_BAIRRO ELSE (SELECT CADP_BAIRRO FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_BAIRRO, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_UF ELSE (SELECT CADP_UF FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_UF, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_CONTATO ELSE (SELECT CADP_CONTATO FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_CONTATO, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_TELEFONE1 ELSE (SELECT CADP_TELEFONE1 FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_TELEFONE1, 
                (CASE WHEN ASOL_CLIENTE IS NOT NULL THEN CAD_EMAIL ELSE (SELECT CADP_EMAIL FROM AssepontoClientesProvisorios WHERE CADP_IND = ASOL_CLIENTE_PROVISORIO) END) AS CAD_EMAIL, 
                ASOL_ORIGEM, (SELECT SUP_NOME FROM AssepontoSuporte WHERE SUP_IND = ASOL_LIBERADO_MANUAL_SUPORTE_POR) AS ASOL_LIBERADO_MANUAL_SUPORTE_POR, ASOL_CLIENTE 
                FROM AssepontoSolicitacoes LEFT JOIN AssepontoClientes ON CAD_IND = ASOL_CLIENTE WHERE ASOL_IND = @ASOL_IND">
                <DeleteParameters>
                    <asp:QueryStringParameter Name="ASOL_IND" QueryStringField="ind" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="ASOL_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
