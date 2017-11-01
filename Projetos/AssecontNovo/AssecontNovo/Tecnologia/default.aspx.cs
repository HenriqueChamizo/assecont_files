using System;
using System.Data;
using AssecontNovo.Classes;

namespace AssecontNovo
{
    public partial class tecnologia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CarregarDepoimentos();
        }

        void CarregarDepoimentos()
        {
            string Html = string.Empty;
            string command = "SELECT TOP 4 DEP_IND, SUBSTRING(DEP_HTML, 0, 220) as HTML, DEP_DATA, DEP_AUTOR, DEP_EMPRESA, DEP_LINK_EMPRESA, DEP_CARGO_AUTOR  FROM AssepontoDepoimentos ORDER BY DEP_DATA DESC";
       
            DataTable table = (new BDAppTecnologia()).getDataTable(command);

            foreach (DataRow dr in table.Rows)
            {
                Html += "<li style='width: 420px; height: 230px; top: 5px;' > " +
                            "<table style='width: 100%;'>" +
                                "<tr><td class='font_red' style=' border-bottom: 1px dotted red; text-shadown 0 0 0; '>Escrito " +
                                    DateTime.Parse(dr["DEP_DATA"].ToString()).ToString("dd/MM/yyyy")  + "</td></tr>" +

                                "<tr><td class='titulo'  style='text-indent: 30px; height: 70px;'> <a href='/Tecnologia/depoimentos.aspx?ind=" + 
                                    dr["DEP_IND"].ToString().Trim() + "'>" + dr["HTML"].ToString().Trim() + "(...)</a></td></tr> " +
                    
                                "<tr><td style='font-style: italic;'><b>" + dr["DEP_AUTOR"].ToString().Trim() + "</b><br />" + dr["DEP_CARGO_AUTOR"] +
                                    "da empresa: <a href='" + dr["DEP_LINK_EMPRESA"] + "'>" + dr["DEP_EMPRESA"] + "</a></td></tr></table> " +
                        "</li>";
            }

            LiteralInformativos.Text = Html;
        }
    }
}