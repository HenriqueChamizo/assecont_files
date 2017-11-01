using DAO;
using DAO.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace BLL
{
    public class ClienteBLL : BLL, ICliente
    {
        public ClienteDAO DAO;

        public ClienteBLL()
        {
            BLLConn(TypesConnections.Asseponto);
            DAO = new ClienteDAO();
            DAO.SetValuesConnection(conn);
        }

        public ClienteBLL(TypesConnections connection)
        {
            BLLConn(connection);
            DAO = new ClienteDAO();
            DAO.SetValuesConnection(conn);
        }

        public ClienteBLL(Connection connect)
        {
            BLLConn(connect);
            DAO = new ClienteDAO();
            DAO.SetValuesConnection(conn);
        }

        public bool GetClienteWithRevenda(ref Modelo.Asseponto.ClienteDetail cliente, ref Modelo.Asseponto.RevendaDetail revenda)
        {
            return DAO.GetClienteWithRevenda(ref cliente, ref revenda);
        }

        public bool setUpdateCadastroAssefin(Modelo.Assefin.ClienteDetail cliente)
        {
            return DAO.setUpdateCadastroAssefin(cliente);
        }

        public bool setUpdateCadastroAsseponto(Modelo.Asseponto.ClienteDetail cliente)
        {
            return DAO.setUpdateCadastroAsseponto(cliente);
        }
    }
}
