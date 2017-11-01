<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Asseponto.Revenda.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #sitetitle .descricao
        {
            display: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <asp:Label ID="labelRevendaRazaoSocial" runat="server" Text="Label" CssClass="sitecorpotitulodescricao"></asp:Label>
        <div id="sitecorpoboxinner" style="padding-top: 20px;">

            <wr:PedidosResumo ID="PedidosResumo1" runat="server" />
            <wr:ImplantacoesResumo ID="ImplantacoesResumo1" runat="server" />

            <section style="padding-top: 20px;">
                <p>
                    <span class="titleSubs">
                        <img class="titleSubs blue" src="../Images/24x24/implantacao24x24.png" style="float: left; margin-right: 12px;" />
                        Implantação </span>
                </p>
                <p>
                    A implantação será realizada de forma online, pela internet (acesso remoto pelo BEANYWHERE), skype ou telefone por um analista de suporte técnico ASSEPONTO.
                </p>
                <p>
                    A instalação do ASSEPONTO4 consiste na: Importação ou Cadastro da Empresa, Funcionários, Horários, 
                    Tabela de Eventos da Folha, Cadastro de Motivos, Parametrização de acordo com o sindicato (horas extras, tolerâncias mínimas, 
                    Adicional Noturno, etc), ou Convenção Coletiva, Configuração do Layout para Importação das Marcações e integração com o Sistema de Folha. 
                </p>
                <p>
                    Desta forma o cliente não precisará, cadastrar manualmente cada funcionário, bem como cargos e expedientes e outras parametrizações. Através desta planilha geramos um arquivo
                     para importação com os dados devidamente preenchidos. Nossa intenção é poupar o usuário para que
                     se preocupe apenas com  o tratamento do ponto e controle de frequência de seus funcionários. 
                    O preenchimento dela é opcional, e após o treinamento o usuário tem total autonomia para realizar 
                    futuros cadastros.
                </p>
                <p>
                    <a class="sitebutton blue" href="../Arquivos/ConfigPlanilhaAsseponto4.xls">Planilha relação dos funcionarios e config AssePonto4.xls
                           <img src="../Images/24x24/dowloand24x24.png" />
                    </a>
                </p>
            </section>
        </div>
    </div>
</asp:Content>
