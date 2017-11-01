<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Atestado.aspx.cs" Inherits="Asseponto.Suporte.Relatorios.Atestado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
        <script src="../../JQuery/Impressao.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <asp:LinkButton ID="lkImpressao" runat="server" OnClientClick="JavaScript: imprimePanel('DivImpressao')" OnClick="lkImpressao_Click" CssClass="sitebutton blue"> Imprimir Atestado</asp:LinkButton>
        <br />
        <div style="top: 180px; position: absolute;">
            <div id="DivImpressao">
                <style type="text/css">
                    #AtestadoTecnico
                    {
                        width: 1014px;
                        height: 670px;
                        position: relative;
                    }

                    .imgAtestadoTecnico
                    {
                        top: 0px;
                        bottom: 20px;
                        position: absolute;
                    }

                    .txtAtestadoTecnico
                    {
                        top: 100px;
                        left: 140px;
                        position: absolute;
                    }

                    @media print
                    {
                        *
                        {
                            margin: 0;
                            padding: 0;
                        }

                        .LandscapeDiv
                        {
                            width: 100%;
                            height: 100%;
                            filter: progid:DXImageTransform.Microsoft.BasicImage(Rotation=3);
                        }
                    }
                </style>
                <section id="AtestadoTecnico">
                </section>
                <asp:Image ID="imgAtestado" ImageUrl="http://www.assecont.com.br/assepontocontrole/Images/Site/AtestadoTecnico.png" runat="server" class="imgAtestadoTecnico" Height="685" />
                <div class="txtAtestadoTecnico">
                    <div style="text-align: justify; font-family: Ebrima; font-size: 10pt;">
                        Na qualidade de responsável técnico e de responsável legal do fabricante ASSECONT TECNOLOGIA LTDA EPP, CNPJ
                        <br />
                        13.369.340/0001-36, os signatários abaixo, em atenção ao art. 18 da Portaria 1.510/2009, atestam e declaram que o
                        <br />
                        programa de registro de ponto eletrônico denominado ASSEPONTO versão 4 está em conformidade com a Portaria
                        <br />
                        1.510/2009, e especialmente que não permite:
                        <br />
                        <br />
                        I- alterações no Arquivo Fonte de Dados - AFD; e<br />
                        <br />
                        II - divergências entre o AFD e os demais arquivos e relatórios gerados pelo programa.<br />
                        <br />

                        Declaramos ainda, em atenção ao Parágrafo 1o. do art. 18 da mencionada Portaria, que
                        estamos cientes das
                        <br />
                        consequências legais, cíveis e criminais, quanto à falsa declaração, falso atestado e falsidade ideológica. Reiteramos ao 
                         <br />
                        usuário que este documento deve ficar disponível para pronta apresentação para a Inspeção do Trabalho.
                    </div>

                    <table style="text-align: center; width: 700px; padding-top: 5px;">
                        <tr>
                            <td style="font-family: 'Monotype Corsiva'; font-size: 20pt;">
                                <asp:Label ID="lbRazaoSocial" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-family: 'Mongolian Baiti'; font-size: 12pt;">
                                <asp:Label ID="lbCNPJ" runat="server" Text="" ></asp:Label>
                                <asp:Label ID="lbCPF" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
