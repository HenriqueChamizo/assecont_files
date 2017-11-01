using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using AssecontNovo.Classes.Emails;
using Telerik.Web.UI;

namespace AssecontNovo.Curriculum
{
    public partial class EnviarCurriculo : System.Web.UI.Page
    {
        private string nome;
        private string telefone;
        private string email;
        private string objetivo;
        private Decimal salario;
        private int sexo;
        private string bairro;
        private string zona;
        private string celular;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lkEnviar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    nome = txtNome.Text;
                    telefone = txtTelefone.Text;
                    email = txtEmail.Text;
                    objetivo = txtObjetivo.Text;
                    salario = Convert.ToDecimal(txtSalario.Text);
                    sexo = Convert.ToInt32(RblSexo.SelectedValue);
                    bairro = txtBairro.Text;
                    zona = RadComboxZona.SelectedItem.Text;
                    celular = txtCelular.Text;

                    gravarBanco();
                    enviarCurriculo();
                }
                catch (Exception ex)
                {
                    string a = ex.Message;
                    Response.RedirectPermanent("~/Avisos/ErroTela.aspx");
                }

                Response.Redirect("http://www.assecont.com.br/Curriculum/operacaoRealizadaSucesso.aspx");
            }
        }

        void gravarBanco()
        {
            byte[] BytesCurriculum = new byte[FUCurriculum.PostedFile.InputStream.Length + 1];
            FUCurriculum.PostedFile.InputStream.Read(BytesCurriculum, 0, BytesCurriculum.Length);

            string s = "INSERT INTO Curriculum (CUR_NOME, CUR_EMAIL, CUR_TELEFONE, CUR_OBJETIVO, CUR_DISPONIVEL, CUR_ARQUIVO, CUR_EXTENSAO, CUR_SEXO, CUR_BAIRRO, CUR_ZONA, CUR_CELULAR, CUR_SALARIO ) " +
                "VALUES (@NOME, @EMAIL, @TELEFONE, @OBJETIVO, GETDATE(), @ARQUIVO, @EXTENSAO, @SEXO, @BAIRRO, @ZONA, @CELULAR, @SALARIO )";

            BDAppAssecont bd = new BDAppAssecont();
            bd.openConnection();

            SqlCommand cmd = new SqlCommand(s, bd.Conn);
            cmd.Parameters.Add("@NOME", SqlDbType.NChar).Value = nome;
            cmd.Parameters.Add("@EMAIL", SqlDbType.NChar).Value = email;
            cmd.Parameters.Add("@TELEFONE", SqlDbType.NChar).Value = telefone;
            cmd.Parameters.Add("@OBJETIVO", SqlDbType.NChar).Value = objetivo;

            cmd.Parameters.Add("@ARQUIVO", SqlDbType.Binary).Value = BytesCurriculum;
            cmd.Parameters.Add("@EXTENSAO", SqlDbType.NChar).Value = "pdf";

            cmd.Parameters.Add("@SEXO", SqlDbType.Int).Value = sexo;
            cmd.Parameters.Add("@BAIRRO", SqlDbType.NChar).Value = bairro;
            cmd.Parameters.Add("@ZONA", SqlDbType.NChar).Value = zona;
            cmd.Parameters.Add("@CELULAR", SqlDbType.NChar).Value = celular;
            cmd.Parameters.Add("@SALARIO", SqlDbType.Decimal).Value = salario;

            cmd.ExecuteNonQuery();
        }

        void enviarCurriculo()
        {
            EmailCurriculo emailCurriculo = new EmailCurriculo("notificacao@assecont.com.br", null, Server.MapPath("") + "..\\Classes\\Emails\\Curriculum\\EmailCurriculum.htm");
            emailCurriculo.Send(nome, telefone, email, objetivo);
        }

        protected void CustomValidatorCurriculo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string fileName = FUCurriculum.PostedFile.FileName;

            string fileExtension = System.IO.Path.GetExtension(fileName).Replace(".", string.Empty).ToLower();

            args.IsValid = fileExtension != "pdf" ? false : true;
        }

        protected void RadComboxZona_Load(object sender, EventArgs e)
        {
            Types.zonas[] listZonas = (Types.zonas[])Enum.GetValues(typeof(Types.zonas));
            foreach (Types.zonas zona in listZonas)
                RadComboxZona.Items.Add(new RadComboBoxItem(zona.ToString(), ((int)zona).ToString()));
        }
    }
}