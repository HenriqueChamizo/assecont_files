using System;
using System.Threading;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Asseponto.WebControls
{
    public partial class PageTitle : System.Web.UI.UserControl
    {
        /*
       * Node.Description precedido por '_' trocará de posição Title pelo SubTitle
       * atributo no SiteMap, hidetitle = "1", PageTitle não será exibido
       */

        string _ImageFolder = "";
        string _PageTitleTitle = "";
        string _SubTitle = "";

        #region Properties
        public string Title
        {
            get
            {
                return _PageTitleTitle;
            }
            set
            {
                _PageTitleTitle = value;
            }
        }

        public string SubTitle
        {
            get
            {
                return _SubTitle;
            }
            set
            {
                _SubTitle = value;
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

        public System.Drawing.Color ImageColor
        {
            set
            {
                PageTitleImage.BackColor = value;
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
                    //PageTitleWrapper.Parent.Visible = false;
                    //PageTitleWrapper.Parent.Parent.Visible = false;
                }
                else
                {
                    if (!String.IsNullOrEmpty(Node["image"]))
                    {
                        ImageUrl = Node["image"];

                        if (ImageUrl.IndexOf('/') == -1 && ImageFolder != "")
                            ImageUrl = Wr.Classes.Files.IncludeTrailingBackslashUrl(ImageFolder) + ImageUrl;

                        if (!String.IsNullOrEmpty(Node["imagecolor"]))
                        {
                            ImageColor = System.Drawing.ColorTranslator.FromHtml(Node["imagecolor"]);
                            //ImageColor = Node["imagecolor"];
                        }
                    }
                    else
                        imagewrapper.Visible = false;

                    Page.Title = Node.Title;
                    Title = Node.Title;

                    Label PageTitleTitleLabel = new Label();
                    HyperLink PageTitleTitleLink = new HyperLink();

                    if (String.IsNullOrEmpty(Node["TitleLink"]))
                    {
                        PageTitleTitleLabel.CssClass = "descricao";
                        PageTitleTitleLabel.Text = Node.Title;
                        PageTitleTexts.Controls.Add(PageTitleTitleLabel);
                    }
                    else
                    {
                        PageTitleTitleLink.Text = Node.Title;
                        PageTitleTitleLink.CssClass = "descricao";
                        PageTitleTitleLink.NavigateUrl = Node["TitleLink"];
                        PageTitleTexts.Controls.Add(PageTitleTitleLink);
                    }



                    if (Node.Description != "")
                    {
                        if (Node.Description[0] == '_')
                        {
                            if (String.IsNullOrEmpty(Node["TitleLink"]))
                            {
                                PageTitleTitleLabel.Text = Node.Description.Substring(1);
                            }
                            else
                            {
                                PageTitleTitleLink.Text = Node.Description.Substring(1);
                            }
                        }
                    }

                    //SubTitulo

                    if (Node.Description != "")
                    {
                        Label PageTitleSubTitle = new Label();
                        PageTitleSubTitle.CssClass = "subdescricao";

                        if (Node.Description[0] == '_')
                        {
                            PageTitleSubTitle.Text = Node.Title;

                            if (String.IsNullOrEmpty(Node["TitleLink"]))
                            {
                                PageTitleTitleLabel.Text = Node.Description.Substring(1);
                            }
                            else
                            {
                                PageTitleTitleLink.Text = Node.Description.Substring(1);
                            }
                        }
                        else
                        {
                            PageTitleSubTitle.Text = Node.Description;
                        }

                        Page.Title = Title + " - " + SubTitle;
                        PageTitleTexts.Controls.Add(PageTitleSubTitle);
                    }

                    if (Node["showtitleseparator"] != null && Convert.ToBoolean(Node["showtitleseparator"]))
                    {
                        ((HtmlGenericControl)PageTitleWrapper.Parent.Parent).Attributes.Add("style", "border-bottom-style: solid;border-width: 5px;border-color: #004C70;");
                    }
                }
            }
            else
            {
                PageTitleWrapper.Visible = false;
                PageTitleWrapper.Parent.Visible = false;
            }
        }

        protected void lbCopy_Click(object sender, EventArgs e)
        {
            //SiteMapNode Node = SiteMap.CurrentNode;
            //SwapClipboardHtmlText(Node.Title);
            //SiteMapNode Node = SiteMap.CurrentNode;

            //Thread thread = new Thread(() => System.Windows.Forms.Clipboard.SetText(Node.Title));
            //thread.SetApartmentState(ApartmentState.STA); 
            //thread.Start();
            //thread.Join();

            Response.Redirect(Request.RawUrl);
        }
    }
}