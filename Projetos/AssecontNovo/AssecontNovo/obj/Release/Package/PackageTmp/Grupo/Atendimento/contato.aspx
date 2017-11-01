<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="contato.aspx.cs" Inherits="AssecontNovo.Grupo.Atendimento.Contato" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuLeftAtendimento runat="server" ID="MenuLeftAtendimento" />
    <table style="padding-top: 15px;">
        <tr>
            <td style="padding-right: 30px;" valign="top">
                <style type="text/css">
                    .titulo_liksRapidos
                    {
                        background-color: #CCCCCC;
                        box-shadow: -1px 1px 2px #A7ABB4;
                    }

                    .tableContact td
                    {
                        padding-top: 20px;
                    }
                </style>
                <table class="liksRapidos" border="0" cellpadding="5" cellspacing="0" width="491">
                    <tr>
                        <td>TRONCO </td>
                        <td>11 2173 8888</td>
                    </tr>
                    <tr>
                        <td>FAX  </td>
                        <td>11 2173 8893</td>
                    </tr>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">RECURSOS HUMANOS</td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>Marcela Barreto</b>
                            <br />
                            11 2173 8884<br />
                            E-mail: rh@assecont.com.br
                        </td>
                    </tr>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">DEPTO PESSOAL</td>
                    </tr>
                    <asp:Literal ID="LiteralPessoal" runat="server"></asp:Literal>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">DEPTO LEGALIZAÇÃO</td>
                    </tr>
                    <asp:Literal ID="LiteralLegalizacao" runat="server"></asp:Literal>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">DEPTO FISCAL</td>
                    </tr>
                    <asp:Literal ID="LiteralFiscal" runat="server"></asp:Literal>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">DEPTO CONTABIL</td>
                    </tr>
                    <asp:Literal ID="LiteralContabil" runat="server"></asp:Literal>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">SUPORTE</td>
                    </tr>
                    <asp:Literal ID="LiteralSuporte" runat="server"></asp:Literal>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">GED</td>
                    </tr>
                    <asp:Literal ID="LiteralGed" runat="server"></asp:Literal>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">FINANCEIRO</td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>Débora Marques</b>
                            <br />
                            11 2173 8855<br />
                            E-mail: debora@assecont.com.br
                        </td>
                    </tr>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">DIRETORIA</td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>Valdemir Fontes </b>
                            <br />
                            11 2173 8877<br />
                            E-mail: valdemir@assecont.com.br
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>Valmir Junior</b>
                            <br />
                            Tel: 11 2173 8860          
                            <br />
                            E-mail: valmirreis@assecont.com.br
                        </td>
                    </tr>
                    <tr>
                        <td class="titulo_liksRapidos" colspan="2">COMERCIAL</td>
                    </tr>
                    <asp:Literal ID="LiteralComercial" runat="server"></asp:Literal>
                    <%--<tr>
                        <td colspan="2"><b>Maria Caroline</b>
                            <br />
                            Tel: 11 2173 8872
                            <br />
                            E-mail: mariac@assecont.com.br
                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2" class="titulo_liksRapidos">CONTROLLER</td>
                    </tr>
                    <tr>
                        <td colspan="2"><b>Valmir Fontes</b>
                            <br />
                            Tel: 11 2173 8899
                            <br />
                            E-mail: valmir@assecont.com.br
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
