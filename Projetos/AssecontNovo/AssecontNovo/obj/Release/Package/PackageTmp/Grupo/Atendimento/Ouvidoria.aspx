<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Ouvidoria.aspx.cs" Inherits="AssecontNovo.Grupo.Atendimento.Ouvidoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuLeftAtendimento runat="server" ID="MenuLeftAtendimento" />
    <section>

        <p>
            A Ouvidoria Assecont tem como missão representar os interesses dos clientes e usuários de produtos e serviços. Se sua reclamação foi tratada em nossos canais de atendimento, mas a solução apresentada não foi satisfatória, a questão poderá ser reexaminada pela Ouvidoria. 
        </p>
        <p>
            <b>•	Nossa Missão</b>
        </p>
        <div class="font_lightBlue" style="font-size: 12pt;">
            Ouvidoria Assecont
            <br />
            011 2173 8855
        </div>
        A Ouvidoria atende das 8h às 17h30, de segunda a sexta-feira, exceto feriados.
    </section>
</asp:Content>
