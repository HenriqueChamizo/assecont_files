<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Tecnology.Master" AutoEventWireup="true" CodeBehind="requisitosDeInstalacao.aspx.cs" Inherits="AssecontNovo.Teste.Asseponto.requisitosDeInstalacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <flv:MenuLeftAsseponto4 runat="server" id="MenuLeftAsseponto4" />
    <section class="ContentText" style="width: 780px">
        <p>
            <b>Para instalação do sistema recomendamos os requisitos mínimos abaixo:</b>
        </p>
        <ul>
            <b>Sistemas Operacionais</b>
            <li>Windows 7 (ou superior) podendo ser 32 ou 64 bits.
                <ul>
                    <li>Net Framework 2.0
                    </li>
                    <li>Net Framework 3.5
                    </li>
                    <li>Net Framework 4.0
                    </li>
                </ul>
            </li>
            <li style="padding-top: 10px;">Windows Server 2003 (ou superior) podendo ser 32 ou 64 bits.
                <ul>
                    <li>Net Framework 2.0
                    </li>
                    <li>Net Framework 3.5
                    </li>
                    <li>Net Framework 4.0
                    </li>
                    <li>Windows PowerShell
                    </li>
                    <li>Windows Imaging Component
                    </li>
                    <li>Windows Instaler 4.5
                    </li>
                </ul>
            </li>
        </ul>

        <ul>
            <b>Hardware</b>
            <li>HD
                <ul>
                    <li>Espaço livre de no minimo 5 GB
                    </li>
                </ul>
            </li>
            <li>Memoria RAM 2 GHZ
            </li>
            <li>Processador Dual Core
            </li>
        </ul>

        <ul>
            <b>Permissões</b>
            <li>Acesso de administrador no computador com todas as permissões para download e instalação.
                <br />
                <b>Obs: O nome do usuário no Windows não pode ser o mesmo nome do computador (por exemplo: Nome do usuário no Windows é USUARIO e o nome do computador é USUARIO-PC).
                </b>
            </li>
        </ul>

        <ul>
            <b>Comunicação com REP</b>
            <li>Rede
                <ul>
                    <li>Endereço Ip fixo, que não esteja em uso na empresa, cabo de rede ou cabo crossower quando conectado na placa de rede do computador.
                    </li>
                </ul>
            </li>
            <li>Pen Drive
                <ul>
                    <li>Pen drive com no mínimo 2 GB e 4 GB formato como FAT32.
                    </li>
                </ul>
            </li>
        </ul>

        <p>
            Qualquer dúvida por favor entrar em contato com nossa equipe técnica.
        </p>
            <b class="font_red">Canais de atendimento:        </b>
        <flv:WbCanaisSuporte runat="server" ID="WbCanaisSuporte" />
    </section>
</asp:Content>
