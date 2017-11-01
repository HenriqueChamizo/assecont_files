﻿using System;
using System.Web.UI.WebControls;
using AssecontNovo.Classes;
using AssecontNovo.Holerite.Classes;
using Wr.Classes;

namespace AssecontNovo.Holerite
{
    public partial class HoleriteClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BDAppAssecontAntigo BDAntigo = new BDAppAssecontAntigo();
            int ind = Convert.ToInt32(Request.QueryString["ind"]);
            int mes = Convert.ToInt32(Request.QueryString["mes"]);
            int ano = Convert.ToInt32(Request.QueryString["ano"]);
            int tipo = Convert.ToInt32(Request.QueryString["tipo"]);

            ind = (new BDAppAssecont()).getClienteID(BDAntigo.getClienteNumero(ind));

            //if (mes == 0 && ano == 0 && tipo == 0)
            //{
            //    string dia = BDAntigo.getFieldValueDateTime(string.Format("SELECT TOP 1 SAL_COMPETENCIA FROM Funcionarios INNER JOIN HoleriteResumoSalario ON SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND SAL_DATA_CRIACAO IS NOT NULL ORDER BY SAL_DATA_CRIACAO DESC", ind)).ToString("dd/MM/yyyy");
            //    mes = Convert.ToInt32(dia.Substring(3, 2));
            //    ano = Convert.ToInt32(dia.Substring(6, 4));
            //    tipo = BDAntigo.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM Funcionarios INNER JOIN HoleriteResumoSalario ON SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} ORDER BY SAL_DATA_CRIACAO DESC", ind, mes, ano));
            //}

            Response.Redirect(string.Format("~/holerite/defaultCli.aspx?ind={0}&mes={1}&ano={2}&tipo={3}", ind, mes, ano, tipo));
        }

        //    string criacao = bd.getFieldValueDateTime(string.Format("SELECT TOP 1 SAL_DATA_CRIACAO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = {3}", ind, mes, ano, tipo)).ToString("dd/MM/yyyy HH:mm");
        //    lbDataCriacao.Text = criacao != "01/01/0001 00:00" ? "Enviado em: " + criacao : "";

        //    bd.executeCommand(string.Format("UPDATE HoleriteResumoSalario  SET SAL_VISUALIZADO_CLIENTE = '{0}' WHERE MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = {3} AND SAL_VISUALIZADO_CLIENTE IS NULL", DateTime.Now, mes, ano, tipo));
        //    string visualizado = bd.getFieldValueDateTime(string.Format("SELECT TOP 1 SAL_VISUALIZADO_CLIENTE FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = {3}", ind, mes, ano, tipo)).ToString("dd/MM/yyyy HH:mm");
        //    lbVisualizado.Text = visualizado != "01/01/0001 00:00" ? "Visualizado em: " + visualizado : "";

        //    #region TREENODE
        //    TreeNode nodeSalario = new TreeNode("Salario");
        //    TreeNode nodeProLab = new TreeNode("Pró-Labore");
        //    TreeNode nodeAdiant = new TreeNode("Adiantamento");
        //    TreeNode nodeSalario13 = new TreeNode("13º Salário");
        //    TreeNode nodeSalario132 = new TreeNode("13º Salári 2ª");
        //    TreeNode nodePRL = new TreeNode("PRL");
        //    TreeNode nodeAbono = new TreeNode("Abono");

        //    if (mes != 0)
        //    {
        //        if (bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 1 ", ind, mes, ano)) != 0)
        //        {
        //            TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeSalario);
        //        }
        //        if (bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 2", ind, mes, ano)) != 0)
        //        {
        //            TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeProLab);
        //        }
        //        if (bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 3", ind, mes, ano)) != 0)
        //        {
        //            TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeAdiant);
        //        }
        //        if (bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 4", ind, mes, ano)) != 0)
        //        {
        //            TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeSalario13);
        //        }
        //        if (bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 5", ind, mes, ano)) != 0)
        //        {
        //            TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeSalario132);
        //        }
        //        if (bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 6", ind, mes, ano)) != 0)
        //        {
        //            TreeView1.Nodes[mes - 1].ChildNodes.Add(nodePRL);
        //        }
        //        if (bd.getFieldValueInteger(string.Format("SELECT TOP 1 SAL_HOLERITE_TIPO FROM dbo.Funcionarios INNER JOIN HoleriteResumoSalario  ON HoleriteResumoSalario .SAL_FUNC = FUNC_IND WHERE FUNC_EMPRESA = {0} AND MONTH(SAL_COMPETENCIA) = {1} AND YEAR(SAL_COMPETENCIA) = {2} AND SAL_HOLERITE_TIPO = 7", ind, mes, ano)) != 0)
        //        {
        //            TreeView1.Nodes[mes - 1].ChildNodes.Add(nodeAbono);
        //        }
        //        TreeView1.Nodes[mes - 1].ExpandAll();
        //    }
        //    #endregion
        //}

        //protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        //{
        //    int ind = Convert.ToInt32(Request.QueryString["ind"]);
        //    int mes = Convert.ToInt32(Request.QueryString["mes"]);
        //    int ano = Convert.ToInt32(Request.QueryString["ano"]);
        //    int tipo = 1;

        //    #region MESES
        //    if (TreeView1.SelectedNode.Value == "1") mes = 1;

        //    if (TreeView1.SelectedNode.Value == "2") mes = 2;

        //    if (TreeView1.SelectedNode.Value == "3") mes = 3;

        //    if (TreeView1.SelectedNode.Value == "4") mes = 4;

        //    if (TreeView1.SelectedNode.Value == "5") mes = 5;

        //    if (TreeView1.SelectedNode.Value == "6") mes = 6;

        //    if (TreeView1.SelectedNode.Value == "7") mes = 7;

        //    if (TreeView1.SelectedNode.Value == "8") mes = 8;

        //    if (TreeView1.SelectedNode.Value == "9") mes = 9;

        //    if (TreeView1.SelectedNode.Value == "10") mes = 10;

        //    if (TreeView1.SelectedNode.Value == "11") mes = 11;

        //    if (TreeView1.SelectedNode.Value == "12") mes = 12;
        //    #endregion

        //    if (TreeView1.SelectedNode.Value == "Ano")
        //        ano = Convert.ToInt32(TreeView1.SelectedNode.Text) + 1;

        //    if (TreeView1.SelectedNode.Value == "AnoAnterior")
        //        ano = Convert.ToInt32(TreeView1.SelectedNode.Text);

        //    if (TreeView1.SelectedNode.Value == "Funcionário")
        //        Response.Redirect(string.Format("~/ProcurarHolerite.aspx?cl={0}", ind));

        //    #region Obrigações
        //    if (TreeView1.SelectedNode.Value == "Salario") tipo = 1;

        //    if (TreeView1.SelectedNode.Value == "Pró-Labore") tipo = 2;

        //    if (TreeView1.SelectedNode.Value == "Adiantamento") tipo = 3;

        //    if (TreeView1.SelectedNode.Value == "13º Salário") tipo = 4;

        //    if (TreeView1.SelectedNode.Value == "13º Salári 2ª") tipo = 5;

        //    if (TreeView1.SelectedNode.Value == "PRL") tipo = 6;

        //    if (TreeView1.SelectedNode.Value == "Abono") tipo = 7;
        //    #endregion

        //    Response.Redirect(string.Format("~/defaultCli.aspx?ind={0}&&mes={1}&&ano={2}&&tipo={3}", ind, mes, ano, tipo));
        //}

        //protected void TreeView1_PreRender(object sender, EventArgs e)
        //{
        //    int ind = Convert.ToInt32(Request.QueryString["ind"]);
        //    int ano = Convert.ToInt32(Request.QueryString["ano"]);

        //    #region Preencher Menu
        //    if (!Page.IsPostBack)
        //    {
        //        int aux;
        //        BD bd = new BD();
        //        bd.openConnection();
        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 1 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[0].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 2 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[1].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 3 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[2].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 4 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[3].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 5 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[4].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 6 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[5].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 7 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[6].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 8 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[7].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 9 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[8].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 10 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[9].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 11 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[10].Text += " (" + aux + ")";

        //        aux = bd.getFieldValueInteger(string.Format("SELECT COUNT(DISTINCT SAL_HOLERITE_TIPO) FROM HoleriteResumoSalario  INNER JOIN dbo.Funcionarios ON SAL_FUNC = FUNC_IND WHERE MONTH(SAL_COMPETENCIA) = 12 AND YEAR(SAL_COMPETENCIA) = {0} AND FUNC_EMPRESA = {1}", ano, ind));
        //        if (aux > 0) TreeView1.Nodes[11].Text += " (" + aux + ")";
        //        bd.closeConnection();
        //    }
        //    #endregion

        //    TreeView1.FindNode("Ano").Text = Convert.ToString(ano);

        //    TreeView1.FindNode("AnoAnterior").Text = Convert.ToString(ano - 1);
        //}

        //protected void DataList1_PreRender(object sender, EventArgs e)
        //{

        //}
    }
}