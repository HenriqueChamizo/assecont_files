<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="ImplantacaoAssefin.aspx.cs" Inherits="Asseponto.Suporte.Implantacoes.ImplantacaoAssefin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript" src="../../Scripts/Scripts.js"></script>
    <script type="text/javascript">
        function confirmarfinalizar() { return (window.confirm('Confirma a finalização da implantação?')) }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu2_ItemClick">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Pendências" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Nova Pendência" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="E-mail Cobrança Instalação" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Cadastro" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="IM_IND" DataSourceID="sqlImplantacoes">
                <EditItemTemplate>
                    <wr:Alerta runat="server" ID="Alerta" revenda='<%# Eval("REV_CNPJ") %>' cnpj_cpf='<%# Eval("CNPJ_CPF")  %>' />
                    <table class="formviewtable" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <table style="width: 450px;" boder="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Cliente</div>
                                            <asp:Label ID="lbCliente" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="txtCnpjCpf" runat="server" Text='<%# Eval("CNPJ_CPF") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Revenda</div>
                                            <asp:Label ID="lbRevenda" runat="server" Text='<%# Eval("REV_RAZAOSOCIAL") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Responsável</div>
                                            <asp:Label ID="lbResponsavel" runat="server" Text='<%# Eval("CAD_CONTATO") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Telefone</div>
                                            <asp:Label ID="lbDDD" runat="server" Text='<%# Eval("CAD_TELEFONE1_DDD") %>'></asp:Label>
                                            <asp:Label ID="lbTelefone" runat="server" Text='<%# Eval("CAD_TELEFONE1") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbDDD2" runat="server" Text='<%# Eval("CAD_TELEFONE2_DDD") %>'></asp:Label>
                                            <asp:Label ID="lbTelefone2" runat="server" Text='<%# Eval("CAD_TELEFONE2") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='<%# String.IsNullOrEmpty(Eval("CAD_SKYPE").ToString()) ? "display: none": "" %>'>
                                            <div class="fieldviewcaption">Skype</div>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("CAD_SKYPE") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">E-mail</div>
                                            <asp:Label ID="lbEmail" runat="server" Text='<%# Eval("CAD_EMAIL") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbEmail2" runat="server" Text='<%# Eval("CAD_EMAIL2") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Versão do Assefin</div>
                                            <telerik:RadComboBox ID="VERSAO" runat="server" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="sqlAssefinVersao"
                                                DataTextField="VER_ASSEF_NOME" DataValueField="VER_ASSEF_IND" SelectedValue='<%# Bind("IM_VERSAO") %>' EnableTextSelection="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td style="padding-right: 30px;">
                                                        <div class="fieldviewcaption">Data do Agendamento</div>
                                                        <asp:LinkButton ID="lkVoltarAgenda" runat="server" CssClass="sitebutton blue" Visible='<%# Eval("IM_AGENDA_CONCLUIDO_POR") is DBNull ? false : true %>' OnClick="lkVoltarAgenda_Click">Voltar a agenda ?</asp:LinkButton>                                                        
                                                        <telerik:RadDateTimePicker ID="IM_DTAGENDA" Skin="Web20" Width="200px" runat="server"
                                                            Visible='<%# Eval("IM_AGENDA_CONCLUIDO_POR") is DBNull ? true : false %>' DbSelectedDate='<%# Bind("IM_DTAGENDA", "{0:dd/MM/yyyy HH:mm}") %>'  >
                                                            <Calendar ID="Calendar2" runat="server" EnableKeyboardNavigation="true" />
                                                            <DateInput DateFormat="dd/MM/yyyy HH:mm" DisplayDateFormat="dd/MM/yyyy HH:mm" ToolTip="Date input" Label="" />
                                                        </telerik:RadDateTimePicker>
                                                    </td>
                                                    <td style='<%# Eval("IM_AGENDA_CONCLUIDO_POR") is DBNull ? "": "display: none;" %>'>
                                                        <div class="fieldviewcaption">Agendamento Concluido ?</div>
                                                        <asp:LinkButton ID="lkAgendamento" runat="server" CssClass="sitebutton blue" Visible='<%# Eval("IM_AGENDA_CONCLUIDO_POR") is DBNull ? true : false %>' OnClick="lkAgendamento_Click">Sim</asp:LinkButton><br />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='<%# String.IsNullOrEmpty(Eval("IM_OBS_PEDIDO").ToString()) ? "display: none": "" %>'>
                                            <div class="fieldviewcaption">Observações do Pedido</div>
                                            <asp:Label ID="IM_OBS_PEDIDOLabel" runat="server" Text='<%# Eval("IM_OBS_PEDIDO") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 8px;">
                                            <asp:Label ID="txtPedidoFechado" runat="server" Text='<%# "Pedido Fechado em " + Eval("IM_INICIO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label><br />
                                            <asp:Label ID="txtImplantacaIniciada" runat="server" Text='<%# "Implantação Iniciada em " + Eval("IM_INICIO_IMPLANTACAO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label><br />
                                            <asp:Label ID="txtTermino" Visible='<%# Eval("IM_TERMINO") is DBNull ? false : true  %>' runat="server" Text='<%# "Término " + Eval("IM_TERMINO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='<%# String.IsNullOrEmpty(Eval("CAD_OBS").ToString()) ? "display: none": "" %>'>
                                            <div class="fieldviewcaption">Observações do cadastro</div>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("CAD_OBS") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top">
                                <table class="formviewtableinner" style="width: 200px;" boder="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Andamento da
                                                <br />
                                                Implantação
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:RadioButtonList ID="RdbStatusAndamento" runat="server" DataSourceID="sqlAssepontoStatusAndamento"
                                                DataTextField="STAT_NOME" DataValueField="STAT_IND" SelectedValue='<%# Bind("IM_ANDAMENTO")  %>'
                                                RepeatDirection="Vertical" RepeatLayout="Flow" Width="340px">
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>
        </div>
        <div class="sitecorpoboxbottom">
            <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton blue">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Atualizar Dados</asp:LinkButton>
            
            <asp:LinkButton ID="btFinalizar" runat="server" CssClass="sitebutton" OnClick="btFinalizar_Click"
                OnClientClick="return confirmarfinalizar();" BackColor="Crimson">Finalizar Implantação</asp:LinkButton>
            
            <asp:LinkButton ID="btExcluir" runat="server" CssClass="sitebutton" OnClick="btExcluir_Click"
                OnClientClick="return confirmarExcluir();" Visible="false" BackColor="Gray">Excluir Implantação</asp:LinkButton>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlImplantacoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        DeleteCommand="DELETE FROM AssepontoImplantacoes WHERE IM_IND = @IM_IND"
        SelectCommand="SELECT REV_RAZAOSOCIAL, PED_DATA, IM_DTAGENDA, IM_AGENDA_CONCLUIDO_POR, IM_TECNICO, IM_VERSAO, IM_INICIO_IMPLANTACAO,
            IM_INICIO, IM_TERMINO, dbo.fn_texttohtmltext(IM_OBS_PEDIDO) AS IM_OBS_PEDIDO, IM_OBS, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF,
            CAD_RAZAOSOCIAL, CAD_EMAIL, CAD_SKYPE, CAD_TELEFONE1, CAD_TELEFONE2, CAD_TELEFONE1_DDD, CAD_TELEFONE2_DDD, CAD_CONTATO, CAD_OBS, CAD_EMAIL2, 
            IM_REP_FABRICANTE, IM_ANDAMENTO, IM_MODELOREP, IM_IND,
        (CASE WHEN (SELECT TOP 1 (CASE WHEN MNT_CANCELADO = 1 THEN NULL ELSE MNT_REVENDA END) FROM AssepontoManutencao WHERE REV_IND = MNT_REVENDA ORDER BY MNT_DATA DESC) IS NULL THEN '' ELSE REV_CNPJ END) AS REV_CNPJ
            FROM AssepontoImplantacoes
            INNER JOIN AssepontoPedidosRevendas ON PED_IND = IM_PEDIDO 
            INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE 
            INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA 
            WHERE IM_IND = @IM_IND"
        UpdateCommand="UPDATE AssepontoImplantacoes SET IM_DTAGENDA = @IM_DTAGENDA, IM_TECNICO = @IM_TECNICO, IM_VERSAO = @IM_VERSAO, IM_TERMINO = @IM_TERMINO, 
        IM_OBS = @IM_OBS, IM_REP_FABRICANTE = @IM_REP_FABRICANTE, IM_MODELOREP = @IM_MODELOREP, IM_ANDAMENTO = @IM_ANDAMENTO
        WHERE IM_IND = @IM_IND"
        OnInserted="sqlImplantacoes_Updated" OnUpdated="sqlImplantacoes_Updated">
        <SelectParameters>
            <asp:QueryStringParameter Name="IM_IND" Type="Int32" QueryStringField="ind" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="IM_IND" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="IM_DTAGENDA" Type="DateTime" />
            <asp:Parameter Name="IM_TECNICO" Type="Byte" />
            <asp:Parameter Name="IM_VERSAO" Type="Byte" />
            <asp:Parameter Name="IM_TERMINO" Type="DateTime" />
            <asp:Parameter Name="IM_OBS_PEDIDO" Type="String" Size="-1" />
            <asp:Parameter Name="IM_OBS" Type="String" Size="-1" />
            <asp:Parameter Name="IM_REP_FABRICANTE" Type="Byte" />
            <asp:Parameter Name="IM_ANDAMENTO" Type="Int32" />
            <asp:Parameter Name="IM_MODELOREP" Type="String" />
            <asp:QueryStringParameter Name="IM_IND" Type="Int32" QueryStringField="ind" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlAssepontoSuporte" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [SUP_IND], [SUP_NOME] FROM [AssepontoSuporte] WHERE [SUP_ATIVO] = 1 ORDER BY [SUP_NOME]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAssefinVersao" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT VER_ASSEF_IND, VER_ASSEF_NOME FROM [AssepontoAssefinVersoes] "></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAssepontoStatusAndamento" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [STAT_IND], [STAT_NOME] FROM [AssepontoImplantacoesStatus] ORDER BY STAT_NOME"></asp:SqlDataSource>
</asp:Content>
