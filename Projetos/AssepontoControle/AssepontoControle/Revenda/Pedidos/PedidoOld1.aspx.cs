using Asseponto.Classes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Asseponto.Revenda.Pedidos
{
    public partial class PedidoOld1 : System.Web.UI.Page
    {
        int PedidoIndice = 0;
        int RepFabricante = 0;
        string dataPedido = "";
        bool passou = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BDApp bd = new BDApp();
                string PedidoIndice = Request.QueryString["ind"];
                if (!string.IsNullOrEmpty(PedidoIndice))
                {
                    string query = @"SELECT PED_IND, 
	                                    PED_REV_IND, 
	                                    PED_CLI_RAZAO, 
	                                    PED_CLI_CNPJ, 
	                                    PED_CLI_CPF, 
	                                    PED_CLI_IE, 
	                                    PED_CLI_ENDERECO, 
	                                    PED_CLI_ENDERECO_NUMERO, 
	                                    PED_CLI_ENDERECO_COMPLEMENTO, 
	                                    PED_CLI_CEP, 
	                                    PED_CLI_BAIRRO, 
	                                    PED_CLI_CIDADE, 
	                                    PED_CLI_UF, 
	                                    PED_CLI_EMAIL, 
	                                    PED_SKYPE, 
	                                    PED_CLI_TELEFONE, 
	                                    PED_CLI_TELEFONE_DDD, 
	                                    PED_CLI_QTD_FUNCIONA, 
	                                    PED_CLI_CONTATO, 
	                                    PED_VERSAO_AQUISICAO, 
	                                    PED_EMAIL2, 
	                                    CASE PED_COM_MANUTENCAO WHEN 1 THEN 'True' ELSE 'False' END AS PED_COM_MANUTENCAO, 
	                                    PED_MODELOREP, 
	                                    CASE WHEN PED_REPINSTALADO = 1 THEN 'True' ELSE 'False' END AS PED_REPINSTALADO, 
	                                    PED_DESCRICAO, 
	                                    PED_SITUACAO, 
	                                    PED_SOLICITANTE, 
	                                    PED_DATA_FECHAMENTO, 
	                                    PED_REP_FABRICANTE, 
	                                    PED_CLI_TELEFONE2, 
	                                    PED_CLI_TELEFONE2_DDD, 
	                                    PED_CLI_CELULAR, 
	                                    PED_CLI_CELULAR_DDD, 
	                                    PED_CLI_CELULAR_ACEITA, 
	                                    PED_FANTASIA, 
	                                    PED_DATA, PED_STATUS, 
	                                    PED_PLANILHA_EXCEL 
                                 FROM AssepontoPedidosRevendas 
                                 WHERE (PED_IND = @PED_IND)";
                    query = query.Replace("@PED_IND", PedidoIndice);
                    DataTable pedido = bd.getDataTable(query);
                    hiddenRevenda.Value = pedido.Rows[0]["PED_REV_IND"].ToString();
                    HiddenIndice.Value = pedido.Rows[0]["PED_IND"].ToString();
                    HiddenStatus.Value = pedido.Rows[0]["PED_STATUS"].ToString();

                    PED_CLI_RAZAO.Text = pedido.Rows[0]["PED_CLI_RAZAO"].ToString();
                    PED_CLI_CNPJ.Text = pedido.Rows[0]["PED_CLI_CNPJ"].ToString();
                    PED_FANTASIA.Text = pedido.Rows[0]["PED_FANTASIA"].ToString();
                    PED_CLI_IE.Text = pedido.Rows[0]["PED_CLI_IE"].ToString();
                    PED_CLI_CPF.Text = pedido.Rows[0]["PED_CLI_CPF"].ToString();
                    PED_CLI_CEP.Text = pedido.Rows[0]["PED_CLI_CEP"].ToString();
                    PED_CLI_UF.Text = pedido.Rows[0]["PED_CLI_CEP"].ToString();
                    PED_CLI_CIDADE.Text = pedido.Rows[0]["PED_CLI_CIDADE"].ToString();
                    PED_CLI_BAIRRO.Text = pedido.Rows[0]["PED_CLI_BAIRRO"].ToString();
                    PED_CLI_ENDERECO.Text = pedido.Rows[0]["PED_CLI_ENDERECO"].ToString();
                    PED_CLI_ENDERECO_NUMERO.Text = pedido.Rows[0]["PED_CLI_ENDERECO_NUMERO"].ToString();
                    PED_CLI_ENDERECO_COMPLEMENTO.Text = pedido.Rows[0]["PED_CLI_ENDERECO_COMPLEMENTO"].ToString();
                    PED_CLI_CONTATO.Text = pedido.Rows[0]["PED_CLI_CONTATO"].ToString();
                    PED_SKYPE.Text = pedido.Rows[0]["PED_SKYPE"].ToString();
                    PED_CLI_TELEFONE_DDD.Text = pedido.Rows[0]["PED_CLI_TELEFONE_DDD"].ToString();
                    PED_CLI_TELEFONE.Text = pedido.Rows[0]["PED_CLI_TELEFONE"].ToString();
                    PED_CLI_TELEFONE2_DDD.Text = pedido.Rows[0]["PED_CLI_TELEFONE2_DDD"].ToString();
                    PED_CLI_TELEFONE2.Text = pedido.Rows[0]["PED_CLI_TELEFONE2"].ToString();
                    PED_CLI_CELULAR_DDD.Text = pedido.Rows[0]["PED_CLI_CELULAR_DDD"].ToString();
                    PED_CLI_CELULAR.Text = pedido.Rows[0]["PED_CLI_CELULAR"].ToString();
                    //string teste = pedido.Rows[0]["PED_CLI_CELULAR_ACEITA"].ToString();
                    CAD_CELULAR_ACEITA.SelectedValue = pedido.Rows[0]["PED_CLI_CELULAR_ACEITA"].ToString();
                    txtEmail.Text = pedido.Rows[0]["PED_CLI_EMAIL"].ToString();
                    txtEmail2.Text = pedido.Rows[0]["PED_EMAIL2"].ToString();
                    RadNumericTextBox1.Text = pedido.Rows[0]["PED_CLI_QTD_FUNCIONA"].ToString();
                    PED_SOLICITANTE.Text = pedido.Rows[0]["PED_SOLICITANTE"].ToString();
                    PED_DATA.Text = pedido.Rows[0]["PED_DATA"].ToString();
                    //string teste2 = pedido.Rows[0]["PED_VERSAO_AQUISICAO"].ToString();
                    radioVersao.SelectedValue = pedido.Rows[0]["PED_VERSAO_AQUISICAO"].ToString();
                    //string teste3 = pedido.Rows[0]["PED_COM_MANUTENCAO"].ToString();
                    PED_COM_MANUTENCAO.SelectedValue = pedido.Rows[0]["PED_COM_MANUTENCAO"].ToString();
                    //string teste4 = pedido.Rows[0]["PED_REP_FABRICANTE"].ToString();
                    PED_REP_FABRICANTE.SelectedValue = pedido.Rows[0]["PED_REP_FABRICANTE"].ToString();
                    PED_MODELOREP.Text = pedido.Rows[0]["PED_MODELOREP"].ToString();
                    //string teste5 = pedido.Rows[0]["PED_REPINSTALADO"].ToString();
                    PED_REPINSTALADO.SelectedValue = pedido.Rows[0]["PED_REPINSTALADO"].ToString();
                    PED_DESCRICAOTextBox.Text = pedido.Rows[0]["PED_DESCRICAO"].ToString();
                }
                else
                    hiddenRevenda.Value = bd.getFieldValueInteger("select USUREV_REVENDA from AssepontoUsuariosRevendas where USUREV_IND = " + UserApp.UserId.ToString()).ToString();

                PED_REP_FABRICANTE.DataBind();
            }
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            string PedidoIndice = Request.QueryString["ind"];
            if (string.IsNullOrEmpty(PedidoIndice))
            {
                planFuncInsert.Style.Add("display", "block");
                planFuncEdit.Style.Add("display", "none");
            }
            else
            {
                planFuncInsert.Style.Add("display", "none");
                planFuncEdit.Style.Add("display", "block");
            }

            //if (!string.IsNullOrEmpty(PED_CLI_CPF.Text))
            //{
            //    psFisica.Checked = true;
            //    PED_CLI_CNPJ.Text = "";
            //    fisica.Style.Value = fisica.Style.Value.Replace("display: none", "");
            //    juridica.Style.Value = "display: none";
            //}
            //if (!string.IsNullOrEmpty(PED_CLI_CNPJ.Text))
            //{
            //    psJuridica.Checked = true;
            //    PED_CLI_CEP.Text = "";
            //    fisica.Style.Value = "display: none";
            //    juridica.Style.Value = juridica.Style.Value.Replace("display: none", "");
            //}

        }

        protected void Enviar_Email_Pedido(BDApp bd, int pedido = 0)
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = ConfigurationManager.AppSettings["EMAILRECIPIENT"];
            string EmailCC = ConfigurationManager.AppSettings["EMAILRECIPIENTCC"];
            string EmailCC2 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC2"];
            string EmailCC3 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC3"];
            string EmailCC4 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC4"];
            string EmailCC5 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC5"];

            EmailPedido email = new EmailPedido(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedido.htm");
            email.Send(EmailTo, EmailCC, EmailCC2, EmailCC3, EmailCC4, EmailCC5, pedido == 0 ? PedidoIndice : pedido);
        }

        protected void Enviar_Email_Pedido_Retorno(BDApp bd, int pedido = 0)
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = bd.getRevendaEmailFromPedido(PedidoIndice);
            string EmailCC = bd.getRevendaEmailFromPedido2(PedidoIndice);

            EmailPedidoRetorno email = new EmailPedidoRetorno(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedidoRetorno.htm");
            email.Send(EmailTo, EmailCC, pedido == 0 ? PedidoIndice : pedido);
        }

        #region DataBinding
        protected void RadComboBox1_DataBinding(object sender, EventArgs e)
        {
            //Binding do Combox UF
            RadComboBox combo = (RadComboBox)sender;
            combo.DataSourceID = "sqlEstados";
            combo.DataTextField = "EST_NOME";
            combo.DataValueField = "EST_SIGLA";
        }

        protected void RadComboBox2_DataBinding(object sender, EventArgs e)
        {
            //Binding do Combox Lista de Relogios
            RadComboBox combo = (RadComboBox)sender;
            //if (!IsPostBack)
            //{
            combo.DataSourceID = "sqlAssepontoRepFabricantes";
            combo.DataTextField = "FABR_NOME";
            combo.DataValueField = "FABR_COD";
            //}
            //else
            //{
            //combo.SelectedValue = null;
            //BDApp bd = new BDApp();
            //RadComboBoxItem item;
            //combo.DataSourceID = null;
            //combo.DataTextField = null;
            //combo.DataValueField = null;
            ////combo.DataTextField = "FABR_NOME";
            ////combo.DataValueField = "FABR_COD";
            //string query;


            //if (!string.IsNullOrEmpty(Request.QueryString["ind"]))
            //    query = ("SELECT [FABR_NOME] + '%||%' + CONVERT(VARCHAR(5), [FABR_COD]) + '%||%' + CONVERT(VARCHAR(5), [FABR_ATIVO]) + '%||%' + " +
            //                "       (CASE WHEN FABR_COD = (SELECT TOP 1 PED_REP_FABRICANTE " +
            //                "                              FROM AssepontoPedidosRevendas " +
            //                "                              WHERE PED_IND = @PED_IND " +
            //                "                              ORDER BY PED_DATA DESC) " +
            //                "             THEN '1' " +
            //                "             ELSE '0' " +
            //                "        END) " +
            //                "FROM[AssepontoRepFabricantes] " +
            //                "WHERE([FABR_ATIVO] = 1)  " +
            //                "ORDER BY[FABR_NOME]").Replace("@PED_IND", Request.QueryString["ind"]);
            //else
            //    query = "SELECT [FABR_NOME] + '%||%' + CONVERT(VARCHAR(5), [FABR_COD]) + '%||%' + CONVERT(VARCHAR(5), [FABR_ATIVO]) + '%||%0'" +
            //                "FROM[AssepontoRepFabricantes] " +
            //                "WHERE([FABR_ATIVO] = 1)  " +
            //                "ORDER BY[FABR_NOME]";
            //System.Collections.Generic.List<string> lines = bd.getFieldValueListString(query);
            //foreach (string line in lines)
            //{
            //    item = new RadComboBoxItem();
            //    string[] split = line.Split(new String[] { "%||%" }, StringSplitOptions.None);
            //    item.Text = split[0];
            //    item.Value = split[1];
            //    if (split[3] == "1")
            //    {
            //        item.Selected = true;
            //        RepFabricante = Convert.ToInt32(split[1]);
            //    }
            //    if (RepFabricante == 0)
            //        RepFabricante = -1;
            //    combo.Items.Add(item);
            //}
            //}
        }

        protected void RadComboBox2_DataBound(object sender, EventArgs e)
        {
            RadComboBox combo = sender as RadComboBox;
            if (!IsPostBack)
            {
                if (RepFabricante == 0 || RepFabricante == -1)
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["ind"]))
                    {
                        BDApp bd = new BDApp();
                        int REP_FABRICANTE = bd.getFieldValueInteger("SELECT TOP 1 PED_REP_FABRICANTE FROM AssepontoPedidosRevendas WHERE PED_IND = " + Request.QueryString["ind"] + " ORDER BY PED_DATA DESC");
                        combo.SelectedValue = REP_FABRICANTE.ToString();
                    }
                }
                else
                    combo.SelectedValue = RepFabricante.ToString();
            }
        }

        //protected void RadComboBox2_DataBinding(object sender, EventArgs e)
        //{
        //    Binding do Combox Lista de Relogios
        //    RadComboBox combo = (RadComboBox)sender;
        //    combo.DataSourceID = "sqlAssepontoRepFabricantes";
        //    combo.DataTextField = "FABR_NOME";
        //    combo.DataValueField = "FABR_COD";
        //}
        #endregion

        #region CustomValidator
        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            RadMaskedTextBox txtCNPJ = PED_CLI_CNPJ;//(RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ");
            RadMaskedTextBox txtCPF = PED_CLI_CPF;// (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF");

            if (
                (!string.IsNullOrEmpty(txtCNPJ.Text) && string.IsNullOrEmpty(txtCPF.Text)) ||
                (string.IsNullOrEmpty(txtCNPJ.Text) && !string.IsNullOrEmpty(txtCPF.Text))
               )
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string cnpj = PED_CLI_CNPJ.Text;// ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ")).Text;
            string cpf = PED_CLI_CPF.Text;// ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF")).Text;

            /*Validar se já existe o CNPJ ou CPF na tabela AssepontoClientes*/
            args.IsValid = (new BDApp()).getFieldValueInteger(string.Format("SELECT CAD_IND FROM AssepontoClientes WHERE CAD_ASSEPONTO4 = 1 AND " +
                                "(dbo.fn_asseponto_trim_cnpj(CAD_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}') OR " +
                                "dbo.fn_asseponto_trim_cnpj(CAD_CPF) = dbo.fn_asseponto_trim_cnpj('{1}'))", cnpj, cpf)) == 0;
        }

        protected void CustomValidatorPlanilha_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string fileName = FilePlanilha.PostedFile.FileName;// ((FileUpload)FormView1.FindControl("FilePlanilha")).PostedFile.FileName;
            string fileExtension = System.IO.Path.GetExtension(fileName).Replace(".", string.Empty).ToLower();

            args.IsValid = (fileExtension == "xls" || fileExtension == "xlsx") ? true : false;

        }

        protected void CV_Pedido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string cnpj = PED_CLI_CNPJ.Text;// ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ")).Text;
            string cpf = PED_CLI_CPF.Text;// ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF")).Text;

            /*Validar se já existe o CNPJ ou CPF na tabela AssepontoPedidos*/
            args.IsValid = (new BDApp()).getFieldValueInteger(string.Format("SELECT PED_IND FROM AssepontoPedidosRevendas WHERE dbo.fn_asseponto_trim_cnpj(PED_CLI_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}') OR " +
                                                                                "dbo.fn_asseponto_trim_cnpj(PED_CLI_CPF) = dbo.fn_asseponto_trim_cnpj('{1}')", cnpj, cpf)) == 0;
        }
        #endregion

        protected void lkPlanilha_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ViewFile.aspx?ind=" + PedidoIndice);
        }


        protected void Salvar_Click(object sender, EventArgs e)
        {
            if ((!PED_CLI_CNPJ_ERRO.Visible || !PED_CLI_CPF_ERRO.Visible) && Page.IsValid)
            {
                string PedidoIndice = Request.QueryString["ind"];
                string query;
                if (string.IsNullOrEmpty(PedidoIndice))
                {
                    query = @"INSERT INTO AssepontoPedidosRevendas(PED_REV_IND, PED_CLI_RAZAO, PED_CLI_CNPJ, PED_CLI_CPF, PED_CLI_IE, PED_CLI_ENDERECO, 
                            PED_CLI_ENDERECO_NUMERO, PED_CLI_ENDERECO_COMPLEMENTO, PED_CLI_CEP, PED_CLI_BAIRRO, PED_CLI_CIDADE, PED_CLI_UF, PED_CLI_EMAIL, 
                            PED_SKYPE, PED_CLI_TELEFONE, PED_CLI_TELEFONE_DDD, PED_CLI_QTD_FUNCIONA, PED_CLI_CONTATO, PED_VERSAO_AQUISICAO, 
                            PED_COM_MANUTENCAO, PED_MODELOREP, PED_REPINSTALADO, PED_DESCRICAO, PED_SOLICITANTE, PED_REP_FABRICANTE, PED_FANTASIA, 
                            PED_STATUS, PED_EMAIL2, PED_ASSEPONTO4, PED_ASSEFIN, PED_CLI_TELEFONE2, PED_CLI_TELEFONE2_DDD, PED_CLI_CELULAR, 
                            PED_CLI_CELULAR_DDD, PED_CLI_CELULAR_ACEITA) 
                            VALUES (@PED_REV_IND, @PED_CLI_RAZAO, @PED_CLI_CNPJ, @PED_CLI_CPF, @PED_CLI_IE, @PED_CLI_ENDERECO, 
                            @PED_CLI_ENDERECO_NUMERO, @PED_CLI_ENDERECO_COMPLEMENTO, @PED_CLI_CEP, @PED_CLI_BAIRRO, @PED_CLI_CIDADE, @PED_CLI_UF, @PED_CLI_EMAIL, 
                            @PED_SKYPE, @PED_CLI_TELEFONE, @PED_CLI_TELEFONE_DDD, @PED_CLI_QTD_FUNCIONA, @PED_CLI_CONTATO, @PED_VERSAO_AQUISICAO, 
                            @PED_COM_MANUTENCAO, @PED_MODELOREP, @PED_REPINSTALADO, @PED_DESCRICAO, @PED_SOLICITANTE, @PED_REP_FABRICANTE, @PED_FANTASIA, 
                            1, @PED_EMAIL2, 1, 0, @PED_CLI_TELEFONE2, @PED_CLI_TELEFONE2_DDD, @PED_CLI_CELULAR, 
                            @PED_CLI_CELULAR_DDD, @PED_CLI_CELULAR_ACEITA)
                            select SCOPE_IDENTITY()";
                }
                else
                {
                    query = @" UPDATE AssepontoPedidosRevendas 
                             SET PED_CLI_RAZAO = @PED_CLI_RAZAO, 
	                             PED_CLI_CNPJ = @PED_CLI_CNPJ, 
	                             PED_CLI_CPF = @PED_CLI_CPF, 
	                             PED_CLI_IE = @PED_CLI_IE, 
	                             PED_CLI_ENDERECO = @PED_CLI_ENDERECO, 
	                             PED_CLI_ENDERECO_NUMERO = @PED_CLI_ENDERECO_NUMERO, 
	                             PED_CLI_ENDERECO_COMPLEMENTO = @PED_CLI_ENDERECO_COMPLEMENTO, 
	                             PED_CLI_CEP = @PED_CLI_CEP, 
	                             PED_CLI_BAIRRO = @PED_CLI_BAIRRO, 
	                             PED_CLI_CIDADE = @PED_CLI_CIDADE, 
	                             PED_CLI_UF = @PED_CLI_UF, 
	                             PED_CLI_EMAIL = @PED_CLI_EMAIL, 
	                             PED_SKYPE = @PED_SKYPE, 
	                             PED_CLI_TELEFONE = @PED_CLI_TELEFONE, 
	                             PED_CLI_TELEFONE_DDD = @PED_CLI_TELEFONE_DDD, 
	                             PED_CLI_QTD_FUNCIONA = @PED_CLI_QTD_FUNCIONA, 
	                             PED_CLI_CONTATO = @PED_CLI_CONTATO, 
	                             PED_VERSAO_AQUISICAO = @PED_VERSAO_AQUISICAO, 
	                             PED_COM_MANUTENCAO = @PED_COM_MANUTENCAO, 
	                             PED_MODELOREP = @PED_MODELOREP, 
	                             PED_REPINSTALADO = @PED_REPINSTALADO, 
	                             PED_DESCRICAO = @PED_DESCRICAO, 
	                             PED_SOLICITANTE = @PED_SOLICITANTE, 
	                             PED_REP_FABRICANTE = @PED_REP_FABRICANTE, 
	                             PED_FANTASIA = @PED_FANTASIA, 
                                 PED_STATUS = @PED_STATUS, 
	                             PED_EMAIL2 = @PED_EMAIL2, 
	                             PED_CLI_TELEFONE2 = @PED_CLI_TELEFONE2,  
	                             PED_CLI_TELEFONE2_DDD = @PED_CLI_TELEFONE2_DDD,  
	                             PED_CLI_CELULAR = @PED_CLI_CELULAR,  
	                             PED_CLI_CELULAR_DDD = @PED_CLI_CELULAR_DDD,  
	                             PED_CLI_CELULAR_ACEITA = @PED_CLI_CELULAR_ACEITA 
                            WHERE PED_IND = @PED_IND";
                }
                query = query.Replace("@PED_IND", HiddenIndice.Value);
                query = query.Replace("@PED_REV_IND", hiddenRevenda.Value);
                query = query.Replace("@PED_CLI_RAZAO", string.IsNullOrEmpty(PED_CLI_RAZAO.Text) ? "NULL" : "'" + PED_CLI_RAZAO.Text + "'");
                query = query.Replace("@PED_CLI_CNPJ", string.IsNullOrEmpty(PED_CLI_CNPJ.Text) ? "NULL" : "'" + PED_CLI_CNPJ.Text + "'");
                query = query.Replace("@PED_CLI_CPF", string.IsNullOrEmpty(PED_CLI_CPF.Text) ? "NULL" : "'" + PED_CLI_CPF.Text + "'");
                query = query.Replace("@PED_CLI_IE", string.IsNullOrEmpty(PED_CLI_IE.Text) ? "NULL" : "'" + PED_CLI_IE.Text + "'");
                query = query.Replace("@PED_CLI_ENDERECO_NUMERO", string.IsNullOrEmpty(PED_CLI_ENDERECO_NUMERO.Text) ? "NULL" : "'" + PED_CLI_ENDERECO_NUMERO.Text + "'");
                query = query.Replace("@PED_CLI_ENDERECO_COMPLEMENTO", string.IsNullOrEmpty(PED_CLI_ENDERECO_COMPLEMENTO.Text) ? "NULL" : "'" + PED_CLI_ENDERECO_COMPLEMENTO.Text + "'");
                query = query.Replace("@PED_CLI_ENDERECO", string.IsNullOrEmpty(PED_CLI_ENDERECO.Text) ? "NULL" : "'" + PED_CLI_ENDERECO.Text + "'");
                query = query.Replace("@PED_CLI_CEP", string.IsNullOrEmpty(PED_CLI_CEP.Text) ? "NULL" : "'" + PED_CLI_CEP.Text + "'");
                query = query.Replace("@PED_CLI_BAIRRO", string.IsNullOrEmpty(PED_CLI_BAIRRO.Text) ? "NULL" : "'" + PED_CLI_BAIRRO.Text + "'");
                query = query.Replace("@PED_CLI_CIDADE", string.IsNullOrEmpty(PED_CLI_CIDADE.Text) ? "NULL" : "'" + PED_CLI_CIDADE.Text + "'");
                query = query.Replace("@PED_CLI_UF", string.IsNullOrEmpty(PED_CLI_UF.Text) ? "NULL" : "'" + PED_CLI_UF.Text + "'");
                query = query.Replace("@PED_CLI_EMAIL", string.IsNullOrEmpty(txtEmail.Text) ? "NULL" : "'" + txtEmail.Text + "'");
                query = query.Replace("@PED_SKYPE", string.IsNullOrEmpty(PED_SKYPE.Text) ? "NULL" : "'" + PED_SKYPE.Text + "'");
                query = query.Replace("@PED_CLI_QTD_FUNCIONA", string.IsNullOrEmpty(RadNumericTextBox1.Text) ? "NULL" : "'" + RadNumericTextBox1.Text + "'");
                query = query.Replace("@PED_CLI_CONTATO", string.IsNullOrEmpty(PED_CLI_CONTATO.Text) ? "NULL" : "'" + PED_CLI_CONTATO.Text + "'");
                query = query.Replace("@PED_VERSAO_AQUISICAO", radioVersao.SelectedValue);
                query = query.Replace("@PED_COM_MANUTENCAO", PED_COM_MANUTENCAO.SelectedValue == "False" ? "0" : "1");
                query = query.Replace("@PED_MODELOREP", string.IsNullOrEmpty(PED_MODELOREP.Text) ? "NULL" : "'" + PED_MODELOREP.Text + "'");
                query = query.Replace("@PED_REPINSTALADO", PED_REPINSTALADO.SelectedValue == "False" ? "0" : "1");
                query = query.Replace("@PED_DESCRICAO", string.IsNullOrEmpty(PED_DESCRICAOTextBox.Text) ? "NULL" : "'" + PED_DESCRICAOTextBox.Text + "'");
                query = query.Replace("@PED_SOLICITANTE", string.IsNullOrEmpty(PED_SOLICITANTE.Text) ? "NULL" : "'" + PED_SOLICITANTE.Text + "'");
                query = query.Replace("@PED_REP_FABRICANTE", PED_REP_FABRICANTE.SelectedValue);
                query = query.Replace("@PED_FANTASIA", string.IsNullOrEmpty(PED_FANTASIA.Text) ? "NULL" : "'" + PED_FANTASIA.Text + "'");
                query = query.Replace("@PED_STATUS", string.IsNullOrEmpty(HiddenStatus.Value) ? "NULL" : "'" + HiddenStatus.Value);
                query = query.Replace("@PED_EMAIL2", string.IsNullOrEmpty(txtEmail2.Text) ? "NULL" : "'" + txtEmail2.Text + "'");
                query = query.Replace("@PED_CLI_TELEFONE2_DDD", string.IsNullOrEmpty(PED_CLI_TELEFONE2_DDD.Text) ? "NULL" : "'" + PED_CLI_TELEFONE2_DDD.Text + "'");
                query = query.Replace("@PED_CLI_TELEFONE2", string.IsNullOrEmpty(PED_CLI_TELEFONE2.Text) ? "NULL" : "'" + PED_CLI_TELEFONE2.Text + "'");
                query = query.Replace("@PED_CLI_TELEFONE_DDD", string.IsNullOrEmpty(PED_CLI_TELEFONE_DDD.Text) ? "NULL" : "'" + PED_CLI_TELEFONE_DDD.Text + "'");
                query = query.Replace("@PED_CLI_TELEFONE", string.IsNullOrEmpty(PED_CLI_TELEFONE.Text) ? "NULL" : "'" + PED_CLI_TELEFONE.Text + "'");
                query = query.Replace("@PED_CLI_CELULAR_DDD", string.IsNullOrEmpty(PED_CLI_CELULAR_DDD.Text) ? "NULL" : "'" + PED_CLI_CELULAR_DDD.Text + "'");
                query = query.Replace("@PED_CLI_CELULAR_ACEITA", CAD_CELULAR_ACEITA.SelectedValue == "False" ? "0" : "1");
                query = query.Replace("@PED_CLI_CELULAR", string.IsNullOrEmpty(PED_CLI_CELULAR.Text) ? "NULL" : "'" + PED_CLI_CELULAR.Text + "'");
                BDApp bd = new BDApp();

                if (string.IsNullOrEmpty(PedidoIndice))
                {
                    //bd.executeCommand(query);
                    int indice = bd.getFieldValueInteger(query);

                    if (indice > 0)
                    {
                        bd.openConnection();

                        if (FilePlanilha.HasFile)
                        {
                            Model.Pedido ped = new Model.Pedido(indice);
                            ped.setPlanilha(FilePlanilha);
                            ped.insertPlanilhaRevenda(bd);
                        }

                        Enviar_Email_Pedido(bd, indice);
                        Enviar_Email_Pedido_Retorno(bd, indice);
                        bd.closeConnection();

                        Response.Redirect("~/Revenda/Pedidos/PedidoEnviado.aspx");
                    }
                }
                else
                    bd.executeCommand(query);
            }
        }

        protected void PED_CLI_CEP_TextChanged(object sender, EventArgs e)
        {
            if (!passou)
            {
                RadMaskedTextBox txtcep = sender as RadMaskedTextBox;
                string cep = txtcep.Text.Replace("-", "").Replace(".", "");
                if (cep.Length == 8)
                {
                    Chamizo.Web.Control.FindAddress findaddress = new Chamizo.Web.Control.FindAddress();
                    Chamizo.Web.Control.Address address = findaddress.GetAddressBy(cep);
                    if (address != null)
                    {
                        if (!string.IsNullOrEmpty(address.District) &&
                            !string.IsNullOrEmpty(address.Street) &&
                            !string.IsNullOrEmpty(address.State) &&
                            !string.IsNullOrEmpty(address.City))
                        {
                            if (!string.IsNullOrEmpty(address.District.Trim()))
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_BAIRRO") as TextBox;
                                //txt.Text = address.District;

                                PED_CLI_BAIRRO.Text = address.District;
                            }
                            else
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_BAIRRO") as TextBox;
                                //txt.Enabled = true;
                                PED_CLI_BAIRRO.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.Street.Trim()))
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO") as TextBox;
                                //txt.Text = address.Street;
                                PED_CLI_ENDERECO.Text = address.Street;
                            }
                            else
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO") as TextBox;
                                //txt.Enabled = true;
                                PED_CLI_ENDERECO.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.Complement.Trim()))
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_COMPLEMENTO") as TextBox;
                                //txt.Text = address.Complement;
                                PED_CLI_ENDERECO_COMPLEMENTO.Text = address.Complement;
                            }
                            else
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_COMPLEMENTO") as TextBox;
                                //txt.Enabled = true;
                                PED_CLI_ENDERECO_COMPLEMENTO.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.StreetNumber))
                            {
                                //RadMaskedTextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_NUMERO") as RadMaskedTextBox;
                                //txt.Text = address.StreetNumber;
                                PED_CLI_ENDERECO_NUMERO.Text = address.StreetNumber;
                            }
                            else
                            {
                                //RadMaskedTextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_NUMERO") as RadMaskedTextBox;
                                //txt.Enabled = true;
                                PED_CLI_ENDERECO_NUMERO.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.State.Trim()))
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_UF") as TextBox;
                                //txt.Text = address.State.Trim();
                                PED_CLI_UF.Text = address.State.Trim();
                                //HiddenField hidden = FormView1.FindControl("PED_CLI_UF") as HiddenField;
                                //BDApp bd = new BDApp();
                                //string query = "SELECT EST_IND FROM [Estados] WHERE UPPER(EST_SIGLA) = '" + address.State.ToUpper().Trim() + "'";
                                //hidden.Value = Convert.ToString(bd.getFieldValueInteger(query));
                            }
                            else
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_UF") as TextBox;
                                //txt.Enabled = true;
                                PED_CLI_UF.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.City.Trim()))
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_CIDADE") as TextBox;
                                //txt.Text = address.City;
                                PED_CLI_CIDADE.Text = address.City;
                            }
                            else
                            {
                                //TextBox txt = FormView1.FindControl("PED_CLI_CIDADE") as TextBox;
                                PED_CLI_CIDADE.Enabled = true;
                            }
                        }
                        else
                        {
                            //TextBox PED_CLI_BAIRRO = FormView1.FindControl("PED_CLI_BAIRRO") as TextBox;
                            PED_CLI_BAIRRO.Enabled = true;
                            //TextBox PED_CLI_ENDERECO = FormView1.FindControl("PED_CLI_ENDERECO") as TextBox;
                            PED_CLI_ENDERECO.Enabled = true;
                            //TextBox PED_CLI_ENDERECO_COMPLEMENTO = FormView1.FindControl("PED_CLI_ENDERECO_COMPLEMENTO") as TextBox;
                            PED_CLI_ENDERECO_COMPLEMENTO.Enabled = true;
                            //RadMaskedTextBox PED_CLI_ENDERECO_NUMERO = FormView1.FindControl("PED_CLI_ENDERECO_NUMERO") as RadMaskedTextBox;
                            PED_CLI_ENDERECO_NUMERO.Enabled = true;
                            //TextBox PED_CLI_UF = FormView1.FindControl("PED_CLI_UF") as TextBox;
                            PED_CLI_UF.Enabled = true;
                            //TextBox PED_CLI_CIDADE = FormView1.FindControl("PED_CLI_CIDADE") as TextBox;
                            PED_CLI_CIDADE.Enabled = true;
                        }
                    }
                }
                else return;
                //RadComboBox rad = FormView1.FindControl("PED_REP_FABRICANTE") as RadComboBox;
                if (PED_REP_FABRICANTE != null)
                    PED_REP_FABRICANTE.DataBind();
                //TextBox txtDate = FormView1.FindControl("PED_DATA") as TextBox;
                if (PED_DATA != null)
                    if (string.IsNullOrEmpty(dataPedido))
                        if (string.IsNullOrEmpty(PED_DATA.Text))
                            PED_DATA.Text = DateTime.Now.ToString("dd/MM/yyyy");
                        else
                        if (string.IsNullOrEmpty(PED_DATA.Text))
                            PED_DATA.Text = dataPedido;
                passou = true;
            }
        }

        protected void PED_CLI_CNPJ_TextChanged(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            PED_CLI_CNPJ_ERRO.Visible = 
                bd.getFieldValueBool(
                    ("select case when exists(select * from AssepontoClientes where CAD_CNPJ is not null and CAD_CNPJ = '@PEDCLICNPJ') then 1 else 0 end").Replace("@PEDCLICNPJ", PED_CLI_CNPJ.Text.Trim()));
        }

        protected void PED_CLI_CPF_TextChanged(object sender, EventArgs e)
        {
            BDApp bd = new BDApp();
            PED_CLI_CPF_ERRO.Visible =
                bd.getFieldValueBool(
                    ("select case when exists(select * from AssepontoClientes where CAD_CPF is not null and CAD_CPF = '@PEDCLICPF') then 1 else 0 end").Replace("@PEDCLICPF", PED_CLI_CPF.Text.Trim()));
        }
    }
}