
namespace AssecontNovo.Classes
{
    public class Cliente
    {
        private int id;
        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private string razaoSocial;
        public string RazaoSocial
        {
            get { return razaoSocial; }
            set { razaoSocial = value; }
        }

        private string cpfCnpj;
        public string CpfCnpj
        {
            get { return cpfCnpj; }
            set { cpfCnpj = value; }
        }

        private string contato;
        public string Contato
        {
            get { return contato; }
            set { contato = value; }
        }

        private string telefone;
        public string Telefone
        {
            get { return telefone; }
            set { telefone = value; }
        }

        private string telefone_ddd;
        public string Telefone_ddd
        {
            get { return telefone_ddd; }
            set { telefone_ddd = value; }
        }

        private string celular;
        public string Celular
        {
            get { return celular; }
            set { celular = value; }
        }

        private string celular_ddd;
        public string Celular_ddd
        {
            get { return celular_ddd; }
            set { celular_ddd = value; }
        }

        private string email;
        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        private string clienteNumero;
        public string ClienteNumero
        {
            get { return clienteNumero; }
            set { clienteNumero = value; }
        }
        
        public Cliente()
        { }
        
        //public Cliente(string nome, string telefone, string telefone_ddd, string celular, string celular_ddd)
        //{
        //    Nome = nome;
        //    Telefone = telefone;
        //    Telefone_ddd = telefone_ddd;
        //    Celular = celular;
        //    Celular_ddd = celular_ddd;
        //}
    }
}