using System.Collections.Generic;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class Sms : Wr.Classes.Sms
    {
        BDApp bd = new BDApp();
        BDAppAssecontweb bdAssecontweb = new BDAppAssecontweb();
        private int UsuarioRevenda;
        private string DDD;
        private string Celular;

        const string Template = "%REVENDA%, para acessar seu Login: %LOGIN% e Senha: %SENHA% no site www.assecont.com.br";

        public Sms(int UsuarioRevenda, string DDD, string Celular)
        {
            this.UsuarioRevenda = UsuarioRevenda;
            this.DDD = DDD;
            this.Celular = Celular;
            LastId = bdAssecontweb.getFieldValueInteger("SELECT ISNULL((SELECT TOP 1 SMS_ID FROM Smss ORDER BY SMS_ID DESC), 0)");
            //LastId = bd.getFieldValueInteger("SELECT ISNULL((SELECT TOP 1 USUREV_SMS_ID FROM AssepontoUsuariosRevendas ORDER BY USUREV_SMS_ID DESC), 0)");

            if (LastId == 0) LastId = 19;

            EnviarSms();
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

                bdAssecontweb.executeCommand(sqlAssecontWeb);

                string s = "UPDATE AssepontoUsuariosRevendas SET USUREV_DATA_ENVIO_SENHA = GETDATE(), USUREV_EMAIL_ENVIO_SENHA = '%SMS_CELULAR%', USUREV_SMS_ID = '%SMS_ID%', USUREV_SMS_MSG_RETORNO = '%SMS_CODIGOENVIO%'  WHERE USUREV_IND = %SMS_REVENDA_ID%";

                s = s.Replace("%SMS_CELULAR%", Celular);
                s = s.Replace("%SMS_ID%", Numero.ToString());
                s = s.Replace("%SMS_CODIGOENVIO%", mensagemretorno.CodigoStatus);
                s = s.Replace("%SMS_REVENDA_ID%", UsuarioRevenda.ToString());

                bd.executeCommand(s);
            }
        }

        public void EnviarSms()
        {
            string Texto = Template;
            Texto = Texto.Replace("%REVENDA%", bd.getRevendaRazaoSocialFromUsuariosRevendas(UsuarioRevenda).PadLeft(20, ' ').Substring(0, 20));
            Texto = Texto.Replace("%LOGIN%", bd.getLoginFromUsuariosRevendas(UsuarioRevenda));
            Texto = Texto.Replace("%SENHA%", bd.getPasswordFromUsuariosRevendas(UsuarioRevenda));

            base.Add(DDD, Celular, Texto, 0, 0);
        }
    }
}