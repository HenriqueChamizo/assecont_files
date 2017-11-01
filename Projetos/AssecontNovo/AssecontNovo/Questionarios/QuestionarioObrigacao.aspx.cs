using System;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.Pesquisas
{
    public partial class QuestionarioObrigacao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { }

        protected void combobox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGridQuestionarioDepartamento.DataBind();
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            SqlData.ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void SqlData_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@SETOR"].Value = comboboxSetor.SelectedItem.Value;
        }

        protected void comboboxDatas_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                foreach (Types.setorIterno a in ((Types.setorIterno[])Enum.GetValues(typeof(Types.setorIterno))))
                    comboboxSetor.Items.Add(new RadComboBoxItem(Wr.Classes.Utils.GetDescription(a), ((int)a).ToString()));
               comboboxSetor.SelectedIndex = 0;
            }
        }
    }
}