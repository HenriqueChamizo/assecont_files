using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Asseponto.Classes;

namespace Asseponto.Suporte.Clientes
{
    public partial class Contrato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                (new Permissoes(new BDApp())).getAcessoResponse("Manutencao", Response);

            setManutencao(Convert.ToInt32(Request.QueryString["ind"]));
        }

        void setManutencao(int ind)
        {
            DataTable dados = (new BDApp()).getDataTable(
                "SELECT CAD_RAZAOSOCIAL, dbo.fn_trim_cnpj(dbo.fn_cliente_cnpj_cpf(CAD_IND)) AS CNPJCPF, CAD_QTD_FUNCIONARIO FROM AssepontoClientes WHERE CAD_IND = " + ind);
            //DataRow d = dados.Rows[0];
            foreach (DataRow dr in dados.Rows)
            {
                ManutencaoContrato.Funcionarios = Convert.ToInt32(dr["CAD_QTD_FUNCIONARIO"]);
                ManutencaoContrato.RazaoSocial = dr["CAD_RAZAOSOCIAL"].ToString().Trim();
                ManutencaoContrato.CNPJ_CPF = dr["CNPJCPF"].ToString();
                //ManutencaoContrato.Web = Convert.ToInt32(string.IsNullOrEmpty(RadioButtonList1.SelectedValue) ? "0" : RadioButtonList1.SelectedValue);
                if (!string.IsNullOrEmpty(txtValor.Text))
                {
                    ManutencaoContrato.getGerarOutroValor(Convert.ToDouble(txtValor.Text), txtDescricao.Text, Convert.ToInt32(string.IsNullOrEmpty(RadioButtonList1.SelectedValue) ? "0" : RadioButtonList1.SelectedValue));
                }
            }
        }

        protected void btValor_Click(object sender, EventArgs e)
        {
            setManutencao(Convert.ToInt32(Request.QueryString["ind"]));
        }
    }
}