using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.Legalizacao
{
    public partial class Intranet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void RadMenu1_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Types.LegalizacaoServicoTipo[] resAss = (Types.LegalizacaoServicoTipo[])Enum.GetValues(typeof(Types.LegalizacaoServicoTipo));
                foreach (Types.LegalizacaoServicoTipo a in resAss)
                    RadMenu1.Items.Add(new RadMenuItem(getFormatTextServico(a), "~/Legalizacao/Intranet.aspx?p=" + ((int)a).ToString()));
            }
        }

        private string getFormatTextServico(Types.LegalizacaoServicoTipo a)
        {
            string name = Wr.Classes.Utils.GetDescription(a);
            int contador = getEmAbertoServico(Convert.ToInt32(a));            

            if (contador > 0) return name + " (" + contador + ")";
            else return name;
        }

        private int getEmAbertoServico(int Servico)
        {
            return (new BDAppAssecont()).getFieldValueInteger("SELECT COUNT(*) FROM legalizacaoPedidos " +
                "INNER JOIN LegalizacaoClientes ON LEGPED_CADASTRO = LEGCLI_IND WHERE LEGPED_SERVICO = " + Servico);
        }
    }
}