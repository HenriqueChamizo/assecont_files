using System;
using System.Drawing;

namespace Assecontweb.Classes.Views
{
    public class CodigoBarras
    {
        public CodigoBarras()
        { }

        public Image REGGerarCodigoBarra(string strCodigo)
        {
            const int intFino = 1;
            const int intLargo = 3;
            const int intAltura = 70;

            int intLarguraFinal = 500;
            int intAlturaFinal = 70;
            int intAtual = 0;
            int intI;
            int intF;
            int intF1;
            int intF2;
            string strF;
            string strTexto;

            string[] strCodigoBarra = new string[100];

            Size dimensaoFinal = new Size(intLarguraFinal, intAlturaFinal);

            Image oIMGFinal = new Bitmap(intLarguraFinal, intAlturaFinal, System.Drawing.Imaging.PixelFormat.Format32bppArgb);

            SolidBrush oBPreto = new SolidBrush(Color.Black);

            SolidBrush oBBranco = new SolidBrush(Color.White);

            Graphics oGrap = Graphics.FromImage(oIMGFinal);

            oGrap.FillRectangle(oBBranco, new Rectangle(0, 0, intLarguraFinal, intAlturaFinal));

            strCodigoBarra[0] = "00110";
            strCodigoBarra[1] = "10001";
            strCodigoBarra[2] = "01001";
            strCodigoBarra[3] = "11000";
            strCodigoBarra[4] = "00101";
            strCodigoBarra[5] = "10100";
            strCodigoBarra[6] = "01100";
            strCodigoBarra[7] = "00011";
            strCodigoBarra[8] = "10010";
            strCodigoBarra[9] = "01010";

            for (intF1 = 9; intF1 >= 0; intF1--)
            {
                for (intF2 = 9; intF2 >= 0; intF2--)
                {
                    intF = intF1 * 10 + intF2;
                    strTexto = "";

                    for (int intCont = 0; intCont <= 4; intCont++)
                    {
                        strTexto += strCodigoBarra[intF1].Substring(intCont, 1) + strCodigoBarra[intF2].Substring(intCont, 1);
                    }

                    strCodigoBarra[intF] = strTexto;
                }
            }

            oGrap.FillRectangle(oBPreto, new Rectangle(0, 0, intFino, intAltura));
            intAtual += intFino;
            oGrap.FillRectangle(oBBranco, new Rectangle(intAtual, 0, intFino, intAltura));
            intAtual += intFino;
            oGrap.FillRectangle(oBPreto, new Rectangle(intAtual, 0, intFino, intAltura));
            intAtual += intFino;
            oGrap.FillRectangle(oBBranco, new Rectangle(intAtual, 0, intFino, intAltura));
            intAtual += intFino;

            strTexto = strCodigo;

            if ((strTexto.Length % 2) != 0)
            {
                strTexto = "0" + strTexto;
            }

            while (strTexto.Length > 0)
            {
                intI = Convert.ToInt32(strTexto.Substring(0, 2));
                strTexto = InverteString(InverteString(strTexto).Substring(0, strTexto.Length - 2));
                strF = strCodigoBarra[intI];

                for (int intCont = 0; intCont <= 9; intCont = intCont + 2)
                {
                    if (strF.ToString().Substring(intCont, 1) == "0")
                        intF1 = intFino;
                    else
                        intF1 = intLargo;

                    oGrap.FillRectangle(oBPreto, new Rectangle(intAtual, 0, intF1, intAltura));
                    intAtual += intF1;

                    if (strF.ToString().Substring(intCont + 1, 1) == "0")
                        intF2 = intFino;
                    else
                        intF2 = intLargo;

                    oGrap.FillRectangle(oBBranco, new Rectangle(intF2, 0, intFino, intAltura));
                    intAtual += intF2;
                }
            }

            oGrap.FillRectangle(oBPreto, new Rectangle(intAtual, 0, intLargo, intAltura));
            intAtual += intLargo;
            oGrap.FillRectangle(oBBranco, new Rectangle(intAtual, 0, intFino, intAltura));
            intAtual += intFino;
            oGrap.FillRectangle(oBPreto, new Rectangle(intAtual, 0, 1, intAltura));
            intAtual += 1;

            return oIMGFinal;
            //oIMGFinal.Save(strPathNome, System.Drawing.Imaging.ImageFormat.Jpeg);
            //oIMGFinal.Dispose();
        }

        public static string InverteString(string strString)
        {
            string strResult = "";

            for (int intCont = strString.Length - 1; intCont >= 0; intCont--)
                strResult += strString.Substring(intCont, 1);

            return strResult;
        }
    }
}