using System;
using AssecontNovo.Classes;
using Telerik.Web.UI;

namespace AssecontNovo.WebControl
{
    public partial class WbHeader : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarRadComboBox();
                CarregarLogins(1);
            }
        }

        void CarregarRadComboBox()
        {
            RadComboxAcesso.Items.Add(new RadComboBoxItem("AssecontWeb", "1"));
            RadComboxAcesso.Items.Add(new RadComboBoxItem("Revenda", "2"));
            RadComboxAcesso.Items.Add(new RadComboBoxItem("AssepontoWeb", "3"));
        }

        protected void RadComboxAcesso_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            CarregarLogins(Convert.ToInt32(e.Value));
        }

        void CarregarLogins(int Value)
        {
            if (Value == 2)
            {
                Logins.InnerHtml = "Usuário <input type='text' class='textbox' name='u' value='' style='height: 18px; width: 150px;' /> " +
                               "Senha <input type='password' class='textbox' name='p' value='' style='height: 18px; width: 100px;' /> ";
                login.PostBackUrl = "http://www.asseponto.com.br/assepontocontrole/revenda/login.aspx";
                lkLoginAntigo.Visible = false;
            }
            else if (Value == 1)
            {
                Logins.InnerHtml = "Email " +
                    "<input type='text' class='textbox' name='u' value='' style='height: 18px; width: 150px;'/> " +
                     "Senha " +
                     "<input type='password' class='textbox' name='p' value='' style='height: 18px; width: 100px;' /> ";
                login.PostBackUrl = "http://www.assecont.com.br/Assecontwebnovo/login.aspx";
                lkLoginAntigo.Visible = true;
            }
            else if (Value == 3)
            {
                Logins.InnerHtml = "Usuário <input type='text' class='textbox' name='u' value='' style='height: 18px; width: 150px;' /> " +
                               "Senha <input type='password' class='textbox' name='p' value='' style='height: 18px; width: 100px;' /> ";
                //login.PostBackUrl = "http://www.asseponto.com.br/assepontowebnovo/logindirect.ashx";
                login.PostBackUrl = "http://www.asseponto.com.br/asseponto/logindirect.ashx";
                lkLoginAntigo.Visible = false;
            }


           // login.PostBackUrl = "http://www.assecont.com.br/Avisos/AvisoManutencao.html";
        }

        protected void login_Click(object sender, EventArgs e)
        { 

        }
    }
}