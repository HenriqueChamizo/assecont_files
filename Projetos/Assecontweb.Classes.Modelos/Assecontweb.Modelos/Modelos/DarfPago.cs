using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using Wr.Classes;

namespace Assecontweb.Modelos
{
    public class DarfPago
    {
        private BD bd;
        private bool Publish;
        private int loginUser;
        private int EmpresaInd;
        private int ObrigacaoClientePeriodo;
        private int ObrigacaoArquivo;

        #region Const
        const string msgFormat = "table[{0}], tr[{1}], td[{2}], a: {3}, b: {4}";

        const string table_pattern = "<table.*?>(.*?)</table>";

        const string tr_pattern = "<tr.*?>(.*?)</tr>";

        const string td_pattern = "<td.*?>(.*?)</td>";

        const string font_pattern = "<font.*?>(.*?)</font>";

        const string b_pattern = "<b.*?>(.*?)</b>";
        #endregion

        #region Strucut Comprovante
        struct Comprovante
        {
            public string documento;
            public DateTime DataCompetencia;
            public DateTime DataArrecadacao;
            public DateTime DataVencimento;
            public string receita;
            public decimal valorPago;
        }
        #endregion

        public DarfPago(BD bd, string Html, int ObrigacaoClientePeriodo, int ObrigacaoArquivo, int EmpresaInd, int loginUser, bool Publish)
        {
            this.bd = bd;
            this.loginUser = loginUser;
            this.Publish = Publish;
            this.EmpresaInd = EmpresaInd;
            this.ObrigacaoClientePeriodo = ObrigacaoClientePeriodo;
            this.ObrigacaoArquivo = ObrigacaoArquivo;

            try
            {
                if (Path.GetExtension(Html).ToLower() == ".html" || Path.GetExtension(Html).ToLower() == ".htm")
                {
                    string htmlString = Wr.Classes.Files.ReadFile(Html);

                    List<string> tableContents = GetContents(htmlString, table_pattern);

                    int Modelo = verificarModelo(tableContents[1]);

                    if (Modelo == 1)
                    {
                        if (!Publish)
                        {
                            validarModelo1(tableContents[1]);
                        }
                        else
                            CapturaDarfsPagos(tableContents[2]);
                    }

                    else
                    {
                        if (Modelo == 2)
                        {
                            if (!Publish)
                            {
                                validarModelo2(tableContents[1]);

                            }
                            else { CapturarComprovate(tableContents[1]); }
                        }
                        else
                            throw new Exception("Formato do arquivo Inválido");
                    }

                }
                else
                    throw new Exception("O arquivo deve estar em formato .Htm");
            }
            catch (Exception ex)
            {
                throw new System.ArgumentException(ex.Message);
            }
        }

        #region Validar
        void validarModelo1(string tableContent)
        {
            List<string> trContents = GetContents(tableContent, tr_pattern);

            List<string> FontContents = GetContents(trContents[0], font_pattern);

            string cnpj = string.Empty;

            try
            {
                cnpj = Regex.Replace(FontContents[2], @"<[^>]*>", string.Empty);
            }
            catch (Exception ex)
            {
                throw new Exception("Formato do arquivo incorreto");
            }

            validarCLiente(cnpj);
        }

        void validarModelo2(string tableContent)
        {
            List<string> trContents = GetContents(tableContent, tr_pattern);

            List<string> td_patterns = GetContents(trContents[3], td_pattern);

            string cnpj = string.Empty;

            try
            {
                cnpj = Regex.Replace(td_patterns[1], @"<[^>]*>", string.Empty);

                cnpj = cnpj.Trim();
            }
            catch (Exception ex)
            {
                throw new Exception("Formato do arquivo incorreto");
            }

            validarCLiente(cnpj);
        }

        public void validarCLiente(string cnpj_cpf)
        {
            int ind = bd.getFieldValueInteger(string.Format("SELECT CLI_IND FROM Clientes WHERE (dbo.fn_trim_cnpj(CLI_CNPJ) = dbo.fn_trim_cnpj('{0}') OR " +
                                                "dbo.fn_trim_cnpj(CLI_CPF) = dbo.fn_trim_cnpj('{0}'))", cnpj_cpf));
            if (ind != EmpresaInd)
            {
                throw new System.ArgumentException("Erro de Validação:<br/>CNPJ ou CPF nos Darfs Pagos não corresponde com o código de empresa");
            }
        }
        #endregion

        #region GetContents
        List<string> GetContents(string input, string pattern)
        {
            MatchCollection matches = Regex.Matches(input, pattern, RegexOptions.Singleline);

            List<string> contents = new List<string>();

            foreach (Match match in matches)

                contents.Add(match.Value);

            return contents;

        }
        #endregion

        private int verificarModelo(string tableContent)
        {
            List<string> trContents = GetContents(tableContent, tr_pattern);
            List<string> FontContents = GetContents(trContents[0], font_pattern);

            if (Regex.Replace(FontContents[0], @"<[^>]*>", string.Empty) == "Comprovante de Arrecadação")
                return 2;

            if (Regex.Replace(FontContents[0], @"<[^>]*>", string.Empty) == "Parâmetros Informados")
                return 1;

            return 3;
        }

        #region Caputra Darfs
        void CapturaDarfsPagos(string tableContent)
        {
            List<string> trContents = GetContents(tableContent, tr_pattern);

            List<Comprovante> Comprovantes = new List<Comprovante>();

            for (int i = 0; i < trContents.Count; i++)
            {
                string trContent = trContents[i];

                List<string> TdContents = GetContents(trContent, td_pattern);

                string tipo = Regex.Replace(TdContents[0], @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", "");

                if (tipo.ToUpper() == "DARF")
                {
                    Comprovante Darf = new Comprovante();

                    Darf.DataArrecadacao = Convert.ToDateTime(Regex.Replace(TdContents[1], @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", ""));
                    Darf.DataVencimento = Convert.ToDateTime(Regex.Replace(TdContents[2], @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", ""));
                    Darf.DataCompetencia = Convert.ToDateTime(Regex.Replace(TdContents[3], @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", ""));
                    Darf.receita = Regex.Replace(TdContents[4], @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", "");
                    Darf.documento = Regex.Replace(TdContents[5], @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", "");
                    Darf.valorPago = decimal.Parse(Regex.Replace(TdContents[6], @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", ""));

                    Comprovantes.Add(Darf);
                }
            }

            GravarDarfsSQL(Comprovantes);
        }

        private void CapturarComprovate(string tableContent)
        {
            List<string> tdContents = GetContents(tableContent, td_pattern);

            List<Comprovante> Comprovantes = new List<Comprovante>();

            Comprovante Darf = new Comprovante();

            for (int linha = 0; linha < tdContents.Count; linha++)
            {
                string tdContent = tdContents[linha];

                if (linha == 1)
                {
                    string tipo = Regex.Replace(tdContent, @"<[^>]*>", string.Empty).Trim().Replace("&nbsp;", "");

                    if (!tipo.ToUpper().Contains("DARF"))
                    {
                        break;
                    }
                }

                if (linha == 7)
                    Darf.DataArrecadacao = Convert.ToDateTime(Regex.Replace(tdContent, @"<[^>]*>", string.Empty).Trim());

                if (linha == 15)
                    Darf.DataVencimento = Convert.ToDateTime(Regex.Replace(tdContent, @"<[^>]*>", string.Empty).Trim());

                if (linha == 13)
                    Darf.DataCompetencia = Convert.ToDateTime(Regex.Replace(tdContent, @"<[^>]*>", string.Empty).Trim());

                if (linha == 18)
                {
                    List<string> b = GetContents(tdContent, b_pattern);

                    Darf.receita = Regex.Replace(b[0], @"<[^>]*>", string.Empty).Trim();
                }

                if (linha == 17)
                    Darf.documento = Regex.Replace(tdContent, @"<[^>]*>", string.Empty).Trim();

                if (linha == 21)
                    Darf.valorPago = decimal.Parse(Regex.Replace(tdContent, @"<[^>]*>", string.Empty).Trim());
            }

            Comprovantes.Add(Darf);

            GravarDarfsSQL(Comprovantes);
        }
        #endregion

        private void GravarDarfsSQL(List<Comprovante> Comprovantes)
        {
            List<int> ListDarfConflito = new List<int>();

            foreach (Comprovante Darf in Comprovantes)
            {
                int darf_ind = 0;

                string s = "SET DATEFORMAT DMY " +
                           "SELECT * FROM Darfs " +
                           "INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = DARF_OBRIGACAOCLIENTEPERIODO " +
                           "WHERE CONVERT(DATE, DARF_PERIODOAPURACAO) = CONVERT(DATE, '{0}') AND " +
                           "DARF_CODIGORECEITA = {1} AND OBRCLIPER_CLIENTE = {2} AND " +
                           "CONVERT(DATE, DARF_VENCIMENTO) = CONVERT(DATE, '{3}') AND " +
                           "CAST((DARF_VALOR + dbo.fn_valor_atualizado_multa(DARF_VALOR, '{3}', '{5}')) AS NUMERIC(15,2)) " +
                           " = REPLACE('{4}', ',', '.')";

                SqlCommand cmd = new SqlCommand(string.Format(s, Darf.DataCompetencia, Darf.receita,
                        EmpresaInd, Darf.DataVencimento, Darf.valorPago, Darf.DataArrecadacao), bd.Conn);

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    darf_ind = Convert.ToInt32(dr["DARF_IND"].ToString());

                    ListDarfConflito.Add(darf_ind);
                }
                dr.Close();

                int status = 0;

                if (ListDarfConflito.Count > 1)
                {
                    status = 2;
                }

                if (ListDarfConflito.Count != 0)
                {
                    status = 1;
                }

                int ind = bd.getFieldValueInteger(string.Format("INSERT INTO DarfsPagos (DARFPAGO_DTA_ARRECADACAO, DARFPAGO_DTA_COMPETENCIA, DARFPAGO_DTA_VENCIMENTO, " +
                                        "DARFPAGO_NUMERO_DOCUMENTO, DARFPAGO_VALOR_TOTAL, DARFPAGO_CODIGO_RECEITA, DARFPAGO_STATUS,  DARFPAGO_OBRIGACAOCLIENTEPERIODO, DARFPAGO_OBRIGACAOARQUIVO) " +
                                        "VALUES ( '{0}', '{1}', '{2}', '{3}', REPLACE('{4}', ',', '.'), {5}, " +
                                        "{6}, {7}, {8}) SELECT @@IDENTITY", Darf.DataArrecadacao, Darf.DataCompetencia, Darf.DataVencimento, Darf.documento,
                                        Darf.valorPago, Darf.receita, status, ObrigacaoClientePeriodo, ObrigacaoArquivo));
                if (status == 1)
                {
                    bd.executeCommand(string.Format("UPDATE Darfs SET DARF_DARFPAGO = {0} WHERE DARF_IND = {1}", ind, darf_ind));
                }

                ListDarfConflito.Clear();
            }
        }
    }
}