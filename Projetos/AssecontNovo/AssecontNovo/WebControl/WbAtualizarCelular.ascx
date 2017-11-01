<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WbAtualizarCelular.ascx.cs" Inherits="AssecontNovo.WebControl.WbAtualizarCelular" %>

<a href="javaScript: void(0)" onclick="Open('Boleto');" id="ButtonBoleto" style="width: 180px; height: 20px;" class="siteButtonBoleto red">Clique aqui para imprimir
</a>
<div id="OpenBoxBoleto" class="OpenBox">
    <div id="OpenFormBoleto" class="OpenForm">
        <div class="seta-cima" style="margin-left: 120px;">
        </div>
        <asp:UpdatePanel ID="UpdateBoleto" runat="server">
            <ContentTemplate>
                <table id="OpenTableBoleto" class="OpenTable" style="width: 100%;">
                    <tr>
                        <td colspan="2">Deseja receber notificações de boleto ?
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="lkSIM" runat="server" CssClass="sitebutton blue" >SIM</asp:LinkButton>
                            <asp:LinkButton ID="lkNAO" runat="server" CssClass="sitebutton red" >NÃO</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="tableg"><span class="titulo">Celular:</span>
                            <br />
                            <asp:TextBox ID="txtxCelDDD" runat="server" CssClass="textbox" Width="50" Text='<%# Bind("CEL_DDD") %>'></asp:TextBox>
                            <asp:TextBox ID="txtCelular" runat="server" CssClass="textbox" Width="100" Text='<%# Bind("CEL") %>'></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</div>

<script language="javascript" type="text/javascript">
    function OpenAtualizar() {
        var button = $('#OpenButtonHelp');
        var box = $('#OpenBoxHelp');
        var form = $('#OpenFormHelp');

        button.removeAttr('href');

        if (!button.hasClass('active'))
            box.toggle();

        form.mouseup(function () {
            return false;
        });

        $(this).mouseup(function (login) {
            if (!($(login.target).parent(button).length > 0)) {
                button.removeClass('active');
            }
        });
    }

    OpenAtualizar();
</script>
