using System;
using System.Web;

namespace Wr.WebControls
{
    public partial class TextSearch : System.Web.UI.UserControl
    {
        string _PostBackUrl = "";
        string _QueryStringField = "";
        string _QueryStringFieldFixed1 = "1";
        string _QueryStringValueFixed1 = "";
        string _QueryStringFieldFixed2 = "";
        string _QueryStringValueFixed2 = "";
        bool _ShowDateFilter = false;
        bool _ShowTableFilter = false;
        bool _ShowTexto = true;
        bool _ShowAssefin = false;

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

        public bool ShowDateFilter
        {
            get
            {
                return _ShowDateFilter;
            }
            set
            {
                _ShowDateFilter = value;
            }
        }

        public bool ShowTableFilter
        {
            get
            {
                return _ShowTableFilter;
            }
            set
            {
                _ShowTableFilter = value;
            }
        }

        public bool ShowTexto
        {
            get
            {
                return _ShowTexto;
            }
            set
            {
                _ShowTexto = value;
            }
        }

        public bool ShowAssefin
        {
            get
            {
                return _ShowAssefin;
            }
            set
            {
                _ShowAssefin = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                edPesquisa.Text = HttpContext.Current.Server.UrlDecode(Request.QueryString[QueryStringField]);
                rdFiltro.SelectedValue = HttpContext.Current.Server.UrlDecode(Request.QueryString[QueryStringFieldFixed1]);
                rdFiltroAssefin.SelectedValue = HttpContext.Current.Server.UrlDecode(Request.QueryString[QueryStringFieldFixed1]);

                panelData.Visible = ShowDateFilter;
                panelFitro.Visible = ShowTableFilter;
                panelTexto.Visible = ShowTexto;
                if (panelFitro.Visible)
                    panelAssefin.Visible = false;
                else
                    panelAssefin.Visible = ShowAssefin;

                if (!string.IsNullOrEmpty(Request.QueryString["datainicial"]))
                    RadDatePicker1.SelectedDate = Convert.ToDateTime(HttpContext.Current.Server.UrlDecode(Request.QueryString["datainicial"]));

                if (!string.IsNullOrEmpty(Request.QueryString["datafinal"]))
                    RadDatePicker2.SelectedDate = Convert.ToDateTime(HttpContext.Current.Server.UrlDecode(Request.QueryString["datafinal"]));
            }
        }

        private void PostBack()
        {
            if (QueryStringField == "")
                throw new Exception("Propriedade QueryStringField não definida");

            string postbackurl = PostBackUrl;

            if (postbackurl == "" || ShowAssefin)
            {
                postbackurl = Request.RawUrl;
            }

            //if (postbackurl.IndexOf("?") == -1)
            //    postbackurl = postbackurl + "?datainicial=01/" + DateTime.Now.ToString("MM/yyyy") + "&datafinal=30/" + DateTime.Now.ToString("MM/yyyy");

            string Result = postbackurl;

            if (edPesquisa.Text != "")
            {
                Result = Classes.HttpUtils.addQueryStringToUrl(Result, QueryStringField, edPesquisa.Text);
            }

            if (!string.IsNullOrEmpty(QueryStringFieldFixed1) && !string.IsNullOrEmpty(QueryStringValueFixed1))
            {
                Result = Classes.HttpUtils.addQueryStringToUrl(Result, QueryStringFieldFixed1, QueryStringValueFixed1);
            }

            if (QueryStringFieldFixed2 != "")
            {
                Result = Classes.HttpUtils.addQueryStringToUrl(Result, QueryStringFieldFixed2, QueryStringValueFixed2);
            }

            if (ShowDateFilter)
            {
                if (RadDatePicker1.SelectedDate.HasValue)
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["datainicial"]))
                        Result = Result.Replace(HttpContext.Current.Server.UrlEncode(Request.QueryString["datainicial"]), "");
                    Result = Classes.HttpUtils.addQueryStringToUrl(Result, "datainicial", RadDatePicker1.SelectedDate.Value.ToString("dd/MM/yyyy")).Replace("%2c","");
                }
                else
                    Result = Classes.HttpUtils.addQueryStringToUrl(Result, "datainicial", "");

                if (RadDatePicker2.SelectedDate.HasValue)
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["datafinal"]))
                        Result = Result.Replace(HttpContext.Current.Server.UrlEncode(Request.QueryString["datafinal"]), "");
                    Result = Classes.HttpUtils.addQueryStringToUrl(Result, "datafinal", RadDatePicker2.SelectedDate.Value.ToString("dd/MM/yyyy")).Replace("%2c", "");
                }
                else
                    Result = Classes.HttpUtils.addQueryStringToUrl(Result, "datafinal", "");
            }

            Response.Redirect(HttpContext.Current.Server.UrlDecode(Result));
        }

        protected void edPesquisa_TextChanged(object sender, EventArgs e)
        {
            if (ShowAssefin)
                QueryStringValueFixed1 = rdFiltroAssefin.SelectedValue;
            else
                QueryStringValueFixed1 = rdFiltro.SelectedValue;
            PostBack();
        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            PostBack();
        }

        protected void rdFiltro_SelectedIndexChanged(object sender, EventArgs e)
        {
            QueryStringValueFixed1 = rdFiltro.SelectedValue;
            PostBack();
        }

        protected void rdFiltroAssefin_SelectedIndexChanged(object sender, EventArgs e)
        {
            QueryStringValueFixed1 = rdFiltroAssefin.SelectedValue;
            PostBack();
        }
    } 
}