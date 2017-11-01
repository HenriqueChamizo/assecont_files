using System;
using System.ComponentModel;
using System.Web.UI.WebControls;

namespace Assecontweb.Classes.Views
{
    public static class Global
    {
        public const string rotate = "<style> .rotate {" +
                            " -webkit-transform: rotate(-45deg); " + /* Safari */
                            "-moz-transform: rotate(-45deg); " + /* Firefox */
                            "-ms-transform: rotate(-45deg); " + /* IE */
                            "-o-transform: rotate(-45deg); }" + /* Opera */
                            "body { margin: 0; font-family: 'Segoe UI'; }  " +
                            "</style> ";

        public static System.Web.UI.WebControls.Image getImagem(System.Drawing.Image Figura)
        {
            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                Figura.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] byteImage = ms.ToArray();

                Convert.ToBase64String(byteImage);

                img.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String(byteImage);
            }

            return img;
        }

        public static string quebraPagina()
        {
            return "<br /><div style='page-break-before: always;'> </div><p>";
        }

        public static string conexaoAssecontWeb()
        {
            return "Data Source=200.170.88.138;Initial Catalog=assecont2;Persist Security Info=true;User ID=assecont5272;Password=*h6prMvr";
        }

        public static RadioButtonList Bit(int numero)
        {
            RadioButtonList rbList = new RadioButtonList();
            rbList.ID = "rbBit-" + numero;
            rbList.RepeatDirection = RepeatDirection.Horizontal;
            rbList.CssClass = "radioBtnList";

            rbList.Items.Add(new ListItem("Não", "0"));
            rbList.Items.Add(new ListItem("Sim", "1"));

            return rbList;
        }

        public static TextBox Dissertativa(int numero)
        {
            TextBox txt = new TextBox();
            txt.ID = "dissertativa-" + numero;
            txt.TextMode = TextBoxMode.MultiLine;
            txt.Width = Unit.Pixel(700);
            txt.Height = Unit.Pixel(150);
            txt.CssClass = "ViewsTextbox";
            txt.Style.Add("resize", "none");
            txt.Style.Add("outline", "none");

            return txt;
        }

        public static RadioButtonList Frequencia(int numero)
        {
            RadioButtonList rbList = new RadioButtonList();
            rbList.ID = "rbFrequencia-" + numero;
            rbList.RepeatDirection = RepeatDirection.Horizontal;
            rbList.CssClass = "radioBtnList";

            rbList.Items.Add(new ListItem("Diariamente", "0"));
            rbList.Items.Add(new ListItem("Semanalmente", "1"));
            rbList.Items.Add(new ListItem("Mensalmente", "2"));
            rbList.Items.Add(new ListItem("Raramente", "3"));

            return rbList;
        }


        public static RadioButtonList Qualificacao(int numero)
        {
            RadioButtonList rbList = new RadioButtonList();
            rbList.ID = "rbQualificacao-" + numero;
            rbList.RepeatDirection = RepeatDirection.Horizontal;
            rbList.CssClass = "radioBtnList";

            rbList.Items.Add(new ListItem("Ruim", "0"));
            rbList.Items.Add(new ListItem("Razoável", "1"));
            rbList.Items.Add(new ListItem("Bom", "2"));
            rbList.Items.Add(new ListItem("Ótimo", "3"));

            return rbList;
        }


        public static RadioButtonList Numeracao(int numero, bool readOnly = false)
        {
            RadioButtonList rbList = new RadioButtonList();
            rbList.ID = "rbNumeracao-" + numero;
            rbList.RepeatDirection = RepeatDirection.Horizontal;
            rbList.CssClass = "Number";

            ListItem a = null;

            for (int i = 0; i <= 10; i++)
            {
                a = new ListItem(i.ToString(), i.ToString());

                if (i < 4)
                    a.Attributes.Add("style", "color: red !important;");

                if (i >= 4 && i < 8)
                    a.Attributes.Add("style", "color: orange  !important;");

                if (i >= 8)
                    a.Attributes.Add("style", "color: #009EFF !important;");

                a.Enabled = !readOnly;
                a.Attributes.CssStyle.Add("font-weight", "bold");
                rbList.Items.Add(a);
            }

            return rbList;
        }
    }
}