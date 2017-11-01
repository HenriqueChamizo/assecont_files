<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Implantacao.aspx.cs" Inherits="AssecontNovo.Tecnologia.AssepontoWeb.Implantacao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <div id="sitetitle">
        <table id="Table1" style="width: 100%;">
            <tbody><tr>
                <td>
                    <div id="PageTitle_PageTitleWrapper" style="padding: 0px 5px 5px 0px;">
                        <table>
                            <tbody><tr>
                                <td>
                                    <div id="PageTitle_imagewrapper">
                                         <img id="PageTitle_PageTitleImage" src="../../Imagens/24x24/requerimentos24x24.png">
                                    </div>
                                </td>
                                <td>
                                    <div id="PageTitle_PageTitleTexts">
                                    <span class="descricaoGrupo">Implantação</span></div>
                                </td>
                            </tr>
                        </tbody></table>
                    </div>
                </td>
                <td align="right"></td>
            </tr>
        </tbody></table>
    </div>
    <flv:MenuLeftAssepontoWeb runat="server" ID="MenuLeftAsseponto4" />
    <section class="ContentText">
        <p>
            A implantação será realizada de forma online, pela internet (acesso remoto pelo BEANYWHERE), skype ou telefone por um analista de suporte técnico AssePontoWeb.
        </p>
        <p>
            A instalação do AssePontoWeb consiste na: Importação ou Cadastro da Empresa, Funcionários, Horários, 
            Tabela de Eventos da Folha, Cadastro de Motivos, Parametrização de acordo com o sindicato (horas extras, tolerâncias mínimas, 
            Adicional Noturno, etc), ou Convenção Coletiva, Configuração do Layout para Importação das Marcações e integração com o Sistema de Folha. 
        </p>
        <p>
            Para agilizar e otimizar o processo de instalação do sistema uma planilha no formato <b class="font_red">EXCEL </b>devera ser previamente enviada para <a href="mailto:implantacao@assecont.com.br">implantacao@assecont.com.br</a>.
            Desta forma você não precisará, cadastrar manualmente cada funcionário, bem como cargos e expedientes e outras parametrizações. Através desta planilha geramos um arquivo
             para importação com os dados devidamente preenchidos. Nossa intenção é poupar o usuário para que
             se preocupe apenas com  o tratamento do ponto e controle de frequência de seus funcionários. 
            O preenchimento dela é opcional, e após o treinamento o usuário tem total autonomia para realizar 
            futuros cadastros.
        </p>

        <p>
            <a class="sitebutton blue" href="Planilha%20relação%20dos%20funcionarios%20e%20config%20AssePontoWeb.xls">Planilha relação dos funcionarios e config AssePontoWeb.xls
                <img src="../../Imagens/24x24/dowloand24x24.png" />
            </a>
        </p>
        <br />
        <p>
            Acesso remoto agora: <a class="sitebutton blue" href="https://secure.corporate.beanywhere.com/integration/integration2.php?uid=20ea03c4-63cc-11e2-b330-1231392ccdf2|774">setor de Implantação
               <img src="../../Imagens/16x16/OpenWhite16x16.png" />
            </a>
        </p>
    </section>
</asp:Content>
