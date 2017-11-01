using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class Default : System.Web.UI.Page
    {
        private RadMenuItem RadMenu;
        private BDApp bd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bd = new BDApp();
                pontoLink1.Text += " (" + bd.getCountImplantacaoAndamento(6, 1) + ")";
                pontoLink2.Text += " (" + bd.getCountImplantacaoAndamento(1, 1) + ")";
                pontoLink3.Text += " (" + bd.getCountImplantacaoAndamento(2, 1) + ")";
                pontoLink4.Text += " (" + bd.getCountImplantacaoAndamento(4, 1) + ")";
                pontoLink5.Text += " (" + bd.getCountImplantacaoAndamento(5, 1) + ")";
                pontoLink6.Text += " (" + bd.getCountImplantacaoAndamento(9, 1) + ")";
                
                webLink1.Text += " (" + bd.getCountImplantacaoAndamento(6, 1, 1) + ")";
                webLink2.Text += " (" + bd.getCountImplantacaoAndamento(1, 1, 1) + ")";
                webLink3.Text += " (" + bd.getCountImplantacaoAndamento(2, 1, 1) + ")";
                webLink4.Text += " (" + bd.getCountImplantacaoAndamento(4, 1, 1) + ")";
                webLink5.Text += " (" + bd.getCountImplantacaoAndamento(5, 1, 1) + ")";
                webLink6.Text += " (" + bd.getCountImplantacaoAndamento(9, 1, 1) + ")";

                //RadMenu2.Items.FindItemByText("Primeiro Contato").Text += " (" + bd.getCountImplantacaoAndamento(6, 1) + ")";
                //RadMenu2.Items.FindItemByText("Aguardando Planilha").Text += " (" + bd.getCountImplantacaoAndamento(1, 1) + ")";
                //RadMenu2.Items.FindItemByText("Aguardando Treinamento").Text += " (" + bd.getCountImplantacaoAndamento(2, 1) + ")";
                //RadMenu2.Items.FindItemByText("REP Manutenção").Text += " (" + bd.getCountImplantacaoAndamento(4, 1) + ")";
                //RadMenu2.Items.FindItemByText("Retorno do Cliente").Text += " (" + bd.getCountImplantacaoAndamento(5, 1) + ")";
                //RadMenu2.Items.FindItemByText("Agendamento").Text += " (" + bd.getCountImplantacaoAndamento(9, 1) + ")";
                
                    //<telerik:RadMenuItem runat="server" Text="Agendamentos hoje" NavigateUrl="~/suporte/implantacoes/Agenda.aspx?tipo=1" />
                    //<telerik:RadMenuItem runat="server" Text="Todos Agendamentos" NavigateUrl="~/suporte/implantacoes/Agenda.aspx?tipo=2" />

                RadMenuItem rmi1 = new RadMenuItem();
                rmi1.Text = "Agendamentos hoje (" + bd.getCountImplantacaoAgendasHoje().ToString() + ")";
                rmi1.NavigateUrl = "~/suporte/implantacoes/Agenda.aspx?ind=0&data=1&finalizado=0&tipo=0&status=0&datavalue=" + DateTime.Now.ToString("dd/MM/yyyy");
                RadMenu3.Items.Add(rmi1);
                //RadMenu3.Items.FindItemByText("Agendamentos hoje").Text += " (" + bd.getCountImplantacaoAgendasHoje().ToString() + ")";

                RadMenuItem rmi2 = new RadMenuItem();
                rmi2.Text = "Todos Agendamentos (" + bd.getFieldValueString("SELECT COUNT(*) FROM AssepontoImplantacoes WHERE IM_DTAGENDA IS NOT NULL AND IM_AGENDA_CONCLUIDO_POR IS NULL") + ")";
                rmi2.NavigateUrl = "~/suporte/implantacoes/Agenda.aspx?ind=0&data=0&finalizado=0&tipo=0&status=0&datavalue=" + DateTime.Now.ToString("dd/MM/yyyy");
                RadMenu3.Items.Add(rmi2);
                //RadMenu3.Items.FindItemByText("Todos Agendamentos").Text += " (" + bd.getFieldValueString("SELECT COUNT(*) FROM AssepontoImplantacoes WHERE IM_DTAGENDA IS NOT NULL AND IM_AGENDA_CONCLUIDO_POR IS NULL") + ")";

                bool assepontoWeb;
                if (!string.IsNullOrEmpty(Request.QueryString["web"]))
                    assepontoWeb = (Convert.ToInt32(Request.QueryString["web"]) != 0);
                else
                    assepontoWeb = false;


                switch (Convert.ToInt32(Request.QueryString["andam"]))
                {
                    case 1:
                        PreencherMenu("Cobrança Planilha", 1, 0, assepontoWeb);
                        break;

                    case 2:
                        PreencherMenu("Cobrança Treinamento", 2, 0, assepontoWeb);
                        break;

                    case 5:
                        PreencherMenu("Cobrança Retorno", 5, 0, assepontoWeb);
                        PreencherMenu("Rodar Script", 5, 1, assepontoWeb);
                        PreencherMenu("1º Contato C/ Responsavel", 5, 2, assepontoWeb);
                        PreencherMenu("Instalação Inicial", 5, 3, assepontoWeb);
                        PreencherMenu("Retorno da Revenda", 5, 5, assepontoWeb);
                        PreencherMenu("Configurar REP", 5, 6, assepontoWeb);
                        break;

                    case 9:
                        PreencherMenu("Cobrança de Planilha", 9, 7, assepontoWeb);
                        PreencherMenu("Rodar Script", 9, 8, assepontoWeb);
                        PreencherMenu("Retorno", 9, 9, assepontoWeb);
                        PreencherMenu("Treinamento", 9, 10, assepontoWeb);
                        break;
                }


                List<String> listaItens;
                string STR = "SELECT (LTRIM(RTRIM(TIPO_STAT_NOME)) + ';' + " +
                             "	    LTRIM(RTRIM(TIPO_STAT_IND)) + ';' + " +
                             "		CONVERT(varchar(3), (SELECT COUNT(*) FROM AssepontoImplantacoesAgenda " +
		                     "      INNER JOIN AssepontoImplantacoes on AGE_IMPLANTACAO = IM_IND " +
		                     "      WHERE IM_ANDAMENTO = TIPO_STAT_STATUS AND " +
			                 "          IM_ANDAMENTO_TIPO = TIPO_STAT_IND AND AGE_FINALIZADO_POR IS NULL))) AS VALOR " +
                             "FROM AssepontoImplantacoesStatusTipo " +
                             "WHERE TIPO_STAT_STATUS = {0} " +
                             "ORDER BY VALOR ";

                listaItens = bd.getFieldValueListString(String.Format(STR, (int)Types.ImplantacaoAndamento.Agendamento));
                foreach (String l in listaItens)
                {
                    String[] split = l.Split(new String[] { ";" }, StringSplitOptions.None);
                    string count = split[2];
                    string ind = split[1];
                    string texto = split[0];
                    string url = "~/suporte/implantacoes/Agenda.aspx?ind={0}&data={1}&finalizado={2}&tipo={3}&status={4}&datavalue=" + DateTime.Now.ToString("dd/MM/yyyy");
                    RadMenuItem rmi = new RadMenuItem();
                    rmi.Text = texto + " (" + count + ")";
                    rmi.NavigateUrl = String.Format(url + "&statTipo={5}", 0, 0, 0, 2, (int)Types.ImplantacaoAndamento.Agendamento, ind);
                    RadMenu3.Items.Add(rmi);
                }
            }
            else
            {
                bool assepontoWeb;
                if (!string.IsNullOrEmpty(Request.QueryString["web"]))
                    assepontoWeb = (Convert.ToInt32(Request.QueryString["web"]) != 0);
                else
                    assepontoWeb = false;
                bd = new BDApp();
                switch (Convert.ToInt32(Request.QueryString["andam"]))
                {
                    case 1:
                        PreencherMenu("Cobrança Planilha", 1, 0, assepontoWeb);
                        break;

                    case 2:
                        PreencherMenu("Cobrança Treinamento", 2, 0, assepontoWeb);
                        break;

                    case 5:
                        PreencherMenu("Cobrança Retorno", 5, 0, assepontoWeb);
                        PreencherMenu("Rodar Script", 5, 1, assepontoWeb);
                        PreencherMenu("1º Contato C/ Responsavel", 5, 2, assepontoWeb);
                        PreencherMenu("Instalação Inicial", 5, 3, assepontoWeb);
                        PreencherMenu("Retorno da Revenda", 5, 5, assepontoWeb);
                        PreencherMenu("Configurar REP", 5, 6, assepontoWeb);
                        break;

                    case 9:
                        PreencherMenu("Cobrança de Planilha", 9, 7, assepontoWeb);
                        PreencherMenu("Rodar Script", 9, 8, assepontoWeb);
                        PreencherMenu("Retorno", 9, 9, assepontoWeb);
                        PreencherMenu("Treinamento", 9, 10, assepontoWeb);
                        break;
                }
            }
        }

        void PreencherMenu(string Titulo, int andam, int andamTipo, bool assepontoWeb)
        {
            //RadMenu = new RadMenuItem();

            HtmlGenericControl li = new HtmlGenericControl("li");
            HtmlGenericControl a = new HtmlGenericControl("a");
            string link = "default.aspx?status=1&andam={0}&iniciadas=2&tip={1}";
            a.InnerText = Titulo;
            //RadMenu.Text = Titulo;
            if (assepontoWeb)
                link += "&web=1";

            if (andamTipo > 0)
            {
                a.InnerText += " (" + bd.getCountImplantacaoAndamentoTipo(andam, 1, andamTipo, assepontoWeb).ToString() + ")";
                //RadMenu.Text += " (" + bd.getCountImplantacaoAndamentoTipo(andam, 1, andamTipo) + ")";
                a.Attributes.Add("href", string.Format(link, andam, andamTipo));
                //RadMenu.NavigateUrl = string.Format("~/Suporte/Implantacoes/default.aspx?status=1&andam={0}&iniciadas=2&tip={1}", andam, andamTipo);
            }
            else
            {
                li.Style.Add("color", "#000000");
                li.Style.Add("background", "darkgrey");
                //RadMenu.ForeColor = System.Drawing.Color.White;
                //RadMenu.BackColor = System.Drawing.ColorTranslator.FromHtml("#026BD8");
                a.Attributes.Add("href", string.Format("ImplantacaoEmails.aspx?status=1&andam={0}&iniciadas=1&tip={1}", andam, andamTipo));
                //RadMenu.NavigateUrl = string.Format("~/Suporte/implantacoes/ImplantacaoEmails.aspx?status=1&andam={0}&iniciadas=1&tip={1}", andam, andamTipo);
            }

            li.Controls.Add(a);
            if (assepontoWeb)
            {
                web.Controls.Add(li);
                web.DataBind();
            }
            else
            {
                ponto4.Controls.Add(li);
                ponto4.DataBind();
            }
            //RadMenu2.Items.Add(RadMenu);
        }
    }
}