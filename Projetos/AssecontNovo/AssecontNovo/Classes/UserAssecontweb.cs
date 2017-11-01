using System;

namespace AssecontNovo.Classes
{
    public class UserAssecontweb
    {
        public UserAssecontweb()
        { }

        private int id;
        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private string nome;
        public string Nome
        {
            get { return nome; }
            set { nome = value; }
        }

        private string email;
        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        public void setId(string parameter)
        {
            try
            {
                id = Convert.ToInt32((new Wr.Classes.Crypto()).Decrypt(parameter.Replace(' ', '+')));
            }
            catch
            { }
        }

        public bool checarPermisao(Assecontweb.Classes.AccessApp.PermissoesList p)
        {
            Assecontweb.Classes.AccessApp access = new Assecontweb.Classes.AccessApp(id);
            return access.CheckPermission(p);
        }
    }
}