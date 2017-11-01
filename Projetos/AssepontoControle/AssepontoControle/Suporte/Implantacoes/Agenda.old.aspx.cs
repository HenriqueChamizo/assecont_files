using System;
using System.Configuration;
using Asseponto.Classes;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Asseponto.Suporte.Implantacoes
{
    public partial class Agenda : System.Web.UI.Page
    {
        public BDApp bd;
        public int data;

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            data = Convert.ToInt32(Request.QueryString["data"]);
            if (!IsPostBack)
                LoadPage();
            //LoadDropDown();
        }

        private void LoadPage()
        {
            #region teste switch
            //string teste;
            //switch (Request.QueryString["data"])
            //{
            //    case "0":
            //        switch (Request.QueryString["finalizado"])
            //        {
            //            case "0":
            //                switch (Request.QueryString["tipo"])
            //                {
            //                    case "0":
            //                        teste = "teste 0.0";
            //                        break;
            //                    case "1":
            //                        teste = "teste 0.1";
            //                        break;
            //                    case "2":
            //                        teste = "teste 0.2";
            //                        break;
            //                }
            //                break;
            //            case "1":
            //                switch (Request.QueryString["tipo"])
            //                {
            //                    case "0":
            //                        teste = "teste 1.0";
            //                        break;
            //                    case "1":
            //                        teste = "teste 1.1";
            //                        break;
            //                    case "2":
            //                        teste = "teste 1.2";
            //                        break;
            //                }
            //                break;
            //        }
            //        break;

            //    case "1":
            //        switch (Request.QueryString["finalizado"])
            //        {
            //            case "0":
            //                switch (Request.QueryString["tipo"])
            //                {
            //                    case "0":
            //                        teste = "teste 2.0";
            //                        break;
            //                    case "1":
            //                        teste = "teste 2.1";
            //                        break;
            //                    case "2":
            //                        teste = "teste 2.2";
            //                        break;
            //                }
            //                break;
            //            case "1":
            //                switch (Request.QueryString["tipo"])
            //                {
            //                    case "0":
            //                        teste = "teste 3.0";
            //                        break;
            //                    case "1":
            //                        teste = "teste 3.1";
            //                        break;
            //                    case "2":
            //                        teste = "teste 3.2";
            //                        break;
            //                }
            //                break;
            //        }
            //        break;

            //    case "2":
            //        switch (Request.QueryString["finalizado"])
            //        {
            //            case "0":
            //                switch (Request.QueryString["tipo"])
            //                {
            //                    case "0":
            //                        teste = "teste 4.0";
            //                        break;
            //                    case "1":
            //                        teste = "teste 4.1";
            //                        break;
            //                    case "2":
            //                        teste = "teste 4.2";
            //                        break;
            //                }
            //                break;
            //            case "1":
            //                switch (Request.QueryString["tipo"])
            //                {
            //                    case "0":
            //                        teste = "teste 5.0";
            //                        break;
            //                    case "1":
            //                        teste = "teste 5.1";
            //                        break;
            //                    case "2":
            //                        teste = "teste 5.2";
            //                        break;
            //                }
            //                break;
            //        }
            //        break;
            //}
            #endregion

            LoadDropDown();
            if (Convert.ToInt32(Request.QueryString["status"]) == 6)
            {
                ddwStatusTipo.Visible = true;
                ddwStatusTipo.SelectedValue = "0";
            }
            else
            {
                ddwStatusTipo.Visible = true;
                ddwStatusTipo.SelectedValue = Request.QueryString["statTipo"];
            }
        }

        private void LoadDropDown()
        {
            List<String> list = new List<String>();
            list = bd.getFieldValueListString(String.Format("select (LTRIM(RTRIM(TIPO_STAT_NOME)) + '%.%' + LTRIM(RTRIM(TIPO_STAT_IND))) as nome from AssepontoImplantacoesStatusTipo where TIPO_STAT_STATUS = {0} order by nome", 9));
            if (list.Count > 0)
            {
                foreach (String i in list)
                {
                    String[] split = i.Split(new String[] { "%.%" }, StringSplitOptions.None);
                    String nome = split[0];
                    String indice = split[1];
                    ListItem li = new ListItem();
                    li.Text = nome;
                    li.Value = indice;


                    ddwStatusTipo.Items.Add(li);
                }
                ddwStatusTipo.Visible = true;
            }
            else
                ddwStatusTipo.Visible = false;
        }

        protected void btnStatus_Click(object sender, EventArgs e)
        {
            string redirect = "~/suporte/implantacoes/Agenda.aspx?ind={0}&data={1}&finalizado={2}&tipo={3}&status={4}&datavalue=" + DateTime.Now.ToString("dd/MM/yyyy");
            if (Convert.ToInt32(ddwStatusTipo.SelectedValue) == 0)
                Response.Redirect(String.Format(redirect, 0, data, 0, 1, 6));
            else
                Response.Redirect(String.Format(redirect + "&statTipo={5}", 0, data, 0, 2, 9, ddwStatusTipo.SelectedValue));
        }

        protected void SqlAgendaCliente_Selecting(object sender, SqlDataSourceCommandEventArgs e)
        {
            if (String.IsNullOrEmpty(Request.QueryString["datavalue"]))
                e.Command.Parameters["@DATAVALUE"].Value = DateTime.Now.ToString("dd/MM/yyyy");
        }
    }
}