using System;

namespace Asseponto.WebControls
{
    public partial class PendenciasControl : System.Web.UI.UserControl
    {
        int _Cliente = 0;
        string _Title = "";
        byte _Situacao = 0;
        string _LinkUrl = "";

        public int Cliente
        {
            get
            {
                return _Cliente;
            }
            set
            {
                _Cliente = value;
                SqlPendencias.SelectParameters["CLIENTE"].DefaultValue = _Cliente.ToString();
                RadListView1.DataSourceID = "SqlPendencias";
                RadListView1.DataBind();
            }
        }

        public byte Situacao
        {
            get
            {
                return _Situacao;
            }
            set
            {
                _Situacao = value;
                SqlPendencias.SelectParameters["Situacao"].DefaultValue = _Situacao.ToString();
                RadListView1.DataSourceID = "SqlPendencias";
                RadListView1.DataBind();
            }
        }

        public string Title
        {
            get
            {
                return _Title;
            }
            set
            {
                _Title = value;
                labelTitulo.Text = _Title;
            }
        }

        public string LinkUrl
        {
            get
            {
                return _LinkUrl;
            }
            set
            {
                _LinkUrl = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}