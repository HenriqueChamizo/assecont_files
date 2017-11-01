<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Clientes.Master" AutoEventWireup="true" CodeBehind="_videos.aspx.cs" Inherits="Asseponto.Clientes.videos" %>

<%@ Register
    Assembly="Gaia.Ajax.UI.WebControls.VideoPlayers"
    Namespace="Gaia.Ajax.UI.WebControls.VideoPlayers"
    TagPrefix="gaia" %>

<%@ Register
    Assembly="Gaia.WebWidgets"
    Namespace="Gaia.WebWidgets"
    TagPrefix="gaia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div style="height: 25px;"></div>

    <gaia:FlowPlayer
        ID="flowplayer"
        runat="server"
        AutoPlay="false"
        OnPlayerStateChanged="flowplayer_StateChanged"
        OnCuePointReached="flowplayer_CuePointReached"
        OnVideoClipFinished="flowplayer_VideoClipFinished"
        ControlsOverVideo="true"
        Width="480"
        Height="320"
        InitialVolumePercentage="40"
        InitScale="Scale"
        ShowFlashMenu="false"
        ShowFullScreenButton="true"
        ShowMenu="true"
        ShowMuteVolumeButton="true"
        ShowScrubber="true"
        ShowStopButton="true"
        ShowVolumeSlider="true"
        AlternativeContent="" />

    <gaia:Panel
        ID="pnlModal"
        Visible="false"
        runat="server"
        Style="z-Index: 500; border: 2px solid black; background-color: white; width: 300px; height: 300px;
        left: 200px; top: 200px; position: absolute;">
    </gaia:Panel>

    <gaia:Label
        ID="lblStatus"
        runat="server">
    </gaia:Label>
</asp:Content>
