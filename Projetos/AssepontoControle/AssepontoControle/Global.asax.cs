using System;
using System.Web;
using System.Collections.Specialized;
using Asseponto.Classes;

namespace Asseponto
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            SiteMap.SiteMapResolve += new SiteMapResolveEventHandler(this.ModifyNode);
        }

        protected void Session_Start(object sender, EventArgs e)
        {
           //BDApp bd = new BDApp();
           //bd.executeCommand("DELETE FROM [AssepontoSolicitacoes] WHERE ASOL_CLIENTE IS NULL AND ASOL_DATA_SOLICITACAO < GETDATE()-15 AND ASOL_SENHA IS NULL");
            
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        private SiteMapNode ModifyNode(Object sender, SiteMapResolveEventArgs e)
        {
            if (SiteMap.CurrentNode == null)
            {
                return null;
            }

            Wr.Classes.SiteMapUtils sitemaputils = new Wr.Classes.SiteMapUtils();

            SiteMapNode tempNode = SiteMap.CurrentNode.Clone(true);
            SiteMapNode Node = tempNode;

            while (Node != null)
            {
                string querystring = "";
                string NodeUrl = Node.Url.ToLower();
                string AppPath = e.Context.Request.ApplicationPath.ToLower();

                if (AppPath != "/" && NodeUrl.Substring(0, AppPath.Length).ToLower() == AppPath)
                {
                    NodeUrl = NodeUrl.Remove(0, AppPath.Length);
                }

                if (Node.Url.ToLower() == SiteMap.CurrentNode.Url.ToLower())
                {
                    querystring = HttpContext.Current.Request.Url.Query;
                }
                else
                {
                    querystring = sitemaputils.getQueryStringSite(NodeUrl);
                }

                #region Test Nodes
                if (NodeUrl == "/suporte/revendas/revenda.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "ind")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Title = (ind > 0 ? bd.getRevendaRazaoSocial(ind) : "Nova Revenda");
                        }
                    }

                }

                if (NodeUrl == "/suporte/clientes/cliente.aspx" || NodeUrl == "/revenda/clientes/cliente.aspx" || NodeUrl == "/suporte/treinamentos/addagendacliente.aspx")
                {
                    BDApp bd = new BDApp();
                    BDAppAssefin bdAssefin = new BDAppAssefin();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    string[] keys = queries.AllKeys;
                    bool cliAssefin = false;
                    for (int i = 0; i < keys.Length; i++)
                    {
                        if (keys[i] == "banco")
                            cliAssefin = true;
                    }

                    foreach (String s in queries.AllKeys)
                    {
                        if (!cliAssefin)
                        {
                            if (s == "ind")
                            {
                                int ind = Convert.ToInt32(queries[s]);
                                Node.Title = bd.getClienteRazaoSocial(ind);
                            }
                        }
                        else
                        {
                            if (s == "ind")
                            {
                                int ind = Convert.ToInt32(queries[s]);
                                Node.Title = bdAssefin.getFieldValueString("select CAD_RAZAOSOCIAL from Cadastros where CAD_IND = " + ind.ToString());
                                //Node.Title = bd.getClienteRazaoSocial(ind);
                            }
                        }
                    }
                }

                if (NodeUrl == "/suporte/clientes/manutencoesexpirar.aspx")
                {
                    BDApp bd = new BDApp();
                    int expirado = 1;

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "expirado")
                        {
                            expirado = Convert.ToInt32(queries[s]);
                        }
                    }

                    Node.Title = (expirado == 1) ? "Manutenções Expiradas" : "Manutenções a Expirar";
                }

                if (NodeUrl == "/suporte/clientes/manutencoescliente.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "cliente")
                        {
                            int cliente = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocial(cliente);
                        }
                    }
                }

                if (NodeUrl == "/suporte/atendimento/solicitacoesdesbloqueio.aspx")
                {
                    BDApp bd = new BDApp();
                    int liberado = 0;

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "liberado")
                        {
                            liberado = Convert.ToInt32(queries[s]);
                        }
                    }

                    Node.Description = (liberado == 1) ? "Liberados" : "Em Aberto";
                }

                if (NodeUrl == "/suporte/atendimento/senhas.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "cliente")
                        {
                            int cliente = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocial(cliente);
                        }
                    }
                }

                if (NodeUrl == "/suporte/atendimento/pendencias.aspx")
                {
                    BDApp bd = new BDApp();
                    int situacao = Convert.ToInt32(Types.PendenciaSituacao.EmAberto);

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "situacao")
                        {
                            situacao = Convert.ToInt32(queries[s]);
                        }
                    }

                    Node.Description = Utils.GetDescription((Types.PendenciaSituacao)situacao);
                }

                if (NodeUrl == "/suporte/clientes/pendencia.aspx" ||
                    NodeUrl == "/suporte/atendimento/pendencia.aspx" || 
                    NodeUrl == "/revenda/clientes/pendencia.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "ind")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocialFromPendencia(ind);
                            string Numero = bd.getProtocoloFromPendencia(ind);

                            if (Numero != "")
                                Node.Title += " nº " + Numero;
                        }
                    }
                }

                if (NodeUrl == "/suporte/clientes/pendencias.aspx" || 
                    NodeUrl == "/revenda/clientes/pendencias.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "cliente")
                        {
                            int cliente = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocial(cliente);
                        }
                    }
                }

                if (NodeUrl.Contains("/suporte/atendimento/cliente.aspx"))
                //if (NodeUrl == "/assecont/atendimento/cliente.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "ind")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = Node.Title;
                            Node.Title = bd.getClienteRazaoSocial(ind);
                        }
                    }
                }

                if (NodeUrl == "/suporte/atendimento/senhas.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "cliente")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocial(ind);
                        }
                    }
                }

                if (NodeUrl == "/suporte/implantacoes/default.aspx" || (NodeUrl == "/revenda/implantacoes/default.aspx"))
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);
                    string StatusDescricao = Utils.GetDescription(Types.ImplantacaoStatus.EmAberto);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "status")
                        {
                            int status = Convert.ToInt32(queries[s]);

                            StatusDescricao = Utils.GetDescription((Types.ImplantacaoStatus) status);
                        }
                    }

                    Node.Description = StatusDescricao;
                }

                if (NodeUrl == "/suporte/implantacoes/implantacaoassefin.aspx" || 
                    NodeUrl == "/suporte/implantacoes/implantacao.aspx" ||
                    NodeUrl == "/suporte/implantacoes/agenda.aspx" || 
                    NodeUrl == "/revenda/implantacoes/implantacao.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "ind")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocialFromImplantacao(ind);
                        }
                    }
                }

                if (NodeUrl == "/suporte/implantacoes/pendencia.aspx" || NodeUrl == "/revenda/implantacoes/pendencia.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "ind")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocialFromPendencia(ind);

                            string Numero = bd.getProtocoloFromPendencia(ind);

                            if (Numero != "")
                                Node.Title += " nº " + Numero;
                        }

                        if (s == "implantacao")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocialFromImplantacao(ind);

                            string Numero = bd.getProtocoloFromPendencia(ind);

                            if (Numero != "")
                                Node.Title += " nº " + Numero;
                        }
                    }
                }

                if (NodeUrl == "/suporte/implantacoes/pendencias.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "implantacao")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getClienteRazaoSocialFromImplantacao(ind);
                        }
                    }
                }

                if (NodeUrl == "/suporte/revendas/clientes.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "revenda")
                        {
                            int ind = Convert.ToInt32(queries[s]);
                            Node.Description = "_" + bd.getRevendaRazaoSocial(ind);
                        }
                    }
                }

                if (NodeUrl == "/suporte/pedidos/default.aspx" ||
                    NodeUrl == "/revenda/pedidos/default.aspx")
                {
                    BDApp bd = new BDApp();

                    NameValueCollection queries = HttpUtility.ParseQueryString(querystring);

                    string Descricao = "";

                    foreach (String s in queries.AllKeys)
                    {
                        if (s == "status")
                        {
                            Descricao = Convert.ToInt32(queries[s]) == 1 ? "Pedidos em Aberto" : "Pedidos Fechados";
                        }
                    }

                    if (Descricao == "")
                    {
                        Descricao = "Pedidos em Aberto";
                    }

                    Node.Title = Descricao;
                }

                if (NodeUrl == "/suporte/default.aspx")
                {
                    UserApp user = new UserApp();
                    if (UserApp.UserId == 0)
                    {
                        Node.Title = "Login";
                    }
                }

                if (NodeUrl == "/default.aspx" && tempNode.ParentNode == null)
                {
                    Node.Title = "";
                }

                #endregion

                Node.Url = Node.Url + querystring;
                Node = Node.ParentNode;
            }

            return tempNode;
        }
    }
}