using DAO;
using Modelo.Asseponto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public class PedidosBLL : BLL
    {
        PedidosDAO DAO;

        public PedidosBLL()
        {
            BLLConn(TypesConnections.Asseponto);
            DAO = new PedidosDAO();
            DAO.SetValuesConnection(conn);
        }

        public PedidosBLL(TypesConnections connection)
        {
            BLLConn(connection);
            DAO = new PedidosDAO();
            DAO.SetValuesConnection(conn);
        }

        public PedidosBLL(Connection connect)
        {
            BLLConn(connect);
            DAO = new PedidosDAO();
            DAO.SetValuesConnection(conn);
        }

        public PedidoDetail GetPedidobyId(int ind)
        {
            return DAO.GetPedidobyId(ind);
        }

        public List<FabricantesDropDrow> GetFabricantesDropDown()
        {
            return DAO.GetFabricantesDropDown();
        }

        public void SetPedidos(PedidoDetail pedido)
        {
            DAO.SetPedidos(pedido);
        }

        public void SetPedidosGetId(PedidoDetail pedido, ref int ind)
        {
            DAO.SetPedidoGetId(pedido, ref ind);
        }
    }
}
