using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Wr.Classes;

namespace AssecontNovo.Classes.Emails
{
    public class EmailApp : Email
    {
        public EmailApp(string EmailFrom, Label Mensagem, string TemplateFile)
        : base(EmailFrom, "assecont", "BwpGCkuA7951", "", Mensagem, TemplateFile)
        //: base(EmailFrom, "assecont", "admasseCONT01", "", Mensagem, TemplateFile)
        {
        }
        public EmailApp(string EmailFrom, string Subject, Label Mensagem, string TemplateFile)
            : base(EmailFrom, "assecont", "BwpGCkuA7951", Subject, Mensagem, TemplateFile)
        {
        }
    }
}