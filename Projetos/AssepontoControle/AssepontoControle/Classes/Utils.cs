using System;
using System.Reflection;
using System.ComponentModel;
using Telerik.Web.UI;
using System.Globalization;
using System.Threading;

namespace Asseponto.Classes
{
    public static class Utils
    {
        public static string GetDescription(this Enum value)
        {
            Type type = value.GetType();
            string name = Enum.GetName(type, value);
            if (name != null)
            {
                FieldInfo field = type.GetField(name);
                if (field != null)
                {
                    DescriptionAttribute attr =
                           Attribute.GetCustomAttribute(field,
                             typeof(DescriptionAttribute)) as DescriptionAttribute;
                    if (attr != null)
                    {
                        return attr.Description;
                    }
                }
            }
            return null;
        }

        public static void FillComboBox_SimNao(RadComboBox combobox)
        {
            combobox.Items.Add(new RadComboBoxItem("Não", "False"));
            combobox.Items.Add(new RadComboBoxItem("Sim", "True"));
        }

        public static void Cultura()
        {
            CultureInfo culture = new CultureInfo("pt-BR", true);
            Thread.CurrentThread.CurrentCulture = culture;
            Thread.CurrentThread.CurrentUICulture = culture;
        }

        public static string getMesAnoFormat(int Mes, int Ano)
        {
            return Wr.Classes.DateUtils.getMonthName(Mes) + " / " + Ano.ToString();
        }

        public static string getFormatCNPJ_CPF(string cnpjCpf)
        {
            if (cnpjCpf.Length < 14)
                return String.Format(@"{0:000\.000\.000\-00}", Convert.ToDouble(cnpjCpf));
            else
                return String.Format(@"{0:00\.000\.000/0000\-00}", Convert.ToDouble(cnpjCpf));
        }

        public static string ConvertBooleanToString(Boolean value)
        {
            return value ? "1" : "0";
        }

        public static Boolean ConvertStringToBoolean(string value)
        {
            return value.Equals("0") ? false :  true;
        }
    }
}