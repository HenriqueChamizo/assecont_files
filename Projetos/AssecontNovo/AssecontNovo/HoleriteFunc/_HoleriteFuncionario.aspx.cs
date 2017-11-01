using System;
using System.Globalization;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;

namespace AssecontNovo.Holerite
{
    public partial class _HoleriteFuncionario : System.Web.UI.Page
    {
        private BDAppAssecont bd;
        private int ind = 0;
        private int mes = 0;
        private int ano = 0;
        private int tipo = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            CultureInfo culture = new CultureInfo("pt-BR", true);
            Thread.CurrentThread.CurrentCulture = culture;
            Thread.CurrentThread.CurrentUICulture = culture;

            bd = new BDAppAssecont();

            ind = Convert.ToInt32(Request.QueryString["ind"]);
            mes = Convert.ToInt32(Request.QueryString["mes"]);
            ano = Convert.ToInt32(Request.QueryString["ano"]);
            tipo = Convert.ToInt32(Request.QueryString["tipo"]);

            if (mes == 0 && ano == 0 && tipo == 0)
            {
                string dia = bd.getFieldValueDateTime(string.Format("SELECT TOP 1 SAL_COMPETENCIA FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND SAL_DATA_CRIACAO IS NOT NULL ORDER BY SAL_DATA_CRIACAO DESC ", ind)).ToString("dd/MM/yyyy");
                mes = Convert.ToInt32(dia.Substring(3, 2));
                ano = Convert.ToInt32(dia.Substring(6, 4));
                tipo = bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} ORDER BY SAL_DATA_CRIACAO DESC", ind, mes, ano));

                Response.Redirect(string.Format("~/holerite/HoleriteFuncionario.aspx?ind={0}&mes={1}&ano={2}&tipo={3}", ind, mes, ano, tipo));
            }

            bd.setReciboVisualizadoFuncionario(ind, mes, ano);
            //bd.executeCommand(string.Format("UPDATE HoleriteResumoSalario  SET SAL_VISUALIZADO = '{0}' WHERE SAL_FUNC = {1} AND MONTH(SAL_COMPETENCIA) = {2} AND YEAR(SAL_COMPETENCIA) = {3} AND SAL_VISUALIZADO IS NULL", DateTime.Now, ind, mes, ano));

            string criacao = bd.getFieldValueDateTime(string.Format("SELECT SAL_DATA_CRIACAO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = {3}", ind, mes, ano, tipo)).ToString("dd/MM/yyyy HH:mm");
            lbDataCriacao.Text = criacao != "01/01/0001 00:00" ? "Enviado em: " + criacao : "";

            string visualizado = bd.getFieldValueDateTime(string.Format("SELECT SAL_VISUALIZADO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = {3}", ind, mes, ano, tipo)).ToString("dd/MM/yyyy HH:mm");
            lbVisualizado.Text = visualizado != "01/01/0001 00:00" ? "Visualizado em: " + visualizado : "";

            MasterPage MasterP = (MasterPage)Master;
            LinkButton LbNome = (LinkButton)MasterP.FindControl("lbNomeLogin");
            LbNome.Text = bd.getNomeFuncionario(ind);
            LbNome.Click += new EventHandler(Mostrar_Dados);

            #region TREENODE
            //TreeNode nodeSalario = new TreeNode("Salario");
            //TreeNode nodeProLab = new TreeNode("Pró-Labore");
            //TreeNode nodeAdiant = new TreeNode("Adiantamento");
            //TreeNode nodeSalario13 = new TreeNode("13º Salário");
            //TreeNode nodeSalario132 = new TreeNode("13º Salári 2ª");
            //TreeNode nodePRL = new TreeNode("PRL");
            //TreeNode nodeAbono = new TreeNode("Abono");

            //if (mes != 0)
            //{
            //    bd.openConnection();

            //if (bd.getFieldValueInteger(string.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 1 ", ind, mes, ano)) != 0)
            //{
            //    TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeSalario);
            //}
            //if (bd.getFieldValueInteger(string.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 2 ", ind, mes, ano)) != 0)
            //{
            //    TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeProLab);
            //}
            //if (bd.getFieldValueInteger(string.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 3 ", ind, mes, ano)) != 0)
            //{
            //    TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeAdiant);
            //}
            //if (bd.getFieldValueInteger(string.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 4 ", ind, mes, ano)) != 0)
            //{
            //    TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeSalario13);
            //}
            //if (bd.getFieldValueInteger(string.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 5 ", ind, mes, ano)) != 0)
            //{
            //    TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeSalario132);
            //}
            //if (bd.getFieldValueInteger(string.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 6 ", ind, mes, ano)) != 0)
            //{
            //    TreeView1.Nodes[mes - 1].ChildNodes.Add(nodePRL);
            //}
            //if (bd.getFieldValueInteger(string.Format("SELECT SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario  ON SAL_FUNC = FUNC_IND WHERE FUNC_IND = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 7 ", ind, mes, ano)) != 0)
            //{
            //    TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeAbono);
            //}
            //    bd.closeConnection();
            //    TreeView1.Nodes[mes - 1].ExpandAll();
            //}
            #endregion
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
            //ind = Convert.ToInt32(Request.QueryString["ind"]);
            //mes = Convert.ToInt32(Request.QueryString["mes"]);
            //ano = Convert.ToInt32(Request.QueryString["ano"]);
            tipo = 1;

            #region MESES
            if (TreeView1.SelectedNode.Value == "1")
            {
                mes = 1;
            }
            if (TreeView1.SelectedNode.Value == "2")
            {
                mes = 2;
            }
            if (TreeView1.SelectedNode.Value == "3")
            {
                mes = 3;
            }
            if (TreeView1.SelectedNode.Value == "4")
            {
                mes = 4;
            }
            if (TreeView1.SelectedNode.Value == "5")
            {
                mes = 5;
            }
            if (TreeView1.SelectedNode.Value == "6")
            {
                mes = 6;
            }
            if (TreeView1.SelectedNode.Value == "7")
            {
                mes = 7;
            }
            if (TreeView1.SelectedNode.Value == "8")
            {
                mes = 8;
            }
            if (TreeView1.SelectedNode.Value == "9")
            {
                mes = 9;
            }
            if (TreeView1.SelectedNode.Value == "10")
            {
                mes = 10;
            }
            if (TreeView1.SelectedNode.Value == "11")
            {
                mes = 11;
            }
            if (TreeView1.SelectedNode.Value == "12")
            {
                mes = 12;
            }
            #endregion

            if (TreeView1.SelectedNode.Value == "Ano")
            {
                ano = Convert.ToInt32(TreeView1.SelectedNode.Text) + 1;
            }
            if (TreeView1.SelectedNode.Value == "AnoAnterior")
            {
                ano = Convert.ToInt32(TreeView1.SelectedNode.Text);
            }

            //#region Obrigações
            //if (TreeView1.SelectedNode.Value == "Salario")
            //{
            //    tipo = 1;
            //}

            //if (TreeView1.SelectedNode.Value == "Pró-Labore")
            //{
            //    tipo = 2;
            //}

            //if (TreeView1.SelectedNode.Value == "Adiantamento")
            //{
            //    tipo = 3;
            //}

            //if (TreeView1.SelectedNode.Value == "13º Salário")
            //{
            //    tipo = 4;
            //}

            //if (TreeView1.SelectedNode.Value == "13º Salári 2ª")
            //{
            //    tipo = 5;
            //}

            //if (TreeView1.SelectedNode.Value == "PRL")
            //{
            //    tipo = 6;
            //}

            //if (TreeView1.SelectedNode.Value == "Abono")
            //{
            //    tipo = 7;
            //}
            //#endregion

            Response.Redirect(string.Format("~/holerite/HoleriteFuncionario.aspx?ind={0}&mes={1}&ano={2}&tipo={3}", ind, mes, ano, tipo));
        }

        protected void TreeView1_PreRender(object sender, EventArgs e)
        {
            //ind = Convert.ToInt32(Request.QueryString["ind"]);
            //mes = Convert.ToInt32(Request.QueryString["mes"]);
            //ano = Convert.ToInt32(Request.QueryString["ano"]);


            if (!Page.IsPostBack)
            {
                foreach (TreeNode node in TreeView1.Nodes)
                {
                    try
                    {
                        int elemento = Convert.ToInt32(node.Value);

                        int valor = bd.getCountRecibos(ind, elemento, ano);

                        if (valor > 0)
                            TreeView1.Nodes[elemento].Text += " (" + valor + ")";
                    }
                    catch (Exception ex) { }
                }
            }

            TreeView1.FindNode("Ano").Text = Convert.ToString(ano + 1);
            TreeView1.FindNode("AnoAnterior").Text = Convert.ToString(ano - 1);
        }

        void Mostrar_Dados(object sender, EventArgs e)
        {
            //ind = Convert.ToInt32(Request.QueryString["ind"]);
            Response.Redirect(string.Format("~/holerite/Dados.aspx?ind={0}", ind));
        }

        protected void SqlData_Load(object sender, EventArgs e)
        {
            ((SqlDataSource)sender).ConnectionString = bd.Conn.ConnectionString;
        }
    }
}