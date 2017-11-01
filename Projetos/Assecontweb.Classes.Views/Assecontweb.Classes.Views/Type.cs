using System.ComponentModel;

namespace Assecontweb.Classes.Views
{
   public class Type : Assecontweb.Types.Types
   {
       public enum RelatorioSpedFiscal
       {
           Fornecedor = 1,
           Cliente = 2,
           FornecedorProdutos,
           ClienteProdutos
       }

       public enum PesquisaTipo
       {
           [Description("Nenhum")]
           Nenhum = 0,
           [Description("Pesquisa  de Satisfação Assecont Contabilidade Ltda")]
           Socio = 1,
           [Description("Pesquisa dos Colaboradores")]
           Departamento = 2,
           [Description("Avaliação Interna dos Funcionários")]
           Funcionario = 3
       }

       public enum Alternativas
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
