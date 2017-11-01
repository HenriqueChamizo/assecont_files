<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="comunicadoHolerite.aspx.cs" Inherits="AssecontNovo.Comunicados.comunicadoHolerite" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <table class="comunicados" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="padding-left: 30px;">Este serviço permite a empresa disponibilizar a seus colaboradores os demonstrativos de salários,
                    <br />
                    adiantamentos, 13º salários e Participações de resultado.<br />
                    <br />
                </td>
            </tr>
            <tr>
                <td style="background-color: #e7dfdc; padding-left: 30px;">
                    <p>Conheça os benefícios</p>
                    <ul>
                        <li><b>Agilidade: </b>os demonstrativos de pagamento ficam disponíveis para as consultas dos funcionários
	                      
                            <br />
                            antes do momento em que o crédito do salário é realizado em conta-corrente.
                        </li>
                        <li><b>Conveniência: </b>os funcionários podem consultar os demonstrativos de pagamento de salários 
	                      
                            <br />
                            pela internet. 
                        </li>
                        <li><b>Segurança: </b>contamos com modernas tecnologias de segurança da informação na guarda e 
	                      
                            <br />
                            disponibilidade dos demonstrativos de pagamento. 
                        </li>
                        <li><b>Redução nos custos: </b>reduz os custos operacionais do RH com a impressão, guarda, 
	                      
                            <br />
                            controle e distribuição física dos demonstrativos de pagamento. 
                        </li>
                        <li><b>Os demonstrativos ficam disponíveis para consulta por 36 meses.</b>
                        </li>
                    </ul>

                    <br />
                    <img src="../Imagens/Comunicado/holeriteExemplo.png" width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Image ID="Imagefooter" runat="server" ImageUrl="../Imagens/Comunicado/footerComunicado.png" Width="970" />
                </td>
            </tr>
        </table>
    </section>
</asp:Content>
