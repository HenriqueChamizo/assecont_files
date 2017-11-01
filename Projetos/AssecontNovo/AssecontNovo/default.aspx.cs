using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BDAppAssecont bd = new BDAppAssecont();
                FraseDoDia(bd);
                CarregarInformativos(bd);
            }
        }

        protected void lkHolerite_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lkBoleto.Attributes.Add("target", "_black");
                Response.Redirect("~/holeriteFunc/login.aspx?cpf=" + txtHolerite.Text);
            }
        }

        void FraseDoDia(BDAppAssecont bd)
        {
            lbfrases.Text = bd.getFrase();
        }

        void CarregarInformativos(BDAppAssecont bd)
        {
            string Html = string.Empty;
            string command = "SELECT TOP 4 INF_IND, SUBSTRING(INF_HTML, 0, 200) as HTML, INF_NUMERO, INF_DATA, INF_TITULO, INF_HTML FROM Informativos WHERE INF_ATIVO = 1 ORDER BY INF_NUMERO DESC";
           
            DataTable table = bd.getDataTable(command);

            foreach(DataRow dr in table.Rows)
            {
                Html += "<li style='width: 420px; height: 200px; top: 5px; ' > " +
                            "<table style='width: 100%;'>" +
                                "<tr><td class='font_red' style='border-bottom: 1px dotted red; text-shadown 0 0 0; '>Publicado " + DateTime.Parse(dr["INF_DATA"].ToString()).ToString("dd/MM/yyyy") + "<br /></td></tr>" +
                                "<tr><td class='titulo' style=' height: 60px;'> <a href='/Informativos/ViewInfo.aspx?ind=" + dr["INF_IND"].ToString().Trim() + "'>" + dr["INF_TITULO"].ToString().Trim() + "</a></td></tr> " +
                                //"<tr><td style='font-style: italic !important; font-family: 'Segoei ui' !important; font-size: 10pt !important; '>" + dr["HTML"].ToString().Trim() + "(...)</td></tr>
                                "</table> " +
                        "</li>";
            }
            LiteralInformativos.Text = Html;         
        }

        protected void lkBoleto_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lkBoleto.Attributes.Add("target", "_black");
                Response.Redirect(string.Format("~/Grupo/Boletos/default.aspx?cnpj={0}", txtBoleto.Text.Replace("/", "").Replace("-", "").Replace(".", "")));
            }
        }

        protected void CVBOLETO_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (new BDAppAssefin()).getCliente(txtBoleto.Text.Trim()) > 0 ? true : false;
        }

        protected void CV_Holerite_ServerValidate(object source, ServerValidateEventArgs args)
        {
           args.IsValid = (new BDAppAssecont()).getFuncionarioHolerite(txtHolerite.Text) > 0 ? true : false;
        }
    }
}