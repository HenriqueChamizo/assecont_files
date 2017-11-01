using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Wr.Classes;

namespace Assecont2.Holerite.Classes
{
    public class BDApp : BD
    {
        public BDApp()
        {
            Conectar("AppConnectionString");
        }

    
    }
}