using DAO;
using DAO.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL
{
    public abstract class BLL
    {
        public Connection conn;

        public BLL()
        {

        }

        public void BLLConn(TypesConnections connection)
        {
            switch (connection)
            {
                case TypesConnections.Asseponto:
                    conn = new Connection("200.170.88.138", "assecont1", "assecont3730", "Gklwi89Hmk");
                    break;
                case TypesConnections.Assefin:
                    conn = new Connection("200.98.136.201", "Assefin_assecont4", "assefin45231", "768fkl448mb");
                    break;
                case TypesConnections.AssecontWeb:
                    conn = new Connection("200.170.88.138", "assecont2", "assecont5272", "*h6prMvr");
                    break;
            }
        }

        public void BLLConn(Connection connect)
        {
            conn = connect;
        }
    }
}
