using System;
using System.Web;
using System.Web.UI.WebControls;

namespace AssecontNovo.Classes
{
    public class UserApp
    {
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

        public bool Login(HttpResponse Response, string cpf, string registro, string Password, Literal ltError)
        {
            bool Result = false;
            int func_ind = 0;
            AssecontNovo.Classes.BDAppAssecont bd = new AssecontNovo.Classes.BDAppAssecont();

            int cadastrado = bd.getVerificarCadastroFuncionario(cpf, registro);
            // int cadastrado = bd.getFieldValueInteger(string.Format("SELECT FUNC_IND FROM Funcionarios WHERE FUNC_CPF='{0}' AND  FUNC_REG='{1}' AND FUNC_DATA_CADASTRO IS NULL AND FUNC_SENHA IS NULL", cpf, registro));
            DateTime ultimoacesso = DateTime.MinValue;

            if (cadastrado == -1)
            {
                //int validar =

                //if(validar != 0)
                //{
                // Response.RedirectPermanent(string.Format("~/holeriteFunc/PrimeiroLogin.aspx?cpf={0}&reg={1}", cpf, registro));
                //}             
            }
            else
            {
                if (cadastrado > 0)
                {
                    func_ind = bd.getFieldValueInteger(string.Format("SELECT FUNC_IND FROM Funcionarios WHERE FUNC_REG='{0}' AND FUNC_CPF='{1}' AND FUNC_SENHA = '{2}'", registro, cpf, Password));

                    if (func_ind > 0)
                    {
                        DateTime.TryParse(bd.getFieldValueString("SELECT FUNC_ULTIMO_ACESSO FROM Funcionarios WHERE FUNC_IND = " + func_ind), out ultimoacesso);
                        //DestinationUrl = getPageDestination("~/holeriteFunc/HoleriteFuncionario.aspx");

                        Wr.Classes.Cookies cookies = new Wr.Classes.Cookies(Response);
                        bd.executeCommand(String.Format("UPDATE Funcionarios SET FUNC_ULTIMO_ACESSO = GETDATE() WHERE FUNC_IND = {0}", func_ind));
                        cookies.Write("UserLogin", cpf);
                        HttpContext.Current.Session.Add("UserLogin", cpf);

                        Result = true;
                    }
                    else
                        Result = false;
                }
                else
                    Result = false;
            }

            if (Result)
            {
                UltimoAcesso = ultimoacesso;
                UserId = func_ind;
                UserName = bd.getNomeFuncionario(func_ind);
            }
            else
                ltError.Text = "Dados Invalidos... ";

            return Result;
        }

        public int UserId
        {
            set
            {
                HttpContext.Current.Session.Add("UserId", value);
            }
            get
            {
                if (HttpContext.Current.Session["UserId"] != null)
                    return Convert.ToInt32(HttpContext.Current.Session["UserId"]);
                else
                    return 0;
            }
        }

        public int UserType
        {
            set
            {
                HttpContext.Current.Session.Add("UserType", value);
            }
            get
            {
                if (HttpContext.Current.Session["UserType"] != null)
                    return Convert.ToInt16(HttpContext.Current.Session["UserType"]);
                else
                    return 0;
            }
        }
        
        public string UserName
        {
            set
            {
                HttpContext.Current.Session.Add("UserName", value);
            }
            get
            {
                if (HttpContext.Current.Session["UserName"] != null)
                    return HttpContext.Current.Session["UserName"].ToString();
                else
                    return string.Empty;
            }
        }

        public DateTime UltimoAcesso
        {
            set
            {
                HttpContext.Current.Session.Add("UltimoAcesso", value);
            }
            get
            {
                return Convert.ToDateTime(HttpContext.Current.Session["UltimoAcesso"]);
            }
        }
    }
}