using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.Suporte.Clientes
{
    public partial class Faturamento : System.Web.UI.Page
    {
        private int idAssefin;
        private BDAppAssefin bdAssefin;
        private UserApp user;
        protected void Page_Load(object sender, EventArgs e)
        {
            bdAssefin = new BDAppAssefin();
            user = new UserApp();
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            idAssefin = bdAssefin.getCadastroIndice((new BDApp()).getClienteCnpjCpf(ind));
        }

        protected void SqlDataFaturamento_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@INDICE_CADASTRO"].Value = idAssefin;
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = bdAssefin.Conn.ConnectionString;
        }

        protected void CustomValidatorFile_ServerValidate(object source, ServerValidateEventArgs args)
        {
            CustomValidator cv = source as CustomValidator;
            GridDataItem item = (GridDataItem)cv.NamingContainer;

            string fileName = (item.FindControl("File") as FileUpload).PostedFile.FileName;
            string fileExtension = System.IO.Path.GetExtension(fileName).Replace(".", string.Empty).ToLower();

            cv.IsValid = (fileExtension != "pdf" || fileExtension != "pdf") ? false : true;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton btnAnexar = sender as LinkButton;
            GridDataItem item = (GridDataItem)btnAnexar.NamingContainer;
            int indice = Convert.ToInt32((item.FindControl("lbIndiceContrato") as Label).Text);
            FileUpload file = item.FindControl("file") as FileUpload;

            if (file.HasFile)
            {
                string fileName = file.PostedFile.FileName;

                byte[] arquivo = new byte[file.PostedFile.InputStream.Length + 1];
                file.PostedFile.InputStream.Read(arquivo, 0, arquivo.Length);

                bdAssefin.setContratoFaturamento(arquivo, fileName, indice, user.UserName());
                RadGrid1.DataBind();
            }           
        }

        protected void SqlDataContratos_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void DataListContratos_DeleteCommand(object source, DataListCommandEventArgs e)
        {
            DataList DataListContratos = source as DataList;
            GridDataItem item = (GridDataItem)DataListContratos.NamingContainer;
            int id = (int)DataListContratos.DataKeys[e.Item.ItemIndex];
            (item.FindControl("SqlDataContratos") as SqlDataSource).DeleteParameters["FATUCONARQ_IND"].DefaultValue = id.ToString();
            (item.FindControl("SqlDataContratos") as SqlDataSource).Delete();
        }
    }
}