<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="beneficio.aspx.cs" Inherits="AssecontNovo.Contabilidade.Cotacao.beneficio" %>

<%@ Register Src="~/WebControl/MenuTopCotacao.ascx" TagPrefix="flv" TagName="MenuTopCotacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuTopCotacao runat="server" ID="MenuTopCotacao" />
    <section class="ContentText">
        <p>
            <div class="titleSubs font_red">
                Benefícios 
                    
            </div>
        </p>
        <p>
            <b>Soluções integradas</b> <br />
            Assecont Contabilidade desenvolveu diversas ferramentas e soluções integradas:
        </p>
        <ul class="lista alfabeto">
            <li><span><a target="_blank" class="liksRapidos" href="http://www.assecont.com.br/tecnologia/AssecontWeb.aspx">Assecontweb </a> – Tudo sob Controle!</span>
            </li>
            <li><span><a target="_blank" class="liksRapidos" href="http://www.assecont.com.br/tecnologia/assefin/" >Assefin</a> – Software - Assessor Financeiro;</span>
            </li>
            <li><span><a target="_blank" class="liksRapidos" href="http://www.assecont.com.br/tecnologia/asseponto/" >Asseponto4</a> – Controle de Frequência e Apontamento de Horas;</span>
            </li>
            <li><span><a target="_blank" class="liksRapidos" href="http://www.assecont.com.br/contabilidade/AsseAdmin.aspx" >Asseadmin</a> – Assessoria Administrativa;</span>
            </li>
            <li><span><a target="_blank" class="liksRapidos" href="http://martinsfontes.adv.br/areas/" >Assejur</a> – Assessoria Jurídica;</span>
            </li>
            <li><span><a target="_blank" class="liksRapidos" href="http://www.assecont.com.br/Contabilidade/IntegracaoSistema.aspx" >Integração de Sistemas:</a> Elimina a repetição de processos;</span>
            </li>
            <li><span><a target="_blank" class="liksRapidos" href="http://www.assecont.com.br/Grupo/RetencaoImpostos.aspx" >Retenção de Impostos e Contribuições sobre Serviços Tomados</a> – Software integrado;</span>
            </li>
            <li><span><a target="_blank" class="liksRapidos" href="http://www.assecont.com.br/Grupo/AtendPersonalizado.aspx" >Atendimento Personalizado</a> - tenha um contador dentro da sua empresa.</span>
            </li>
            <li><span>E muito mais...</span>
            </li>
        </ul>
    </section>
</asp:Content>
