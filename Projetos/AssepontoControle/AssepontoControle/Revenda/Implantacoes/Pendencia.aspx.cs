using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Wr.Classes;

namespace Asseponto.Revenda.Implantacoes
{
    public partial class Pendencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            sitecorpoboxbottom.Visible = false;
            if (Convert.ToInt32(Request.QueryString["ind"]) > 0)
                FormView1.DefaultMode = FormViewMode.Edit;
            else
                FormView1.DefaultMode = FormViewMode.Insert;
        }

        protected void sqlPendencias_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                int Implantacao = (new BDApp()).getImplantacaoFromPendencia(Convert.ToInt32(Request.QueryString["ind"]));
                Response.Redirect(String.Format("~/Revenda/Implantacoes/Pendencias.aspx?implantacao={0}", Implantacao));
            }
        }

        protected void sqlPendencias_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            FormUtils utils = new FormUtils();
            utils.InitializePageControls();

            e.Command.Parameters["@PEN_RESPONSAVEL1"].Value = UserApp.UserId.ToString();

            if (e.Command.Parameters["@PEN_SOLUCAO"].Value != null)
            {
                e.Command.Parameters["@PEN_DATAHORASOLUCAO"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.Fechado;
            }
            else
            {
                e.Command.Parameters["@PEN_DATAHORA"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.EmAberto;
            }
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {
            if (FormView1.CurrentMode == FormViewMode.Insert)
            {
                FormUtils utils = new FormUtils();
                utils.InitializePageControls();
                UserApp user = new UserApp();

                if (String.IsNullOrEmpty(Request.QueryString["ind"]))
                {
                    ((Label)Wr.Classes.PageUtils.FindControl(FormView1, "labelResponsavel")).Text = user.UserName();
                    ((Label)Wr.Classes.PageUtils.FindControl(FormView1, "PEN_DATAHORA")).Text = String.Format("{0:dd/MM/yyyy}", DateTime.Now);
                }
            }
        }

        protected void sqlPendencias_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            FormUtils formutils = new FormUtils();
            formutils.InitializePageControls();
            UserApp user = new UserApp();
            BDApp bd = new BDApp();
            int Implantacao = Convert.ToInt32(Request.QueryString["Implantacao"]);

            e.Command.Parameters["@PEN_RESPONSAVEL1"].Value = UserApp.UserId.ToString();
            e.Command.Parameters["@PEN_INDCADASTRO"].Value = bd.getClienteIndiceFromImplantacao(Implantacao);
            e.Command.Parameters["@PEN_TIPO"].Value = Types.PendenciaTipo.Implantacao;

            if (e.Command.Parameters["@PEN_SOLUCAO"].Value != null)
            {
                e.Command.Parameters["@PEN_DATAHORASOLUCAO"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.Fechado;
            }
            else
            {
                e.Command.Parameters["@PEN_DATAHORA"].Value = DateTime.Now;
                e.Command.Parameters["@PEN_SITUACAO"].Value = Types.PendenciaSituacao.EmAberto;
            }
        }

        protected void sqlPendencias_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                Response.Redirect(String.Format("~/Revenda/Implantacoes/Pendencias.aspx?implantacao={0}", Request.QueryString["implantacao"]));
            }
        }
    }
}