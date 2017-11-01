using System;
using System.Web.UI.WebControls;
using System.Configuration;
using Asseponto.Classes;
using Telerik.Web.UI;
using Wr.Classes;

namespace Asseponto.Revenda.Pedidos
{
    public partial class PedidoOld : System.Web.UI.Page
    {
        int PedidoIndice = 0;
        int RepFabricante = 0;
        string dataPedido = "";
        bool passou = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            int PedidoIndice = Convert.ToInt32(Request.QueryString["ind"]);
            if (Convert.ToInt32(Request.QueryString["ind"]) > 0)
                FormView1.DefaultMode = FormViewMode.Edit;
            else
                FormView1.DefaultMode = FormViewMode.Insert;
        }

        protected void Enviar_Email_Pedido(BDApp bd)
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = ConfigurationManager.AppSettings["EMAILRECIPIENT"];
            string EmailCC = ConfigurationManager.AppSettings["EMAILRECIPIENTCC"];
            string EmailCC2 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC2"];
            string EmailCC3 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC3"];
            string EmailCC4 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC4"];
            string EmailCC5 = ConfigurationManager.AppSettings["EMAILRECIPIENTCC5"];

            EmailPedido email = new EmailPedido(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedido.htm");
            email.Send(EmailTo, EmailCC, EmailCC2, EmailCC3, EmailCC4, EmailCC5, PedidoIndice);
        }

        protected void Enviar_Email_Pedido_Retorno(BDApp bd)
        {
            string EmailFrom = ConfigurationManager.AppSettings["EMAILSENDER"];
            string EmailTo = bd.getRevendaEmailFromPedido(PedidoIndice);
            string EmailCC = bd.getRevendaEmailFromPedido2(PedidoIndice);

            EmailPedidoRetorno email = new EmailPedidoRetorno(EmailFrom, null, Server.MapPath("") + "\\..\\..\\Arquivos\\EmailPedidoRetorno.htm");
            email.Send(EmailTo, EmailCC, PedidoIndice);
        }

        protected void sqlPedidosRevendas_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            BDApp bd = new BDApp();

            if (Page.IsValid)
            {
                PedidoIndice = bd.getIdentity(e.Command);

                if (PedidoIndice > 0)
                {
                    bd.openConnection();

                    if (((FileUpload)FormView1.FindControl("FilePlanilha")).HasFile)
                    {
                        Model.Pedido ped = new Model.Pedido(PedidoIndice);
                        ped.setPlanilha((FileUpload)FormView1.FindControl("FilePlanilha"));
                        ped.insertPlanilhaRevenda(bd);
                    }

                    Enviar_Email_Pedido(bd);
                    Enviar_Email_Pedido_Retorno(bd);
                    bd.closeConnection();

                    Response.Redirect("~/Revenda/Pedidos/PedidoEnviado.aspx");
                }
            }
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (FormView1.CurrentMode == FormViewMode.Insert)
            {
                UserApp user = new UserApp();
                FormUtils formutils = new FormUtils();
                formutils.InitializePageControls();
                HiddenField hiddenRevenda = (HiddenField)FormView1.FindControl("hiddenRevenda");
                hiddenRevenda.Value = user.Revenda.ToString();

                HiddenField hiddenStatus = (HiddenField)FormView1.FindControl("hiddenStatus");
                hiddenStatus.Value = "1";

                TextBox PED_DATA = (TextBox)FormView1.FindControl("PED_DATA");
                PED_DATA.Text = DateTime.Now.ToString("dd/MM/yyyy");
            }
            else
            {
                int PedidoIndice = Convert.ToInt32(Request.QueryString["ind"]);
                int Status = (new BDApp()).getFieldValueInteger(String.Format("SELECT PED_STATUS FROM AssepontoPedidosRevendas WHERE PED_IND = {0}", PedidoIndice));

                if (Status == Convert.ToInt32(Types.PedidoStatus.Fechado))
                {
                    sitecorpoboxbottom.Visible = false;
                }
            }

            if (((FormView)sender).CurrentMode != FormViewMode.ReadOnly)
            {
                Validadores validadores = new Validadores((FormView)sender);
            }
        }

        protected void sqlPedidosRevendas_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            BDApp bd = new BDApp();

            PedidoIndice = Convert.ToInt32(Request.QueryString["ind"]);

            Enviar_Email_Pedido(bd);
            Enviar_Email_Pedido_Retorno(bd);

            Response.Redirect("~/Revenda/Pedidos/PedidoEnviado.aspx");
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
            RadMaskedTextBox txtCNPJ = (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ");
            RadMaskedTextBox txtCPF = (RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF");

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
            string cnpj = ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ")).Text;
            string cpf = ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF")).Text;

            /*Validar se já existe o CNPJ ou CPF na tabela AssepontoClientes*/
            args.IsValid = (new BDApp()).getFieldValueInteger(string.Format("SELECT CAD_IND FROM AssepontoClientes WHERE CAD_ASSEPONTO4 = 1 AND " +
                                "(dbo.fn_asseponto_trim_cnpj(CAD_CNPJ) = dbo.fn_asseponto_trim_cnpj('{0}') OR " +
                                "dbo.fn_asseponto_trim_cnpj(CAD_CPF) = dbo.fn_asseponto_trim_cnpj('{1}'))", cnpj, cpf)) == 0;          
        }

        protected void CustomValidatorPlanilha_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string fileName = ((FileUpload)FormView1.FindControl("FilePlanilha")).PostedFile.FileName;
            string fileExtension = System.IO.Path.GetExtension(fileName).Replace(".", string.Empty).ToLower();

            args.IsValid = (fileExtension == "xls" || fileExtension == "xlsx") ? true : false;

        }

        protected void CV_Pedido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string cnpj = ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CNPJ")).Text;
            string cpf = ((RadMaskedTextBox)FormView1.FindControl("PED_CLI_CPF")).Text;

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
            if (FormView1.CurrentMode == FormViewMode.Insert)
                FormView1.InsertItem(((LinkButton)sender).CausesValidation);
            else
                if (FormView1.CurrentMode == FormViewMode.Edit)
                    FormView1.UpdateItem(((LinkButton)sender).CausesValidation);
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
                                TextBox txt = FormView1.FindControl("PED_CLI_BAIRRO") as TextBox;
                                txt.Text = address.District;
                            }
                            else
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_BAIRRO") as TextBox;
                                txt.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.Street.Trim()))
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO") as TextBox;
                                txt.Text = address.Street;
                            }
                            else
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO") as TextBox;
                                txt.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.Complement.Trim()))
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_COMPLEMENTO") as TextBox;
                                txt.Text = address.Complement;
                            }
                            else
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_COMPLEMENTO") as TextBox;
                                txt.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.StreetNumber))
                            {
                                RadMaskedTextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_NUMERO") as RadMaskedTextBox;
                                txt.Text = address.StreetNumber;
                            }
                            else
                            {
                                RadMaskedTextBox txt = FormView1.FindControl("PED_CLI_ENDERECO_NUMERO") as RadMaskedTextBox;
                                txt.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.State.Trim()))
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_UF") as TextBox;
                                txt.Text = address.State.Trim();
                                //HiddenField hidden = FormView1.FindControl("PED_CLI_UF") as HiddenField;
                                //BDApp bd = new BDApp();
                                //string query = "SELECT EST_IND FROM [Estados] WHERE UPPER(EST_SIGLA) = '" + address.State.ToUpper().Trim() + "'";
                                //hidden.Value = Convert.ToString(bd.getFieldValueInteger(query));
                            }
                            else
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_UF") as TextBox;
                                txt.Enabled = true;
                            }

                            if (!string.IsNullOrEmpty(address.City.Trim()))
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_CIDADE") as TextBox;
                                txt.Text = address.City;
                            }
                            else
                            {
                                TextBox txt = FormView1.FindControl("PED_CLI_CIDADE") as TextBox;
                                txt.Enabled = true;
                            }
                        }
                        else
                        {
                            TextBox PED_CLI_BAIRRO = FormView1.FindControl("PED_CLI_BAIRRO") as TextBox;
                            PED_CLI_BAIRRO.Enabled = true;
                            TextBox PED_CLI_ENDERECO = FormView1.FindControl("PED_CLI_ENDERECO") as TextBox;
                            PED_CLI_ENDERECO.Enabled = true;
                            TextBox PED_CLI_ENDERECO_COMPLEMENTO = FormView1.FindControl("PED_CLI_ENDERECO_COMPLEMENTO") as TextBox;
                            PED_CLI_ENDERECO_COMPLEMENTO.Enabled = true;
                            RadMaskedTextBox PED_CLI_ENDERECO_NUMERO = FormView1.FindControl("PED_CLI_ENDERECO_NUMERO") as RadMaskedTextBox;
                            PED_CLI_ENDERECO_NUMERO.Enabled = true;
                            TextBox PED_CLI_UF = FormView1.FindControl("PED_CLI_UF") as TextBox;
                            PED_CLI_UF.Enabled = true;
                            TextBox PED_CLI_CIDADE = FormView1.FindControl("PED_CLI_CIDADE") as TextBox;
                            PED_CLI_CIDADE.Enabled = true;
                        }
                    }
                }
                else return;
                RadComboBox rad = FormView1.FindControl("PED_REP_FABRICANTE") as RadComboBox;
                if (rad != null)
                    rad.DataBind();
                TextBox txtDate = FormView1.FindControl("PED_DATA") as TextBox;
                if (txtDate != null)
                    if (string.IsNullOrEmpty(dataPedido))
                        if (string.IsNullOrEmpty(txtDate.Text))
                            txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                        else
                        if (string.IsNullOrEmpty(txtDate.Text))
                            txtDate.Text = dataPedido;
                passou = true;
            }
        }
    }
}