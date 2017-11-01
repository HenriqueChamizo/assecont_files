using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using AssecontNovo.Classes;

namespace AssecontNovo.Informativos
{
    public partial class criarInformativo : System.Web.UI.Page
    {
        private string Titulo;
        private string Texto;
        private string Numero;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RadEditor1.EditModes = RadEditor1.EditModes ^ Telerik.Web.UI.EditModes.Preview;
                RadEditor1.ImageManager.ViewMode = Telerik.Web.UI.Editor.DialogControls.ImageManagerViewMode.Grid;
            } 
        }

        protected void lkPublicar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    Texto = RadEditor1.Content; //txtHtml.Text.Replace("\n", "<br />").Replace("\r", "");
                    Titulo = txtTitulo.Text;

                    BDAppAssecont bd = new BDAppAssecont();
                    bd.openConnection();

                    saveInformativo(bd);
                    bd.closeConnection();

                    Response.RedirectPermanent("~/Informativos/listarInformativos.aspx");

                }
                catch (Exception ex)
                {
                    HttpContext.Current.Response.Write(ex.Message);
                    HttpContext.Current.Response.Flush();
                }
            }
        }

        public void saveInformativo(BDAppAssecont bd)
        {
            SqlCommand cmd = new SqlCommand("informativo_criar", bd.Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();

            cmd.Parameters.AddWithValue("@P_TITULO", Titulo);
            cmd.Parameters.AddWithValue("@P_TEXTO", Texto);

            SqlParameter parameter_result = cmd.Parameters.Add("@NUMERO", SqlDbType.Int);
            parameter_result.Direction = ParameterDirection.ReturnValue;

            cmd.ExecuteNonQuery();

            Numero = string.Empty;

            if (parameter_result.Value != null)
                Numero = parameter_result.Value.ToString();
            else
                throw new Exception("Erro ao retornar o número do Informativo !");
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("http://www.assecont.com.br/informativos/listarInformativos.aspx");
        }


        /*#region CustomValidartor
        protected void CustomValidatorCapa_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (FileUploadCapa.HasFile)
            {
              args.IsValid = verificarFormato(fileExtensionName(FileUploadCapa.PostedFile.FileName));
            }
        }

        protected void CustomValidatorImagem_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (FileUploadImagem.HasFile)
            {
                 args.IsValid = verificarFormato(fileExtensionName(FileUploadImagem.PostedFile.FileName));
            }
        }
        #endregion

        #region fileExtension
        bool verificarFormato(string FileExtension)
        {
            bool flag = false;

            if (FileExtension == "jpeg" || FileExtension == "jpg" || FileExtension == "png")
                flag = true;

            return flag;
        }

        string fileExtensionName(string FileName)
        {
            return System.IO.Path.GetExtension(FileName).Replace(".", string.Empty).ToLower();
        }

        string fileTypeName(string FileExtension)
        {
            string fileType = null;

            switch (FileExtension)
            {
                case "jpg":
                case "jpeg":
                    fileType = "image/jpeg";
                    break;
                case "png":
                    fileType = "image/png";
                    break;
            }

            return fileType;
        }
        #endregion */

        //byte[] BytesCapa = new byte[FileUploadCapa.PostedFile.InputStream.Length + 1];
        //FileUploadCapa.PostedFile.InputStream.Read(BytesCapa, 0, BytesCapa.Length);

        //byte[] BytesImg = new byte[FileUploadImagem.PostedFile.InputStream.Length + 1];
        //FileUploadImagem.PostedFile.InputStream.Read(BytesImg, 0, BytesImg.Length);

        //string fileExtensionCapa = fileExtensionName(FileUploadCapa.PostedFile.FileName);
        //string fileExtensionImg = fileExtensionName(FileUploadImagem.PostedFile.FileName);

        //string fileTypeCapa = fileTypeName(fileExtensionCapa);
        //string fileTypeImg = fileTypeName(fileExtensionImg);

        //cmd.Parameters.AddWithValue("@capa", /*BytesCapa*/ DBNull.Value);
        //cmd.Parameters.AddWithValue("@img", /*BytesImg*/ DBNull.Value);

        // if (fileTypeCapa == null)
        //cmd.Parameters.AddWithValue("@tipoCapa", DBNull.Value);
        // else
        //  cmd.Parameters.AddWithValue("@tipoCapa", fileTypeCapa); 

        // if(fileTypeImg == null)
        // cmd.Parameters.AddWithValue("@tipoImg", DBNull.Value);
        // else
        // cmd.Parameters.AddWithValue("@tipoImg", fileTypeImg);  


        //FileUploadImagem.PostedFile.InputStream.Read(BytesImg, 0, texto.Length);

    }
}