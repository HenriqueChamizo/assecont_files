using Wr.Classes;
namespace Assecontweb.Classes.Views
{
    public class BDAppLocal : Wr.Classes.BD
    {
        public BDAppLocal()
        {
            Conectar();
        }

        public class BDAppTecnologia : Wr.Classes.BD
        {
            public BDAppTecnologia()
            {
                Conectar(new BDConnection("200.170.88.138", "assecont1", "assecont3730", "Gklwi89Hmk"));
            }
        }

        public class BDAppAssecont : Wr.Classes.BD
        {
            public BDAppAssecont()
            {
                Conectar(new BDConnection("200.170.88.138", "assecont2", "assecont5272", "*h6prMvr"));
            }

            public string getLoginInternoNome(int loginId)
            {
                return getFieldValueString("SELECT LOGI_NOME FROM LoginsInternos WHERE LOGI_IND = " + loginId);
            }
        }
    }
}
