using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DAO.Interfaces
{
    public interface ICliente
    {
        bool GetClienteWithRevenda(ref Modelo.Asseponto.ClienteDetail cliente, ref Modelo.Asseponto.RevendaDetail revenda);
        bool setUpdateCadastroAssefin(Modelo.Assefin.ClienteDetail cliente);
        bool setUpdateCadastroAsseponto(Modelo.Asseponto.ClienteDetail cliente);
    }
}
