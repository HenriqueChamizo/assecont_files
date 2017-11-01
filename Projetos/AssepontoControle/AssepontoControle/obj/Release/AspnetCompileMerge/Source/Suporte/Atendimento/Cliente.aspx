<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Cliente.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.Cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <style>
        .fieldviewcaption
        {
            text-transform: uppercase;
        }
    </style>
    <script type="text/javascript" id="telerikClientEvents1">
        //<![CDATA[

        function RadMenu2_ItemClicking(sender, args) {
            var item = args.get_item().get_text();

            if (item == "Questionario Treinamento") {
                args.set_cancel(!window.confirm("Deseja enviar o questionario de treinamento ?"));
            }
        }
        //]]>
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu2" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu2_ItemClick" OnClientItemClicking="RadMenu2_ItemClicking">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Nova Pendência" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Pendências em Aberto" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Pendências Solucionadas" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Questionario Treinamento" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Senhas" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Cadastro" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Marcar como finalizado" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Ir para implantação" NavigateUrl="#" />
                <telerik:RadMenuItem runat="server" Text="Agendar Treinamento" NavigateUrl="#" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">

    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <div id="implantacao" runat="server" style="background-color: #36A1F5; width: 585px; text-align: center; padding: 6px;">
                <asp:Label ID="lbImplatacao" runat="server" Font-Size="11pt" ForeColor="White">IMPLANTACAÇÃO </asp:Label>
            </div>
            <flv:CadastroAssefin runat="server" ID="CadastroAssefin" />

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="CAD_IND" DefaultMode="ReadOnly" DataSourceID="sqlClientes" Width="600">
                <ItemTemplate>
                    <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                        <div style='<%# Convert.ToBoolean(Eval("REV_COBRAR_CLIENTES")) ? "display: none;": " background: #FFC961; width: 585px;  text-align: center; padding: 6px;" %>'>
                            <asp:Label ID="lbRevendaMaster" runat="server" ForeColor="#545454" Font-Size="11pt" Text="REVENDA GOLD MASTER" />
                        </div>
                        <table class="formviewtable" style="width: 100%;">
                            <tr>
                                <td>
                                    <table class="formviewtableinner" style="width: 100%;">
                                        <tr>
                                            <td colspan="3" style="padding-top: 8px;">
                                                <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                                    Cliente 
                                                </div>
                                                <div class="fieldviewtext">
                                                    <asp:Label ID="Label12" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>' />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="padding-top: 5px;">
                                                <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                                    Revenda 
                                                </div>
                                                <div class="fieldviewtext">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("REV_RAZAOSOCIAL") %>' />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="padding-top: 5px;">
                                                <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                                    Contatos
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="padding-top: 5px;">
                                                <div class="fieldviewtext">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td colspan="2" style="text-transform: capitalize;">
                                                                <asp:Label ID="lbContato1" runat="server" Text='<%# Eval("CAD_CONTATO") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 250px">
                                                                <asp:Label ID="lbTelefone1" runat="server" Text='<%# Eval("CAD_TELEFONE1_DDD") + " " + Eval("CAD_TELEFONE1") %>' />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lbEmail1" runat="server" Text='<%# Eval("CAD_EMAIL") %>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="padding-top: 5px;">
                                                <div class="fieldviewtext">
                                                    <table>
                                                        <tr>
                                                            <td colspan="2" style="text-transform: capitalize;">
                                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("CAD_CONTATO2") %>' />
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td style="width: 250px">
                                                                <asp:Label ID="Label7" runat="server" Text='<%#  Eval("CAD_TELEFONE2_DDD") + " " + Eval("CAD_TELEFONE2") %>' />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("CAD_EMAIL2") %>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style='<%# String.IsNullOrEmpty(Eval("CAD_CONTATO3").ToString()) ? "display: none;": "padding-top: 5px;" %>'>
                                                <div class="fieldviewtext">
                                                    <table>
                                                        <tr>
                                                            <td colspan="2" style="text-transform: capitalize;">
                                                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("CAD_CONTATO3") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 250px">
                                                                <asp:Label ID="Label10" runat="server" Text='<%#  Eval("CAD_TELEFONE3_DDD") + " " + Eval("CAD_TELEFONE3") %>' />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("CAD_EMAIL3") %>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="3" style="padding-top: 5px;">
                                                <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                                    Comercial
                                                </div>
                                                <div class="fieldviewtext">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td style="min-width: 250px">
                                                                <asp:Label ID="Label5" runat="server" Text='<%# "Quantidade de Funcionarios: " + Eval("CAD_QTD_FUNCIONARIO")  %>' />
                                                            </td>
                                                            
                                                            <asp:Panel ID="Panel3" runat="server" Visible='<%# Convert.ToBoolean(Eval("VISIBLE")) %>'>
                                                                <td style="text-align: right">
                                                                    <asp:Button ID="btnEnviaComercial" runat="server" Text="Enviar p/ Comercial" OnClick="btnEnviaComercial_Click" 
                                                                        Enabled='<%# !string.IsNullOrEmpty(Eval("ENVIADO").ToString()) ? !string.IsNullOrEmpty(Eval("FECHADO").ToString()) ? true : false : true %>' />
                                                                </td>
                                                            </asp:Panel>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <br />
                                                                <br />
                                                                <asp:Image ID="Image2" runat="server" ImageUrl='<%# !Convert.ToBoolean(Eval("CAD_IMPRESSAO_CERTIFICADO")) ? "~/Images/16x16/close.png" : "~/Images/16x16/TickVerde.png" %>' />
                                                                <asp:Label ID="Label4" runat="server" Text='<%# string.IsNullOrEmpty(Eval("CAD_DTA_CERTIFICADO").ToString()) ? !Convert.ToBoolean(Eval("CAD_IMPRESSAO_CERTIFICADO")) ? "Atestado não emitido " : "Atestado já emitido, mas não enviado " : "Atestado enviado em " + Eval("CAD_DTA_CERTIFICADO", "{0:dd/MM/yyyy}") %>' />
                                                            </td>
                                                            <asp:Panel ID="Panel2" runat="server" Visible='<%# Convert.ToBoolean(Eval("VISIBLE")) %>'>
                                                                <td style="text-align: right">
                                                                    <br />
                                                                    <asp:Label ID="lbEnviadoComercial" runat="server" 
                                                                        Text='<%# !string.IsNullOrEmpty(Eval("ENVIADO").ToString()) ? 
                                                                            !string.IsNullOrEmpty(Eval("FECHADO").ToString()) && !string.IsNullOrEmpty(Eval("COM_FECHADOEM").ToString()) ? 
                                                                                "Enviado: " + Eval("ENVIADO").ToString() + " em " + Convert.ToDateTime(Eval("COM_ENVIADOEM")).ToString("dd/MM/yy hh:mm") + 
                                                                                    ". Fechado: " + Eval("FECHADO") + " em " + Convert.ToDateTime(Eval("COM_FECHADOEM")).ToString("dd/MM/yy hh:mm") + "."  : 
                                                                                "Enviado: " + Eval("ENVIADO").ToString() + " em " + Convert.ToDateTime(Eval("COM_ENVIADOEM")).ToString("dd/MM/yy hh:mm") + ". EM ABERTO." : 
                                                                                "NUNCA FOI ENVIADO." %>' />
                                                                </td>
                                                            </asp:Panel>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="padding-top: 5px;">
                                                <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                                    REP
                                                </div>
                                                <div class="fieldviewtext">
                                                    <asp:Label ID="Label2" runat="server" Text='<%# !(bool)Eval("CAD_ASSEPONTO4")? "" : "<b>" + Eval("FABR_NOME") + "</b> - " + Eval("CAD_MODELOREP") %>' />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style='<%# String.IsNullOrEmpty(Eval("CAD_OBS").ToString()) ? "display: none;": "padding-top: 5px;" %>'>
                                                <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                                    Observações
                                                </div>
                                                <div class="fieldviewtext">
                                                    <asp:Label ID="Label3" runat="server" Text='<%# "<b>" + Eval("CAD_OBS") %>' MultiLine='1' />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="padding-top: 8px;">
                                                <wr:Alerta runat="server" ImageUrl="~/Images/48x48/WarningRed.png" Text="Cliente Bloqueado" revenda='<%# Eval("REV_CNPJ") %>' cnpj_cpf='<%# Eval("CAD_CNPJ").ToString()  %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </ItemTemplate>
            </asp:FormView>

            <asp:SqlDataSource ID="sqlClientes" runat="server" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="SELECT CAD_IND, B.SUP_NOME AS TECNICO, B.DIASCORRIDOS, 
                                CAD_CADASTRO_ATUALIZADOEM, CAD_RAZAOSOCIAL, 
                                AssepontoClientes.CAD_IND, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CAD_CNPJ, 
                                CAD_TELEFONE1_DDD, CAD_TELEFONE1, CAD_TELEFONE2_DDD, CAD_TELEFONE2, 
                                CAD_TELEFONE3_DDD, CAD_TELEFONE3, CAD_CONTATO2, CAD_CONTATO3,
                                A.REV_CNPJ, CAD_EMAIL, CAD_SKYPE, CAD_CONTATO, CAD_CELULAR_DDD, CAD_CELULAR, CAD_CELULAR_ACEITA, 
                                CAD_QTD_FUNCIONARIO, (CASE WHEN REV_COBRAR_CLIENTES IS NULL 
						                                    THEN 1 ELSE REV_COBRAR_CLIENTES END) AS REV_COBRAR_CLIENTES,
                                REV_RAZAOSOCIAL, FABR_NOME, CAD_MODELOREP, CAD_OBS, CAD_EMAIL2, CAD_EMAIL3, CAD_DTA_CERTIFICADO, 
                                CAD_IMPRESSAO_CERTIFICADO, VER_ASSEF_NOME, CAD_ASSEFIN, CAD_ASSEPONTO4, 
                                C.ENVIADO, C.COM_ENVIADOEM, C.FECHADO, C.COM_FECHADOEM, 
		                        (CASE WHEN (B.DIASCORRIDOS &lt; 60 AND A.REV_CNPJ = '') OR
                                        (CASE WHEN REV_COBRAR_CLIENTES IS NULL 
				                                THEN 1 ELSE REV_COBRAR_CLIENTES END) = 0
		                                THEN 0 ELSE 1 END) AS VISIBLE  
                                FROM AssepontoClientes 
                                LEFT JOIN AssepontoRevendas ON CAD_REVENDA = REV_IND 
                                LEFT JOIN AssepontoRepFabricantes ON FABR_COD = CAD_REP_FABRICANTE 
                                LEFT JOIN AssepontoAssefinVersoes ON VER_ASSEF_IND = CAD_VERSAO_ASSEFIN
                                OUTER APPLY(
	                                SELECT (CASE WHEN EXISTS(SELECT MNT_IND FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND)
				                                THEN (CASE WHEN (SELECT TOP 1 (CASE WHEN MNT_CANCELADO = 1 
									  				                                THEN NULL 
													                                ELSE MNT_REVENDA 
											                                    END)
								                                    FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC) IS NULL
						                                    THEN '' 
						                                    ELSE REV_CNPJ
					                                    END)
				                                ELSE ''
			                                END) AS REV_CNPJ
                                ) A
                                OUTER APPLY(
	                                SELECT TOP 1 SUP_NOME, DATEDIFF(day, NSE_DATA, GETDATE()) AS DIASCORRIDOS 
                                    FROM AssepontoNSeries 
                                    LEFT JOIN AssepontoSuporte ON SUP_IND = NSE_SUPORTE 
                                    WHERE NSE_CLIENTE = CAD_IND AND NSE_SOLICITACAO = 1 ORDER BY NSE_DATA 
                                ) B
                                OUTER APPLY(
	                                SELECT TOP 1 ENVI.SUP_NOME AS ENVIADO, COM_ENVIADOEM, FECH.SUP_NOME AS FECHADO, COM_FECHADOEM
	                                FROM AssepontoClientesComercial
	                                INNER JOIN ASSEPONTOSUPORTE ENVI ON ENVI.SUP_IND = COM_ENVIADOPOR
	                                LEFT JOIN ASSEPONTOSUPORTE FECH ON FECH.SUP_IND = COM_FECHADOPOR
	                                WHERE COM_CLIENTE = CAD_IND	ORDER BY COM_ENVIADOEM DESC
                                ) C
                                WHERE CAD_IND = @CAD_IND ">
                <SelectParameters>
                    <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <wr:ManutencaoStatus ID="ManutencaoStatus1" runat="server" ViewStateMode="Inherit" EnableViewState="False" />
            <div class="siteseparador">
            </div>
            <wr:PendenciasControl runat="server" ID="pendenciasEmAberto1" Situacao="0" Title="Pendências em Aberto"
                LinkUrl="~/suporte/Atendimento/Pendencia.aspx" ViewStateMode="Disabled"></wr:PendenciasControl>
        </div>
    </div>
</asp:Content>

                <%--SelectCommand="SELECT CAD_IND, (SELECT SUP_NOME FROM AssepontoSuporte WHERE SUP_IND = CAD_CADASTRO_ATUALIZADOPOR) AS TECNICO, CAD_CADASTRO_ATUALIZADOEM, CAD_RAZAOSOCIAL, 
                AssepontoClientes.CAD_IND, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CAD_CNPJ, 
                CAD_TELEFONE1_DDD, CAD_TELEFONE1, CAD_TELEFONE2_DDD, CAD_TELEFONE2, CAD_TELEFONE3_DDD, CAD_TELEFONE3, CAD_CONTATO2, CAD_CONTATO3,
                (CASE WHEN (SELECT TOP 1 (CASE WHEN MNT_CANCELADO = 1 THEN NULL ELSE MNT_REVENDA END) FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC) IS NULL THEN '' ELSE REV_CNPJ END) AS REV_CNPJ,
                CAD_EMAIL, CAD_SKYPE, CAD_CONTATO, CAD_CELULAR_DDD, CAD_CELULAR, CAD_CELULAR_ACEITA, CAD_QTD_FUNCIONARIO, (CASE WHEN REV_COBRAR_CLIENTES IS NULL THEN 1 ELSE REV_COBRAR_CLIENTES END) AS REV_COBRAR_CLIENTES,
                REV_RAZAOSOCIAL, FABR_NOME, CAD_MODELOREP, CAD_OBS, CAD_EMAIL2, CAD_EMAIL3, CAD_DTA_CERTIFICADO, CAD_IMPRESSAO_CERTIFICADO, VER_ASSEF_NOME, CAD_ASSEFIN, CAD_ASSEPONTO4
                FROM AssepontoClientes 
                LEFT JOIN AssepontoRevendas ON CAD_REVENDA = REV_IND 
                LEFT JOIN AssepontoRepFabricantes ON FABR_COD = CAD_REP_FABRICANTE 
                LEFT JOIN AssepontoAssefinVersoes ON VER_ASSEF_IND = CAD_VERSAO_ASSEFIN
                WHERE CAD_IND = @CAD_IND ">--%>
