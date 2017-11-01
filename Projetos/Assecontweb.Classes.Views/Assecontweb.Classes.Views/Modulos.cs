using System;

namespace Assecontweb.Classes.Views
{
    public class Modulos
    {
        public Int32 Modulo10(String valor)
        {
            String auxiliar = String.Empty;
            Int32 digito = 0, contador, peso = 2;

            for (contador = valor.Length; contador >= 1; contador--)
            {
                auxiliar = Convert.ToInt32(valor[contador - 1].ToString()) * peso + auxiliar;

                if (peso == 1)
                    peso = 2;
                else
                    peso = 1;
            }

            for (contador = 0; contador < auxiliar.Length; contador++)
                digito += Convert.ToInt32(auxiliar[contador].ToString());

            digito = 10 - digito % 10;
            if (digito > 9)
                digito = 0;

            return digito;
        }

        public Int32 Modulo11(String valor, Int32 modulo = 9, Boolean resto = false)
        {
            Int32 soma = 0, contador, peso = 2, digito;

            for (contador = valor.Length; contador >= 1; contador--)
            {
                soma += Convert.ToInt32(valor[contador - 1].ToString()) * peso;
                if (peso < modulo)
                    peso++;
                else
                    peso = 2;
            }

            if (resto)
                return soma % 11;
            else
            {
                digito = 11 - soma % 11;
                if (digito > 9)
                    digito = 0;

                return digito;
            }
        }
    }
}
