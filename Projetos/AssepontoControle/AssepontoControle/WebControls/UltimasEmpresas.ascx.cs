using System;
using Asseponto.Classes;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace Asseponto.WebControls
{
    public partial class UltimasEmpresas : System.Web.UI.UserControl
    {
        string _NavigateUrl = "";

        #region Properties
        public string NavigateUrl
        {
            get
            {
                return _NavigateUrl;
            }
            set
            {
                _NavigateUrl = value;
            }
        }

        public string ImageUrl
        {
            get
            {
                return imageTitulo.Src;
            }
            set
            {
                imageTitulo.Src = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            DisplayResumo();
        }

        public void DisplayResumo()
        {
            BDApp bd = new BDApp();
            BDRegistryApp registry = new BDRegistryApp();

            List<int> listUltimasEmpresas = registry.getUltimosClientes();
            int NEmpresas = 0;

            if (listUltimasEmpresas.Count > 0)
            {
                foreach (int Cliente in listUltimasEmpresas)
                {
                    string RazaoSocial = bd.getClienteRazaoSocial(Cliente);

                    if (!String.IsNullOrEmpty(RazaoSocial))
                    {
                        HyperLink button = new HyperLink();
                        button.CssClass = "sitelinkpadraoazul";
                        button.Text = RazaoSocial;
                        button.NavigateUrl = String.Format("{0}?ind={1}", NavigateUrl, Cliente);
                        button.Style.Add("display", "-webkit-box");
                        button.Style.Add("height", "5px");
                        button.Style.Add("font-weight", "normal");
                        divUltimasEmpresas.Controls.Add(button);
                        divUltimasEmpresas.Controls.Add(new LiteralControl("<BR>"));
                        NEmpresas++;
                    }
                }
            }

            UltimasEmpresasWrapper.Visible = (NEmpresas > 0);
        }
    }
}