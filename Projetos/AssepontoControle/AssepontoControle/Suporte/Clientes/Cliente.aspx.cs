using System;
using Asseponto.Classes;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using BLL;

namespace Asseponto.Suporte.Clientes
{
    public partial class Cliente : System.Web.UI.Page
    {
        private BDApp bdAssepontoControle;
        private BDAppAssefin bdAssefin;
        private UserApp user;
        private DataTable tableAssepontoControle;
        private DataTable tableAssefin;
        private int clienteId;
        private int clienteIdAssefin;
        private bool clieAssefin;
        private string cnpj_cpf;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                bdAssepontoControle = new BDApp();
                bdAssefin = new BDAppAssefin();
                user = new UserApp();

                if (Request.QueryString["banco"] == "fin")
                {
                    clieAssefin = true;
                    clienteId = 0;
                    clienteIdAssefin = Convert.ToInt32(Request.QueryString["ind"]);
                }
                else
                {
                    clieAssefin = false;
                    clienteId = Convert.ToInt32(Request.QueryString["ind"]);
                    clienteIdAssefin = 0;
                }

                if (clieAssefin)
                {
                    tableAssefin = bdAssefin.getCadastro(clienteIdAssefin);

                    if (tableAssefin.Rows.Count != 1)
                        Response.Redirect("default.aspx");
                    else
                    {
                        cnpj_cpf = String.IsNullOrEmpty(tableAssefin.Rows[0]["CAD_CNPJ"].ToString()) ? tableAssefin.Rows[0]["CAD_CPF"].ToString() : tableAssefin.Rows[0]["CAD_CNPJ"].ToString();
                        string select = "SELECT [CAD_IND], [CAD_REVENDA], [CAD_RAZAOSOCIAL], [CAD_FANTASIA], [CAD_CNPJ], [CAD_CPF], [CAD_IE], [CAD_ENDERECO], [CAD_ENDERECO_NUMERO], " +
                                               "[CAD_ENDERECO_COMPLEMENTO], [CAD_CIDADE], [CAD_BAIRRO], [CAD_UF], [CAD_CEP], [CAD_TELEFONE1], [CAD_TELEFONE2], [CAD_TELEFONE3], [CAD_FAX], " +
                                               "[CAD_CONTATO], [CAD_CONTATO2], [CAD_CONTATO3], [_CAD_ENT_ENDERECO], [_CAD_ENT_CIDADE], [_CAD_ENT_BAIRRO], [_CAD_ENT_CEP], [_CAD_ENT_TELEFONE1], " +
                                               "[_CAD_ENT_TELEFONE2], [_CAD_ENT_FAX], [CAD_ENT_CONTATO], [CAD_OBS], [_CAD_PRODUTO], [CAD_EMAIL], [CAD_DATAAQUISICAO], [_CAD_BLOQUEADO], [CAD_NUMERO], " +
                                               "[_CAD_BLOQUEIO_LIBERADO], [CAD_TELEFONE1_DDD], [CAD_TELEFONE2_DDD], [CAD_TELEFONE3_DDD], [CAD_REP_FABRICANTE], [CAD_MODELOREP], [CAD_SKYPE], " +
                                               "[CAD_EMAIL2], [CAD_EMAIL3], [CAD_DTA_CERTIFICADO], [CAD_IMPRESSAO_CERTIFICADO], [CAD_DTA_COMUNICADO], [CAD_ASSEFIN], [CAD_ASSEPONTO4], " +
                                               "[CAD_VERSAO_ASSEFIN], [CAD_RECEBEU_ATESTADO], [CAD_ATENDIMENTO], [CAD_CELULAR_DDD], [CAD_CELULAR], [CAD_CELULAR_ACEITA], [CAD_QTD_FUNCIONARIO], " +
                                               "[CAD_FINANCEIRO_EMAIL], [CAD_FINANCEIRO_EMAIL2], [CAD_FINANCEIRO_EMAIL3], [CAD_CADASTRO_ATUALIZADOEM], [CAD_CADASTRO_ATUALIZADOPOR], [CAD_TESTE], " +
                                               "[CAD_FINANCEIRO_CONTATO], [CAD_FINANCEIRO_TELEFONE1_DDD], [CAD_FINANCEIRO_TELEFONE1], [CAD_FINANCEIRO_TELEFONE2_DDD], [CAD_FINANCEIRO_TELEFONE2], " +
                                               "[CAD_FINANCEIRO_CELULAR_DDD], [CAD_FINANCEIRO_CELULAR], [CAD_FINANCEIRO_CELULAR_ACEITA], [CAD_MATRIZ], [CAD_EMAIL_ENVIAR], [CAD_EMAIL2_ENVIAR], " +
                                               "[CAD_EMAIL3_ENVIAR] " +
                                        "FROM [dbo].[AssepontoClientes] " +
                                        "WHERE CAD_CNPJ = '" + cnpj_cpf + "' OR CAD_CPF = '" + cnpj_cpf + "' ";
                        tableAssepontoControle = bdAssepontoControle.getDataTable(select);
                        if (tableAssepontoControle.Rows.Count != 1)
                            Response.Redirect("default.aspx");
                        else
                        {
                            clienteId = Convert.ToInt32(tableAssepontoControle.Rows[0]["CAD_IND"]);
                            RadMenu2.Visible = false;
                            Permissao();
                        }
                    }
                }
                else
                {
                    string select = "SELECT [CAD_IND], [CAD_REVENDA], [CAD_RAZAOSOCIAL], [CAD_FANTASIA], [CAD_CNPJ], [CAD_CPF], [CAD_IE], [CAD_ENDERECO], [CAD_ENDERECO_NUMERO], " +
                                                  "[CAD_ENDERECO_COMPLEMENTO], [CAD_CIDADE], [CAD_BAIRRO], [CAD_UF], [CAD_CEP], [CAD_TELEFONE1], [CAD_TELEFONE2], [CAD_TELEFONE3], [CAD_FAX], " +
                                                  "[CAD_CONTATO], [CAD_CONTATO2], [CAD_CONTATO3], [_CAD_ENT_ENDERECO], [_CAD_ENT_CIDADE], [_CAD_ENT_BAIRRO], [_CAD_ENT_CEP], [_CAD_ENT_TELEFONE1], " +
                                                  "[_CAD_ENT_TELEFONE2], [_CAD_ENT_FAX], [CAD_ENT_CONTATO], [CAD_OBS], [_CAD_PRODUTO], [CAD_EMAIL], [CAD_DATAAQUISICAO], [_CAD_BLOQUEADO], [CAD_NUMERO], " +
                                                  "[_CAD_BLOQUEIO_LIBERADO], [CAD_TELEFONE1_DDD], [CAD_TELEFONE2_DDD], [CAD_TELEFONE3_DDD], [CAD_REP_FABRICANTE], [CAD_MODELOREP], [CAD_SKYPE], " +
                                                  "[CAD_EMAIL2], [CAD_EMAIL3], [CAD_DTA_CERTIFICADO], [CAD_IMPRESSAO_CERTIFICADO], [CAD_DTA_COMUNICADO], [CAD_ASSEFIN], [CAD_ASSEPONTO4], " +
                                                  "[CAD_VERSAO_ASSEFIN], [CAD_RECEBEU_ATESTADO], [CAD_ATENDIMENTO], [CAD_CELULAR_DDD], [CAD_CELULAR], [CAD_CELULAR_ACEITA], [CAD_QTD_FUNCIONARIO], " +
                                                  "[CAD_FINANCEIRO_EMAIL], [CAD_FINANCEIRO_EMAIL2], [CAD_FINANCEIRO_EMAIL3], [CAD_CADASTRO_ATUALIZADOEM], [CAD_CADASTRO_ATUALIZADOPOR], [CAD_TESTE], " +
                                                  "[CAD_FINANCEIRO_CONTATO], [CAD_FINANCEIRO_TELEFONE1_DDD], [CAD_FINANCEIRO_TELEFONE1], [CAD_FINANCEIRO_TELEFONE2_DDD], [CAD_FINANCEIRO_TELEFONE2], " +
                                                  "[CAD_FINANCEIRO_CELULAR_DDD], [CAD_FINANCEIRO_CELULAR], [CAD_FINANCEIRO_CELULAR_ACEITA], [CAD_MATRIZ], [CAD_EMAIL_ENVIAR], [CAD_EMAIL2_ENVIAR], " +
                                                  "[CAD_EMAIL3_ENVIAR], [CAD_ASSEPONTOWEB] " +
                                           "FROM [dbo].[AssepontoClientes] " +
                                           "WHERE CAD_IND = " + clienteId;
                    tableAssepontoControle = bdAssepontoControle.getDataTable(select);
                    if (tableAssepontoControle.Rows.Count != 1)
                        Response.Redirect("default.aspx");
                    else
                    {
                        cnpj_cpf = string.IsNullOrEmpty(tableAssepontoControle.Rows[0]["CAD_CNPJ"].ToString().Replace(" ", "")) ? tableAssepontoControle.Rows[0]["CAD_CPF"].ToString() : tableAssepontoControle.Rows[0]["CAD_CNPJ"].ToString();
                        //cnpj_cpf = tableAssepontoControle.Rows[0]["CAD_CNPJ"] is DBNull ? tableAssepontoControle.Rows[0]["CAD_CPF"].ToString() : tableAssepontoControle.Rows[0]["CAD_CNPJ"].ToString();
                        RadMenu2.Items.FindItemByText("Histórico de Pendências").NavigateUrl = "~/suporte/Clientes/Pendencias.aspx?cliente=" + clienteId;
                        RadMenu2.Items.FindItemByText("Manutenção").NavigateUrl = "~/suporte/Clientes/ManutencoesCliente.aspx?cliente=" + clienteId;
                        //RadMenu2.Items.FindItemByText("Atestado Técnico").NavigateUrl = "~/suporte/Relatorios/Atestado.aspx?ind=" + Client;
                        RadMenu2.Items.FindItemByText("Contrato").NavigateUrl = "~/suporte/Clientes/Contrato.aspx?ind=" + clienteId;
                        RadMenu2.Items.FindItemByText("Faturamento").NavigateUrl = "~/suporte/Clientes/Faturamento.aspx?ind=" + clienteId;
                        Permissao();
                    }
                }
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    preencherTextBoxsAssepontoControle();

                    if (!clieAssefin)
                    {
                        clienteIdAssefin = bdAssefin.getCadastroIndice(cnpj_cpf);
                        tableAssefin = bdAssefin.getCadastro(clienteIdAssefin);
                    }

                    if (tableAssefin.Rows.Count == 0)
                    {
                        preencherTextBoxsAbaContato();
                        preencherTextBoxsAbaFinanceiro();
                    }
                    else
                    {
                        if (!(tableAssefin.Rows[0]["CAD_CADASTRO_ATUALIZADO_EM"] is DBNull) &&
                            !(tableAssepontoControle.Rows[0]["CAD_CADASTRO_ATUALIZADOEM"] is DBNull) &&
                            Convert.ToDateTime(tableAssefin.Rows[0]["CAD_CADASTRO_ATUALIZADO_EM"].ToString()).CompareTo(Convert.ToDateTime(tableAssepontoControle.Rows[0]["CAD_CADASTRO_ATUALIZADOEM"])) >= 0)
                            preencherTextBoxsAssefinAbaContato();
                        else
                            preencherTextBoxsAbaContato();

                        preencherTextBoxsAssefinAbaFinanceiro();
                        btAssefin.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            txtQtdFuncionario.Text = tableAssepontoControle.Rows[0]["CAD_QTD_FUNCIONARIO"].ToString().Trim();
            comboboxRepFabricante.SelectedValue = tableAssepontoControle.Rows[0]["CAD_REP_FABRICANTE"].ToString();
        }

        #region Contato - AssepontoControle
        void preencherTextBoxsAbaContato()
        {
            try
            {

                //Aba Cadastro
                txtRazaoSocial.Text = tableAssepontoControle.Rows[0]["CAD_RAZAOSOCIAL"].ToString().Trim();
                txtFantasia.Text = tableAssepontoControle.Rows[0]["CAD_FANTASIA"].ToString().Trim();
                txtIE.Text = tableAssepontoControle.Rows[0]["CAD_IE"].ToString().Trim();

                //txtQtdFuncionario.Text = tableAssepontoControle.Rows[0]["CAD_QTD_FUNCIONARIO"].ToString().Trim();
                txtEndereco.Text = tableAssepontoControle.Rows[0]["CAD_ENDERECO"].ToString().Trim();
                txtEnderecoComplemento.Text = tableAssepontoControle.Rows[0]["CAD_ENDERECO_COMPLEMENTO"].ToString().Trim();
                txtEnderecoNumero.Text = tableAssepontoControle.Rows[0]["CAD_ENDERECO_NUMERO"].ToString().Trim();
                txtCEP.Text = tableAssepontoControle.Rows[0]["CAD_CEP"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtBairro.Text = tableAssepontoControle.Rows[0]["CAD_BAIRRO"].ToString().Trim();
                txtCidade.Text = tableAssepontoControle.Rows[0]["CAD_CIDADE"].ToString().Trim();
                comboboxUF.SelectedValue = tableAssepontoControle.Rows[0]["CAD_UF"].ToString().Trim().ToUpper().Trim().ToUpper();

                txtEmail.Text = tableAssepontoControle.Rows[0]["CAD_EMAIL"].ToString().Trim();
                txtEmail2.Text = tableAssepontoControle.Rows[0]["CAD_EMAIL2"].ToString().Trim();
                txtEmail3.Text = tableAssepontoControle.Rows[0]["CAD_EMAIL3"].ToString().Trim();

                txtContato.Text = tableAssepontoControle.Rows[0]["CAD_CONTATO"].ToString().Trim();
                txtTelefone1.Text = tableAssepontoControle.Rows[0]["CAD_TELEFONE1"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtTelefone1_DDD.Text = tableAssepontoControle.Rows[0]["CAD_TELEFONE1_DDD"].ToString().Trim();

                txtTelefone2.Text = tableAssepontoControle.Rows[0]["CAD_TELEFONE2"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtTelefone2_DDD.Text = tableAssepontoControle.Rows[0]["CAD_TELEFONE2_DDD"].ToString().Trim();
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }
        #endregion

        #region Financeiro - AssepontoControle
        void preencherTextBoxsAbaFinanceiro()
        {
            try
            {
                //Aba Financeiro - Asseponto Controle
                txtFinanceiroContato.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_CONTATO"].ToString().Trim();
                txtFinanceiroEmail.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_EMAIL"].ToString().Trim();
                txtFinanceiroEmail2.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_EMAIL2"].ToString().Trim();
                txtFinanceiroEmail3.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_EMAIL3"].ToString().Trim();

                txtFinanceiroTelefone.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_TELEFONE1"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtFinanceiroTelefone_DDD.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_TELEFONE1_DDD"].ToString().Trim();

                txtFinanceiroTelefone2.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_TELEFONE2"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtFinanceiroTelefone2_DDD.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_TELEFONE2_DDD"].ToString().Trim();

                txtFinanceiroCelular.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_CELULAR"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtFinanceiroCelular_DDD.Text = tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_CELULAR_DDD"].ToString().Trim();
                rbListFinanceiroCelular.Checked = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_FINANCEIRO_CELULAR_ACEITA"].ToString());
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }

        }
        #endregion

        #region Resto - AssepontoControle
        void preencherTextBoxsAssepontoControle()
        {
            try
            {
                //tableAssepontoControle = bdAssepontoControle.getDataTable("SELECT *, dbo.fn_cliente_cnpj_cpf(CAD_IND) AS CNPJ_CPF FROM AssepontoClientes WHERE CAD_IND = " + clienteId);

                comboboxRevenda.SelectedValue = tableAssepontoControle.Rows[0]["CAD_REVENDA"].ToString().Trim();
                //lbCnpjCpf.Text = tableAssepontoControle.Rows[0]["CNPJ_CPF"].ToString().Trim();
                cnpj_cpf = cnpj_cpf.Trim();
                if (!string.IsNullOrEmpty(cnpj_cpf))
                {
                    if (cnpj_cpf.Length == 14)
                        lbCnpjCpf.Text = cnpj_cpf.Substring(0, 2) + "." +
                                         cnpj_cpf.Substring(2, 3) + "." +
                                         cnpj_cpf.Substring(5, 3) + "/" +
                                         cnpj_cpf.Substring(8, 4) + "-" +
                                         cnpj_cpf.Substring(12, 2);
                    else
                        lbCnpjCpf.Text = cnpj_cpf.Substring(0, 3) + "." +
                                         cnpj_cpf.Substring(3, 3) + "." +
                                         cnpj_cpf.Substring(6, 3) + "-" +
                                         cnpj_cpf.Substring(9, 2);
                }
                else
                    lbCnpjCpf.Text = "";

                txtContato2.Text = tableAssepontoControle.Rows[0]["CAD_CONTATO2"].ToString().Trim();
                txtContato3.Text = tableAssepontoControle.Rows[0]["CAD_CONTATO3"].ToString().Trim();

                txtTelefone3.Text = tableAssepontoControle.Rows[0]["CAD_TELEFONE3"].ToString().Trim();
                txtTelefone3_DDD.Text = tableAssepontoControle.Rows[0]["CAD_TELEFONE3_DDD"].ToString().Trim();

                txtSkype.Text = tableAssepontoControle.Rows[0]["CAD_SKYPE"].ToString().Trim();
                txtCelular.Text = tableAssepontoControle.Rows[0]["CAD_CELULAR"].ToString().Trim();
                txtCelularDDD.Text = tableAssepontoControle.Rows[0]["CAD_CELULAR_DDD"].ToString().Trim();
                rbCelularAceita.Checked = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_CELULAR_ACEITA"].ToString());

                txtObs.Text = tableAssepontoControle.Rows[0]["CAD_OBS"].ToString().Trim();

                rbListAsseponto4.SelectedValue = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_ASSEPONTO4"].ToString()) ? "1" : "0";
                rbListAssepontoWeb.SelectedValue = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_ASSEPONTOWEB"].ToString()) ? "1" : "0";
                comboboxRepFabricante.SelectedValue = tableAssepontoControle.Rows[0]["CAD_REP_FABRICANTE"].ToString();
                txtModeloRep.Text = tableAssepontoControle.Rows[0]["CAD_MODELOREP"].ToString().Trim();

                rbListAssefin.SelectedValue = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_ASSEFIN"].ToString()) ? "1" : "0";
                comboboxAssefin.SelectedValue = tableAssepontoControle.Rows[0]["CAD_VERSAO_ASSEFIN"].ToString();

                txtQtdFuncionario.Text = tableAssepontoControle.Rows[0]["CAD_QTD_FUNCIONARIO"].ToString().Trim();

                chckEmail1.Checked = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_EMAIL_ENVIAR"].ToString());
                chckEmail2.Checked = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_EMAIL2_ENVIAR"].ToString());
                chckEmail3.Checked = Convert.ToBoolean(tableAssepontoControle.Rows[0]["CAD_EMAIL3_ENVIAR"].ToString());
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }
        #endregion

        #region Aba Contato - Assefin
        void preencherTextBoxsAssefinAbaContato()
        {
            try
            {
                //Aba Cadastro
                txtRazaoSocial.Text = tableAssefin.Rows[0]["CAD_RAZAOSOCIAL"].ToString().Trim();
                txtFantasia.Text = tableAssefin.Rows[0]["CAD_FANTASIA"].ToString().Trim();
                txtIE.Text = tableAssefin.Rows[0]["CAD_IE"].ToString().Trim();

                txtEndereco.Text = tableAssefin.Rows[0]["CAD_ENDERECO"].ToString().Trim();
                txtEnderecoComplemento.Text = tableAssefin.Rows[0]["CAD_COMPLEMENTO"].ToString().Trim();
                txtEnderecoNumero.Text = tableAssefin.Rows[0]["CAD_ENDERECO_NUMERO"].ToString().Trim();
                txtCEP.Text = tableAssefin.Rows[0]["CAD_CEP"].ToString().Trim();
                txtBairro.Text = tableAssefin.Rows[0]["CAD_BAIRRO"].ToString().Trim();
                txtCidade.Text = tableAssefin.Rows[0]["CAD_CIDADE"].ToString().Trim();
                comboboxUF.SelectedValue = tableAssefin.Rows[0]["CAD_ESTADO"].ToString();

                txtEmail.Text = tableAssefin.Rows[0]["CAD_EMAIL"].ToString().Trim();
                txtEmail2.Text = tableAssefin.Rows[0]["CAD_EMAIL2"].ToString().Trim();
                txtEmail3.Text = tableAssefin.Rows[0]["CAD_EMAIL3"].ToString().Trim();

                txtContato.Text = tableAssepontoControle.Rows[0]["CAD_CONTATO"].ToString().Trim();
                txtTelefone1.Text = tableAssefin.Rows[0]["CAD_TELEFONE1"].ToString().Trim();
                txtTelefone1_DDD.Text = tableAssefin.Rows[0]["CAD_TELEFONE1_DDD"].ToString().Trim();

                txtTelefone2.Text = tableAssefin.Rows[0]["CAD_TELEFONE2"].ToString().Trim();
                txtTelefone2_DDD.Text = tableAssefin.Rows[0]["CAD_TELEFONE2_DDD"].ToString().Trim();
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }
        #endregion

        #region Aba Financeiro - Assefin
        void preencherTextBoxsAssefinAbaFinanceiro()
        {
            try
            {
                //Aba Financeiro
                txtFinanceiroContato.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_CONTATO"].ToString().Trim();
                txtFinanceiroEmail.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_EMAIL"].ToString().Trim();
                txtFinanceiroEmail2.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_EMAIL2"].ToString().Trim();
                txtFinanceiroEmail3.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_EMAIL3"].ToString().Trim();

                txtFinanceiroTelefone.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_TELEFONE1"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtFinanceiroTelefone_DDD.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_TELEFONE1_DDD"].ToString().Trim();

                txtFinanceiroTelefone2.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_TELEFONE2"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtFinanceiroTelefone2_DDD.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_TELEFONE2_DDD"].ToString().Trim();

                txtFinanceiroCelular.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_CELULAR1"].ToString().Replace("-", "").Replace(".", "").Trim();
                txtFinanceiroCelular_DDD.Text = tableAssefin.Rows[0]["CAD_FINANCEIRO_CELULAR1_DDD"].ToString().Trim();
                rbListFinanceiroCelular.Checked = Convert.ToBoolean(tableAssefin.Rows[0]["CAD_CELULAR_ACEITA"].ToString());
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }
        #endregion

        void Permissao()
        {
            try
            {
                if (!(new Permissoes(bdAssepontoControle).getAcesso("Manuntecao")))
                {
                    RadMenu2.Items.FindItemByText("Manutenção").Visible = false;
                    RadMenu2.Items.FindItemByText("Contrato").Visible = false;
                }
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            try
            {

                DateTime dataAtualiza = DateTime.Now;
                setUpdateCadastroAssepontoControle(dataAtualiza);
                setUpdateCadastroAssefin(dataAtualiza);

                Response.Redirect("~/suporte/Atendimento/Cliente.aspx?ind=" + clienteId);
            }
            catch (Exception ex)
            {
                lblErro.Visible = true;
                lblErro.ForeColor = System.Drawing.Color.Red;
                lblErro.Text = ex.Message;
            }
        }

        #region update Asseponto Controle
        private void setUpdateCadastroAssepontoControle(DateTime dtAtualiza)
        {
            try
            {
                bdAssepontoControle.openConnection();
                SqlCommand cmd = new SqlCommand("SET DATEFORMAT DMY " +
                                            "UPDATE AssepontoClientes SET CAD_REVENDA = @CAD_REVENDA, CAD_RAZAOSOCIAL = @CAD_RAZAOSOCIAL, CAD_FANTASIA = @CAD_FANTASIA, CAD_IE = @CAD_IE, " +
                                            "CAD_EMAIL = @CAD_EMAIL, CAD_EMAIL2 = @CAD_EMAIL2,  CAD_EMAIL3 = @CAD_EMAIL3, CAD_QTD_FUNCIONARIO = @CAD_QTD_FUNCIONARIO, " +

                                            "CAD_CONTATO = @CAD_CONTATO, CAD_CONTATO2 = @CAD_CONTATO2, CAD_CONTATO3 = @CAD_CONTATO3,  " +
                                            "CAD_ENDERECO = @CAD_ENDERECO, CAD_ENDERECO_NUMERO = @CAD_ENDERECO_NUMERO, CAD_ENDERECO_COMPLEMENTO = @CAD_ENDERECO_COMPLEMENTO,  " +
                                            "CAD_BAIRRO = @CAD_BAIRRO, CAD_CIDADE = @CAD_CIDADE, CAD_UF = @CAD_UF, CAD_CEP = @CAD_CEP, CAD_OBS = @CAD_OBS, CAD_SKYPE = @CAD_SKYPE,  " +

                                            "CAD_ASSEFIN = @CAD_ASSEFIN,  CAD_ASSEPONTO4 = @CAD_ASSEPONTO4, CAD_REP_FABRICANTE = @CAD_REP_FABRICANTE, CAD_MODELOREP = @CAD_MODELOREP,  " +

                                            "CAD_TELEFONE1 = @CAD_TELEFONE1, CAD_TELEFONE1_DDD = @CAD_TELEFONE1_DDD,  CAD_TELEFONE2_DDD = @CAD_TELEFONE2_DDD, CAD_TELEFONE2 = @CAD_TELEFONE2, CAD_TELEFONE3_DDD = @CAD_TELEFONE3_DDD, CAD_TELEFONE3 = @CAD_TELEFONE3, " +
                                            "CAD_CELULAR_DDD = @CAD_CELULAR_DDD, CAD_CELULAR = @CAD_CELULAR, CAD_CELULAR_ACEITA = @CAD_CELULAR_ACEITA, " +
                                            "CAD_EMAIL_ENVIAR = @CAD_EMAIL_ENVIAR, CAD_EMAIL2_ENVIAR = @CAD_EMAIL2_ENVIAR, CAD_EMAIL3_ENVIAR = @CAD_EMAIL3_ENVIAR, " +

                                            "CAD_FINANCEIRO_CONTATO = @CAD_FINANCEIRO_CONTATO, CAD_FINANCEIRO_TELEFONE1_DDD = @CAD_FINANCEIRO_TELEFONE1_DDD, CAD_FINANCEIRO_TELEFONE2_DDD = @CAD_FINANCEIRO_TELEFONE2_DDD,  " +
                                            "CAD_FINANCEIRO_TELEFONE1 = @CAD_FINANCEIRO_TELEFONE1, CAD_FINANCEIRO_TELEFONE2 = @CAD_FINANCEIRO_TELEFONE2, CAD_FINANCEIRO_CELULAR_ACEITA = @CAD_FINANCEIRO_CELULAR_ACEITA,  " +
                                            "CAD_FINANCEIRO_CELULAR = @CAD_FINANCEIRO_CELULAR, @CAD_FINANCEIRO_CELULAR_DDD = CAD_FINANCEIRO_CELULAR_DDD, " +

                                            "CAD_FINANCEIRO_EMAIL = @CAD_FINANCEIRO_EMAIL, CAD_FINANCEIRO_EMAIL2 = @CAD_FINANCEIRO_EMAIL2, CAD_FINANCEIRO_EMAIL3 = @CAD_FINANCEIRO_EMAIL3, " +
                                            " CAD_CADASTRO_ATUALIZADOEM = @DATAATUALIZA, CAD_CADASTRO_ATUALIZADOPOR = @USER_ID, CAD_ASSEPONTOWEB = @CAD_ASSEPONTOWEB WHERE CAD_IND = @CAD_IND", bdAssepontoControle.Conn);

                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@DATAATUALIZA", dtAtualiza.ToString("dd/MM/yyyy HH:mm:00"));
                cmd.Parameters.AddWithValue("@CAD_REVENDA", comboboxRevenda.SelectedValue);
                cmd.Parameters.AddWithValue("@CAD_RAZAOSOCIAL", txtRazaoSocial.Text);
                cmd.Parameters.AddWithValue("@CAD_FANTASIA", txtFantasia.Text);
                cmd.Parameters.AddWithValue("@CAD_IE", txtIE.Text);
                cmd.Parameters.AddWithValue("@CAD_QTD_FUNCIONARIO", txtQtdFuncionario.Text);

                cmd.Parameters.AddWithValue("@CAD_EMAIL", txtEmail.Text);
                cmd.Parameters.AddWithValue("@CAD_EMAIL2", txtEmail2.Text);
                cmd.Parameters.AddWithValue("@CAD_EMAIL3", txtEmail3.Text);
                cmd.Parameters.AddWithValue("@CAD_CONTATO", txtContato.Text);
                cmd.Parameters.AddWithValue("@CAD_CONTATO2", txtContato2.Text);
                cmd.Parameters.AddWithValue("@CAD_CONTATO3", txtContato3.Text);
                cmd.Parameters.AddWithValue("@CAD_ENDERECO", txtEndereco.Text.Trim());
                cmd.Parameters.AddWithValue("@CAD_ENDERECO_NUMERO", txtEnderecoNumero.Text.Trim());

                cmd.Parameters.AddWithValue("@CAD_ENDERECO_COMPLEMENTO", txtEnderecoComplemento.Text.Trim());
                cmd.Parameters.AddWithValue("@CAD_BAIRRO", txtBairro.Text.Trim());
                cmd.Parameters.AddWithValue("@CAD_CIDADE", txtCidade.Text.Trim());
                cmd.Parameters.AddWithValue("@CAD_UF", comboboxUF.SelectedValue.Trim().ToUpper());
                cmd.Parameters.AddWithValue("@CAD_CEP", txtCEP.Text.Trim());
                cmd.Parameters.AddWithValue("@CAD_OBS", txtObs.Text);
                cmd.Parameters.AddWithValue("@CAD_SKYPE", txtSkype.Text);
                cmd.Parameters.AddWithValue("@CAD_ASSEFIN", rbListAssefin.SelectedValue);
                cmd.Parameters.AddWithValue("@CAD_ASSEPONTO4", rbListAsseponto4.SelectedValue);
                cmd.Parameters.AddWithValue("@CAD_ASSEPONTOWEB", rbListAssepontoWeb.SelectedValue);

                //cmd.Parameters.AddWithValue("@CAD_VERSAO_ASSEFIN",  Convert.ToInt32(comboboxAssefin.SelectedValue) > 0 ? comboboxAssefin.SelectedValue : "NULL");
                cmd.Parameters.AddWithValue("@CAD_REP_FABRICANTE", comboboxRepFabricante.SelectedValue);

                cmd.Parameters.AddWithValue("@CAD_MODELOREP", txtModeloRep.Text);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE1", txtTelefone1.Text);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE1_DDD", txtTelefone1_DDD.Text);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE2", txtTelefone2.Text);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE2_DDD", txtTelefone2_DDD.Text);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE3", txtTelefone3.Text);
                cmd.Parameters.AddWithValue("@CAD_TELEFONE3_DDD", txtTelefone3_DDD.Text);
                cmd.Parameters.AddWithValue("@CAD_CELULAR", txtCelular.Text);
                cmd.Parameters.AddWithValue("@CAD_CELULAR_DDD", txtCelularDDD.Text);
                cmd.Parameters.AddWithValue("@CAD_CELULAR_ACEITA", rbCelularAceita.Checked ? "1" : "0");

                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CONTATO", txtFinanceiroContato.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1", txtFinanceiroTelefone.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE1_DDD", txtFinanceiroTelefone_DDD.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2", txtFinanceiroTelefone2.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_TELEFONE2_DDD", txtFinanceiroTelefone2_DDD.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR", txtFinanceiroCelular.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR_DDD", txtFinanceiroCelular_DDD.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_CELULAR_ACEITA", rbListFinanceiroCelular.Checked ? "1" : "0");
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL", txtFinanceiroEmail.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL2", txtFinanceiroEmail2.Text);
                cmd.Parameters.AddWithValue("@CAD_FINANCEIRO_EMAIL3", txtFinanceiroEmail3.Text);
                cmd.Parameters.AddWithValue("@USER_ID", UserApp.UserId);
                cmd.Parameters.AddWithValue("@CAD_IND", clienteId);

                cmd.Parameters.AddWithValue("@CAD_EMAIL_ENVIAR", chckEmail1.Checked ? "1" : "0");
                cmd.Parameters.AddWithValue("@CAD_EMAIL2_ENVIAR", chckEmail2.Checked ? "1" : "0");
                cmd.Parameters.AddWithValue("@CAD_EMAIL3_ENVIAR", chckEmail3.Checked ? "1" : "0");

                cmd.ExecuteNonQuery();
                bdAssepontoControle.closeConnection();
            }
            catch (Exception ex)
            {
                lblErro.Visible = true;
                lblErro.ForeColor = System.Drawing.Color.Red;
                lblErro.Text = ex.Message;
            }
        }
        #endregion

        #region update Assefin
        private void setUpdateCadastroAssefin(DateTime dtAtualiza)
        {
            try
            { 
                Modelo.Assefin.ClienteDetail cliente = new Modelo.Assefin.ClienteDetail();

                if (txtRazaoSocial.Text.Length > 70)
                    cliente.CAD_RAZAOSOCIAL = txtRazaoSocial.Text.Substring(0, 70);
                else
                    cliente.CAD_RAZAOSOCIAL = txtRazaoSocial.Text;
                cliente.CAD_FANTASIA = txtFantasia.Text;
                cliente.CAD_IE = txtIE.Text;
                cliente.CAD_EMAIL = txtEmail.Text;
                cliente.CAD_EMAIL2 = txtEmail2.Text;
                cliente.CAD_EMAIL3 = txtEmail3.Text;
                cliente.CAD_ENDERECO = txtEndereco.Text;
                cliente.CAD_ENDERECO_NUMERO = txtEnderecoNumero.Text;
                cliente.CAD_ENDERECO_COMPLEMENTO = txtEnderecoComplemento.Text;
                cliente.CAD_BAIRRO = txtBairro.Text;
                cliente.CAD_CIDADE = txtCidade.Text;
                cliente.CAD_UF = comboboxUF.SelectedValue;
                cliente.CAD_CEP = txtCEP.Text;
                cliente.CAD_CONTATO = txtContato.Text;
                cliente.CAD_TELEFONE1 = txtTelefone1.Text;
                cliente.CAD_TELEFONE1_DDD = txtTelefone1_DDD.Text;
                cliente.CAD_TELEFONE2 = txtTelefone2.Text;
                cliente.CAD_TELEFONE2_DDD = txtTelefone2_DDD.Text;
                cliente.CAD_FINANCEIRO_CONTATO = txtFinanceiroContato.Text;
                cliente.CAD_FINANCEIRO_TELEFONE1 = txtFinanceiroTelefone.Text;
                cliente.CAD_FINANCEIRO_TELEFONE1_DDD = txtFinanceiroTelefone_DDD.Text;
                cliente.CAD_FINANCEIRO_TELEFONE2 = txtFinanceiroTelefone2.Text;
                cliente.CAD_FINANCEIRO_TELEFONE2_DDD = txtFinanceiroTelefone2_DDD.Text;
                cliente.CAD_FINANCEIRO_CELULAR = txtFinanceiroCelular.Text;
                cliente.CAD_FINANCEIRO_CELULAR_DDD = txtFinanceiroCelular_DDD.Text;
                cliente.CAD_CELULAR_ACEITA = rbListFinanceiroCelular.Checked;
                cliente.CAD_FINANCEIRO_EMAIL = txtFinanceiroEmail.Text;
                cliente.CAD_FINANCEIRO_EMAIL2 = txtFinanceiroEmail2.Text;
                cliente.CAD_FINANCEIRO_EMAIL3 = txtFinanceiroEmail3.Text;
                cliente.CAD_CADASTRO_ATUALIZADOPOR = user.UserName();
                cliente.CAD_CNPJ = lbCnpjCpf.Text;
                cliente.CAD_CPF = lbCnpjCpf.Text;
                cliente.CAD_CADASTRO_ATUALIZADOEM = dtAtualiza;

                ClienteBLL BLL = new ClienteBLL(TypesConnections.Assefin);
                BLL.setUpdateCadastroAssefin(cliente);

                //bdAssefin.setCadastroAssefin(txtRazaoSocial.Text, txtFantasia.Text, txtIE.Text, txtEmail.Text, txtEmail2.Text, txtEmail3.Text,
                //     txtEndereco.Text, txtEnderecoNumero.Text, txtEnderecoComplemento.Text, txtBairro.Text, txtCidade.Text, comboboxUF.SelectedValue, txtCEP.Text,
                //     txtContato.Text, txtTelefone1.Text, txtTelefone1_DDD.Text, txtTelefone2.Text, txtTelefone2_DDD.Text,
                //     txtFinanceiroContato.Text, txtFinanceiroTelefone.Text, txtFinanceiroTelefone_DDD.Text, txtFinanceiroTelefone2.Text, txtFinanceiroTelefone2_DDD.Text,
                //     txtFinanceiroCelular.Text, txtFinanceiroCelular_DDD.Text, rbListFinanceiroCelular.Checked,
                //     txtFinanceiroEmail.Text, txtFinanceiroEmail2.Text, txtFinanceiroEmail3.Text, user.UserName(), lbCnpjCpf.Text, dtAtualiza);
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }
        #endregion

        protected void btAssefin_Click(object sender, EventArgs e)
        {
            setInsertCadastroAssefin();
        }

        private void setInsertCadastroAssefin()
        {
            try
            {
                string aux = lbCnpjCpf.Text.Replace("/", "").Replace(".", "").Replace("-", "");
                string cpf = "NULL";
                string cnpj = "NULL";

                if (aux.Length > 11)
                    cnpj = aux;
                else
                    cpf = aux;

                bdAssefin.setCriarCadastroAssefin(txtRazaoSocial.Text, txtFantasia.Text, txtIE.Text, txtEmail.Text, txtEmail2.Text, txtEmail3.Text,
                 txtEndereco.Text, txtEnderecoNumero.Text, txtEnderecoComplemento.Text, txtBairro.Text, txtCidade.Text, comboboxUF.SelectedValue, txtCEP.Text,
                 txtContato.Text, txtTelefone1.Text, txtTelefone1_DDD.Text, txtTelefone2.Text, txtTelefone2_DDD.Text,
                 txtFinanceiroContato.Text, txtFinanceiroTelefone.Text, txtFinanceiroTelefone_DDD.Text, txtFinanceiroTelefone2.Text, txtFinanceiroTelefone2_DDD.Text,
                 txtFinanceiroCelular.Text, txtFinanceiroCelular_DDD.Text, rbListFinanceiroCelular.Checked,
                 txtFinanceiroEmail.Text, txtFinanceiroEmail2.Text, txtFinanceiroEmail3.Text, user.UserName(), cnpj, cpf);

                bdAssepontoControle.setCadastroAtualizado(UserApp.UserId, clienteId);
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }

        protected void txtCEP_TextChanged(object sender, EventArgs e)
        {
            try
            {
                RadMaskedTextBox txtcep = sender as RadMaskedTextBox;
                string cep = txtcep.Text.Replace("-", "").Replace(".", "");
                if (cep.Count() == 8)
                {
                    Chamizo.Web.Control.FindAddress findaddress = new Chamizo.Web.Control.FindAddress();
                    Chamizo.Web.Control.Address address = findaddress.GetAddressBy(cep);
                    if (address != null)
                    {
                        if (!string.IsNullOrEmpty(address.District) &&
                            !string.IsNullOrEmpty(address.Street) &&
                            !string.IsNullOrEmpty(address.Complement) &&
                            !string.IsNullOrEmpty(address.StreetNumber) &&
                            !string.IsNullOrEmpty(address.State) &&
                            !string.IsNullOrEmpty(address.City))
                        {
                            if (!string.IsNullOrEmpty(address.District))
                                txtBairro.Text = address.District;
                            else
                                txtBairro.Enabled = true;

                            if (!string.IsNullOrEmpty(address.Street))
                                txtEndereco.Text = address.Street;
                            else
                                txtEndereco.Enabled = true;

                            if (!string.IsNullOrEmpty(address.Complement))
                                txtEnderecoComplemento.Text = address.Complement;
                            else
                                txtEnderecoComplemento.Enabled = true;

                            if (!string.IsNullOrEmpty(address.StreetNumber))
                                txtEnderecoNumero.Text = address.StreetNumber;
                            else
                                txtEnderecoNumero.Enabled = true;

                            if (!string.IsNullOrEmpty(address.State))
                                comboboxUF.SelectedValue = address.State;
                            else
                                comboboxUF.Enabled = true;

                            if (!string.IsNullOrEmpty(address.City))
                                txtCidade.Text = address.City;
                            else
                                txtCidade.Enabled = true;
                        }
                        else
                        {
                            txtCidade.Enabled = true;
                            comboboxUF.Enabled = true;
                            txtEnderecoNumero.Enabled = true;
                            txtEnderecoComplemento.Enabled = true;
                            txtEndereco.Enabled = true;
                            txtBairro.Enabled = true;
                        }
                    }
                }
                else return;
            }
            catch (Exception ex)
            {
                string m = ex.Message + "1";
            }
        }
    }
}