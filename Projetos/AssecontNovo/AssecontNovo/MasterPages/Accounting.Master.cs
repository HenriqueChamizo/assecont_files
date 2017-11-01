using System;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.MasterPages
{
    public partial class Accounting : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.RawUrl.ToLower() == ("http://www.assecont.com.br/contabilidade"))
            {
                PageTitle.Visible = false;
            }


            //if (!IsPostBack)
            //{
            //    CarregarRadComboBox();
            //    CarregarLogins(1);
            //}
        }

        //void CarregarRadComboBox()
        //{
        //    RadComboxAcesso.Items.Add(new RadComboBoxItem("AssecontWeb", "1"));
        //    RadComboxAcesso.Items.Add(new RadComboBoxItem("Revenda", "2"));
        //}

        //protected void RadComboxAcesso_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    CarregarLogins(Convert.ToInt32(e.Value));
        //}

        //void CarregarLogins(int Value)
        //{
        //    if (Value == 2)
        //    {
        //        Logins.InnerHtml = "Usuário " +
        //                      "<input type='text' class='textbox' name='u' value='' style='height: 15px; width: 100px;' /> " +
        //                       "Senha " +
        //                       "<input type='password' class='textbox' name='p' value='' style='height: 15px; width: 100px;' /> ";
        //        login.PostBackUrl = "http://www.assecont.com.br/assepontocontrole/revenda/login.aspx";
        //    }
        //    else
        //    {
        //        Logins.InnerHtml = "Email " +
        //            "<input type='text' class='textbox' name='u' value='' style='height: 15px; width: 100px;'/> " +
        //             "Senha " +
        //             "<input type='password' class='textbox' name='p' value='' style='height: 15px; width: 100px;' /> " +
        //             "<input type='hidden' name='OnFailure' value='http://www.assecont.com.br/default.aspx'>";
        //        login.PostBackUrl = "http://www.assecont.com.br/assecontwebnovo/LoginDirect.aspx";
        //    }
        //}
    }
}