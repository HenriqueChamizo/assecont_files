using System;
using Asseponto.Classes;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Drawing;
using System.Data;

namespace Asseponto.WebControls
{
    public partial class PendenciasResumo : System.Web.UI.UserControl
    {
        #region Properties
        byte _PendenciaTipo = 0;

        public byte PendenciaTipo
        {
            get
            {
                return _PendenciaTipo;
            }
            set
            {
                _PendenciaTipo = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            DisplayResumo();
        }

        public void DisplayResumo()
        {
            int EmAberto = Convert.ToInt32(Types.PendenciaSituacao.EmAberto);

            BDApp bd = new BDApp();

            int NPendencias = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) FROM AssepontoPendencias WHERE PEN_SITUACAO = {0} AND PEN_TIPO = {1}", EmAberto, PendenciaTipo));

            if (NPendencias > 0)
            {
                if (NPendencias > 1)
                {
                    linkTodas.Text = String.Format("Exibir todas as {0} pendências", NPendencias);
                }
                else
                {
                    linkTodas.Visible = false;
                }

                labelNPedidos.Text = (PendenciaTipo == Convert.ToInt32(Types.PendenciaTipo.Implantacao)) ? "Pendências de Implantação" : "Pendências de Suporte";

                //SqlCommand comm = bd.Conn.CreateCommand();

                //comm.CommandText = String.Format("SELECT TOP 6 PEN_IND, PEN_DATAHORA, dbo.fn_asseponto_capital(CAD_RAZAOSOCIAL) AS CAD_RAZAOSOCIAL, SUP_NOME " +
                //    "FROM AssepontoPendencias " +
                //    "INNER JOIN AssepontoClientes ON CAD_IND = PEN_INDCADASTRO " +
                //    "INNER JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1 " +
                //    "WHERE PEN_SITUACAO = {0} AND PEN_TIPO = {1} ORDER BY PEN_DATAHORA DESC", EmAberto, PendenciaTipo);

                //SqlDataReader reader = comm.ExecuteReader();

                DataTable tbPendeciasResumo = bd.getDataTable(String.Format("SELECT TOP 6 PEN_IND, PEN_DATAHORA, dbo.fn_asseponto_capital(CAD_RAZAOSOCIAL) AS CAD_RAZAOSOCIAL, SUP_NOME " +
                    "FROM AssepontoPendencias " +
                    "INNER JOIN AssepontoClientes ON CAD_IND = PEN_INDCADASTRO " +
                    "INNER JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1 " +
                    "WHERE PEN_SITUACAO = {0} AND PEN_TIPO = {1} ORDER BY PEN_DATAHORA DESC", EmAberto, PendenciaTipo));

                foreach(DataRow reader in tbPendeciasResumo.Rows)
                //while (reader.Read())
                {
                    HyperLink button = new HyperLink();
                    button.CssClass = "sitelinkpadraoazul";
                    button.Text = reader["CAD_RAZAOSOCIAL"].ToString();
                    button.Style.Add("font-weight", "normal");
                    button.NavigateUrl = String.Format("~/suporte/atendimento/pendencia.aspx?ind={0}", reader["PEN_IND"].ToString());

                    Label suporte = new Label();
                    suporte.Text = reader["SUP_NOME"].ToString();
                    suporte.ForeColor = ColorTranslator.FromHtml("#999999");

                    Label data = new Label();
                    data.Text = String.Format("{0:dd/MM/yyyy HH:mm}", Convert.ToDateTime(reader["PEN_DATAHORA"]));
                    data.ForeColor = ColorTranslator.FromHtml("#999999");

                    divUltimasPendencias.Controls.Add(button);
                    divUltimasPendencias.Controls.Add(new LiteralControl("<BR>"));
                    divUltimasPendencias.Controls.Add(suporte);
                    divUltimasPendencias.Controls.Add(new LiteralControl("<BR>"));
                    divUltimasPendencias.Controls.Add(data);
                    divUltimasPendencias.Controls.Add(new LiteralControl("<BR>"));
                }

                //reader.Close();
                //bd.closeConnection();

                linkTodas.NavigateUrl = String.Format("~/suporte/Atendimento/Pendencias.aspx?tipo={0}", PendenciaTipo);
            }
            else
            {
                PendenciasResumoWrapper.Visible = false;
            }
        }
    }
}