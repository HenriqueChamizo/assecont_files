using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.Teste
{
    public partial class contatoTec : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ContatosTecnologia();
            }
        }

        public void ContatosTecnologia()
        {
            BDAppTecnologia bdTecnologia = new BDAppTecnologia();
            bdTecnologia.openConnection();
            SqlCommand cmd = new SqlCommand("SELECT * FROM AssepontoSuporte WHERE SUP_ATIVO = 1 AND SUP_SETOR <> 0 ORDER BY SUP_NOME ASC", bdTecnologia.Conn);
            SqlDataReader dr = cmd.ExecuteReader();

            string htmlImplantacao = "<tr>";
            string html = "<tr>";
            string htmlGerente = "<tr>";
            int i = 0;
            int j = 0;
            int k = 0;

            while (dr.Read())
            {
                if (Convert.ToInt16(dr["SUP_SETOR"]) == 1)
                {
                    htmlGerente += "<td class='tableContact'><b>" + dr["SUP_NOME"].ToString() + "</b><br />  Tel: 11 " + dr["SUP_TELEFONE"] + "<br />  E-mail: " + dr["SUP_EMAIL"] + "<br />  Skype: " + dr["SUP_SKYPE"] + "</td>";
                    k++;
                }

                if (Convert.ToInt16(dr["SUP_SETOR"]) == 3)
                {
                    htmlImplantacao += "<td class='tableContact'><b>" + dr["SUP_NOME"].ToString() + "</b><br />  Tel: 11 " + dr["SUP_TELEFONE"] + "<br />  E-mail: " + dr["SUP_EMAIL"] + "<br />  Skype: " + dr["SUP_SKYPE"] + "</td>";
                    j++;
                }

                if (Convert.ToInt16(dr["SUP_SETOR"]) == 4)
                {
                    html += "<td class='tableContact'><b>" + dr["SUP_NOME"].ToString() + "</b><br />  Tel: 11 " + dr["SUP_TELEFONE"] + "<br />  E-mail: " + dr["SUP_EMAIL"] + "<br />  Skype: " + dr["SUP_SKYPE"] + "</td>";
                    i++;
                }

                if (i % 2 == 0)
                    html += "</tr><tr>";

                if (j % 2 == 0)
                    htmlImplantacao += "</tr><tr>";

                if (k % 2 == 0)
                    htmlGerente += "</tr><tr>";
                
            }

            bdTecnologia.closeConnection();

            LiteralSuporte.Text = html;
            LiteralImplantacao.Text = htmlImplantacao;
            LiteralGerente.Text = htmlGerente;
        }
    }
}