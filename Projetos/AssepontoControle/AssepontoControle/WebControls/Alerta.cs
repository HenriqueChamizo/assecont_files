using System;

namespace Wr.WebControls
{
    public partial class Alerta : System.Web.UI.UserControl
    {
        #region Properties
        string _ImageUrl = "";
        string _Text = "";

        public string ImageUrl
        {
            get
            {
                return _ImageUrl;
            }
            set
            {
                _ImageUrl = value;
            }
        }

        public string Text
        {
            get
            {
                return _Text;
            }
            set
            {
                _Text = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            Imagem.Alt = Text;
            Imagem.Src = ImageUrl;
            Mensagem.Text = Text;
        }
    }
}