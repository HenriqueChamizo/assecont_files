using System;
using Asseponto.Classes;

namespace Asseponto.WebControls
{
    public partial class PedidosResumo : System.Web.UI.UserControl
    {
        int _Revenda = 0;

        #region Properties
        public int Revenda
        {
            get
            {
                return _Revenda;
            }
            set
            {
                _Revenda = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            int NPedidosPonto4 = 0;
            int NPedidosPontoWeb = 0;
            int UltimoPedidoPonto4 = 0;
            int UltimoPedidoPontoWeb = 0;

            BDApp bd = new BDApp();

            if (Revenda == 0)
            {
                NPedidosPonto4 = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) AS NPEDIDOS FROM [AssepontoPedidosRevendas] WHERE (PED_STATUS = {0}) and PED_VERSAO_AQUISICAO != 8", Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                NPedidosPontoWeb = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) AS NPEDIDOS FROM [AssepontoPedidosRevendas] WHERE (PED_STATUS = {0}) and PED_VERSAO_AQUISICAO = 8", Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                UltimoPedidoPonto4 = bd.getFieldValueInteger(String.Format("SELECT TOP 1 PED_IND FROM [AssepontoPedidosRevendas] WHERE (PED_STATUS = {0}) and PED_VERSAO_AQUISICAO != 8 ORDER BY PED_IND DESC", Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                UltimoPedidoPontoWeb = bd.getFieldValueInteger(String.Format("SELECT TOP 1 PED_IND FROM [AssepontoPedidosRevendas] WHERE (PED_STATUS = {0}) and PED_VERSAO_AQUISICAO = 8 ORDER BY PED_IND DESC", Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                linkNPedidos4.NavigateUrl = String.Format("~/suporte/Pedidos/Default.aspx?status={0}", Convert.ToInt32(Types.PedidoStatus.EmAberto));
                linkNPedidosWeb.NavigateUrl = String.Format("~/suporte/Pedidos/Default.aspx?status={0}&web=8", Convert.ToInt32(Types.PedidoStatus.EmAberto));
                linkUltimoPedido4.NavigateUrl = String.Format("~/suporte/Pedidos/Pedido.aspx?ind={0}", UltimoPedidoPonto4);
                linkUltimoPedidoWeb.NavigateUrl = String.Format("~/suporte/Pedidos/PontoWeb.aspx?ind={0}", UltimoPedidoPontoWeb);
            }
            else
            {
                NPedidosPonto4 = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) AS NPEDIDOS FROM [AssepontoPedidosRevendas] WHERE ([PED_REV_IND] = {0} AND PED_STATUS = {1}) and PED_VERSAO_AQUISICAO != 8", Revenda, Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                NPedidosPontoWeb = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) AS NPEDIDOS FROM [AssepontoPedidosRevendas] WHERE ([PED_REV_IND] = {0} AND PED_STATUS = {1}) and PED_VERSAO_AQUISICAO = 8", Revenda, Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                UltimoPedidoPonto4 = bd.getFieldValueInteger(String.Format("SELECT TOP 1 PED_IND FROM [AssepontoPedidosRevendas] WHERE ([PED_REV_IND] = {0} AND PED_STATUS = {1}) and PED_VERSAO_AQUISICAO != 8 ORDER BY PED_IND DESC", Revenda, Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                UltimoPedidoPontoWeb = bd.getFieldValueInteger(String.Format("SELECT TOP 1 PED_IND FROM [AssepontoPedidosRevendas] WHERE ([PED_REV_IND] = {0} AND PED_STATUS = {1}) and PED_VERSAO_AQUISICAO = 8 ORDER BY PED_IND DESC", Revenda, Convert.ToInt32(Types.PedidoStatus.EmAberto)));
                linkNPedidos4.NavigateUrl = "~/Revenda/Pedidos/Default.aspx";
                linkNPedidosWeb.NavigateUrl = "~/Revenda/Pedidos/Default.aspx";
                linkUltimoPedido4.NavigateUrl = String.Format("~/Revenda/Pedidos/Pedido.aspx?ind={0}", UltimoPedidoPonto4);
                linkUltimoPedidoWeb.NavigateUrl = String.Format("~/Revenda/Pedidos/Pedido.aspx?ind={0}", UltimoPedidoPontoWeb);
            }

            string asseponto4 = "{0} pedidos0 <img src='../Images/Logos/logoAsseponto.png' style='height:20px;margin-bottom: 4px;' />";
            string assepontoWeb = "{0} pedidos0 <img src='../Images/Logos/logoAssepontoWeb1.png' style='height:13px;' />";
            
            if (NPedidosPonto4 > 0)
            {
                asseponto4 = String.Format(asseponto4, NPedidosPonto4);
                if (NPedidosPonto4 == 1)
                    asseponto4 = asseponto4.Replace("pedidos0", "pedido");
                else
                    asseponto4 = asseponto4.Replace("pedidos0", "pedidos");
            }

            if (NPedidosPontoWeb > 0)
            {
                assepontoWeb = String.Format(assepontoWeb, NPedidosPontoWeb);
                if (NPedidosPontoWeb == 1)
                    assepontoWeb = assepontoWeb.Replace("pedidos0", "pedido");
                else
                    assepontoWeb = assepontoWeb.Replace("pedidos0", "pedidos");
            }

            if (NPedidosPonto4 > 0 || NPedidosPontoWeb > 0)
            {
                if (NPedidosPonto4 > 0)
                {
                    linkNPedidos4.Text = asseponto4;
                    linkNPedidos4.Visible = true;
                    if (Revenda <= 0)
                    {
                        linkUltimoPedido4.Text = bd.getFieldValueString(String.Format("SELECT PED_CLI_RAZAO FROM AssepontoPedidosRevendas WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO != 8", UltimoPedidoPonto4));
                        labelDataHora4.Text = String.Format("{0:dd/MM/yyyy HH:mm}", bd.getFieldValueDateTime(String.Format("SELECT TOP 1 PED_DATA FROM [AssepontoPedidosRevendas] WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO != 8", UltimoPedidoPonto4)));
                        labelRevenda4.Text = "Revenda: " + bd.getFieldValueString(String.Format("SELECT REV_RAZAOSOCIAL FROM AssepontoPedidosRevendas INNER JOIN AssepontoRevendas ON REV_IND = PED_REV_IND WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO != 8", UltimoPedidoPonto4)) + "<br>";
                    }
                    else
                        labelRevenda4.Visible = false;
                }
                else
                {
                    ponto4.Style.Add("display", "none");
                    linkUltimoPedido4.Visible = false;
                    labelDataHora4.Visible = false;
                    labelRevenda4.Visible = false;
                    linkNPedidos4.Visible = false;
                    labelRevendaTit4.Visible = false;
                }

                if (NPedidosPontoWeb > 0)
                {
                    linkNPedidosWeb.Text = assepontoWeb;
                    linkNPedidosWeb.Visible = true;
                    if (Revenda <= 0)
                    {
                        linkUltimoPedidoWeb.Text = bd.getFieldValueString(String.Format("SELECT PED_CLI_RAZAO FROM AssepontoPedidosRevendas WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO = 8", UltimoPedidoPontoWeb));
                        labelDataHoraWeb.Text = String.Format("{0:dd/MM/yyyy HH:mm}", bd.getFieldValueDateTime(String.Format("SELECT TOP 1 PED_DATA FROM [AssepontoPedidosRevendas] WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO = 8", UltimoPedidoPontoWeb)));
                        labelRevendaWeb.Text = "Revenda: " + bd.getFieldValueString(String.Format("SELECT REV_RAZAOSOCIAL FROM AssepontoPedidosRevendas INNER JOIN AssepontoRevendas ON REV_IND = PED_REV_IND WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO = 8", UltimoPedidoPontoWeb)) + "<br>";
                    }
                    else
                        labelRevendaWeb.Visible = false;
                }
                else
                {
                    pontoWeb.Style.Add("display", "none");
                    linkUltimoPedidoWeb.Visible = false;
                    labelDataHoraWeb.Visible = false;
                    labelRevendaWeb.Visible = false;
                    linkNPedidosWeb.Visible = false;
                    labelRevendaTitWeb.Visible = false;
                }
            }
            else
            {
                if (NPedidosPonto4 <= 0 && NPedidosPontoWeb <= 0)
                    PedidosResumosWrapper.Visible = false;
                else
                {
                    if (NPedidosPonto4 > 0)
                    {
                        linkNPedidos4.Text = asseponto4;
                        linkNPedidos4.Visible = true;
                        if (Revenda <= 0)
                        {
                            linkUltimoPedido4.Text = bd.getFieldValueString(String.Format("SELECT PED_CLI_RAZAO FROM AssepontoPedidosRevendas WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO != 8", UltimoPedidoPonto4));
                            labelDataHora4.Text = String.Format("{0:dd/MM/yyyy HH:mm}", bd.getFieldValueDateTime(String.Format("SELECT TOP 1 PED_DATA FROM [AssepontoPedidosRevendas] WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO != 8", UltimoPedidoPonto4)));
                            labelRevenda4.Text = "Revenda: " + bd.getFieldValueString(String.Format("SELECT REV_RAZAOSOCIAL FROM AssepontoPedidosRevendas INNER JOIN AssepontoRevendas ON REV_IND = PED_REV_IND WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO != 8", UltimoPedidoPonto4)) + "<br>";
                        }
                        else
                            labelRevenda4.Visible = false;
                    }
                    else
                    {
                        ponto4.Style.Add("display", "none");
                        linkUltimoPedido4.Visible = false;
                        labelDataHora4.Visible = false;
                        labelRevenda4.Visible = false;
                        linkNPedidos4.Visible = false;
                        labelRevendaTit4.Visible = false;
                    }

                    if (NPedidosPontoWeb > 0)
                    {
                        linkNPedidosWeb.Text = assepontoWeb;
                        linkNPedidosWeb.Visible = true;
                        if (Revenda <= 0)
                        {
                            linkUltimoPedidoWeb.Text = bd.getFieldValueString(String.Format("SELECT PED_CLI_RAZAO FROM AssepontoPedidosRevendas WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO = 8", UltimoPedidoPontoWeb));
                            labelDataHoraWeb.Text = String.Format("{0:dd/MM/yyyy HH:mm}", bd.getFieldValueDateTime(String.Format("SELECT TOP 1 PED_DATA FROM [AssepontoPedidosRevendas] WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO = 8", UltimoPedidoPontoWeb)));
                            labelRevendaWeb.Text = "Revenda: " + bd.getFieldValueString(String.Format("SELECT REV_RAZAOSOCIAL FROM AssepontoPedidosRevendas INNER JOIN AssepontoRevendas ON REV_IND = PED_REV_IND WHERE PED_IND = {0} and PED_VERSAO_AQUISICAO = 8", UltimoPedidoPontoWeb)) + "<br>";
                        }
                        else
                            labelRevendaWeb.Visible = false;
                    }
                    else
                    {
                        pontoWeb.Style.Add("display", "none");
                        linkUltimoPedidoWeb.Visible = false;
                        labelDataHoraWeb.Visible = false;
                        labelRevendaWeb.Visible = false;
                        linkNPedidosWeb.Visible = false;
                        labelRevendaTitWeb.Visible = false;
                    }
                }
            }

            //if (NPedidosPonto4 > 0 || NPedidosPontoWeb > 0)
            //{
            //    if (NPedidosPonto4 == 1)
            //    {
            //        linkNPedidos.Text = "1 pedido em aberto";
            //    }
            //    else
            //    {
            //        linkNPedidos.Text = String.Format("{0} pedidos em aberto", NPedidosPonto4);
            //    }

            //    if (Revenda > 0)
            //    {
            //        labelRevenda.Visible = false;
            //    }
            //    else
            //    {
            //        labelRevenda.Text = "Revenda: " + bd.getFieldValueString(String.Format("SELECT REV_RAZAOSOCIAL FROM AssepontoPedidosRevendas INNER JOIN AssepontoRevendas ON REV_IND = PED_REV_IND WHERE PED_IND = {0}", UltimoPedido)) + "<br>";
            //    }

            //    linkUltimoPedido.Text = bd.getFieldValueString(String.Format("SELECT PED_CLI_RAZAO FROM AssepontoPedidosRevendas WHERE PED_IND = {0}", UltimoPedido));
            //    labelDataHora.Text = String.Format("{0:dd/MM/yyyy HH:mm}", bd.getFieldValueDateTime(String.Format("SELECT TOP 1 PED_DATA FROM [AssepontoPedidosRevendas] WHERE PED_IND = {0}", UltimoPedido)));
            //}
            //else
            //    PedidosResumosWrapper.Visible = false;
        }
    }
}