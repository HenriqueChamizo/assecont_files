<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Accounting.Master" AutoEventWireup="true" CodeBehind="legalizacao.aspx.cs" Inherits="Assecont2.Contabilidade.empresarial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
  <script src="http://www.assecont.com.br/assecont/Jquery/Arccodion/arccodion.js"></script>
    <link href="http://www.assecont.com.br/assecont/Styles/arccodion.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#buttons').akordeon({ buttons: true, toggle: true });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceWebSite" runat="server">
    <section class="ContentText">
        <p>
            Segundo pesquisa realizada pelo SEBRAE-SP, do total das empresas registradas anualmente,
             35% dão adeus no primeiro ano. Há um acréscimo de 11% por cento no segundo ano e 10% no terceiro. 
            Dentro deste quadro, podemos dizer que uma pesquisa prévia de mercado, um plano de negócio bem 
            elaborado, junto a uma gestão bem fundamentada, auxiliará, em muito a empresa a vencer esses três 
            primeiros anos de vida.
        </p>

        <div id="demo-wrapper">
            <div class="akordeon" id="buttons">
                <div class="akordeon-item expanded">
                    <div class="akordeon-item-head">
                        <div class="akordeon-item-head-container">
                            <div class="akordeon-heading">
                                1.	Regularizamos sua empresa nos órgãos públicos e conselhos de classe. 
                            </div>
                        </div>
                    </div>
                    <div class="akordeon-item-body">
                        <div class="akordeon-item-content">
                            <ul>
                                <li>Elaboração e Alteração de Contratos Sociais e registro na JUCESP ou Cartórios;</li>
                                <li>Estatutos, Atas e registros como OSCIPs, etc.;</li>
                                <li>Obtenção e baixa de alvará e inscrição municipal (ISS).</li>
                                <li>Obtenção e baixa de inscrição estadual (ICMS).</li>
                                <li>Obtenção e baixa do cadastro nacional de pessoa jurídica (CNPJ).</li>
                                <li>Registro nos conselhos de classe: CRM, CREA, CRO, OAB, CORCESP, e outros;</li>
                                <li>Registro de livros fiscais e contábeis;</li>
                                <li>Obtenção de certidões negativas no âmbito federal, municipal e estadual;</li>
                                <li>Obtenção de certidões negativas nos Cartórios dos Distribuidores;</li>
                                <li>Certidões Negativas dos Cartórios de Protesto de Títulos;</li>
                                <li>Certidões Negativas dos Cartórios de Interdições e Tutelas;</li>
                                <li>Levantamento, pesquisas e regularizações fiscais.</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="akordeon-item">
                    <div class="akordeon-item-head">
                        <div class="akordeon-item-head-container">
                            <div class="akordeon-heading">
                                2.	Controle de Acompanhamento de Processos
                            </div>
                        </div>
                    </div>
                    <div class="akordeon-item-body">
                        <div class="akordeon-item-content">
                            <ul>
                                <li>A Assecont Contabilidade disponibiliza, na ASSECONTWEB, canal para acompanhamento dos processos 
                                    de regularizações e certidões.
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
