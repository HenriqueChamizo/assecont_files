<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ForaMasterPage.Master" AutoEventWireup="true" CodeBehind="FormContratoManut.aspx.cs" Inherits="Asseponto.Suporte.Formulario.FormContratoManut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">

    <script type="text/javascript" src="http://www.assecont.com.br/Assepontocontrole/JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>
            <div style="width: 70%; margin-left:auto; margin-right:auto">
                <%--<div style="font-size: 16pt; margin-bottom: 20px" class="titleExterno">Adesão Contrato de Prestação de Serviço</div>--%>

                <asp:Panel ID="panelFunc" runat="server">
                <% if (!avulso) { %>
                    <div style="font-size: 16pt; margin-bottom: 20px" class="titleExterno">Adesão Contrato de Prestação de Serviço</div>
                 <% } else { %>
                    <div style="font-size: 16pt; margin-bottom: 20px" class="titleExterno">Adesão Avulsa de Prestação de Serviço</div>
                <% } %>
                    <table class="width100">
                        <tr>
                            <td>
                                <asp:Label ID="lbCnpj" runat="server" Text="Digite o CNPJ da empresa (somente números)"></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtCnpj" runat="server" requerid="true" MaxLength="14" CssClass="width100"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFieldCnpj" runat="server" SetFocusOnError="true" Display="Dynamic" ControlToValidate="txtCnpj" CssClass="sitevalidator" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="RCustomCnpj" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtCnpj" CssClass="sitevalidator" runat="server" ErrorMessage="CNPJ INVALIDO" OnServerValidate="RCustomCnpj_ServerValidate"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbRazaoSocial" runat="server" Text="Digite Razão Social: "></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtRazaoSocial" runat="server" MaxLength="200" CssClass="width100"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFieldRazaoSocial" runat="server" SetFocusOnError="true" ControlToValidate="txtRazaoSocial" CssClass="sitevalidator" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbFuncionario" runat="server" Text="Digite a quantidade de funcionarios: "></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtQtd" runat="server" MaxLength="4" CssClass="width100"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RFieldsQtd" runat="server" Display="Dynamic" ControlToValidate="txtQtd" CssClass="sitevalidator" ErrorMessage="Obrigatório"></asp:RequiredFieldValidator>

                                <asp:CustomValidator ID="RCustomQtd" Display="Dynamic" ControlToValidate="txtQtd" CssClass="sitevalidator2" runat="server" ErrorMessage="Por favor, consultar o nosso Comercial Tel: 11 2173 8860" OnServerValidate="RCustomQtd_ServerValidate"></asp:CustomValidator>
                            </td>
                        </tr>
                    </table>
                    <table class="width100">
                        <tr style="column-count: 1">
                            <td>
                                <br />
                                <b><asp:Label ID="lbContato" runat="server" Text="Digite os dados para contato: " Visible="false"></asp:Label><br /></b>
                            </td>
                        </tr>
                        <tr style="column-count: 2">
                            <td>
                                <asp:Label ID="lbNome" runat="server" Text="Nome: " Visible="false"></asp:Label><br />
                                <asp:TextBox ID="txtNome" runat="server" MaxLength="200" CssClass="width80" Visible="false"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lbEmail" runat="server" Text="Email: " Visible="false"></asp:Label><br />
                                <asp:TextBox ID="txtEmail" runat="server" MaxLength="200" CssClass="width100" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>
                                <asp:Label ID="lbEmail" runat="server" Text="Email: " Visible="false"></asp:Label><br />
                                <asp:TextBox ID="txtEmail" runat="server" MaxLength="200" CssClass="width100" Visible="false"></asp:TextBox>
                            </td>
                        </tr>--%>
                    </table>
                    <table class="width100">
                        <tr style="display: none">
                            <td>
                                <asp:Label ID="lbPeriodo" runat="server" Text="Selecione o periodo do contrato: "></asp:Label><br />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td>
                                <asp:DropDownList ID="cmbPeriodo" runat="server" CssClass="width100" Height="27"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <br />
                            <br />
                            <td>
                                <asp:Label ID="lbVigencia" runat="server" Text="Vigência no periodo de: " Visible="true"></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:center">
                                <asp:LinkButton ID="lkOK3" runat="server" CssClass="width100 sitebutton" OnClick="lkOK3_Click">3 meses</asp:LinkButton>
                                <asp:LinkButton ID="lkOK6" runat="server" CssClass="width100 sitebutton" OnClick="lkOK6_Click">6 meses</asp:LinkButton>
                                <asp:LinkButton ID="lkOK12" runat="server" CssClass="width100 sitebutton" OnClick="lkOK12_Click">12 meses</asp:LinkButton>
                                <asp:LinkButton ID="lkSolicitar" runat="server" CssClass="width100 sitebutton" Visible="false" OnClick="lkSolicitar_Click">Solicitar</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                                <br />

                                <p><b style="color:red">IMPORTANTE:</b>  Nesse momento esta sendo feito apenas a simulação, consulta das condições para adesão, 
                                    conforme as informações inseridas. Para adesão basta imprimir, e enviar cópia digitalizada, assinada e 
                                    carimbada para <b>"comercial@assecont.com.br"</b>.</p>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>

                
                <asp:Panel ID="panelAvulso" runat="server" Visible="false">
                    <table>
                        <tr>
                            <td>
                                <b style="font-size: 20px"><asp:Label ID="lbRazaoSocialDigitada" runat="server" Text=""></asp:Label><br /></b>
                                <p>A solicitação de <b>Prestação de Serviço Avulso</b> foi efetuada com sucesso! <br />
                                    Em instantes, será enviado para o email informado (<b><asp:Label ID="lbEmailDigitada" runat="server" Text=""></asp:Label></b>) um boleto
                                    para a contratação do serviço.</p>
                                <br />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>

                <asp:Panel ID="panelDescricao" runat="server" Visible="true">
                    <% if (!avulso) { %>
                    <p>Neste momento esta sendo feito apenas a <b>consulta</b> do valor, condições e garantias contratuais. A adesão é feita mediante envio de cópia digitalizada, assinada e carimbada, em seguida enviaremos boleto para confirmação e liberação dos serviços.</p>
                    
                    <br />
                    <br />
                    <p style="font-size: 10pt;">
                        <b style="color: red">OBS: </b>Para adesão por favor assine e carimbe, e envie cópia digitalizada para <a href="mailto:comercial@assecont.com.br">comercial@assecont.com.br </a>
                        em seguida enviamos boleto para confirmação e liberação dos serviços.
                            <br />
                        <br />
                        <b>Grato pela preferência! </b>
                    </p>
                    <% } else { %>
                    <br />
                    <br />
                    <p style="font-size: 10pt;">
                        <b style="color: red">OBS: </b>A contratação avulso é por chamada, após a contratação (mediante comprovação) os técnicos abrem um chamado para atender a sua necessidade, seja ela qual for. Os técnicos apresentam a resolução motivo da contratação, após o término o técnico informa que a chamada será encerrada. Pode-se aproveitar a contratação avulso para tirar outras duvidas ou levantar outras necessidades, além da que gerou o motivo da contratação. A chamada pode ter duração de 10 minutos, 30 minutos , duas horas, enfim, até o término das duvidas ou necessidades, o técnico de suporte encerra somente após a resolução das duvidas e ou necessidades apresentadas.
                            <br />
                        <br />
                        <b>Grato pela preferência! </b>
                    </p>
                    <% } %>
                </asp:Panel>
            </div>

            <div id="impressao" runat="server" style="padding-top: 20px;">
                <flv:ManutencaoContrato runat="server" ID="ManutencaoContrato" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
