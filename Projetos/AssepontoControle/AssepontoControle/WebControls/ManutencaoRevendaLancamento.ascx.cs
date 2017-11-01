using System;
using System.Web.UI.WebControls;
using Asseponto.Classes;
using Telerik.Web.UI;

namespace Asseponto.WebControls
{
    public partial class ManutencaoRevendaLancamento : System.Web.UI.UserControl
    {
        #region Properties
        int _revenda = 0;

        public int Revenda
        {
            get
            {
                return _revenda;
            }
            set
            {
                _revenda = value;
            }
        }
        #endregion

        private Double valor;
        private int versao;
        private DateTime enviadoEm;
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void SqlCliente_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            //e.Command.Parameters["@Revenda"].Value = Revenda;
        }

        protected void Salvar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                valor = Convert.ToDouble(txtValor.Text);
                versao = Convert.ToInt32(comboVersao.SelectedItem.Value);
                enviadoEm = Convert.ToDateTime(RadDateEnviado.SelectedDate.Value);

                InserirManutencao();
            }
        }

        private void InserirManutencao()
        {
            try
            {
                BDApp bd = new BDApp();
                UserApp user = new UserApp();

                string sql = "INSERT INTO AssepontoManutencao (MNT_CLIENTE, MNT_DATA, MNT_VALOR, MNT_VERSAO_ASSEPONTO, MNT_DATA_LANCAMENTO, MNT_CONTRATO_ENVIADOEM, MNT_REALIZADO_POR, MNT_REVENDA) " +
                    "VALUES ({0}, GETDATE(), '{1}', '{2}', GETDATE(), '{3}', '{4}', {5})";

                foreach (GridDataItem item in RadGrid1.Items)
                {
                    CheckBox chkSelecionar = (CheckBox)item["selecionar"].FindControl("CheckRealizado");
                    int cliente = Convert.ToInt32(item.GetDataKeyValue("CAD_IND").ToString());

                    if (chkSelecionar.Checked)
                    {
                        bd.executeCommand(string.Format(sql, cliente, valor.ToString().Replace(',', '.'), versao, enviadoEm, UserApp.UserId, Revenda));
                    }
                }

                Response.Redirect(string.Format("~/Suporte/Revendas/Manuntecao.aspx?revenda={0}", Revenda));
            }
            catch (Exception ex)
            {
                lbError.Text = "ERRO: " + ex.Message;
            }
        }
    }
}