<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="linksRapidos.aspx.cs" Inherits="Assecont2.App.Menu.linksRapidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <style type="text/css">
        .titulo_liksRapidos
        {
            color: #369;
            font-size: 12pt;
            margin-bottom: 2px;
        }
    </style>
    <table class="liksRapidos" border="0" cellpadding="5" cellspacing="0" width="600">
        <tr>
            <td valign="top">
                <div class="titulo_liksRapidos">Receita Federal</div>
                <div style="margin-left: 15px;">
                    - <a href="http://www.receita.fazenda.gov.br/Download/ProgramasPF.htm" target="_blank">Programas Pessoa Física</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Download/ProgramasPJ.htm" target="_blank">Programas Pessoa Jurídica</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Principal/Cadastros.htm" target="_blank">Consultas CPF e CNPJ</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Pagamentos/jrselic.htm" target="_blank">Tabela taxas de juros SELIC</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Certidoes/PessoaJuridica.htm" target="_blank">Certidão negativa de débito</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Aplicacoes/ATRJO/ConsRest/Atual.app/index.asp" target="_blank">Consultar restituição do IRPF</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Aplicacoes/ATRJO/Simulador/SimIRPFMensal.htm" target="_blank">Simulação de Alíquota Efetiva</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Aliquotas/ContribFont.htm" target="_blank">Alíquotas IR Retido na Fonte</a><br />
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <div class="titulo_liksRapidos">Trabalhista</div>
                <div style="margin-left: 15px;">
                    - <a href="http://www.caixa.gov.br/Voce/fgts/index.asp" target="_blank">FGTS</a><br />
                    - <a href="http://portal.mte.gov.br/ctps/carteira-de-trabalho-e-previdencia-social-ctps.htm" target="_blank">CTPS</a><br />
                    - <a href="http://portal.mte.gov.br/seg_desemp/seguro-desemprego.htm" target="_blank">Seguro Desemprego</a><br />
                    - <a href="http://portal.mte.gov.br/abono/abono-salarial.htm" target="_blank">Abono Salarial - Informações</a><br />
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <div class="titulo_liksRapidos">ICMS/SP IPI e Outras</div>
                <div style="margin-left: 15px;">
                    - <a href="http://www.fazenda.sp.gov.br/oquee/oq_icms.asp" target="_blank">ICMS/SP</a><br />
                    - <a href="http://www3.fazenda.sp.gov.br/ipvanet/" target="_blank">IPVA</a><br />
                    - <a href="http://www.prefeitura.sp.gov.br/cidade/secretarias/financas/legislacao/index.php?p=3166" target="_blank">ISS - PMSP (Legislação)</a><br />
                    - <a href="http://www.receita.fazenda.gov.br/Legislacao/LegisAssunto/ImpSobProIndIPI/ImpSobProIndIPI.htm" target="_blank">IPI - Legislação</a><br />
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <div class="titulo_liksRapidos">Previdência Social</div>
                <div style="margin-left: 15px;">
                    - <a href="http://www.previdencia.gov.br/guia-da-previdncia-social-gps/" target="_blank">Guia da Previdência Social (GPS)</a><br />
                    - <a href="http://www5.dataprev.gov.br/irpf01/pages/consultarExtratoIR.xhtml" target="_blank">Demonstrativo do Imposto de Renda</a><br />
                    - <a href="http://www.previdencia.gov.br/crp-certificado-de-regularidade-previdenciria/" target="_blank">CRP – Certificado de Regularidade Previdenciária</a><br />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
