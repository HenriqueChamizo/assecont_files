using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using System.Data;
using System.Data.SqlClient;

namespace AssecontNovo.Grupo.Atendimento
{
    public partial class Contato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ContatosAssecont();
                ContatosTecnologia();
            }
        }

        public void ContatosTecnologia()
        {
            BDAppTecnologia bdTecnologia = new BDAppTecnologia();
            bdTecnologia.openConnection();
            SqlCommand cmd = new SqlCommand("SELECT SUP_NOME, SUP_TELEFONE, SUP_EMAIL, SUP_SKYPE, SUP_SETOR FROM AssepontoSuporte WHERE SUP_ATIVO = 1 AND (SUP_SETOR IN (1, 2, 3, 4)) ORDER BY SUP_NOME ASC", bdTecnologia.Conn);

            SqlDataReader dr = cmd.ExecuteReader();

            string html = "<tr>";
            string htmlComercial = "<tr>";
            int i1 = 0;
            int i2 = 0;

            while (dr.Read())
            {
                if (Convert.ToInt32(dr["SUP_SETOR"]) == 2)
                {
                    htmlComercial += "<td style='padding-bottom: 20px;'><b>" + dr["SUP_NOME"].ToString() + "</b><br />  Tel: 11 " + dr["SUP_TELEFONE"] + "<br />  E-mail: " + dr["SUP_EMAIL"] + "<br />  Skype: " + dr["SUP_SKYPE"] + "</td>";
                    i1++;
                    if (i1 % 2 == 0)
                        htmlComercial += "</tr><tr>";
                }
                else
                {
                    html += "<td style='padding-bottom: 20px;'><b>" + dr["SUP_NOME"].ToString() + "</b><br />  Tel: 11 " + dr["SUP_TELEFONE"] + "<br />  E-mail: " + dr["SUP_EMAIL"] + "<br />  Skype: " + dr["SUP_SKYPE"] + "</td>";

                    i2++;
                    if (i2 % 2 == 0)
                        html += "</tr><tr>";
                }
            }

            bdTecnologia.closeConnection();

            LiteralSuporte.Text = html;
            LiteralComercial.Text = htmlComercial;
        }

        public void ContatosAssecont()
        {
            BDAppAssecont bdAssecont = new BDAppAssecont();

            bdAssecont.openConnection();
            SqlCommand cmd = new SqlCommand("SELECT * FROM LoginsInternos WHERE LOGI_ATIVO = 1 AND LOGI_SUPERVISOR = 1 AND LOGI_SETOR > 0 AND LOGI_DESLIGAMENTO IS NULL ORDER BY LOGI_SETOR, LOGI_NOME ASC", bdAssecont.Conn);

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                string html = "<tr>";
                int i = 0;

                html += "<td style='padding-bottom: 20px;'><b>" + dr["LOGI_NOME"].ToString() + "</b><br />  Tel: 11 " + dr["LOGI_TELEFONE"] + "<br />  E-mail: " + dr["LOGI_EMAIL"] + "</td>";

                if (i % 2 == 0)
                    html += "</tr><tr>";

                switch (Convert.ToInt32(dr["LOGI_SETOR"]))
                {
                    case 1:
                        LiteralFiscal.Text += html;
                        break;

                    case 2:
                        LiteralContabil.Text += html;
                        break;

                    case 3:
                        LiteralPessoal.Text += html;
                        break;

                    case 4:
                        LiteralLegalizacao.Text += html;
                        break;

                    case 5:
                        LiteralGed.Text += html;
                        break;
                }

                i++;

                
            }

            bdAssecont.closeConnection();

        }
    }
}