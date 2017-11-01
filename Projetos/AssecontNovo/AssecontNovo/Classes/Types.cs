using System.ComponentModel;

namespace AssecontNovo.Classes
{
    public class Types : Assecontweb.Types.Types
    {
        public const string PageBeforeLogin = "PageBeforeLogin";

        public enum PerfilItemIndiceInformativo
        {
            [Description("Lucro Presumido")]
            LucroPresumido = 2,
            [Description("Lucro Real")]
            LucroReal = 3,
            [Description("Simples")]
            Simples = 4,
            [Description("Pessoa Física")]
            PessoaFisica = 7
            //[Description("Comércio")]
            //Comercio = 9,
            //[Description("Indústria")]
            //Industria = 11,
            //[Description("Serviço")]
            //Servico = 13,
            //[Description("Imune")]
            //Imune = 27,
            //[Description("Inativa")]
            //Inativa = 29,
            //[Description("Desoneração Folha")]
            //Desoneracao = 31,
            //[Description("Antecipação")]
            //Antecipacao = 32,
            //[Description("Quota Única")]
            //QuotaUnica = 33,
            //[Description("Três Quotas")]
            //TresQuotas = 34,
        }

        public enum perfilTecnologia
        {
            [Description("Revendas")]
            Revendas = 2,
            [Description("Clientes com Manutenção")]
            Clientes = 3,
            [Description("Clientes Sem Manutenção")]
            ClientesSemManutencao = 4,
            [Description("Clientes com Manutenção 60 dias")]
            ClientesComManutencao60 = 5
        }

        public enum perfilInterno
        {
            [Description("Fiscal")]
            Fiscal = 1,
            [Description("Contabil")]
            Contabil = 2,
            [Description("Pessoal")]
            Pessoal = 3,
            [Description("Legalização")]
            Legalizacao = 4,
            [Description("Diretoria")]
            Diretoria = 0,
            [Description("GED")]
            Ged = 5
        }

        public enum setorIterno
        {
            [Description("Fiscal")]
            Fiscal = 1,
            [Description("Contabil")]
            Contabil = 2,
            [Description("Pessoal")]
            Pessoal = 3
        }

        public enum zonas
        {
            [Description("Central")]
            Central = 1,
            [Description("Noroeste")]
            Noroeste = 2,
            [Description("Norte")]
            Norte = 3,
            [Description("Leste")]
            Leste = 4,
            [Description("Sudeste")]
            Sudeste = 5,
            [Description("Sul")]
            Sul = 6,
            [Description("Sudoeste")]
            Sudoeste = 7,
            [Description("Oeste")]
            Oeste = 8
        }

        public enum LegalizacaoServicoTipo
        {
            [Description("Abertura")]
            Abertura = 0,
            [Description("Alteração")]
            Alteracao = 1,
            [Description("Encerramento")]
            Encerramento = 2,
            [Description("Outro")]
            Outro = 3
        }

        public enum LegalizacaoPedidosStatus
        {
            [Description("Em Aberto")]
            EmAberto = 0,
            [Description("Concluído")]
            Concluido = 1,
            [Description("Cancelado")]
            Cancelado = 2,
        }

        public enum LegalizacaoEtapaStatus
        {
            [Description("Não iniciado")]
            NaoIniciado = 0,
            [Description("Iniciado")]
            Iniciado = 1,
            [Description("Finalizado")]
            Finalizado = 2,
        }
    }
}