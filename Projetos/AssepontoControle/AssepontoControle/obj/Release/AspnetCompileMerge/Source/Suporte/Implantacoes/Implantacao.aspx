<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Implantacao.aspx.cs" Inherits="Asseponto.Suporte.Implantacoes.Implantacao1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <script type="text/javascript" src="../../Scripts/Scripts.js"></script>
    <link href="../../Skins/Window.flv.css" rel="stylesheet" />
    <script type="text/javascript">
        function confirmarExcluir(agenda) {
            if (agenda) {
                return (window.confirm('A implantação está com a Agenda ativa! \n ' +
                                       'Ela será desativada com a exclusão da implantação! \n' +
                                       '<b>Confirma a exclusão?\n'))
            }
            else {
                return (window.confirm('Confirma a exclusão da implantação?'))
            }
        }
        function confirmarfinalizar(agenda) {
            if (agenda) {
                return (window.confirm('ATENÇÃO: \n' + 
                                       ' - A implantação está com a Agenda ativa! Ela será desativada \n' +
                                       ' - Status da implantação NÃO será mais alterado! \n' +
                                       'Confirma a finalização da implantação?\n'))
            }
            else {
                return (window.confirm('Status da implantação estão de acordo? Confirma a finalização da implantação?'))
            }
        }
        function confirmarEnviaEmail() { return (window.confirm('Enviar email de implantação finalizada?')) }
    </script>

    <script type="text/javascript">
        function OpenAgendar(id) {
            var oWnd1 = $find("<%= RadWindowAgendar.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl("AgendarRetorno.aspx?ind=" + id);
            oWnd1.show();
        }

        function RefreshParentPage() {
            document.location.reload();
        }
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
                <telerik:RadMenuItem runat="server" Text="E-mail 60 Dias" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="E-mail Primeiro Contato" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Agendar Treinamento" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Cadastro" NavigateUrl="#">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" Text="Agenda" NavigateUrl="#">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">

    <telerik:RadWindowManager ID="RWM_Agendar" runat="server" EnableShadow="true" ReloadOnShow="true" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAgendar" runat="server" EnableEmbeddedSkins="false" Skin="flv" VisibleTitlebar="true" Title="Agendar"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="380" Width="520" Behaviors="None">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

   <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DefaultMode="Edit" DataKeyNames="IM_IND" DataSourceID="sqlImplantacoes">
                <EditItemTemplate>
                    <wr:Alerta runat="server" ID="Alerta" revenda='<%# Eval("REV_CNPJ") %>' cnpj_cpf='<%# Eval("CNPJ_CPF")  %>' />
                    <table class="formviewtable" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <table style="width: 450px;" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <div style='<%# Convert.ToBoolean(Eval("REV_COBRAR_CLIENTES")) ? "display: none;" : " background: #FFC961; width: 95%;  text-align: center; padding: 6px; margin: 0px auto 5px auto" %>'>
                                                <asp:Label ID="lbRevendaMaster" runat="server" ForeColor="#545454" Font-Size="11pt" Text="REVENDA GOLD MASTER" />
                                            </div>
                                        </td>
                                    </tr>
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
                                            <asp:Label ID="lbSkype" runat="server" Text='<%# Eval("CAD_SKYPE") %>'></asp:Label>
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
                                        <td style='<%# !string.IsNullOrEmpty(Eval("IM_DTAGENDA").ToString()) ? "": "display: none;"  %>'>
                                            <div class="fieldviewcaption">Agenda</div>
                                            <asp:Label ID="lbAgenda" runat="server" Text='<%# "Retorno do contato agendado em " + Eval("IM_DTAGENDA", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                            <asp:Label ID="Label1" runat="server" Text='<%# "por " + Eval("AGENDADO_POR") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div style='float: left; <%# string.IsNullOrEmpty(Eval("IM_DTAGENDA").ToString()) ? "": "display: none;"  %>'>
                                                <a id="btnAgendar" runat="server" class="sitebutton blue" onclick='<%# "OpenAgendar(" + Eval("IM_IND") + ");" %>'>Agendar
                                                   <img src="../../Images/24x24/CalendarDate24x24.png" />
                                                </a>
                                                <asp:HiddenField ID="HiddenUrl" runat="server" Value='<%# RadWindowAgendar.NavigateUrl = "AgendarRetorno.aspx?ind=" + Eval("IM_IND").ToString() %>' />
                                            </div>
                                            <div style='float: left; <%# Convert.ToBoolean(Eval("AGENDA")) ? "" : "display: none;" %>'>
                                                <%--<asp:HyperLink ID="btnHistoricoAgenda" CssClass="sitebutton" runat="server" NavigateUrl='~/Suporte/Implantacoes/Agenda.aspx?ind=<%# Eval("IM_IND").ToString() %>'>Histórico</asp:HyperLink>--%>
                                                <asp:LinkButton ID="btnHistoricoAgenda" CssClass="sitebutton" OnClick="btnHistoricoAgenda_Click" runat="server">Histórico</asp:LinkButton>
                                            </div>
                                            <div style='float: left; <%# !string.IsNullOrEmpty(Eval("IM_DTAGENDA").ToString()) ? "": "display: none;"  %>'>
                                                <asp:LinkButton ID="btnFinalizarAgenda" runat="server" CssClass="sitebutton" BackColor="Gray" OnClick="btnFinalizarAgenda_Click">Finalizar Agenda</asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Versão</div>
                                            <telerik:RadComboBox ID="COMBOBOX_VERSAO" runat="server" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="sqlAsseponto4Versoes"
                                                EmptyMessage="Selecione uma versão" DataTextField="VERS4_DESCRICAO" DataValueField="VERS4_COD" SelectedValue='<%# Bind("IM_VERSAO") %>' EnableTextSelection="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Fabricante REP</div>
                                            <telerik:RadComboBox ID="REP_FABRICANTE" runat="server" Skin="flv" EnableEmbeddedSkins="false" DataSourceID="SqlAssepontoRepFabricantes"
                                                EmptyMessage="Selecione o REP" DataTextField="FABR_NOME" DataValueField="FABR_COD" SelectedValue='<%# Bind("IM_REP_FABRICANTE") %>' EnableTextSelection="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">Modelo do REP</div>
                                            <asp:TextBox ID="txtModelo" runat="server" Text='<%# Bind("IM_MODELOREP") %>' Width="250" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style='<%# String.IsNullOrEmpty(Eval("PED_PLANILHA_EXTENSAO").ToString()) ? "display: none;": "padding-top: 15px; " %>'>
                                            <div class="fieldviewcaption">Planilha de Funcionarios do cliente</div>
                                            <asp:LinkButton ID="lkPlanilha" CausesValidation="false" OnClick="lkPlanilha_Click" runat="server" CssClass="sitebutton blue">Baixar Planilha</asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 10px;">
                                            <div class="fieldviewcaption">Informações do Pedido</div>
                                            <asp:Label ID="Label15" runat="server" Text='<%# "Data do pedido " + Eval("PED_DATA", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label><br />
                                            <asp:Label ID="Label11" runat="server" Text='<%# "Pedido fechado em " + Eval("IM_INICIO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label><br />
                                            <asp:Label ID="Label12" runat="server" Visible='<%# Eval("IM_INICIO_IMPLANTACAO") is DBNull ? false : true  %>' Text='<%# "Implantação Iniciada em " + Eval("IM_INICIO_IMPLANTACAO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label><br />
                                            <asp:Label ID="Label13" runat="server" Visible='<%# Eval("IM_TERMINO") is DBNull ? false : true  %>' Text='<%# "Término " + Eval("IM_TERMINO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='<%# String.IsNullOrEmpty(Eval("IM_OBS_PEDIDO").ToString()) ? "display: none": "" %>'>
                                            <div class="fieldviewcaption">Observações do Pedido</div>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("IM_OBS_PEDIDO") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='<%# String.IsNullOrEmpty(Eval("CAD_OBS").ToString()) ? "display: none": "" %>'>
                                            <div class="fieldviewcaption">Observações do cadastro</div>
                                            <asp:Label ID="Label14" runat="server" Text='<%# Eval("CAD_OBS") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top">
                                <table style="width: 200px; min-height: 150px; border-left: 2px solid #E2E2E2;" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="padding-left: 8px;" class="fieldviewcaption">Andamento da Implantação</td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 10px;">
                                            <asp:RadioButtonList ID="RdbStatusAndamento" runat="server" DataSourceID="sqlAssepontoStatusAndamento"
                                                DataTextField="STAT_NOME" DataValueField="STAT_IND" SelectedValue='<%# Bind("IM_ANDAMENTO")  %>'
                                                RepeatDirection="Vertical" RepeatLayout="Flow" Width="340px">
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style='<%# Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) != 5 &&
                                                       Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) != 9 ? "display: none;": "padding-top: 20px; " %>'>
                                            <table>
                                                <tr>
                                                    <td class="fieldviewcaption" style="padding-left: 8px;">
                                                        <%# Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) == 5 ? "Motivo Retorno Cliente" : "" %>
                                                        <%# Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) == 9 ? "Status Agendamento" : "" %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 10px;">
                                                        <%--<asp:RadioButtonList ID="RadioButtonStatusRetorno" runat="server" DataSourceID="sqlAssepontoStatusRetorno"
                                                            DataTextField="TIPO_STAT_NOME" DataValueField="TIPO_STAT_IND" SelectedValue='<%# Bind("IM_ANDAMENTO_TIPO")  %>'
                                                            RepeatDirection="Vertical" RepeatLayout="Flow" Width="340px">
                                                        </asp:RadioButtonList>--%>
                                                        
                                                        <%--<asp:RadioButtonList ID="RadioButtonStatusRetorno" runat="server" RepeatDirection="Vertical" 
                                                            RepeatLayout="Flow" Width="340px" >--%>
                                                        <asp:RadioButtonList ID="RadioButtonStatusTipo" runat="server" RepeatDirection="Vertical" 
                                                            RepeatLayout="Flow" Width="340px" >

                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <%--<% if (Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) == 9) { %>--%>
                                        <%--<td style='<%# Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) != 9 ? "display: none;": "padding-top: 20px; " %>'>
                                            <table>
                                                <tr>
                                                    <td class="fieldviewcaption" style="padding-left: 8px;">Status Agendamento</td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 10px;">
                                                        <%--<asp:RadioButtonList ID="RadioButtonStatusAgendamento" runat="server" DataSourceID="sqlAssepontoStatusAgendamento"
                                                            RepeatDirection="Vertical" RepeatLayout="Flow" Width="340px">
                                                        </asp:RadioButtonList>--

                                                        <asp:RadioButtonList ID="RadioButtonStatusAgendamento" runat="server" RepeatDirection="Vertical" 
                                                            RepeatLayout="Flow" Width="340px" >

                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>--%>
                                        <%--<% } %>--%>
                                        <% if (andamentoBool) { %>
                                        <td style='padding-top: 20px'>
                                            <table>
                                                <tr>
                                                    <td class="fieldviewcaption" style="padding-left: 8px;">Email Implantação Finalizada Enviado</td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 10px;">
                                                        <div class="fieldviewcaption">Técnico: </div>
                                                        <asp:Label ID="lbTecnicoEmail" runat="server" Text='<%# Eval("SUP_NOME") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 10px">
                                                        <div class="fieldviewcaption">Data de Envio: </div>
                                                        <asp:Label ID="lbDataEnvio" runat="server" Text='<%# String.IsNullOrEmpty(Eval("IM_EMAIL_ENVIADO_EM").ToString()) ? "" : Convert.ToDateTime(Eval("IM_EMAIL_ENVIADO_EM")).ToString() %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <% } %>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>
        </div>
        <div class="sitecorpoboxbottom">
            <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton blue" OnClick="btSalvar_Click" >
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Atualizar Dados</asp:LinkButton>
            <% if(agendaIsExists) { %>
                <asp:LinkButton ID="btFinalizar" runat="server" CssClass="sitebutton" OnClick="btFinalizar_Click"
                    OnClientClick='return confirmarfinalizar(true);' BackColor="Crimson">Finalizar Implantação</asp:LinkButton>

                <asp:LinkButton ID="btExcluir" runat="server" CssClass="sitebutton" OnClick="btExcluir_Click"
                    OnClientClick="return confirmarExcluir(true);" Visible="false" BackColor="Gray">Excluir Implantação</asp:LinkButton>
            <% } else { %>
                <asp:LinkButton ID="btFinalizar1" runat="server" CssClass="sitebutton" OnClick="btFinalizar_Click"
                    OnClientClick='return confirmarfinalizar(false);' BackColor="Crimson">Finalizar Implantação</asp:LinkButton>
            
                <asp:LinkButton ID="btExcluir1" runat="server" CssClass="sitebutton" OnClick="btExcluir_Click"
                    OnClientClick="return confirmarExcluir(false);" Visible="false" BackColor="Gray">Excluir Implantação</asp:LinkButton>

            <% } %>

            <asp:LinkButton ID="btEnviaEmail" runat="server" CssClass="sitebutton" OnClick="btEnviaEmail_Click"
                OnClientClick="return confirmarEnviaEmail();" Visible="false" BackColor="YellowGreen">
                    <% if (andamentoBool){ %>Enviar Email Novamente <% } %>
                    <% else { %>Enviar Email <% } %>
            </asp:LinkButton>

            <asp:Label ID="lbErroMail" runat="server" Text="" ForeColor="Red" Font-Size="Larger"></asp:Label>
        </div>
    </div>
    <%--        UpdateCommand="UPDATE AssepontoImplantacoes SET IM_TECNICO = @IM_TECNICO, IM_VERSAO = @IM_VERSAO, IM_TERMINO = @IM_TERMINO, IM_ANDAMENTO_TIPO =  @IM_ANDAMENTO_TIPO,
            IM_OBS = @IM_OBS, IM_REP_FABRICANTE = @IM_REP_FABRICANTE, IM_MODELOREP = @IM_MODELOREP, IM_ANDAMENTO = @IM_ANDAMENTO
            WHERE IM_IND = @IM_IND"
            <asp:Parameter Name="IM_ANDAMENTO_TIPO" Type="Int32" />
            <asp:Parameter Name="IM_ANDAMENTO" Type="Byte" />--%>
    <asp:SqlDataSource ID="sqlImplantacoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT REV_RAZAOSOCIAL, (CASE WHEN EXISTS(SELECT * FROM AssepontoImplantacoesAgenda WHERE AGE_IMPLANTACAO = IM_IND) THEN 1 ELSE 0 END) AS AGENDA, 
                           (CASE WHEN REV_COBRAR_CLIENTES IS NULL THEN 1 ELSE REV_COBRAR_CLIENTES END) AS REV_COBRAR_CLIENTES, 
                           PED_PLANILHA_EXTENSAO, PED_DATA, IM_DTAGENDA, IM_ANDAMENTO_TIPO,IM_CLIENTE, IM_TECNICO, IM_VERSAO, 
	                       dbo.fn_asseponto_datetostr(IM_INICIO) AS IM_INICIO, IM_INICIO_IMPLANTACAO, IM_TERMINO, 
                           dbo.fn_texttohtmltext(IM_OBS_PEDIDO) AS IM_OBS_PEDIDO, IM_OBS, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF, CAD_RAZAOSOCIAL, 
	                       CAD_EMAIL, CAD_SKYPE, CAD_TELEFONE1, CAD_TELEFONE1_DDD, CAD_CONTATO, CAD_OBS, CAD_EMAIL2, IM_REP_FABRICANTE, IM_ANDAMENTO, 
	                       IM_MODELOREP, IM_IND, CAD_TELEFONE2, CAD_TELEFONE2_DDD, 
                         (SELECT SUP_NOME FROM AssepontoSuporte WHERE IM_AGENDADO_POR = SUP_IND) AS AGENDADO_POR, IM_IMPLANTACAO_ATUALIZADO_POR,
                         (CASE WHEN 
		                    (SELECT TOP 1 
			                    (CASE WHEN MNT_CANCELADO = 1 THEN NULL ELSE MNT_REVENDA END) 
		                    FROM AssepontoManutencao WHERE REV_IND = MNT_REVENDA ORDER BY MNT_DATA DESC)
	                      IS NULL THEN '' ELSE REV_CNPJ END) AS REV_CNPJ,
	                      ISNULL(SUP_NOME, '') as SUP_NOME, isnull(cast(IM_EMAIL_ENVIADO_EM as varchar), '') as IM_EMAIL_ENVIADO_EM, IM_STATUS
                        FROM AssepontoImplantacoes
                        INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE
                        LEFT JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA 
                        LEFT JOIN AssepontoPedidosRevendas ON PED_IND = IM_PEDIDO
	                    LEFT JOIN AssepontoSuporte on SUP_IND = IM_ENVIA_EMAIL_POR
                        WHERE IM_IND = @IM_IND"


        UpdateCommand="UPDATE AssepontoImplantacoes SET IM_TECNICO = @IM_TECNICO, IM_VERSAO = @IM_VERSAO, IM_TERMINO = @IM_TERMINO,
            IM_OBS = @IM_OBS, IM_REP_FABRICANTE = @IM_REP_FABRICANTE, IM_MODELOREP = @IM_MODELOREP
            WHERE IM_IND = @IM_IND"

        OnInserted="sqlImplantacoes_Updated" OnUpdated="sqlImplantacoes_Updated">

        <SelectParameters>
            <asp:QueryStringParameter Name="IM_IND" Type="Int32" QueryStringField="ind" />
        </SelectParameters>

        <UpdateParameters>
            <asp:Parameter Name="IM_TECNICO" Type="Byte" />
            <asp:Parameter Name="IM_VERSAO" Type="Byte" />
            <asp:Parameter Name="IM_TERMINO" Type="DateTime" />
            <asp:Parameter Name="IM_OBS_PEDIDO" Type="String" Size="-1" />
            <asp:Parameter Name="IM_OBS" Type="String" Size="-1" />
            <asp:Parameter Name="IM_REP_FABRICANTE" Type="Byte" />
            <asp:Parameter Name="IM_MODELOREP" Type="String" />
            <asp:QueryStringParameter Name="IM_IND" Type="Int32" QueryStringField="ind" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlAssepontoSuporte" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT SUP_IND, SUP_NOME FROM AssepontoSuporte WHERE SUP_ATIVO = 1 ORDER BY SUP_NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlAsseponto4Versoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT VERS4_COD, VERS4_DESCRICAO FROM Asseponto4Versoes"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlAssepontoRepFabricantes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT FABR_COD, FABR_NOME FROM AssepontoRepFabricantes WHERE FABR_ATIVO = 1 ORDER BY FABR_NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlAssepontoStatusAndamento" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT STAT_IND, STAT_NOME FROM AssepontoImplantacoesStatus ORDER BY STAT_NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlAssepontoStatusRetorno" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT TIPO_STAT_IND, TIPO_STAT_NOME FROM AssepontoImplantacoesStatusTipo where TIPO_STAT_STATUS = 5 ORDER BY TIPO_STAT_NOME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlAssepontoStatusAgendamento" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT TIPO_STAT_IND, TIPO_STAT_NOME FROM AssepontoImplantacoesStatusTipo where TIPO_STAT_STATUS = 9 ORDER BY TIPO_STAT_NOME"></asp:SqlDataSource>
</asp:Content>
