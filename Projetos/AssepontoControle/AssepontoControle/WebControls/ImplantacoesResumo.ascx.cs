using System;
using Asseponto.Classes;

namespace Asseponto.WebControls
{
    public partial class ImplantacoesResumo : System.Web.UI.UserControl
    {
        int _Revenda = 0;

        #region Properties
        public int Revenda
        {
            get
            {
                return _Revenda;
            }
            set
            {
                _Revenda = value;
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            int NImplantacoesIniciadas = 0;
            int NImplantacoesNaoIniciadas = 0;

            BDApp bd = new BDApp();

            if (Revenda == 0)
            {
                NImplantacoesIniciadas = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) FROM [AssepontoImplantacoes] INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA WHERE (IM_STATUS = {0} AND IM_INICIO_IMPLANTACAO IS NOT NULL)", Convert.ToInt32(Types.ImplantacaoStatus.EmAberto)));
                NImplantacoesNaoIniciadas = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) FROM [AssepontoImplantacoes] INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE INNER JOIN AssepontoRevendas ON REV_IND = CAD_REVENDA WHERE (IM_STATUS = {0} AND IM_INICIO_IMPLANTACAO IS NULL)", Convert.ToInt32(Types.ImplantacaoStatus.EmAberto)));

                linkNImplantacoesIniciadas.NavigateUrl = "~/suporte/Implantacoes/Default.aspx?filtronome=*&iniciadas=1&status=1";
                linkNImplantacoesNaoIniciadas.NavigateUrl = "~/suporte/Implantacoes/Default.aspx?filtronome=*&iniciadas=0&status=1";
            }
            else
            {
                NImplantacoesIniciadas = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) AS NImplantacoes FROM [AssepontoImplantacoes] INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE WHERE ([CAD_REVENDA] = {0} AND IM_STATUS = {1} AND IM_INICIO_IMPLANTACAO IS NOT NULL)", Revenda, Convert.ToInt32(Types.ImplantacaoStatus.EmAberto)));
                NImplantacoesNaoIniciadas = bd.getFieldValueInteger(String.Format("SELECT COUNT(*) AS NImplantacoes FROM [AssepontoImplantacoes] INNER JOIN AssepontoClientes ON CAD_IND = IM_CLIENTE WHERE ([CAD_REVENDA] = {0} AND IM_STATUS = {1} AND IM_INICIO_IMPLANTACAO IS NULL)", Revenda, Convert.ToInt32(Types.ImplantacaoStatus.EmAberto)));

                linkNImplantacoesIniciadas.NavigateUrl = "~/Revenda/Implantacoes/Default.aspx?iniciadas=1";
                linkNImplantacoesNaoIniciadas.NavigateUrl = "~/Revenda/Implantacoes/Default.aspx?iniciadas=0";
            }

            ImplantacoesResumosWrapper.Visible = (NImplantacoesIniciadas > 0 || NImplantacoesNaoIniciadas > 0);

            if (NImplantacoesIniciadas > 0)
            {
                if (NImplantacoesIniciadas == 1)
                {
                    linkNImplantacoesIniciadas.Text = "1 Implantação iniciada";
                }
                else
                {
                    linkNImplantacoesIniciadas.Text = String.Format("{0} Implantações iniciadas", NImplantacoesIniciadas);
                }
            }
            else
            {
                divIniciadas.Visible = false;
            }

            if (NImplantacoesNaoIniciadas > 0)
            {
                if (NImplantacoesNaoIniciadas == 1)
                {
                    linkNImplantacoesNaoIniciadas.Text = "1 Implantação não iniciada";
                }
                else
                {
                    linkNImplantacoesNaoIniciadas.Text = String.Format("{0} Implantações não iniciadas", NImplantacoesNaoIniciadas);
                }
            }
            else
            {
                divNaoIniciadas.Visible = false;
            }
        }
    }
}