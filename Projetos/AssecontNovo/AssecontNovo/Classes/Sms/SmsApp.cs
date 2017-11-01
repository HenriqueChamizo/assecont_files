using System;
using System.Collections.Generic;

namespace AssecontNovo.Classes.Sms
{
    public class SmsApp : Wr.Classes.Sms
    {
        public struct celulares
        {
            public string texto;
            public string celular;
            public string ddd;
        }

        BDAppAssecont bd = new BDAppAssecont();
        public SmsApp()
        {
            LastId = bd.getFieldValueInteger("SELECT ISNULL((SELECT TOP 1 SMS_ID FROM Smss ORDER BY SMS_ID DESC), 0)");
            if (LastId == 0) LastId = 19;
        }

        public override void UpdateSmsTable(int LastId, List<MensagemRetorno> MensagensRetorno)
        {
            int Numero = LastId;
            foreach (MensagemRetorno mensagemretorno in MensagensRetorno)
            {
                Numero++;

                string sqlAssecontWeb = "INSERT INTO Smss (SMS_ENVIADOEM, SMS_CELULAR, SMS_CELULAR_DDD, SMS_ID, SMS_CODIGOENVIO, SMS_TEXTO) " +
                                                    "VALUES (GETDATE(), %SMS_CELULAR%, %SMS_DDD%, %SMS_ID%, '%SMS_CODIGOENVIO%', '%SMS_TEXTO%')";

                sqlAssecontWeb = sqlAssecontWeb.Replace("%SMS_DDD%", mensagemretorno.Ddd);
                sqlAssecontWeb = sqlAssecontWeb.Replace("%SMS_CELULAR%", mensagemretorno.Celular);
                sqlAssecontWeb = sqlAssecontWeb.Replace("%SMS_ID%", Numero.ToString());
                sqlAssecontWeb = sqlAssecontWeb.Replace("%SMS_CODIGOENVIO%", mensagemretorno.CodigoStatus);
                sqlAssecontWeb = sqlAssecontWeb.Replace("%SMS_TEXTO%", mensagemretorno.Texto);

                bd.executeCommand(sqlAssecontWeb);
                updateTableGeneric(Convert.ToInt32(mensagemretorno.CodigoStatus.Substring(0, 3)));
            }
        }

        protected virtual void updateTableGeneric(int codigoStatus)
        { }

        protected void Send(List<celulares> celulares)
        {
            foreach (celulares a in celulares)
            {
                base.Add(a.ddd, a.celular, a.texto, 0, 0);
            }
            base.Send();
        }

        protected void Send(string ddd, string celular, string texto)
        {
            base.Add(ddd, celular, texto, 0, 0);
            base.Send();
        }
    }
}