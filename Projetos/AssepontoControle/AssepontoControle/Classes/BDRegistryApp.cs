using System.Collections.Generic;
using Wr.Classes;

namespace Asseponto.Classes
{
    public class BDRegistryApp : BDRegistry
    {
        const string keyULTIMOSCLIENTESACESSADOS = "Ultimos clientes acessados";
        const int maxULTIMOSCLIENTESACESSADOS = 20;

        public BDRegistryApp(string ConnectionString = "")
            : base(UserApp.UserId, "AssepontoSuporteRegistry", "SUPREG_")
        {
            Conectar(ConnectionString);
        }

        public BDRegistryApp(string server, string database, string user, string pwd)
            : base(UserApp.UserId, "AssepontoSuporteRegistry", "SUPREG_")
        {
            BDConnection conn = new BDConnection(server, database, user, pwd);
            //Conectar(server, database, user, pwd);
            Conectar(conn);
        }

        public List<int> getUltimosClientes()
        {
            return Wr.Classes.Utils.ConvertStringToListInt(ReadString(keyULTIMOSCLIENTESACESSADOS));
        }

        public void setUltimoCliente(int Cliente)
        {
            if (Cliente == 0) return;

            List<int> ListInt = getUltimosClientes();

            if (ListInt.IndexOf(Cliente) > -1)
                ListInt.RemoveAt(ListInt.IndexOf(Cliente));

            ListInt.Insert(0, Cliente);

            while (ListInt.Count > maxULTIMOSCLIENTESACESSADOS)
            {
                ListInt.RemoveAt(ListInt.Count - 1);
            }

            WriteString(keyULTIMOSCLIENTESACESSADOS, Wr.Classes.Utils.ConvertListIntToString(ListInt));
        }
    }
}