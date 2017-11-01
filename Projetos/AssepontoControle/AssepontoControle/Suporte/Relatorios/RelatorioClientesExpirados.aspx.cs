using System;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Relatorios
{
    public partial class RelatorioClientesExpirados : System.Web.UI.Page
    {
        private BDApp bd;
        private int ano;
        private int ind;
        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();

            ano = Convert.ToInt32(Request.QueryString["ano"]);
            ind = Convert.ToInt32(Request.QueryString["ind"]);

            if (!IsPostBack)
            {
                (new Permissoes(bd)).getAcessoResponse("relatorios", Response);

                bd.openConnection();
                foreach (RadMenuItem radItem in RadMenu1.Items)
                {
                    try
                    {
                        int valor = bd.getCountEmpresasExpiradas(Convert.ToInt32(radItem.Value), ano);

                        if (valor > 0)
                            RadMenu1.Items.FindItemByValue(radItem.Value).Text += " - " + valor;
                        else
                            RadMenu1.Items.FindItemByValue(radItem.Value).Visible = false;
                    }
                    catch { }
                }

                btnHabilitarComunicado.Text = bd.getComunicadoHabilitado() ? "Desabilitar Comunicado" : "Habilitar Comunicado";
                bd.closeConnection();
            }
        }

        protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
        {
            if (e.Item.Value == "ano")
                ano = ano + 1;
            else
            {
                if (e.Item.Value == "anoAnterior")
                    ano = ano - 1;
                else
                {
                    ind = Convert.ToInt32(e.Item.Value);
                }
            }

            Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioClientesExpirados.aspx?ind={0}&ano={1}", ind, ano));
        }

        protected void RadMenu1_PreRender(object sender, EventArgs e)
        {
            if (ind == 0)
            {
                RadMenu1.FindItemByValue("ano").Text = (DateTime.Now.Year + 1).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (DateTime.Now.Year - 1).ToString();
                Response.Redirect(string.Format("~/suporte/Relatorios/RelatorioClientesExpirados.aspx?ind={0}&ano={1}", DateTime.Now.Month, DateTime.Now.Year));
            }
            else
            {
                RadMenu1.FindItemByValue("ano").Text = (ano + 1).ToString();
                RadMenu1.FindItemByValue("anoAnterior").Text = (ano - 1).ToString();
            }
        }

        protected void btnHabilitarComunicado_Click(object sender, EventArgs e)
        {
            Boolean bit = bd.getComunicadoHabilitado();
            bd.executeCommand(string.Format("UPDATE AssepontoConfiguracao SET CONFG_ENVIO_COMUNICADO = {0}, CONFG_ENVIO_COMUNICADO_ALTERADO_POR = {1} WHERE CONFG_IND = 1", bit ? "0" : "1", UserApp.UserId));
            btnHabilitarComunicado.Text = !bit ? "Desabilitar Comunicado" : "Habilitar Comunicado";
        }
    }
}