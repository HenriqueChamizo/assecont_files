using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class UserApp : User
    {
        const string REVENDA_TABLE = "AssepontoUsuariosRevendas";
        const string REVENDA_FIELDINDEX = "USUREV_IND";
        const string REVENDA_FIELDLOGIN = "USUREV_LOGIN";
        const string REVENDA_FIELDPWD = "USUREV_PWD";
        const string REVENDA_FIELDNOME = "USUREV_LOGIN";
        const string REVENDA_FIELDULTIMOACESSO = "USUREV_ULTIMO_ACESSO";
        const string REVENDA_FIELDATIVO = "USUREV_ATIVO";
        const string REVENDA_DESTINATIONURL = "~/Revenda";

        const string INTERNO_TABLE = "AssepontoSuporte";
        const string INTERNO_FIELDINDEX = "SUP_IND";
        const string INTERNO_FIELDLOGIN = "SUP_LOGIN";
        const string INTERNO_FIELDPWD = "SUP_PWD";
        const string INTERNO_FIELDNOME = "SUP_NOME";
        const string INTERNO_FIELDULTIMOACESSO = "SUP_ULTIMO_ACESSO";
        const string INTERNO_FIELDATIVO = "SUP_ATIVO";
        const string INTERNO_DESTINATIONURL = "~/suporte";

        public int Revenda
        {
            set
            {
                HttpContext.Current.Session.Add("Revenda", value);
            }
            get
            {
                if (HttpContext.Current.Session["Revenda"] != null)
                    return Convert.ToInt32(HttpContext.Current.Session["Revenda"]);
                else
                    return 0;
            }
        }

        private string getPageDestination(string Default)
        {
            if (HttpContext.Current.Session[Types.PageBeforeLogin] != null)
            {
                string page = HttpContext.Current.Session[Types.PageBeforeLogin].ToString();
                HttpContext.Current.Session.Remove(Types.PageBeforeLogin);
                return page;
            }
            else
                return Default;
        }

        public bool Login(HttpResponse Response, Types.UsuarioTipo UsuarioTipo, string User, string Password, Literal FailureText, bool WriteCookie)
        {
            bool Result = false;
            string DestinationUrl = "";

            Cookies cookies = new Cookies(Response);

            switch (UsuarioTipo)
            {
                case Types.UsuarioTipo.Revenda:
                    DestinationUrl = getPageDestination(REVENDA_DESTINATIONURL);
                    Result = base.Login(Response, REVENDA_TABLE, REVENDA_FIELDINDEX, REVENDA_FIELDLOGIN, REVENDA_FIELDPWD, REVENDA_FIELDNOME, 
                        REVENDA_FIELDULTIMOACESSO, "", User, Password, "", FailureText, WriteCookie, false, false, null);
                    BDApp bd = new BDApp();
                    bd.Conectar();
                    Revenda = bd.getFieldValueInteger(String.Format("SELECT USUREV_REVENDA FROM AssepontoUsuariosRevendas WHERE USUREV_IND = {0}", UserId));
                    break;
                case Types.UsuarioTipo.Assecont:
                    DestinationUrl = getPageDestination(INTERNO_DESTINATIONURL);
                    Result = base.Login(Response, INTERNO_TABLE, INTERNO_FIELDINDEX, INTERNO_FIELDLOGIN, INTERNO_FIELDPWD, INTERNO_FIELDNOME, 
                        INTERNO_FIELDULTIMOACESSO, "", User, Password, "", FailureText, WriteCookie, false, false, null);
                    if (!(new BDApp()).getFieldValueBool("SELECT SUP_ATIVO FROM AssepontoSuporte WHERE SUP_IND = " + UserApp.UserId))
                    {
                        UserApp.UserId = 0;
                        Result = false;
                    }
                    Revenda = 0;
                    break;
            }

            if (Result)
            {
                Response.Redirect(DestinationUrl);
            }

            return Result;
        }

        public string UserName()
        {
            string Result = "";

            if (UserId != 0)
            {
                BDApp bd = new BDApp();
                Result = this.UserName(INTERNO_FIELDNOME, INTERNO_TABLE, INTERNO_FIELDINDEX);
            }

            return Result;
        }
    }
}