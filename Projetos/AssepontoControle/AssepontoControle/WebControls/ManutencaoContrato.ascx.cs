using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asseponto.Classes;

namespace Asseponto.WebControls
{
    public partial class ManutencaoContrato : System.Web.UI.UserControl
    {
        int funcionarios;
        public int Funcionarios
        {
            get { return funcionarios; }
            set { funcionarios = value; }
        }

        string razaoSocial;
        public string RazaoSocial
        {
            get { return razaoSocial; }
            set { razaoSocial = value; }
        }

        string cnpjCpf;
        public string CNPJ_CPF
        {
            get { return cnpjCpf; }
            set { cnpjCpf = value; }
        }

        int meses = 12;

        public int Meses
        {
            get { return meses; }
            set { meses = value; }
        }

        int web = 0;

        public int Web
        {
            get { return web; }
            set { web = value; }
        }

        double valor;
        string extensoValor;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Funcionarios > 0)
            {
                getDados();
            }
        }

        public void getDados()
        {
            valorManutencao(Funcionarios, Meses);
            lbMeses.Text = Meses.ToString();
            lbContratante.Text = RazaoSocial;
            lbCnpjContratante.Text = Utils.getFormatCNPJ_CPF(CNPJ_CPF);
            //lbCnpjContratante.Text = string.Format(@"{0:00\.000\.000/0000\-00}", Convert.ToDouble(Cnpj));
            lbValor2.Text = string.Format("{0:n2}", valor);
            lbValorDescricao.Text = extensoValor;
            lbValor3.Text = string.Format("{0:n2}", valor);
            lbValorDescricao3.Text = extensoValor;
            lbValor4.Text = string.Format("{0:n2}", valor);
            lbValorDescricao4.Text = extensoValor;
        }

        public void getGerarOutroValor(Double Value, string Descricao, int PWeb = 0)
        {
            lbContratante.Text = RazaoSocial;
            lbCnpjContratante.Text = Utils.getFormatCNPJ_CPF(CNPJ_CPF);
            lbValor2.Text = string.Format("{0:n2}", Value);
            lbValorDescricao.Text = Descricao;
            lbValor3.Text = string.Format("{0:n2}", Value);
            lbValorDescricao3.Text = Descricao;
            lbValor4.Text = string.Format("{0:n2}", Value);
            lbValorDescricao4.Text = Descricao;
            Web = PWeb;
        }

        private void valorManutencao(int num, int nmes = 12)
        {
            try
            {
                DataTable valores = (new BDApp()).getDataTable("SELECT TOP 1 APLAN_VALUE, APLAN_VALUE_DESCRICAO FROM AssepontoPlanos " +
                    "WHERE APLAN_VALOR_AVULSO_30_DIAS = 0 AND APLAN_VALOR_AVULSO_POR_ATENDIMENTO = 0 AND APLAN_QTD_FUNC >= " + num + " AND APLAN_MESES = " + nmes.ToString());
                Meses = nmes;
                foreach (DataRow dr in valores.Rows)
                {
                    extensoValor = dr["APLAN_VALUE_DESCRICAO"].ToString();
                    valor = Convert.ToDouble(dr["APLAN_VALUE"]);
                }
            }
            catch
            {
                Response.RedirectPermanent("http://www.assecont.com.br/Avisos/ErroTela.aspx");

            }
            #region Comentado Flavia
            //if (num >= 1 && num <= 10)
            //{
            //    extensoValor = "(oitenta e nove reais)";
            //    valor = 89.00;
            //}

            //if (num >= 11 && num <= 20)
            //{
            //    extensoValor = "(cento e dezenove reais)";
            //    valor = 119.00;
            //}

            //if (num >= 21 && num <= 50)
            //{
            //    extensoValor = "(cento e quarenta e nove reais)";
            //    valor = 149.00;
            //}

            //if (num >= 51 && num <= 100)
            //{
            //    extensoValor = "(cento e sessenta e nove reais)";
            //    valor = 169.00;
            //}

            //if (num >= 101 && num <= 200)
            //{
            //    extensoValor = "(duzentos e quarenta e oito reais)";
            //    valor = 248.00;
            //}

            //if (num >= 201 && num <= 300)
            //{
            //    extensoValor = "(trezentos e quarenta e nove reais)";
            //    valor = 349.00;
            //}

            //if (num >= 301 && num <= 400)
            //{
            //    extensoValor = "(quatrocentos e vinte reais)";
            //    valor = 420.00;
            //}

            //if (num >= 401 && num <= 500)
            //{
            //    extensoValor = "(quinhentos e quarenta e nove reais)";
            //    valor = 549.00;
            //}
            #endregion
        }
    }
}