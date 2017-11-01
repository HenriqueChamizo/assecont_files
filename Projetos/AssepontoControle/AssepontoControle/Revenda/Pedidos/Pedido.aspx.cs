using Asseponto.Classes;
using BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Asseponto.Revenda.Pedidos
{
    public partial class Pedido : System.Web.UI.Page
    {
        protected bool passou;

        protected void Page_InitComplete(object sender, EventArgs e)
        {
            PedidosBLL BLL = new PedidosBLL(TypesConnections.Asseponto);
            List<Modelo.Asseponto.FabricantesDropDrow> fabricantes = BLL.GetFabricantesDropDown();
            foreach (Modelo.Asseponto.FabricantesDropDrow fabricante in fabricantes)
            {
                Telerik.Web.UI.RadComboBoxItem item = new Telerik.Web.UI.RadComboBoxItem();
                item.Value = fabricante.FABR_COD;
                item.Text = fabricante.FABR_NOME;
                PED_REP_FABRICANTE.Items.Add(item);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int ind = Convert.ToInt32(string.IsNullOrEmpty(Request.QueryString["ind"]) ? "-1" : Request.QueryString["ind"]);
                if (ind != -1)
                {
                    PedidosBLL BLL = new PedidosBLL(TypesConnections.Asseponto);
                    Modelo.Asseponto.PedidoDetail pedido = BLL.GetPedidobyId(ind);

                    hiddenRevenda.Value = pedido.PED_REV_IND.ToString().Trim();
                    HiddenIndice.Value = pedido.PED_IND.ToString().Trim();
                    HiddenStatus.Value = pedido.PED_STATUS.ToString().Trim();

                    PED_CLI_RAZAO.Text = pedido.PED_CLI_RAZAO.ToString().Trim();
                    PED_CLI_CNPJ.Text = pedido.PED_CLI_CNPJ.ToString().Trim();
                    PED_CLI_CPF.Text = pedido.PED_CLI_CPF.ToString().Trim();
                    if (string.IsNullOrEmpty(PED_CLI_CNPJ.Text.Trim()))
                        PED_CLI_CPF.Enabled = true;
                    else
                    {
                        PED_CLI_CPF.Enabled = false;
                        if (string.IsNullOrEmpty(PED_CLI_CPF.Text.Trim()))
                            PED_CLI_CNPJ.Enabled = true;
                        else
                            PED_CLI_CNPJ.Enabled = false;
                    }

                    PED_FANTASIA.Text = pedido.PED_FANTASIA.ToString().Trim();
                    PED_CLI_IE.Text = pedido.PED_CLI_IE.ToString().Trim();
                    PED_CLI_CEP.Text = pedido.PED_CLI_CEP.ToString().Trim();
                    PED_CLI_UF.Text = pedido.PED_CLI_CEP.ToString().Trim();
                    PED_CLI_CIDADE.Text = pedido.PED_CLI_CIDADE.ToString().Trim();
                    PED_CLI_BAIRRO.Text = pedido.PED_CLI_BAIRRO.ToString().Trim();
                    PED_CLI_ENDERECO.Text = pedido.PED_CLI_ENDERECO.ToString().Trim();
                    PED_CLI_ENDERECO_NUMERO.Text = pedido.PED_CLI_ENDERECO_NUMERO.ToString().Trim();
                    PED_CLI_ENDERECO_COMPLEMENTO.Text = pedido.PED_CLI_ENDERECO_COMPLEMENTO.ToString().Trim();
                    PED_CLI_CONTATO.Text = pedido.PED_CLI_CONTATO.ToString().Trim();
                    PED_SKYPE.Text = pedido.PED_SKYPE.ToString().Trim();
                    PED_CLI_TELEFONE_DDD.Text = pedido.PED_CLI_TELEFONE_DDD.ToString().Trim();
                    PED_CLI_TELEFONE.Text = pedido.PED_CLI_TELEFONE.ToString().Trim();
                    PED_CLI_TELEFONE2_DDD.Text = pedido.PED_CLI_TELEFONE2_DDD.ToString().Trim();
                    PED_CLI_TELEFONE2.Text = pedido.PED_CLI_TELEFONE2.ToString().Trim();
                    PED_CLI_CELULAR_DDD.Text = pedido.PED_CLI_CELULAR_DDD.ToString().Trim();
                    PED_CLI_CELULAR.Text = pedido.PED_CLI_CELULAR.ToString().Trim();
                    CAD_CELULAR_ACEITA.SelectedValue = pedido.PED_CLI_CELULAR_ACEITA.ToString().Trim();
                    txtEmail.Text = pedido.PED_CLI_EMAIL.ToString().Trim();
                    txtEmail2.Text = pedido.PED_EMAIL2.ToString().Trim();
                    PED_CLI_QTD_FUNCIONA.Text = pedido.PED_CLI_QTD_FUNCIONA.ToString().Trim();
                    PED_SOLICITANTE.Text = pedido.PED_SOLICITANTE.ToString().Trim();
                    PED_DATA.Text = pedido.PED_DATA.ToString().Trim();
                    radioVersao.SelectedValue = pedido.PED_VERSAO_AQUISICAO.ToString().Trim();
                    PED_COM_MANUTENCAO.SelectedValue = pedido.PED_COM_MANUTENCAO.ToString().Trim();
                    PED_REP_FABRICANTE.SelectedValue = pedido.PED_REP_FABRICANTE.ToString().Trim();
                    PED_MODELOREP.Text = pedido.PED_MODELOREP.ToString().Trim();
                    PED_REPINSTALADO.SelectedValue = pedido.PED_REPINSTALADO.ToString().Trim();
                    PED_DESCRICAOTextBox.Text = pedido.PED_DESCRICAO.ToString().Trim();
                }
                else
                {
                    BDApp bd = new BDApp();
                    hiddenRevenda.Value = bd.getFieldValueInteger("select USUREV_REVENDA from AssepontoUsuariosRevendas where USUREV_IND = " + UserApp.UserId.ToString()).ToString();
                }

                //PED_REP_FABRICANTE.DataBind();
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
        }

        protected void CustomValidator1_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            //RadMaskedTextBox txtCNPJ = PED_CLI_CNPJ;//(RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ");
            //RadMaskedTextBox txtCPF = PED_CLI_CPF;// (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF");

            //if (
            //    (!string.IsNullOrEmpty(txtCNPJ.Text) && string.IsNullOrEmpty(txtCPF.Text)) ||
            //    (string.IsNullOrEmpty(txtCNPJ.Text) && !string.IsNullOrEmpty(txtCPF.Text))
            //   )
            //    args.IsValid = true;
            //else
            //    args.IsValid = false;
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

        protected void lkPlanilha_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ViewFile.aspx?ind=" + HiddenIndice);
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
            email.Send(EmailTo, EmailCC, EmailCC2, EmailCC3, EmailCC4, EmailCC5, pedido == 0 ? Convert.ToInt32(HiddenIndice.Value) : pedido);
        }

        protected void Enviar_Email_Pedido_Web(BDApp bd, int pedido = 0)
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = "comercial@assecont.com.br";

            EmailPedido email = new EmailPedido(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedidoWeb.htm");
            email.Send(EmailTo, pedido == 0 ? Convert.ToInt32(HiddenIndice.Value) : pedido);
        }

        protected void Enviar_Email_Pedido_Retorno(BDApp bd, int pedido = 0)
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = bd.getRevendaEmailFromPedido(Convert.ToInt32(HiddenIndice.Value));
            string EmailCC = bd.getRevendaEmailFromPedido2(Convert.ToInt32(HiddenIndice.Value));

            EmailPedidoRetorno email = new EmailPedidoRetorno(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedidoRetorno.htm");
            email.Send(EmailTo, EmailCC, pedido == 0 ? Convert.ToInt32(HiddenIndice.Value) : pedido);
        }
        
        protected void RadComboBox1_DataBinding(object sender, EventArgs e)
        {
            //Binding do Combox UF
            //RadComboBox combo = (RadComboBox)sender;
            //combo.DataSourceID = "sqlEstados";
            //combo.DataTextField = "EST_NOME";
            //combo.DataValueField = "EST_SIGLA";
        }

        protected void RadComboBox2_DataBinding(object sender, EventArgs e)
        {
            //Binding do Combox Lista de Relogios
            //RadComboBox combo = (RadComboBox)sender;
            ////if (!IsPostBack)
            ////{
            //combo.DataSourceID = "sqlAssepontoRepFabricantes";
            //combo.DataTextField = "FABR_NOME";
            //combo.DataValueField = "FABR_COD";
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
            //RadComboBox combo = sender as RadComboBox;
            //if (!IsPostBack)
            //{
            //    if (RepFabricante == 0 || RepFabricante == -1)
            //    {
            //        if (!string.IsNullOrEmpty(Request.QueryString["ind"]))
            //        {
            //            BDApp bd = new BDApp();
            //            int REP_FABRICANTE = bd.getFieldValueInteger("SELECT TOP 1 PED_REP_FABRICANTE FROM AssepontoPedidosRevendas WHERE PED_IND = " + Request.QueryString["ind"] + " ORDER BY PED_DATA DESC");
            //            combo.SelectedValue = REP_FABRICANTE.ToString();
            //        }
            //    }
            //    else
            //        combo.SelectedValue = RepFabricante.ToString();
            //}
        }

        protected void Salvar_Click(object sender, EventArgs e)
        {
            if (CheckValues())
            {
                if (!PED_CLI_CNPJ_ERRO.Visible)
                {
                    int PedidoIndice = Convert.ToInt32(string.IsNullOrEmpty(Request.QueryString["ind"]) ? "-1" : Request.QueryString["ind"]);
                    PedidosBLL BLL = new PedidosBLL(TypesConnections.Asseponto);

                    Modelo.Asseponto.PedidoDetail pedido = new Modelo.Asseponto.PedidoDetail();

                    pedido.PED_REV_IND = Convert.ToInt32(hiddenRevenda.Value);
                    pedido.PED_IND = PedidoIndice;
                    if (!string.IsNullOrEmpty(HiddenStatus.Value))
                        pedido.PED_STATUS = Convert.ToInt32(HiddenStatus.Value);
                    else
                        pedido.PED_STATUS = 1;

                    string cnpj = PED_CLI_CNPJ.Text.Replace(".", "").Replace("/", "").Replace("-", "");
                    string cpf = PED_CLI_CPF.Text.Replace(".", "").Replace("-", "");

                    pedido.PED_CLI_RAZAO = PED_CLI_RAZAO.Text;
                    pedido.PED_CLI_CNPJ = string.IsNullOrEmpty(cnpj) ? null : cnpj;
                    pedido.PED_CLI_CPF = string.IsNullOrEmpty(cpf) ? null : cpf;
                    pedido.PED_FANTASIA = PED_FANTASIA.Text;
                    pedido.PED_CLI_IE = PED_CLI_IE.Text;
                    pedido.PED_CLI_CEP = PED_CLI_CEP.Text;
                    pedido.PED_CLI_UF = PED_CLI_UF.Text;
                    pedido.PED_CLI_CIDADE = PED_CLI_CIDADE.Text;
                    pedido.PED_CLI_BAIRRO = PED_CLI_BAIRRO.Text;
                    pedido.PED_CLI_ENDERECO = PED_CLI_ENDERECO.Text;
                    pedido.PED_CLI_ENDERECO_NUMERO = PED_CLI_ENDERECO_NUMERO.Text;
                    pedido.PED_CLI_ENDERECO_COMPLEMENTO = PED_CLI_ENDERECO_COMPLEMENTO.Text;
                    pedido.PED_CLI_CONTATO = PED_CLI_CONTATO.Text;
                    pedido.PED_SKYPE = PED_SKYPE.Text;
                    pedido.PED_CLI_TELEFONE_DDD = PED_CLI_TELEFONE_DDD.Text;
                    pedido.PED_CLI_TELEFONE = PED_CLI_TELEFONE.Text;
                    pedido.PED_CLI_TELEFONE2_DDD = PED_CLI_TELEFONE2_DDD.Text;
                    pedido.PED_CLI_TELEFONE2 = PED_CLI_TELEFONE2.Text;
                    pedido.PED_CLI_CELULAR_DDD = PED_CLI_CELULAR_DDD.Text;
                    pedido.PED_CLI_CELULAR = PED_CLI_CELULAR.Text;
                    pedido.PED_CLI_CELULAR_ACEITA = Convert.ToBoolean(CAD_CELULAR_ACEITA.SelectedValue);
                    pedido.PED_CLI_EMAIL = txtEmail.Text;
                    pedido.PED_EMAIL2 = txtEmail2.Text;
                    pedido.PED_CLI_QTD_FUNCIONA = Convert.ToInt32(string.IsNullOrEmpty(PED_CLI_QTD_FUNCIONA.Text) ? "0" : PED_CLI_QTD_FUNCIONA.Text);
                    pedido.PED_SOLICITANTE = PED_SOLICITANTE.Text;
                    pedido.PED_DATA = Convert.ToDateTime(PED_DATA.Text);
                    pedido.PED_VERSAO_AQUISICAO = Convert.ToInt32(radioVersao.SelectedValue);
                    pedido.PED_COM_MANUTENCAO = Convert.ToBoolean(PED_COM_MANUTENCAO.SelectedValue);
                    pedido.PED_REP_FABRICANTE = Convert.ToInt32(PED_REP_FABRICANTE.SelectedValue);
                    pedido.PED_MODELOREP = PED_MODELOREP.Text;
                    pedido.PED_REPINSTALADO = Convert.ToBoolean(PED_REPINSTALADO.SelectedValue);
                    pedido.PED_DESCRICAO = PED_DESCRICAOTextBox.Text;
                    if (PedidoIndice == -1)
                        BLL.SetPedidosGetId(pedido, ref PedidoIndice);
                    else
                        BLL.SetPedidos(pedido);


                    BDApp bd = new BDApp();

                    if (PedidoIndice != -1)
                    {
                        //bd.executeCommand(query);
                        bd.openConnection();

                        if (FilePlanilha.HasFile)
                        {
                            Model.Pedido ped = new Model.Pedido(PedidoIndice);
                            ped.setPlanilha(FilePlanilha);
                            ped.insertPlanilhaRevenda(bd);
                        }
                        HiddenIndice.Value = PedidoIndice.ToString();
                        Enviar_Email_Pedido(bd, PedidoIndice);
                        Enviar_Email_Pedido_Retorno(bd, PedidoIndice);
                        if (pedido.PED_VERSAO_AQUISICAO == 8)
                            Enviar_Email_Pedido_Web(bd, PedidoIndice);
                        bd.closeConnection();

                        Response.Redirect("~/Revenda/Pedidos/PedidoEnviado.aspx");
                    }
                }
            }
        }

        #region TextChanged
        protected void PED_CLI_CNPJ_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(PED_CLI_CNPJ.Text.Trim()))
            {
                PED_CLI_CPF.Enabled = true;
                PED_CLI_CPF.Text = "";
                PED_CLI_CNPJ_ERRO.Visible = false;
                PED_FANTASIA.Text = "";
                PED_CLI_IE.Text = "";
            }
            else
            {
                PED_CLI_CPF.Enabled = false;
                PED_CLI_CPF.Text = "";

                string value = PED_CLI_CNPJ.Text.Replace(".", "").Replace("/", "").Replace("-", "");
                int length = value.Length;
                if (length == 14)
                {
                    if (Validacao.Valida.IsCnpj(value))
                    {
                        if (string.IsNullOrEmpty(Request.QueryString["ind"]))
                        {
                            if ((new BDApp()).getFieldValueInteger(string.Format("SELECT CAD_IND FROM AssepontoClientes WHERE CAD_ASSEPONTO4 = 1 AND " +
                                "(dbo.fn_asseponto_trim_cnpj(CAD_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}'))", value)) == 0)
                            {
                                if ((new BDApp()).getFieldValueInteger(string.Format("SELECT PED_IND FROM AssepontoPedidosRevendas " +
                                    "WHERE (dbo.fn_asseponto_trim_cnpj(PED_CLI_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}'))", value)) == 0)
                                {
                                    string beginA = value.Substring(0, 2);
                                    string centerA = value.Substring(2, 3);
                                    string endA = value.Substring(5, 3);
                                    string beginB = value.Substring(8, 4);
                                    string endB = value.Substring(12);

                                    PED_CLI_CNPJ.Text = beginA + "." + centerA + "." + endA + "/" + beginB + "-" + endB;
                                }
                                else
                                {
                                    PED_CLI_CNPJ_ERRO.Visible = true;
                                    PED_CLI_CNPJ_ERRO.Text = "O Pedido nesse CNPJ já foi criado!";
                                }
                            }
                            else
                            {
                                PED_CLI_CNPJ_ERRO.Visible = true;
                                PED_CLI_CNPJ_ERRO.Text = "O CNPJ já está cadastrado no sistema!";
                            }
                        }
                        else
                        {
                            if ((new BDApp()).getFieldValueInteger(string.Format("SELECT PED_IND FROM AssepontoPedidosRevendas " +
                                       "WHERE (dbo.fn_asseponto_trim_cnpj(PED_CLI_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}')) and PED_IND != {1}", value, Request.QueryString["ind"])) == 0)
                            {
                                string beginA = value.Substring(0, 2);
                                string centerA = value.Substring(2, 3);
                                string endA = value.Substring(5, 3);
                                string beginB = value.Substring(8, 4);
                                string endB = value.Substring(12);

                                PED_CLI_CNPJ.Text = beginA + "." + centerA + "." + endA + "/" + beginB + "-" + endB;
                            }
                            else
                            {
                                PED_CLI_CNPJ_ERRO.Visible = true;
                                PED_CLI_CNPJ_ERRO.Text = "O Pedido nesse CNPJ já foi criado!";
                            }
                        }
                    }
                    else
                    {
                        PED_CLI_CNPJ_ERRO.Visible = true;
                        PED_CLI_CNPJ_ERRO.Text = "O CNPJ é inválido!";
                    }
                }
                else
                {
                    PED_CLI_CNPJ_ERRO.Visible = true;
                    PED_CLI_CNPJ_ERRO.Text = "O tamanho do CNPJ está incorreto!";
                }
            }
        }

        protected void PED_CLI_CPF_TextChanged(object sender, EventArgs e)
        {
            PED_CLI_IE.Text = "";
            PED_FANTASIA.Text = "";
            PED_CLI_CNPJ.Text = "";
            if (string.IsNullOrEmpty(PED_CLI_CPF.Text.Trim()))
            {
                PED_CLI_CNPJ.Enabled = true;
                PED_FANTASIA.Enabled = true;
                PED_CLI_IE.Enabled = true;
            }
            else
            {
                PED_CLI_CNPJ.Enabled = false;
                PED_FANTASIA.Enabled = false;
                PED_CLI_IE.Enabled = false;
                PED_CLI_IE.Text = "";
                PED_FANTASIA.Text = "";
                PED_CLI_CNPJ.Text = "";
                
                string value = PED_CLI_CPF.Text.Replace(".", "").Replace("-", "");
                int length = value.Length;
                if (length == 11)
                {
                    if (Validacao.Valida.IsCpf(value))
                    {
                        if (string.IsNullOrEmpty(Request.QueryString["ind"]))
                        {
                            if ((new BDApp()).getFieldValueInteger(string.Format("SELECT CAD_IND FROM AssepontoClientes WHERE CAD_ASSEPONTO4 = 1 AND " +
                                "(dbo.fn_asseponto_trim_cnpj(CAD_CPF) = dbo.fn_asseponto_trim_cnpj('{0}'))", value)) == 0)
                            {
                                if ((new BDApp()).getFieldValueInteger(string.Format("SELECT PED_IND FROM AssepontoPedidosRevendas " +
                                    "WHERE(dbo.fn_asseponto_trim_cnpj(PED_CLI_CPF) = dbo.fn_asseponto_trim_cnpj('{0}'))", value)) == 0)
                                {
                                    string beginA = value.Substring(0, 3);
                                    string centerA = value.Substring(3, 3);
                                    string endA = value.Substring(6, 3);
                                    string endB = value.Substring(9, 2);

                                    PED_CLI_CPF.Text = beginA + "." + centerA + "." + endA + "-" + endB;
                                }
                                else
                                {
                                    PED_CLI_CNPJ_ERRO.Visible = true;
                                    PED_CLI_CNPJ_ERRO.Text = "O Pedido nesse CPF já foi criado!";
                                }
                            }
                            else
                            {
                                PED_CLI_CNPJ_ERRO.Visible = true;
                                PED_CLI_CNPJ_ERRO.Text = "O CPF já está cadastrado no sistema!";
                            }
                        }
                        else
                        {
                            if ((new BDApp()).getFieldValueInteger(string.Format("SELECT PED_IND FROM AssepontoPedidosRevendas " +
                                "WHERE(dbo.fn_asseponto_trim_cnpj(PED_CLI_CPF) = dbo.fn_asseponto_trim_cnpj('{0}')) and PED_IND != {1}", value, Request.QueryString["ind"])) == 0)
                            {
                                string beginA = value.Substring(0, 3);
                                string centerA = value.Substring(3, 3);
                                string endA = value.Substring(6, 3);
                                string endB = value.Substring(9, 2);

                                PED_CLI_CPF.Text = beginA + "." + centerA + "." + endA + "-" + endB;
                            }
                            else
                            {
                                PED_CLI_CNPJ_ERRO.Visible = true;
                                PED_CLI_CNPJ_ERRO.Text = "O Pedido nesse CPF já foi criado!";
                            }
                        }
                    }
                    else
                    {
                        PED_CLI_CNPJ_ERRO.Visible = true;
                        PED_CLI_CNPJ_ERRO.Text = "O CPF é inválido!";
                    }
                }
                else
                {
                    PED_CLI_CNPJ_ERRO.Visible = true;
                    PED_CLI_CNPJ_ERRO.Text = "O tamanho do CPF está incorreto!";
                }
            }
        }

        protected void PED_CLI_IE_TextChanged(object sender, EventArgs e)
        {

        }

        protected void PED_CLI_ENDERECO_NUMERO_TextChanged(object sender, EventArgs e)
        {

        }

        protected void PED_CLI_CEP_TextChanged(object sender, EventArgs e)
        {
            if (!passou)
            {
                string cep = PED_CLI_CEP.Text.Replace("-", "").Replace(".", "");
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
                                PED_CLI_BAIRRO.Text = address.District;
                            else
                                PED_CLI_BAIRRO.Enabled = true;

                            if (!string.IsNullOrEmpty(address.Street.Trim()))
                                PED_CLI_ENDERECO.Text = address.Street;
                            else
                                PED_CLI_ENDERECO.Enabled = true;

                            if (!string.IsNullOrEmpty(address.Complement.Trim()))
                                PED_CLI_ENDERECO_COMPLEMENTO.Text = address.Complement;
                            else
                                PED_CLI_ENDERECO_COMPLEMENTO.Enabled = true;

                            if (!string.IsNullOrEmpty(address.StreetNumber))
                                PED_CLI_ENDERECO_NUMERO.Text = address.StreetNumber;
                            else
                                PED_CLI_ENDERECO_NUMERO.Enabled = true;

                            if (!string.IsNullOrEmpty(address.State.Trim()))
                                PED_CLI_UF.Text = address.State.Trim();
                            else
                                PED_CLI_UF.Enabled = true;

                            if (!string.IsNullOrEmpty(address.City.Trim()))
                                PED_CLI_CIDADE.Text = address.City;
                            else
                                PED_CLI_CIDADE.Enabled = true;
                        }
                        else
                        {
                            PED_CLI_BAIRRO.Enabled = true;
                            PED_CLI_ENDERECO.Enabled = true;
                            PED_CLI_ENDERECO_COMPLEMENTO.Enabled = true;
                            PED_CLI_ENDERECO_NUMERO.Enabled = true;
                            PED_CLI_UF.Enabled = true;
                            PED_CLI_CIDADE.Enabled = true;
                        }
                    }
                }
                else return;
                if (PED_REP_FABRICANTE != null)
                    PED_REP_FABRICANTE.DataBind();
                if (string.IsNullOrEmpty(PED_DATA.Text))
                    PED_DATA.Text = DateTime.Now.ToString("dd/MM/yyyy");

                passou = true;
            }
        }

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtEmail.Text))
            {
                lblErroEmail.Text = "Email 1 vazio!";
                lblErroEmail.Visible = true;
            }
            else
            {
                if (Validacao.Valida.IsMail(txtEmail.Text))
                    lblErroEmail.Visible = false;
                else
                {
                    lblErroEmail.Text = "Email 1 inválido!";
                    lblErroEmail.Visible = true;
                }
            }
        }

        protected void txtEmail2_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtEmail2.Text))
            {
                if (Validacao.Valida.IsMail(txtEmail2.Text))
                    lblErroEmail.Visible = false;
                else
                {
                    lblErroEmail.Text = "Email 2 inválido!";
                    lblErroEmail.Visible = true;
                }
            }
        }
        #endregion

        private bool CheckValues()
        {
            bool retorno = true;
            if (string.IsNullOrEmpty(PED_CLI_RAZAO.Text.Trim()))
            {
                lblErroRazao.Text = "Campo obrigatório**";
                lblErroRazao.Visible = true;
                retorno = false;
            }
            else lblErroRazao.Visible = false;

            if (string.IsNullOrEmpty(PED_CLI_CNPJ.Text.Trim()) && string.IsNullOrEmpty(PED_CLI_CPF.Text.Trim()))
            {
                PED_CLI_CNPJ_ERRO.Text = "O CNPJ ou o CPF devem estar preenchidos!";
                PED_CLI_CNPJ_ERRO.Visible = true;
                retorno = false;
            }

            if (string.IsNullOrEmpty(PED_CLI_CEP.Text.Trim()))
            {
                lblErroCEP.Text = "Campo obrigatório**";
                lblErroCEP.Visible = true;
                retorno = false;
            }
            else lblErroCEP.Visible = false;

            if (string.IsNullOrEmpty(PED_CLI_UF.Text.Trim()))
            {
                lblErroUF.Text = "Campo obrigatório**";
                lblErroUF.Visible = true;
                retorno = false;
            }
            else lblErroUF.Visible = false;

            if (string.IsNullOrEmpty(PED_CLI_CIDADE.Text.Trim()))
            {
                lblErroCIDADE.Text = "Campo obrigatório**";
                lblErroCIDADE.Visible = true;
                retorno = false;
            }
            else lblErroCIDADE.Visible = false;

            if (string.IsNullOrEmpty(PED_CLI_BAIRRO.Text.Trim()))
            {
                lblErroBAIRRO.Text = "Campo obrigatório**";
                lblErroBAIRRO.Visible = true;
                retorno = false;
            }
            else lblErroBAIRRO.Visible = false;

            if (string.IsNullOrEmpty(PED_CLI_ENDERECO.Text.Trim()))
            {
                lblErroEndereco.Text = "Campo obrigatório**";
                lblErroEndereco.Visible = true;
                retorno = false;
            }
            else lblErroEndereco.Visible = false;

            if (string.IsNullOrEmpty(PED_CLI_ENDERECO_NUMERO.Text.Trim()))
            {
                lblErroNumero.Text = "Campo obrigatório**";
                lblErroNumero.Visible = true;
                retorno = false;
            }
            else lblErroNumero.Visible = false;

            if (string.IsNullOrEmpty(PED_CLI_CONTATO.Text.Trim()))
            {
                lblErroResponsavel.Text = "Campo obrigatório**";
                lblErroResponsavel.Visible = true;
                retorno = false;
            }
            else lblErroResponsavel.Visible = false;

            if ((string.IsNullOrEmpty(PED_CLI_TELEFONE_DDD.Text.Trim()) && !string.IsNullOrEmpty(PED_CLI_TELEFONE.Text.Trim())) ||
                (string.IsNullOrEmpty(PED_CLI_TELEFONE.Text.Trim()) && !string.IsNullOrEmpty(PED_CLI_TELEFONE_DDD.Text.Trim())))
            {
                lblErroTelefone.Text = "Campo obrigatório para o telefone!";
                lblErroTelefone.Visible = true;
                retorno = false;
            }
            else lblErroTelefone.Visible = false;

            if ((string.IsNullOrEmpty(PED_CLI_TELEFONE2_DDD.Text.Trim()) && !string.IsNullOrEmpty(PED_CLI_TELEFONE2.Text.Trim())) ||
                (string.IsNullOrEmpty(PED_CLI_TELEFONE2.Text.Trim()) && !string.IsNullOrEmpty(PED_CLI_TELEFONE2_DDD.Text.Trim())))
            {
                lblErroTelefone2.Text = "Campo obrigatório para o telefone!";
                lblErroTelefone2.Visible = true;
                retorno = false;
            }
            else lblErroTelefone2.Visible = false;

            if ((string.IsNullOrEmpty(PED_CLI_CELULAR_DDD.Text.Trim()) && !string.IsNullOrEmpty(PED_CLI_CELULAR.Text.Trim())) ||
                (string.IsNullOrEmpty(PED_CLI_CELULAR.Text.Trim()) && !string.IsNullOrEmpty(PED_CLI_CELULAR_DDD.Text.Trim())))
            {
                lblErroCelular.Text = "Campo obrigatório para o celular!";
                lblErroCelular.Visible = true;
                retorno = false;
            }
            else lblErroCelular.Visible = false;

            if (string.IsNullOrEmpty(txtEmail.Text.Trim()))
            {
                lblErroEmail.Text = "Campo obrigatório**";
                lblErroEmail.Visible = true;
                retorno = false;
            }
            else lblErroEmail.Visible = false;

            if (PED_REP_FABRICANTE.SelectedItem == null)
            {
                lblErroFabricante.Text = "Campo obrigatório**";
                lblErroFabricante.Visible = true;
                retorno = false;
            }
            else lblErroFabricante.Visible = false;

            return retorno;
        }
    }
}