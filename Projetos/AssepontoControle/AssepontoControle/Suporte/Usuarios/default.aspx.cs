using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Usuarios
{
    public partial class _default : System.Web.UI.Page
    {
        private BDApp bd;
        private UserApp user;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            user = new UserApp();
            new Permissoes(new BDApp()).getAcessoResponse("usuarios", Response);


            //RadMenu1.Visible = false;

            //int ind = Convert.ToInt32(Request.QueryString["ind"]);

            //if (ind == 0 || ind != UserApp.UserId)
            //    Response.Redirect(string.Format("~/assecont/usuarios/default.aspx?ind={0}", UserApp.UserId));


            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            if (ind > 1 && ind != UserApp.UserId)
                Response.Redirect("~/suporte/usuarios/default.aspx?aux=1&ativo=1");

        }

        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
            //int aux;

            //aux = bd.getFieldValueInteger(string.Format("SELECT SUP_PERFIL FROM AssepontoSuporte WHERE SUP_IND = {0}", UserApp.UserId));

            //if (aux == 1)
            //{
                if (e.Item.Value == "0")
                {
                    Response.Redirect("~/suporte/usuarios/default.aspx?aux=1&ativo=0");
                }

                if (e.Item.Value == "1")
                {
                    Response.Redirect("~/suporte/usuarios/default.aspx?aux=1&ativo=1");
                }
            //}
        }

        protected void chkTest_CheckedChanged(object sender, EventArgs e)
        {
            //int aux;

            //aux = bd.getFieldValueInteger(string.Format("SELECT SUP_PERFIL FROM AssepontoSuporte WHERE SUP_IND = {0}", UserApp.UserId));

            //if (aux == 1)
            //{
                CheckBox chkTest = sender as CheckBox;
                GridDataItem item = (GridDataItem)chkTest.NamingContainer;
                string id = item.GetDataKeyValue("SUP_IND").ToString();
                bd.executeCommand(string.Format("UPDATE AssepontoSuporte SET SUP_ATIVO = {0} WHERE SUP_IND = {1}", chkTest.Checked ? 1 : 0, id));
            //}
            Response.RedirectPermanent("~/suporte/usuarios/default.aspx");
        }

        protected void comboboxPerfil_Load(object sender, EventArgs e)
        {
            RadComboBox comboBox = sender as RadComboBox;
            GridEditableItem edit = (GridEditableItem)comboBox.NamingContainer;
            RadComboBox rcbBalance = (RadComboBox)edit.FindControl("comboboxPerfil");
            foreach (Types.Perfil a in ((Types.Perfil[])Enum.GetValues(typeof(Types.Perfil))))
            {
                if((int)a > 0) rcbBalance.Items.Add(new RadComboBoxItem(a.GetDescription(), ((int)a).ToString()));
            }
        }

        protected void comboboxSetor_Load(object sender, EventArgs e)
        {
            RadComboBox comboBox = sender as RadComboBox;
            GridEditableItem edit = (GridEditableItem)comboBox.NamingContainer;
            RadComboBox rcbBalance = (RadComboBox)edit.FindControl("comboboxSetor");
            foreach (Types.Setor a in ((Types.Setor[])Enum.GetValues(typeof(Types.Setor))))
                rcbBalance.Items.Add(new RadComboBoxItem(a.GetDescription(), ((int)a).ToString()));
        }
    }
}