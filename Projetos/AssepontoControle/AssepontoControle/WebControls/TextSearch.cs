using System;

namespace Wr.WebControls
{
    public partial class TextSearch : System.Web.UI.UserControl
    {
        string _PostBackUrl = "";
        string _QueryStringField = "";
        string _QueryStringFieldFixed1 = "";
        string _QueryStringValueFixed1 = "";
        string _QueryStringFieldFixed2 = "";
        string _QueryStringValueFixed2 = "";

        #region Properties
        public string PostBackUrl
        {
            get
            {
                return _PostBackUrl;
            }
            set
            {
                _PostBackUrl = value;
            }
        }

        public string QueryStringField
        {
            get
            {
                return _QueryStringField;
            }
            set
            {
                _QueryStringField = value;
            }
        }

        public string QueryStringFieldFixed1
        {
            get
            {
                return _QueryStringFieldFixed1;
            }
            set
            {
                _QueryStringFieldFixed1 = value;
            }
        }

        public string QueryStringValueFixed1
        {
            get
            {
                return _QueryStringValueFixed1;
            }
            set
            {
                _QueryStringValueFixed1 = value;
            }
        }

        public string QueryStringFieldFixed2
        {
            get
            {
                return _QueryStringFieldFixed2;
            }
            set
            {
                _QueryStringFieldFixed2 = value;
            }
        }

        public string QueryStringValueFixed2
        {
            get
            {
                return _QueryStringValueFixed2;
            }
            set
            {
                _QueryStringValueFixed2 = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                edPesquisa.Text = Request.QueryString[QueryStringField];
        }

        protected void edPesquisa_TextChanged(object sender, EventArgs e)
        {
            if (QueryStringField == "")
                throw new Exception("Propriedade QueryStringField não definida");

            string postbackurl = PostBackUrl;

            if (postbackurl == "")
            {
                postbackurl = Request.RawUrl;
            }

            string Result = postbackurl;

            Result = Wr.Classes.HttpUtils.addQueryStringToUrl(Result, QueryStringField, edPesquisa.Text);

            if (QueryStringFieldFixed1 != "")
            {
                Result = Wr.Classes.HttpUtils.addQueryStringToUrl(Result, QueryStringFieldFixed1, QueryStringValueFixed1);
            }

            if (QueryStringFieldFixed2 != "")
            {
                Result = Wr.Classes.HttpUtils.addQueryStringToUrl(Result, QueryStringFieldFixed2, QueryStringValueFixed2);
            }

            Response.Redirect(Result);
        }
    }
}