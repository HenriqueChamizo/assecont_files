<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WbHeader.ascx.cs" Inherits="AssecontNovo.WebControl.WbHeader" %>

<link href="/Skins/Window.flv.css" rel="stylesheet" />

<script type="text/javascript">
    function OpenloginAntigo() {
        var oWnd1 = $find("<%= RadWindowloginAntivo.ClientID %>");
        oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
        oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
        //oWnd1.setUrl("http://www.assecont.com.br/Avisos/AvisoManutencao.html");
        oWnd1.setUrl("http://www.assecont.com.br/assecontwebnovo/parts/loginantigo.aspx");
        oWnd1.show();
    }


</script>

<section id="SectionLog">
    <asp:UpdatePanel ID="UpdateNav" runat="server" class="tableNav">
        <ContentTemplate>
            <table style="text-align: left;">
                <tr>
                    <td>Acesso
                    </td>
                    <td>
                        <telerik:RadComboBox ID="RadComboxAcesso" runat="server" Width="150" AutoPostBack="true" 
                          EnableEmbeddedSkins="false" Skin="flv" CausesValidation="false" OnSelectedIndexChanged="RadComboxAcesso_SelectedIndexChanged">
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <div id="Logins" runat="server">
                        </div>
                    </td>
                    <td>
                        <asp:LinkButton ID="login" runat="server" CausesValidation="false" Style="background: #336CAB; cursor: pointer; color: white; padding: 2px 2px 3px 5px;" OnClick="login_Click">Entrar  </asp:LinkButton> &nbsp;&nbsp;| 
                    </td>
                    <td>
                        <a id="lkLoginAntigo" runat="server" style="color: #427fed; cursor: pointer; border: 0px;" href="http://www.assecont.com.br/Assecontwebnovo/login.aspx">Esqueci minha senha </a>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</section>

<telerik:RadWindowManager ID="RWM_loginAntivo" runat="server" EnableShadow="true" ReloadOnShow="True" AutoSizeBehaviors="Default">
    <Windows>
        <telerik:RadWindow ID="RadWindowloginAntivo" runat="server" EnableEmbeddedSkins="false" Skin="flv" Title="Atualização de Acesso" VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false"
            Modal="true" Height="400" Width="480" Behaviors="Close">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>

<script language="javascript" type="text/javascript">
    function CookieAcesso(value) {
        var button = $('#OpenButtonBemVindo');
        var box = $('#OpenBoxBemVindo');
        var form = $('#OpenFormBemVindo');

        var help = readCookie("BemVindoAssec");

        if (help == null || help == "") {
            box.toggle();
        }

        if (value == 1) {
            var now = new Date();
            var time = now.getTime();
            time += 3600 * 24000;
            now.setTime(time);

            document.cookie = "BemVindoAssec=" + value + ";expires=" + now.toUTCString() + "; path=/";
            //OpenHelp();
        }

        $(this).mouseup(function (login) {
            if (!($(login.target).parent(button).length > 0)) {
                button.removeClass('active');
            }
        });
    }

    //CookieAcesso();

    function readCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    function OpenHelp() {
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


</script>
