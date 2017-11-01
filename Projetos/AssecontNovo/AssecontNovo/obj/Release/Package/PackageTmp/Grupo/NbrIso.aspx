<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="NbrIso.aspx.cs" Inherits="AssecontNovo.Grupo.NbrIso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.1/modernizr.min.js"></script>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <link href="../Styles/timeline.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <div class="timeline animated">
        <div class="timeline-row">
            <div class="timeline-time">
                <small>2014</small>Certificado de Conformidade
           
            </div>
            <div class="timeline-icon">
                <div class="bg-primary">
                    <i class="fa">
                        <img src="../Imagens/24x24/camera24x24.png" />
                    </i>
                </div>
            </div>
            <div class="panel timeline-content">
                <div class="panel-body">
                    <blockquote>
                        <img class="img-responsive" src="../Imagens/CertificIsoPqec/Iso2014.png" width="350" />
                    </blockquote>
                </div>
            </div>
        </div>
        <div class="timeline-row">
            <div class="timeline-time">
                   <small>2011</small>Certificado de Conformidade
       
            </div>
            <div class="timeline-icon">
                <div class="bg-warning">
                    <i class="fa fa-camera-retro">
                        <img src="../Imagens/24x24/camera24x24.png" />
                    </i>
                </div>
            </div>
            <div class="panel timeline-content">
                <div class="panel-body">
                    <blockquote>
                        <img class="img-responsive" src="../Imagens/CertificIsoPqec/Iso2011.jpg" width="350" />
                    </blockquote>
                </div>
            </div>
        </div>
    </div>
    <script src="../Jquery/Timeline/timeline.js"></script>
</asp:Content>
