using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using AssecontNovo.Classes.Emails.Legalizacao;
using AssecontNovo.Classes.Sms;

namespace AssecontNovo.Legalizacao
{
    public partial class IntranetProcesso : System.Web.UI.Page
    {
        int status;
        int pedido;
        protected void Page_Load(object sender, EventArgs e)
        {
            status = Convert.ToInt32(Request.QueryString["s"]);
            pedido = Convert.ToInt32(Request.QueryString["p"]);
        }

        protected void lkEnviar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    FileUpload FUArquivo = ((FileUpload)FormViewCadastro.FindControl("FUArquivo"));
                    gravarBanco(FUArquivo);
                }
                catch (Exception ex)
                {
                    string a = ex.Message;
                    Response.RedirectPermanent("~/Avisos/ErroTela.aspx");
                }

                Response.Redirect("~/Legalizacao/IntranetPedido.aspx?p=" + pedido);
            }
        }

        void gravarBanco(FileUpload FUArquivo)
        {
            BDAppAssecont bd = new BDAppAssecont();
            bd.executeCommand("UPDATE LegalizacaoArquivos SET LEGARQ_STATUS = 1 WHERE LEQARQ_PEDIDO_ETAPA = " + status);

            byte[] BytesCurriculum = new byte[FUArquivo.PostedFile.InputStream.Length + 1];
            FUArquivo.PostedFile.InputStream.Read(BytesCurriculum, 0, BytesCurriculum.Length);
            string fileExtension = System.IO.Path.GetExtension(FUArquivo.PostedFile.FileName).Replace(".", string.Empty).ToLower();

            string s = "INSERT INTO LegalizacaoArquivos (LEGARQ_ARQUIVO, LEGARQ_EXTENSAO, LEQARQ_PEDIDO_ETAPA, LEGARQ_NOME ) " +
                "VALUES (@ARQUIVO, @EXTENSAO, @PEDIDO_ETAPA, @NOME )";
            
            bd.openConnection();
            SqlCommand cmd = new SqlCommand(s, bd.Conn);
            cmd.Parameters.Add("@ARQUIVO", SqlDbType.Binary).Value = BytesCurriculum;
            cmd.Parameters.Add("@EXTENSAO", SqlDbType.NChar).Value = fileExtension;
            cmd.Parameters.Add("@PEDIDO_ETAPA", SqlDbType.Int).Value = status;
            cmd.Parameters.Add("@NOME", SqlDbType.NChar).Value = FUArquivo.FileName;

            cmd.ExecuteNonQuery();
        }


        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = (new BDAppAssecont()).Conn.ConnectionString;
        }

        protected void CustomValidatorArquivo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string fileName = ((FileUpload)FormViewCadastro.FindControl("FUArquivo")).PostedFile.FileName;
            string fileExtension = System.IO.Path.GetExtension(fileName).Replace(".", string.Empty).ToLower();

            args.IsValid = fileExtension != "pdf" && fileExtension != "doc" && fileExtension != "docx" ? false : true;
        }

        protected void btnConcluido_Click(object sender, EventArgs e)
        {
            (new SmsLegalizacao(status)).SendSms();
            (new EmailLegalizacaoProcedimento(status, Server.MapPath("") + "\\..\\Classes\\Emails\\Legalizacao\\EmailLegalizacao.htm")).Send();

            BDAppAssecont bd = new BDAppAssecont();
            bd.executeCommand(string.Format("UPDATE LegalizacaoPedidosEtapas SET LPETA_CONCLUIDO_EM = GETDATE(), LPETA_EMAIL_ENVIADO_EM = GETDATE(), LPETA_STATUS = {1} WHERE LPETA_IND = {0} ", status, (int)Types.LegalizacaoEtapaStatus.Finalizado));

            FormViewCadastro.DataBind();
        }
    }
}