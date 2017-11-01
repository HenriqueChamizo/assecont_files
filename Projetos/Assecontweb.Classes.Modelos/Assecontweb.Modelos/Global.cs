using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Threading;

namespace Assecontweb
{
    namespace Modelos
    {
        public class Global
        {
            public static void Cultura()
            {
                CultureInfo culture = new CultureInfo("pt-BR", true);
                culture.NumberFormat.NumberDecimalSeparator = ",";
                culture.NumberFormat.NumberGroupSeparator = ".";
                Thread.CurrentThread.CurrentCulture = culture;
                Thread.CurrentThread.CurrentUICulture = culture;
            }

            public static Single CultureInfoValue(string Value)
            {
                if (Value[Value.Length - 3].Equals(','))
                {
                    Value = Value.Replace(".", "");
                }
                else
                {
                    Value = Value.Replace(",", "").Replace(".", ",");
                }

                return Convert.ToSingle(Value);
            }

            //Txt
            public static List<string> ByteToListString_Txt(byte[] byteArquivo)
            {
                Encoding wind1252 = Encoding.GetEncoding(1252);

                List<string> Arquivo = new List<string>();
                string aux = wind1252.GetString(byteArquivo);
                string linha = string.Empty;

                for (int i = 0; i < aux.Length; i++)
                {
                    linha += aux[i].ToString();
                    if (aux[i] == '\n')
                    {
                        Arquivo.Add(linha);
                        linha = string.Empty;
                    }
                }

                return Arquivo;
            }

            public static string ByteToString_Html(byte[] byteArquivo)
            {
                return Encoding.Unicode.GetString(byteArquivo);
            }
        }
    }
}