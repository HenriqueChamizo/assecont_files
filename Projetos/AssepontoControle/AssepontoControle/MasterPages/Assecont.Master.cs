using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wr.Classes;
using Asseponto.Classes;

namespace Asseponto.MasterPages
{
    public partial class Assecont : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.RawUrl.ToLower().Contains("login.aspx"))
            {
                nav.Visible = false;
                FootNoteSuporte.Visible = false;
                SiteMapPath1.Visible = false;
                subMenus.Visible = false;
                tdLogo.Style.Add("text-align", "center");
                tdLogo.Style.Add("margin-top", "15px");
                tdLogo.Style.Add("padding-top", "15px");
                usuario.Visible = false;
            }

            if (UserApp.UserId == 0)
            {
                if (!HttpContext.Current.Request.Url.ToString().ToLower().Contains("login.aspx"))
                {
                    if (Session[Types.PageBeforeLogin] == null)
                    {
                        Session[Types.PageBeforeLogin] = HttpContext.Current.Request.Url;
                        Response.Redirect("~/suporte/login.aspx");
                    }
                }
            }
            else
            {
                BDApp bd = new BDApp();
                switch ((new Permissoes(bd)).getStatus())
                {
                    case (int)Types.Perfil.suporte:
                        HyperRelatorio.Visible = false;
                        HyperAtestado.Visible = false;
                        HyperUsuario.Visible = false;
                        HyperPesquisa.Visible = false;
                        HyperComercial.Visible = false;
                        lbCountComercial.Visible = false;
                        //Planos.Visible = false;
                        break;

                    case (int)Types.Perfil.treinamento:
                        HyperAtestado.Visible = HyperPesquisa.Visible = HyperUsuario.Visible = false;
                        HyperPedidosAsseponto4.Visible = false; 
                        HyperPedidosAsseponto4Periodo.Visible = false; 
                        HyperImplantacaoCompleta.Visible = false; 
                        HyperImplantacaoIncompleta.Visible = false;
                        HyperClienteExpirados.Visible = HyperRevendaCredenciada.Visible = HyperContratoNaoRecebido.Visible = false;
                        HyperComercial.Visible = false;
                        lbCountComercial.Visible = false;
                        //Planos.Visible = false;
                        break;

                    case (int)Types.Perfil.implantacao:
                        HyperAtestado.Visible = HyperPesquisa.Visible = HyperUsuario.Visible = false;
                        HyperComercial.Visible = false;
                        lbCountComercial.Visible = false;
                        //Planos.Visible = false;
                        HyperRelatorioTreinamento.Visible = HyperClienteExpirados.Visible = HyperRevendaCredenciada.Visible = HyperContratoNaoRecebido.Visible = false;
                        break;

                    case (int)Types.Perfil.comercial:
                        HyperUsuario.Visible = false;
                        HyperPesquisa.Visible = false;
                        break;
                }

                lbCountPedidosAberto.Text = bd.getCountPedidosAberto().ToString();
                lbCountPedidosAberto.Visible = lbCountPedidosAberto.Text == "0" ? false : true;

                lbCountSolicitacoesCli.Text = bd.getCountSolicitacoesCliente().ToString();
                lbCountSolicitacoesCli.Visible = lbCountSolicitacoesCli.Text == "0" ? false : true;

                HyperLink1.NavigateUrl = "~/suporte/implantacoes/Agenda.aspx?ind=0&data=1&finalizado=0&tipo=0&status=0&datavalue=" + DateTime.Now.ToString("dd/MM/yyyy");
                lbCountAgenda.Text = bd.getCountImplantacaoAgendasHoje().ToString();
                lbCountAgenda.Visible = lbCountAgenda.Text == "0" ? false : true;

                DateTime agora = DateTime.Now;
                HyperPedidosRevendasPeriodo.NavigateUrl = HyperPedidosRevendasPeriodo.NavigateUrl + 
                    "?DATAINICIAL=01/" + agora.ToString("MM/yyyy") + "&DATAFINAL=30/" + agora.ToString("MM/yyyy") + "&REP=0&REVIND=0";

                lbCountSolicitacoesRev.Text = bd.getCountSolicitacoesRevenda().ToString();
                SolRevenda.Visible = lbCountSolicitacoesRev.Text.Equals("0") ? false : true;

                if (lbCountComercial.Visible)
                { 
                    lbCountComercial.Text = bd.getFieldValueString("SELECT COUNT(*) FROM AssepontoClientesComercial WHERE COM_FECHADOEM IS NULL");
                    lbCountComercial.Visible = lbCountComercial.Text == "0" ? false : true;
                }

                //if (Planos.Visible)
                //{
                //    lbCountSolicitacoesPlanos.Text = bd.getFieldValueString("select count(*) from AssepontoSolicitacoesPlanos where solpla_concluido_em is null");
                //    lbCountSolicitacoesPlanos.Visible = lbCountSolicitacoesPlanos.Text == "0" ? false : true;

                //    if (lbCountSolicitacoesPlanos.Visible)
                //        HyperSolicitacoesPlanos.NavigateUrl = "~/Suporte/Planos/Default.aspx?Aberto=1";
                //    else
                //        HyperSolicitacoesPlanos.NavigateUrl = "~/Suporte/Planos/Default.aspx?Aberto=0";
                //}
            }
        }
    }
}