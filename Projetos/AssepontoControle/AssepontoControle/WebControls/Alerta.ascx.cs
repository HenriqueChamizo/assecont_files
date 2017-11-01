using System;
using Asseponto.Classes;

namespace Wr.WebControls
{
    public partial class Alerta : System.Web.UI.UserControl
    {
        #region Properties
        string _ImageUrl = "";
        string _Text = "";
        string _cnpj_cpf = "";
        string _revenda = "";
        //bool cobrar;
            
        public string revenda
        {
            get
            {
                return _revenda;
            }
            set
            {
                _revenda = value;
            }
        }

        public string cnpj_cpf
        {
            get
            {
                return _cnpj_cpf;
            }
            set
            {
                _cnpj_cpf = value;
            }
        }

        public string ImageUrl
        {
            get
            {
                return _ImageUrl;
            }
            set
            {
                _ImageUrl = value;
            }
        }

        public string Text
        {
            get
            {
                return _Text;
            }
            set
            {
                _Text = value;
            }
        }
        #endregion

        private BDAppAssefin bdAssefin;
        private int cliente;
        protected void Page_Load(object sender, EventArgs e)
        {
            bdAssefin = new BDAppAssefin();
            cliente = Convert.ToInt32(Request.QueryString["ind"]);

            cnpj_cpf = (new BDApp()).getClienteCnpjCpf(cliente);
            revenda = (new BDApp()).getFieldValueString(
                    "SELECT (CASE WHEN (SELECT TOP 1 (CASE WHEN MNT_CANCELADO = 1 THEN NULL ELSE MNT_REVENDA END) " + 
                    "FROM AssepontoManutencao WHERE MNT_CLIENTE = CAD_IND ORDER BY MNT_DATA DESC) IS NULL THEN '' ELSE REV_CNPJ END) " +
                    "FROM AssepontoClientes LEFT JOIN AssepontoRevendas ON CAD_REVENDA = REV_IND " +
                    "WHERE CAD_IND = " + cliente);

            if (!IsPostBack)
            {
                Imagem.Alt = Text;
                Imagem.Src = ImageUrl;
                Mensagem.Text = Text;

                tableBloqueado.Visible = false;
                checarPendecias();
            }
        }

        void checarPendecias()
        {
            if (bdAssefin.ChecarPendencias(cnpj_cpf) > 0)
                tableBloqueado.Visible = true;

            if (!tableBloqueado.Visible && revenda != "" && bdAssefin.ChecarPendencias(revenda) > 0)
            {
                Mensagem.Text = "Revenda Bloqueada";
                tableBloqueado.Visible = true;
            }
        }


        //void visibleAvisoContrato()
        //{
        //    BDApp bd = new BDApp();

        //    string query = "SELECT TOP 1 MNT_IND, " +
        //        "(CASE WHEN MNT_CONTRATO_RECEBIDOEM IS NOT NULL THEN 0 ELSE " +
        //            "(CASE WHEN MNT_CONTRATO_ENVIADOEM IS NULL THEN 0 ELSE " +
        //                "(CASE WHEN DATEDIFF(day, MNT_CONTRATO_ENVIADOEM, GETDATE()) > 5 THEN 1 ELSE 0 END) " +
        //            "END) " +
        //        "END) " +
        //        "FROM AssepontoManutencao  " +
        //        "WHERE MNT_CLIENTE = {0} " +
        //        "ORDER BY MNT_DATA DESC";

        //    if (bd.getFieldValueBool(string.Format(query, cliente)))
        //    {
        //        tableBloqueado.Visible = true;
        //        Mensagem.Text = "Cliente Bloqueado - não recebemos o contrato assinado !";
        //    }
        //}
    }
}