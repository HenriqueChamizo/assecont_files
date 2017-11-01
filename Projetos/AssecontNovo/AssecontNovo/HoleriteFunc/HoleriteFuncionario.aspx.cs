using System;
using System.Data;
using System.Globalization;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.HoleriteFunc
{
    public partial class HoleriteFuncionario : System.Web.UI.Page
    {
        private BDAppAssecont bd;
        private UserApp user;
        private int ind = 0;
        private int month = 0;
        private int year = 0;
        private int tipo = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            CultureInfo culture = new CultureInfo("pt-BR", true);
            Thread.CurrentThread.CurrentCulture = culture;
            Thread.CurrentThread.CurrentUICulture = culture;

            bd = new BDAppAssecont();
            user = new UserApp();

            ind = user.UserId;
            month = Convert.ToInt32(Request.QueryString["month"]);
            year = Convert.ToInt32(Request.QueryString["year"]);

            if (month == 0)
            {
                DateTime dia = bd.getDataUltimoReciboAnexado(ind);
                month = dia.Month; year = dia.Year;
                redirect();
            }

            setNome();

            if (!IsPostBack)
            {
                bd.openConnection();
                tipo = bd.getUltimoReciboAnexadoTipo(ind, month, year);
                setMenu();
                bd.setReciboVisualizadoFuncionario(ind, month, year);
                bd.closeConnection();
            }
        }

        #region Setters
        private void setNome()
        {
            //Response.RedirectPermanent("~/holeriteFunc/Login.aspx");
            if (ind == 0)
                Response.RedirectPermanent("~/holeriteFunc/Login.aspx");

            MasterPage MasterP = (MasterPage)Master;
            LinkButton LbNome = (LinkButton)MasterP.FindControl("lbNomeLogin");
            LbNome.Text = user.UserName;
            LbNome.Click += new EventHandler(Mostrar_Dados);
        }

        private void setMenu()
        {
            foreach (RadMenuItem radItem in RadMenu1.Items)
            {
                try
                {
                    int valor = bd.getCountRecibos(ind, Convert.ToInt32(radItem.Value), year);
                    if (valor > 0)
                        RadMenu1.Items.FindItemByValue(radItem.Value).Text = "<b style='font-size: 12pt;'>" + radItem.Text + "</b><br />" + valor + (valor > 1 ? " Holerites" : " Holerite");
                    else
                        RadMenu1.Items.FindItemByValue(radItem.Value).Visible = false;
                }
                catch  { }
            }
        }
        #endregion

        #region RadMenu
        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
            if (e.Item.Value == "ano")
                year = year + 1;
            else
            {
                if (e.Item.Value == "anoAnterior")
                    year = year - 1;
                else
                    month = Convert.ToInt32(e.Item.Value);
            }
            redirect();
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            RadMenu2.FindItemByValue("ano").Text = "<b style='font-size: 12pt;'>Próximo </b>" + (year + 1).ToString();
            RadMenu2.FindItemByValue("anoAnterior").Text = "<b style='font-size: 12pt;'>Anterior </b>" + (year - 1).ToString();
        }
        #endregion

        #region SQL
        protected void SqlData_Load(object sender, EventArgs e)
        {
            //((SqlDataSource)sender).ConnectionString = bd.Conn.ConnectionString;
        }

        protected void SqlDataHolerite_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@FUNC_IND"].Value = ind;
            e.Command.Parameters["@MES"].Value = month;
            e.Command.Parameters["@ANO"].Value = year;
            e.Command.Parameters["@SAL_HOLERITE_TIPO"].Value = tipo;
        }
        #endregion

        #region ComboBox
        protected void comboboxRecibo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            tipo = Convert.ToInt32(e.Value);
            DataList1.DataBind();
        }

        protected void comboboxRecibo_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                comboboxRecibo.Items.Clear();

                DataTable dt = bd.getDataTable(String.Format("SELECT SAL_HOLERITE_TIPO FROM HoleriteResumoSalario " +
                                     "WHERE MONTH(SAL_COMPETENCIA) = {0}  AND YEAR(SAL_COMPETENCIA) = {1} AND SAL_FUNC = {2} AND SAL_PROVISORIO = 0 ORDER BY SAL_HOLERITE_TIPO ASC", month, year, ind));

                foreach (DataRow dr in dt.Rows)
                    comboboxRecibo.Items.Add(new RadComboBoxItem(Wr.Classes.Utils.GetDescription((Types.HoleritesTiposSimples)Convert.ToInt32(dr["SAL_HOLERITE_TIPO"])), dr["SAL_HOLERITE_TIPO"].ToString()));

                comboboxRecibo.SelectedIndex = 0;
            }
        }
        #endregion

        void Mostrar_Dados(object sender, EventArgs e)
        {
            Response.RedirectPermanent(String.Format("~/holeriteFunc/Dados.aspx", ind));
        }

        private void redirect()
        {
            Response.RedirectPermanent(String.Format("~/holeriteFunc/HoleriteFuncionario.aspx?month={0}&year={1}", month, year));
        }
    }
}