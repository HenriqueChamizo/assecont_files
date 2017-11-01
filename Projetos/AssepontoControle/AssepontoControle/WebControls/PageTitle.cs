using System;
using System.Web;

namespace Wr.WebControls
{
    public partial class PageTitle : System.Web.UI.UserControl
    {
        /*
         * Node.Description precedido por '_' trocará de posição Title pelo SubTitle
         * atributo no SiteMap, hidetitle = "1", PageTitle não será exibido
         */

        string _ImageFolder = "";

        #region Properties
        public string Title
        {
            get
            {
                return PageTitleTitle.Text;
            }
            set
            {
                PageTitleTitle.Text = value;
            }
        }

        public string SubTitle
        {
            get
            {
                return PageTitleSubTitle.Text;
            }
            set
            {
                PageTitleSubTitle.Text = value;
            }
        }

        public string ImageUrl
        {
            get
            {
                return PageTitleImage.ImageUrl;
            }
            set
            {
                PageTitleImage.ImageUrl = value;
            }
        }

        public string ImageFolder
        {
            get
            {
                return _ImageFolder;
            }
            set
            {
                _ImageFolder = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            SiteMapNode Node = SiteMap.CurrentNode;

            if (Node != null)
            {
                if (Node["hidetitle"] == "1")
                {
                    PageTitleWrapper.Visible = false;
                }
                else
                {
                    if (!String.IsNullOrEmpty(Node["image"]))
                    {
                        ImageUrl = Node["image"];

                        if (ImageFolder != "")
                            ImageUrl = Wr.Classes.Files.IncludeTrailingBackslashUrl(ImageFolder) + ImageUrl;
                    }
                    else
                        PageTitleImage.Visible = false;

                    Page.Title = Node.Title;
                    Title = Node.Title;

                    if (Node.Description != "")
                    {
                        if (Node.Description[0] == '_')
                        {
                            SubTitle = Node.Title;
                            Title = Node.Description.Substring(1);
                        }
                        else
                        {
                            SubTitle = Node.Description;
                        }

                        Page.Title = Title + " - " + SubTitle;
                    }
                }
            }
            else
            {
                PageTitleWrapper.Visible = false;                
            }
        }
    }
}