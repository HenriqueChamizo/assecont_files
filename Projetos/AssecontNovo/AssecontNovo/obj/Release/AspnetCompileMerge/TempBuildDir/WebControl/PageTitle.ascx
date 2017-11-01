<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageTitle.ascx.cs" Inherits="Assecont2.WebControl.PageTitle" %>

<div id="sitetitle">
    <table id="Table1" style="width: 100%;">
        <tr>
            <td>
                <div id="PageTitleWrapper" runat="server" style="padding: 0px 5px 5px 0px;">
                    <table>
                        <tr>
                            <td>
                                <div id="imagewrapper" runat="server">
                                     <asp:Image ID="PageTitleImage" runat="server" />
                                </div>
                            </td>
                            <td>
                                <div id="PageTitleTexts" runat="server">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td align="right"></td>
        </tr>
    </table>
</div>
