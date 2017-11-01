using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using Wr.Classes;
using System.Net.Mail;

namespace AssecontNovo.Informativos
{
    public partial class Informativo : System.Web.UI.Page
    {
        private List<string> ClientesEmail;
        private List<string> ListLog;
        private int inf_numero;
        private BDAppAssecont bdAssecont;
        private BDAppTecnologia bdTecnologia;
        private string e = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            ListLog = new List<string>();
            bdAssecont = new BDAppAssecont();
            inf_numero = Convert.ToInt32(Request.QueryString["ind"]);
            if (!IsPostBack)
            {
                CarregarChecklist();
                txtDiasAntes.Text = "10";
                txtDiasDepois.Text = "10";
            }
        }

        #region CheckList
        void CarregarChecklist()
        {
            Types.PerfilItemIndiceInformativo[] resAss = (Types.PerfilItemIndiceInformativo[])Enum.GetValues(typeof(Types.PerfilItemIndiceInformativo));
            foreach (Types.PerfilItemIndiceInformativo a in resAss)
                ChecklistAssecont.Items.Add(new ListItem(a.GetDescription(), ((int)a).ToString()));

            Types.perfilTecnologia[] resTec = (Types.perfilTecnologia[])Enum.GetValues(typeof(Types.perfilTecnologia));
            foreach (Types.perfilTecnologia a in resTec)
                ChecklistTecnologia.Items.Add(new ListItem(a.GetDescription(), ((int)a).ToString()));

            Types.perfilInterno[] resInt = (Types.perfilInterno[])Enum.GetValues(typeof(Types.perfilInterno));
            foreach (Types.perfilInterno a in resInt)
                ChecklistInterno.Items.Add(new ListItem(a.GetDescription(), ((int)a).ToString()));
        }
        #endregion

        public void EnviarEmailInformativo()
        {
            bool erro = false;
            int counterrors = 0;
            string template = "EmailInformativos.htm";

            if (ChecklistCabecalhoRodape.SelectedValue.Equals("0"))
                template = "EmailInformativoSemCabecalho.htm";

            EmailInformativos InfoEmail = new EmailInformativos("informativo@assecont.com.br", null, Server.MapPath("") + "\\..\\Classes\\Emails\\Informativos\\" + template);
            //EmailInformativos InfoEmail = new EmailInformativos("notificacao@assecont.com.br", null, Server.MapPath("") + "\\..\\Classes\\Emails\\Informativos\\" + template);
            InfoEmail.setTitulo(((Label)FormViewInfo.FindControl("lbTitulo")).Text);
            InfoEmail.CorpoEmailTemp(((Label)FormViewInfo.FindControl("lbHTML")).Text, inf_numero.ToString());

            int i = (ClientesEmail.Count - 1) / 15;
            List<string> list15Emails = new List<string>();

            try
            {
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Write("<div style='margin-top: 50px; margin: 0 auto; width: 1100px; height: 600px; '><textarea id='TextArea1' Class='textbox' ReadOnly='true' style='height: 600px; width: 1100px; font-family: courier new;'>");

                int x = 0;
                foreach (string email in ClientesEmail)
                {
                    if (email.Contains("--- "))
                    {
                        HttpContext.Current.Response.Write("\n\n" + email + "\n");
                        HttpContext.Current.Response.Flush();

                        continue;
                    }

                    list15Emails.Add(email);

                    if (i == 0)
                    {
                        foreach (string item in list15Emails)
                        {
                            string enter = "\n";
                            string divi = "| ";
                            SmtpStatusCode status = InfoEmail.Send(item);
                            if (status != SmtpStatusCode.Ok)
                            {
                                if (!erro)
                                    erro = true;
                                counterrors++;
                            }
                            string write = item + " - " + status;
                            if (x == 3)
                                x = 0;

                            if (x == 0)
                                write = (enter + write).PadRight(50);
                            else if (x > 0)
                                write = (divi + write).PadRight(50);
                            x++;
                            HttpContext.Current.Response.Write((write));
                            HttpContext.Current.Response.Flush();
                            ListLog.Add("Informativo enviado para: " + write.Replace(@"\", "/").Replace("|", "").Replace("  ", ""));

                            //InfoEmail.Send(list15Emails);
                            //list15Emails = new List<string>();
                            //string query = "\n" + email + " - OK";
                            //HttpContext.Current.Response.Write((query).PadRight(60));
                            //HttpContext.Current.Response.Flush();
                            //ListLog.Add(query.Replace(@"\", "/"));
                        }
                        list15Emails = new List<string>();
                    }

                    if (list15Emails.Count == 15 && i > 0)
                    {
                        x = 0;
                        string enter = "\n";
                        string divi = "| ";
                        foreach (string item in list15Emails)
                        {
                            SmtpStatusCode status = InfoEmail.Send(item);
                            if (status != SmtpStatusCode.Ok)
                            {
                                if (!erro)
                                    erro = true;
                                counterrors++;
                            }
                            string write = item + " - " + status;
                            if (x == 3)
                                x = 0;

                            if (x == 0)
                                write = (enter + write).PadRight(50);
                            else if (x > 0)
                                write = (divi + write).PadRight(50);
                            x++;
                            HttpContext.Current.Response.Write((write));
                            HttpContext.Current.Response.Flush();
                            ListLog.Add("Informativo enviado para: " + write.Replace(@"\", "/").Replace("|", "").Replace("  ", ""));
                        }

                        //InfoEmail.Send(list15Emails);
                        //for (int a = 0; a < list15Emails.Count; a++)
                        //{
                        //    HttpContext.Current.Response.Write(("\n" + list15Emails[a] + " - OK").PadRight(50));
                        //    HttpContext.Current.Response.Write(("| " + list15Emails[++a] + " - OK").PadRight(50));
                        //    HttpContext.Current.Response.Write(("| " + list15Emails[++a] + " - OK").PadRight(50));
                        //}

                        HttpContext.Current.Response.Flush();

                        list15Emails = new List<string>();
                        i--;
                    }
                }
            }
            catch (Exception ex)
            {
                foreach (string email in list15Emails)
                {
                    string query = email + " ERRO: " + ex.Message;
                    HttpContext.Current.Response.Write(query);
                    HttpContext.Current.Response.Flush();
                    ListLog.Add(query.Replace(@"\", "/"));
                }
            }

            HttpContext.Current.Response.Write("</textarea></ div>");
            HttpContext.Current.Response.Write("<div style='margin: 0 auto; position: fixed; background-color: white;'>"  + 
                "<span style='font-size: 20pt;'> " + 
                (!erro ? "FINALIZADO COM SUCESSO</span> " : "FINALIZADO COM " + counterrors.ToString() + " ERROS!!</span>") + 
                "<a style='margin-left: 180px; font-size: 12pt; color: white; background: #336CAB; padding: 4px;' href='http://www.assecont.com.br/Informativos/listarInformativos.aspx'> Voltar para os Informativos </a> </div>");
            HttpContext.Current.Response.Flush();
        }

        #region getEmails
        public void getEmails()
        {
            int j = 0;
            ClientesEmail = new List<string>();

            //ClientesEmail.Add("--- ASSECONT / CLIENTES ---");
            //ClientesEmail.Add("henrique@assecont.com.br");
            //ClientesEmail.Add("henriqueconradochamizo@gmail.com");
            //ClientesEmail.Add("henrique_conrado@live.com");
            //ClientesEmail.Add("wrenne@assecont.com.br");
            foreach (ListItem check in ChecklistAssecont.Items)
            {
                if (check.Selected)
                {
                    if (j == 0)
                    {
                        ClientesEmail.Add("--- ASSECONT / CLIENTES ---");
                        j = 1;
                    }

                    getEmailsAssecont(Convert.ToInt32(check.Value));
                }
            }

            j = 0;

            foreach (ListItem check in ChecklistInterno.Items)
            {
                if (check.Selected)
                {
                    if (j == 0)
                    {
                        ClientesEmail.Add("--- ASSECONT / INTERNO ---");
                        j = 1;
                    }

                    getEmailsAssecontLoginInterno(Convert.ToInt32(check.Value));
                }
            }

            bdTecnologia = new BDAppTecnologia();

            if (ChecklistTecnologia.Items.FindByValue(((int)Types.perfilTecnologia.Clientes).ToString()).Selected)
                getEmailsTecnologiaClientes(bdTecnologia);

            if (ChecklistTecnologia.Items.FindByValue(((int)Types.perfilTecnologia.ClientesSemManutencao).ToString()).Selected)
                getEmailsTecnologiaClientesSemManutencao(bdTecnologia);

            if (ChecklistTecnologia.Items.FindByValue(((int)Types.perfilTecnologia.ClientesComManutencao60).ToString()).Selected)
                getEmailsTecnologiaClientesComManutencao60(bdTecnologia);

            if (ChecklistTecnologia.Items.FindByValue(((int)Types.perfilTecnologia.Revendas).ToString()).Selected)
                getEmailsTecnologiaRevendas(bdTecnologia);
        }

        public void getEmailsAssecont(int perfil)
        {
            DataTable tbAssecont = bdAssecont.getListaEmailsAssecontExterno(perfil);
            foreach (DataRow reader in tbAssecont.Rows)
                ContainsEmail_vazio(reader["EMAIL"].ToString(), perfil);

            //ListLog = ClientesEmail;
            setInforamtivoAssecontExterno(perfil);
        }

        public void getEmailsAssecontLoginInterno(int perfil)
        {
            DataTable tbAssecont = bdAssecont.getListaEmailsAssecontInterno(perfil);
            foreach (DataRow reader in tbAssecont.Rows)
                ContainsEmail_vazio(reader["EMAIL"].ToString(), perfil);

            setInforamtivoAssecontInterno(perfil);
        }

        public void getEmailsTecnologiaClientes(BD bd)
        {
            ClientesEmail.Add("--- TECNOLOGIA / CLIENTES ---");
            DataTable tbTecnologia = bdTecnologia.getListaEmailsCliente(true);

            foreach (DataRow reader in tbTecnologia.Rows)
            {
                string[] emails = reader["EMAILS"].ToString().Split(';');

                for (int i = 0; i < emails.Length; i++)
                    ContainsEmail_vazio(emails[i].ToLower().Trim());
            }

            string query = "UPDATE Informativos SET INF_ASSEPONTO_CLIENTE = 1 WHERE INF_NUMERO = " + inf_numero;
            bdAssecont.executeCommand(query);
            ListLog.Add("Comando SQL ..." + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + " : " + query);
        }

        public void getEmailsTecnologiaClientesComManutencao60(BD bd)
        {
            ClientesEmail.Add("--- TECNOLOGIA / CLIENTES COM MANUTENCAO 60 ---");
            int antes;
            int depois;
            try
            {
                antes = Convert.ToInt32(txtDiasAntes.Text);
                depois = Convert.ToInt32(txtDiasDepois.Text);
            }
            catch
            {
                antes = 10;
                depois = 10;
            }
            DataTable tbTecnologia = bdTecnologia.getListaEmailsClienteComManutencao60(antes, depois, true);

            foreach (DataRow reader in tbTecnologia.Rows)
            {
                string[] emails = reader["EMAILS"].ToString().Split(';');

                for (int i = 0; i < emails.Length; i++)
                    ContainsEmail_vazio(emails[i].ToLower().Trim());
            }

            string query = "UPDATE Informativos SET INF_ASSEPONTO_CLIENTE_SEM_MANUTENCAO = 1 WHERE INF_NUMERO = " + inf_numero;
            bdAssecont.executeCommand(query);
            ListLog.Add("Comando SQL ..." + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + " : " + query);
        }

        public void getEmailsTecnologiaClientesSemManutencao(BD bd)
        {
            ClientesEmail.Add("--- TECNOLOGIA / CLIENTES SEM MANUTENCAO ---");
            DataTable tbTecnologia = bdTecnologia.getListaEmailsClienteSemManutencao(true);

            foreach (DataRow reader in tbTecnologia.Rows)
            {
                string[] emails = reader["EMAILS"].ToString().Split(new String[] { ";" }, StringSplitOptions.None);

                for (int i = 0; i < emails.Length; i++)
                    ContainsEmail_vazio(emails[i].ToLower().Trim());
            }

            string query = "UPDATE Informativos SET INF_ASSEPONTO_CLIENTE_SEM_MANUTENCAO = 1 WHERE INF_NUMERO = " + inf_numero;
            bdAssecont.executeCommand(query);
            ListLog.Add("Comando SQL ..." + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + " : " + query);
        }

        public void getEmailsTecnologiaRevendas(BD bd)
        {
            ClientesEmail.Add("--- TECNOLOGIA / REVENDAS ---");
            DataTable tbRevenda = bdTecnologia.getListaEmailsRevendas(true);

            foreach (DataRow reader in tbRevenda.Rows)
            {
                string[] emails = reader["EMAILS"].ToString().Split(';');

                for (int i = 0; i < emails.Length; i++)
                    ContainsEmail_vazio(emails[i].ToLower().Trim());
            }

            string query = "UPDATE Informativos SET INF_ASSEPONTO_REVENDA = 1 WHERE INF_NUMERO = " + inf_numero;
            bdAssecont.executeCommand(query);
            ListLog.Add("Comando SQL ..." + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + " : " + query);
        }
        #endregion

        #region Button's
        protected void btEnviar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    getEmails();
                    EnviarEmailInformativo();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                    ListLog.Add("Exception: " + ex.Message + " ... " + DateTime.Now.ToString("dd/MM/yyyy hh:mm"));
                }
                try
                {
                    Classes.Log log = new Classes.Log(ListLog);
                    log.CreateLog();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
                
            }
        }

        protected void btExcluir_Click(object sender, EventArgs e)
        {
            try
            {
                bdAssecont = new BDAppAssecont();
                bdAssecont.executeCommand(string.Format("DELETE FROM Informativos WHERE INF_NUMERO = {0}", inf_numero));
            }
            catch
            {

            }
            finally
            {
                Response.Redirect("~/informativos/listarInformativos.aspx");
            }
        }
        #endregion

        public void ContainsEmail_vazio(string Email, int perfil = 0)
        {
            if (!ClientesEmail.Contains(Email) && !string.IsNullOrEmpty(Email))
            {
                ClientesEmail.Add(Email);
                ListLog.Add("Email carregado(" + perfil + ") ... " + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + ": " + Email);
            }
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = bdAssecont.Conn.ConnectionString;
            //ListLog.Add("ConnectionString: " + bdAssecont.Conn.ConnectionString);
        }

        #region Update Informativo
        public void setInforamtivoAssecontInterno(int perfil)
        {
            string query = "";
            switch (perfil)
            {
                case (int)Types.perfilInterno.Fiscal:
                    query = "UPDATE Informativos SET INF_INTERNO_FISCAL = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;

                case (int)Types.perfilInterno.Contabil:
                    query = "UPDATE Informativos SET INF_INTERNO_CONTABIL = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;

                case (int)Types.perfilInterno.Pessoal:
                    query = "UPDATE Informativos SET INF_INTERNO_PESSOAL = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;

                case (int)Types.perfilInterno.Legalizacao:
                    //bdAssecont.executeCommand("UPDATE Informativos SET INF_INTERNO_DIRETORIA = 1 WHERE INF_NUMERO = " + queryInd);
                    break;

                case (int)Types.perfilInterno.Ged:
                    //bdAssecont.executeCommand("UPDATE Informativos SET INF_INTERNO_DIRETORIA = 1 WHERE INF_NUMERO = " + queryInd);
                    break;

                default:
                    query = "UPDATE Informativos SET INF_INTERNO_DIRETORIA = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;
            }
            if (!string.IsNullOrEmpty(query))
            {
                bdAssecont.executeCommand(query);
                ListLog.Add("Comando SQL ..." + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + " : " + query + " ... o perfil externo é " + perfil);
            }
        }

        public void setInforamtivoAssecontExterno(int perfil)
        {
            string query = "";
            switch (perfil)
            {
                case (int)Types.PerfilItemIndiceInformativo.LucroPresumido:
                    query = "UPDATE Informativos SET INF_LUCRO_PRESUMIDO = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;

                case (int)Types.PerfilItemIndiceInformativo.LucroReal:
                    query = "UPDATE Informativos SET INF_LUCRO_REAL = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;

                case (int)Types.PerfilItemIndiceInformativo.Simples:
                    query = "UPDATE Informativos SET INF_SIMPLES = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;

                default:
                    query = "UPDATE Informativos SET INF_PESSOA_FISICA = 1 WHERE INF_NUMERO = " + inf_numero;
                    break;
            }
            bdAssecont.executeCommand(query);
            ListLog.Add("Comando SQL ..." + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + " : " + query + " ... o perfil externo é " + perfil);
        }
        #endregion
    }
}