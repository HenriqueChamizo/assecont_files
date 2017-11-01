﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="formularioTreinamento.aspx.cs" Inherits="Asseponto.Suporte.Formulario.formularioTreinamento" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Formulario</title>
    <link href="../../Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="../../Styles/FormView.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="bodywrapper">
        <div id="siteheaderwrapper">
            <div>
                <asp:Image ID="sitetopologotipo" runat="server" ImageUrl="~/Images/Site/Logotipo.png"
                    ImageAlign="Left" />
            </div>
        </div>
        <div id="sitemenuwrapper1">
            <div id="sitemenuwrapper2">
            </div>
        </div>
        <div id="sitecorpoboxinner">
            <table class="formviewtable">
                <tr>
                    <td style="font-size:14px; height: 50px;">
                        Preencha com os dados da empresa no Formulario para garantir sua vaga<br />
                        para o treinamento operacional do software Asseponto4.
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" CssClass="formviewsubtitle">FORMULARIO</asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="formviewtableinner">
                            <tr>
                                <td style="height: 50px">
                                    RAZÃO SOCIAL<br />
                                    <asp:TextBox ID="txtRazaoSocial" runat="server" Width="400px" notnull="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="validator1" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator" ControlToValidate="txtRazaoSocial"></asp:RequiredFieldValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 50px">
                                    CNPJ<br />
                                    <telerik:RadMaskedTextBox runat="server" DisplayMask="##.###.###/####-##" Mask="##.###.###/####-##"
                                        ID="txtCNPJ" MaxLength="20" Width="150px" notnull="true">
                                    </telerik:RadMaskedTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator" ControlToValidate="txtCNPJ"></asp:RequiredFieldValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 50px">
                                    CONTATO<br />
                                    <asp:TextBox ID="txtNome" runat="server" Width="250px" notnull="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator" ControlToValidate="txtNome"></asp:RequiredFieldValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 50px">
                                    E-MAIL<br />
                                    <asp:TextBox ID="txtEmail" runat="server" Width="250px" notnull="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Obrigatorio" CssClass="sitevalidator" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Observações<br />
                                    <asp:TextBox ID="txtOBS" runat="server" Width="400px" TextMode="MultiLine" Height="70px"></asp:TextBox>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 50px">
                                    <br />
                                    <asp:Button ID="btEnviar" runat="server" CssClass="sitebutton blue" Text="ENVIAR" 
                                        onclick="btEnviar_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="siteRodape" style="text-align: center">
        <asp:Label ID="Label2" runat="server" Text=" End.: Rua Mario, 194 - Vila Romana – São Paulo/SP – CEP.: 05048-010 - Tel.: (11)
            2173-8888"></asp:Label>
        <br />
        <asp:Label ID="Label3" runat="server" Text="©2013 Assecont Tecnologia LTDA - Todos os direitos reservados."></asp:Label>
    </div>
    </form>
</body>
</html>