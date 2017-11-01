using System.ComponentModel;

namespace Assecontweb.Classes
{
    public class Tipo
    {
        public const string SufixoOk = "_novo";

        public enum ObrigacaoArquivoSubTipo
        {
            [Description("Documento")]
            Documento = 0,
            [Description("Recibo")]
            Recibo = 1,
            [Description("Protocolo")]
            Protocolo = 2,
        }

        public enum ObrigacaoTipo
        {
            [Description("Nenhum")]
            Nenhum = 0,
            [Description("Impostos")]
            Impostos = 1,
            [Description("Obr. Acessórias")]
            Acessorias = 2,
            [Description("Relatórios")]
            Relatorios = 3,
            [Description("Arquivos")]
            Arquivos = 4,
            [Description("Solicitações do Cliente")]
            Solicitacoes = 5
        }

        public enum ObrigacaoArquivoTipo
        {
            [Description("Original")]
            Original = 0,
            [Description("Complementar")]
            Complementar = 1,
            [Description("Retificação")]
            Retificacao = 2,
            [Description("Recálculo")]
            Recalculo = 3,
        }

        public enum HoleritesTipos
        {
            [Description("RECIBO DE PAGAMENTO DE SALÁRIO MENSAL")]
            Salario = 1,
            [Description("RECIBO DE PRO_LABORE")]
            ProLab = 2, //NÃO ESTÁ IMPLEMENTADO
            [Description("RECIBO DE ADIANTAMENTO DE SALÁRIO MENSAL")]
            Adianta = 3,
            [Description("RECIBO DE PRIMEIRA PARCELA 13º SALÁRIO")]
            Salario131 = 4,
            [Description("RECIBO DE SEGUNDA PARCELA 13º SALÁRIO")]
            Salario132 = 5,
            [Description("PARTICIPAÇÃO REMUNERADA NOS RESULTADOS")]
            PRL = 6,
            [Description("RECIBO DE ABONO")]
            Abono = 7
        }

        public enum DarfPagosStatus
        {
            Desconhecido = 0,
            Encontrado = 1,
            Duplicado = 2
        }

        public enum PerfilItemIndice
        {
            [Description("Lucro Presumido")]
            LucroPresumido = 2,
            [Description("Lucro Real")]
            LucroReal = 3,
            [Description("Simples")]
            Simples = 4,
            [Description("Pessoa Física")]
            PessoaFisica = 7,
            [Description("Comércio")]
            Comercio = 9,
            [Description("Indústria")]
            Industria = 11,
            [Description("Serviço")]
            Servico = 13,
            [Description("Imune")]
            Imune = 27,
            [Description("Inativa")]
            Inativa = 29,
            [Description("Desoneração Folha")]
            Desoneracao = 31,
            [Description("Antecipação")]
            Antecipacao = 32,
            [Description("Quota Única")]
            QuotaUnica = 33,
            [Description("Três Quotas")]
            TresQuotas = 34,
        }

        public enum FolhaTipo
        {
            [Description("Nenhum")]
            Nenhum = 0,
            [Description("Salário")]
            Salario = 1,
            [Description("Pró-Labore")]
            Prolabore = 2,
            [Description("Adiantamento")]
            Adiantamento = 3,
            [Description("13° Parcela 1")]
            Parcela131 = 4,
            [Description("13° Parcela 2")]
            Parcela132 = 5,
            [Description("Participação nos Resultados")]
            PRL = 6,
            [Description("Abono")]
            Abono = 7
        }

        public enum ObrigacaoStatus
        {
            [Description("Nenhum")]
            Nenhum = -1,
            [Description("Em Aberto")]
            EmAberto = 0,
            [Description("Concluído")]
            Concluido = 1,
            [Description("Sem Movimento Não Avaliado")]
            SemMovimentoNaoAvaliado = 2,
            [Description("Sem Movimento Rejeitado")]
            SemMovimentoRejeitado = 3,
            [Description("Provisório")]
            Provisorio = 4,
            [Description("Sem Movimento")]
            SemMovimento = 5,
        }

        public enum ObrigacaoModelo
        {
            Obrigracao = 0,
            Darftxt = 1,
            Holerite = 2,   //tipo .txt
            DarfPago = 3,   //tipo .html
            Gps = 4,        //tipo .txt
            InformeRendimentoFuncionario = 5,  //tipo .txt
            InformeRendimentoSocio = 6,   //tipo .txt
            DarfHtml = 7, //Darf PIS & CONFINS 
            DasLegalizacao = 8,
            Ferias = 9,
            SpedFiscal = 10,
            SpedContabil = 11
        }
    }
}