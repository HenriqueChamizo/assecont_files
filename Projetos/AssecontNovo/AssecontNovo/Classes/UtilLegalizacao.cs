using System;
using System.Drawing;
namespace AssecontNovo.Classes
{
    public class UtilLegalizacao
    {
        public UtilLegalizacao() { }
        
        public static Color getColorEtapaStatus(Object value)
        {
            int status = value is DBNull ? 100 : Convert.ToInt32(value);

            switch(status)
            {
                case 1:
                    return ColorTranslator.FromHtml("#336CAB") ;
                case 2: 
                     return Color.Green;
                
                default:
                    return Color.Gray;
            }
        }

        public static string getNomeServico(int servico)
        {
            return Wr.Classes.Utils.GetDescription((Types.LegalizacaoServicoTipo)servico);
        }
    }
}