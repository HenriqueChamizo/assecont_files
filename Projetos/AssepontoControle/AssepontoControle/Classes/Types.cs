using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;

namespace Asseponto.Classes
{
    public static class Types
    {
        public const string PageBeforeLogin = "PageBeforeLogin";

        public static string ClienteInd = "";

        public enum PedidoStatus
        {
            EmAberto = 1,
            Fechado = 2
        }

        public enum PendenciaTipo
        {
            Suporte = 0,
            /*Programacao = 1,*/
            Implantacao = 2
        }

        public enum ImplantacaoStatus
        {
            [Description("Em aberto")]
            EmAberto = 1,
            [Description("Finalizado")]
            Finalizado = 2,
            //[Description("Iniciado")]
            //Iniciado = 3
        }

        public enum ImplantacaoAndamento
        {
            [Description("Aguardando Planilha")]
            Planilha = 1,
            [Description("Aguardando Treinamento")]
            Treinamento = 2,
            [Description("REP Manutenção")]
            RepManutencao = 4,
            [Description("Retorno do cliente")]
            Retorno = 5,
            [Description("Primeiro Contato")]
            PrimeiroContato = 6,
            [Description("Implantação Finalizada")]
            Finalizada = 7,
            [Description("Repassado para revenda (Finalizado)")]
            RepassadoRevendaFinalizado = 8,
            [Description("Agendamento")]
            Agendamento = 9
        }

        public enum UsuarioTipo
        {
            Revenda = 1,
            Assecont = 2
        }

        public enum PendenciaSituacao
        {
            [Description("Em aberto")]
            EmAberto = 0,
            [Description("Solucionadas")]
            Fechado = 2
        }

        public enum Perfil
        {
            [Description("Administrador")]
            administrador = 0,
            [Description("Gerente")]
            gerente = 1,
            [Description("Comercial")]
            comercial = 2,
            [Description("Implantação")]
            implantacao = 3,
            [Description("Suporte")]
            suporte = 4,
            [Description("Treinamento")]
            treinamento = 5,
        }

        public enum Setor
        {
            [Description("Nenhum")]
            nenhum = 0,
            [Description("Gerente")]
            gerente = 1,
            [Description("Comercial")]
            comercial = 2,
            [Description("Implantação")]
            implantacao = 3,
            [Description("Suporte")]
            suporte = 4,
        }

        public enum alternativas
        {
            [Description("Nenhum")]
            Nenhum = 0,
            [Description("Numeracao")] //1 a 10
            Numeracao = 1,
            [Description("Bit")] //Sim; não
            Bit = 2,
            [Description("Dissertativa")]
            Dissertativa = 3,
            [Description("Classificação")] //Ruim/Razoavel/Bom/Otimo
            Qualificacao = 4,
            [Description("Frequencia")] //Diariamente; Semanalmente; Mensalmente; Raramente;
            Frequencia = 5
        }
    }
}