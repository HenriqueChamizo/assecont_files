<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Treinamentos._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <link href="../../Styles/Calendario.css" rel="stylesheet" />
    <link href="../../Skins/Window.flv.css" rel="stylesheet" />
    <script type="text/javascript">
        function OpenAgendar() {
            var oWnd1 = $find("<%= RadWindowAgendar.ClientID %>");
            oWnd1.set_initialBehaviors(Telerik.Web.UI.WindowBehaviors.Pin);
            oWnd1.set_animation(Telerik.Web.UI.WindowAnimation.Fade);
            oWnd1.setUrl("addTreinamento.aspx");
            oWnd1.show();
        }

        function RefreshParentPage() {
            document.location.reload();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server" />
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">

    <telerik:RadWindowManager ID="RWM_Agendar" runat="server" EnableShadow="true" ReloadOnShow="true" AutoSizeBehaviors="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindowAgendar" runat="server" EnableEmbeddedSkins="false" Skin="flv" VisibleTitlebar="true" Title="Agendar"
                VisibleStatusbar="false" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" Height="380" Width="520" Behaviors="None">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <table>
                <tr>
                    <td>
                        <table style="width: 100%; padding-bottom: 20px;">
                            <tr>
                                <td style="width: 5px; background-color: dodgerblue;"></td>
                                <td>Disponível</td>
                                <td style="width: 5px; background-color: crimson;"></td>
                                <td>Sala Cheia</td>
                                <td style="width: 5px; background-color: green;"></td>
                                <td>Concluído</td>
                                <td style="width: 5px; background-color: blueviolet;"></td>
                                <td>Cancelado</td>
                                <td style="width: 5px; background-color: #FFC961;"></td>
                                <td>Individual</td>
                                <td style="text-align: right;">
                                    <a id="btnAgendar" runat="server" class="sitebutton blue" onclick="OpenAgendar();" >Adicionar
                                               <img src="../../Images/24x24/CalendarDate24x24.png" /></a>
                                    <asp:HiddenField ID="HiddenUrl" runat="server" Value='<%# RadWindowAgendar.NavigateUrl = "addTreinamento.aspx" %>' />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                            <AjaxSettings>
                                <telerik:AjaxSetting AjaxControlID="RadCalendar1">
                                    <UpdatedControls>
                                        <telerik:AjaxUpdatedControl ControlID="RadCalendar1"></telerik:AjaxUpdatedControl>
                                    </UpdatedControls>
                                </telerik:AjaxSetting>
                            </AjaxSettings>
                        </telerik:RadAjaxManager>

                        <telerik:RadCalendar ID="RadCalendar1" runat="server" Skin="Special" EnableEmbeddedSkins="false" TitleFormat="MMMM yyyy"
                            OnSelectionChanged="RadCalendar1_SelectionChanged1" OnDayRender="CustomizeDay" EnableMultiSelect="false"
                            DayNameFormat="Short" ShowOtherMonthsDays="false" EnableMonthYearFastNavigation="false" AutoPostBack="true"
                            ShowRowHeaders="false" ShowColumnHeaders="true" EnableViewSelector="false" UseColumnHeadersAsSelectors="true"
                            EnableNavigation="true">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" Date="" ItemStyle-CssClass="rcToday">
                                    <ItemStyle CssClass="calendarToday"></ItemStyle>
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </telerik:RadCalendar>

                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
