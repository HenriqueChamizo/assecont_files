using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data;
using System.Web;

namespace Assecontweb.Classes.Views
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ServerViewerClass runat=server></{0}:ServerViewerClass>")]

    public class ServerViewerClass : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]

        private bool isCliente;
        private BDApp bd = new BDApp();

        public struct FileViewer
        {
            public string Nome;
            public string Extensao;
            public byte[] Conteudo;
        }

        #region Getters & Setters
        private int _Cliente;
        public int Cliente
        {
            get { return _Cliente; }
            set { _Cliente = value; }
        }

        private Boolean _Recalculo;
        public Boolean Recalculo
        {
            get { return _Recalculo; }
            set { _Recalculo = value; }
        }

        private int _Indice;
        public int Indice
        {
            get { return _Indice; }
            set { _Indice = value; }
        }

        private DateTime _dataPagamento;
        public DateTime dataPagamento
        {
            get { return _dataPagamento; }
            set { _dataPagamento = value; }
        }

        private Types.Types.ViewerArquivoTipo _ArquivoTipo;
        public Types.Types.ViewerArquivoTipo ArquivoTipo
        {
            get { return _ArquivoTipo; }
            set { _ArquivoTipo = value; }
        }

        private bool _ViewCliente;
        public bool ViewCliente
        {
            get { return _ViewCliente; }
            set { _ViewCliente = value; }
        }

        private int _Funcionario;
        public int Funcionario
        {
            get { return _Funcionario; }
            set { _Funcionario = value; }
        }
        #endregion

        public ServerViewerClass()
        { }

        public ServerViewerClass(int Indice, int Cliente, Types.Types.ViewerArquivoTipo ArquivoTipo)
        {
            this.Indice = Indice;
            this.Cliente = Cliente;
            this.ArquivoTipo = ArquivoTipo;
            //this.dataPagamento = dataPagamento;
        }

        protected override void RenderContents(HtmlTextWriter output)
        {
            bd = new BDApp();

            WebControl wc = ViewerUrl();

            isCliente = UserApp.Cliente != 0 && UserApp.UserIdSimulacao == 0;

            UpdateAcesso();

            wc.RenderControl(output);
        }

        #region FileViewer wilder
        public FileViewer ReadFile()
        {
            FileViewer Result = new FileViewer();
            string Sql = "";

            switch (ArquivoTipo)
            {
                case Types.Types.ViewerArquivoTipo.Obrigacao:
                    {
                        // assegurar que o cliente visualize apenas seus arquivos, cliente = 0, Assecont está visualizando
                        if (Indice != 0 && (Cliente == 0 || Cliente == 4554122 /* my client code */ || bd.checkObrigacaoArquivoIsFromCliente(Indice, Cliente)))
                        {
                            if (Cliente == 0 || Cliente == 4554122)
                                Sql = String.Format("SELECT dbo.fn_arquivo_descricao(OBRARQ_IND) AS ARQUIVONOME, OBRARQ_EXTENSAO AS EXTENSAO, OBRARQ_ARQUIVO AS ARQUIVO FROM ObrigacoesArquivos LEFT JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO LEFT JOIN Obrigacoes ON OBR_IND = OBRCLIPER_OBRIGACAO WHERE OBRARQ_IND = {0}", Indice);
                            else
                                Sql = String.Format("SELECT dbo.fn_arquivo_descricao(OBRARQ_IND) AS ARQUIVONOME, OBRARQ_EXTENSAO AS EXTENSAO, OBRARQ_ARQUIVO AS ARQUIVO FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO INNER JOIN Obrigacoes ON OBR_IND = OBRCLIPER_OBRIGACAO WHERE OBRARQ_IND = {0} AND OBRCLIPER_CLIENTE = {1}", Indice, Cliente);

                        }
                    }
                    break;

                case Types.Types.ViewerArquivoTipo.Parcelamento:
                    {
                        Sql = String.Format("SELECT PARCARQ_NOME AS ARQUIVONOME, PARCARQ_EXTENSAO AS EXTENSAO, PARCARQ_ARQUIVO AS ARQUIVO FROM ParcelamentosArquivos WHERE PARCARQ_IND = {0}", Indice);
                        break;
                    }

                case Types.Types.ViewerArquivoTipo.Memorando:
                    {
                        //Sql = String.Format("SELECT OBRMEM_NOME AS ARQUIVONOME, OBRMEM_EXTENSAO AS EXTENSAO, OBRMEM_ARQUIVO AS ARQUIVO FROM ObrigacoesMemorandos WHERE OBRMEM_IND = {0}", Indice);
                        Sql = String.Format("SELECT OBRMEMARQ_NOME AS ARQUIVONOME, OBRMEMARQ_EXTENSAO AS EXTENSAO, OBRMEMARQ_ARQUIVO AS ARQUIVO FROM ObrigacoesMemorandosArquivos WHERE OBRMEMARQ_IND = {0}", Indice);
                        break;
                    }

                case Types.Types.ViewerArquivoTipo.Ocorrencia:
                    {
                        Sql = String.Format("SELECT OCOCLI_NOME AS ARQUIVONOME, OCOCLI_EXTENSAO AS EXTENSAO, OCOCLI_ARQUIVO AS ARQUIVO FROM OcorrenciasClientes WHERE OCOCLI_IND = {0}", Indice);
                        break;
                    }
            }

            if (Sql != "")
            {
                DataTable table = bd.getDataTable(Sql);

                foreach (DataRow reader in table.Rows)
                {
                    Result.Nome = reader["ARQUIVONOME"].ToString().Trim();
                    Result.Extensao = reader["EXTENSAO"].ToString().Trim();

                    if (reader["ARQUIVO"] != DBNull.Value)
                        Result.Conteudo = (byte[])reader["ARQUIVO"];
                }
            }

            return Result;
        }
        #endregion

        #region getModelo wilder
        private Types.Types.ArquivoModelo GetModelo()
        {
            Types.Types.ArquivoModelo Result = Types.Types.ArquivoModelo.Nenhum;

            // assegurar que o cliente visualize apenas seus arquivos, cliente = 0, Assecont está visualizando
            if (Indice != 0 && (Cliente == 0 || bd.checkObrigacaoArquivoIsFromCliente(Indice, Cliente)))
            {
                string Sql = "";

                if (Cliente == 0)
                    Sql = String.Format("SELECT OBR_MODELO, OBRARQ_EXTENSAO, DARF_IND FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO INNER JOIN Obrigacoes ON OBR_IND = OBRCLIPER_OBRIGACAO LEFT JOIN Darfs ON DARF_OBRIGACAOARQUIVO = OBRARQ_IND WHERE OBRARQ_IND = {0}", Indice);
                else
                    Sql = String.Format("SELECT OBR_MODELO, OBRARQ_EXTENSAO, DARF_IND FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO INNER JOIN Obrigacoes ON OBR_IND = OBRCLIPER_OBRIGACAO LEFT JOIN Darfs ON DARF_OBRIGACAOARQUIVO = OBRARQ_IND WHERE OBRARQ_IND = {0} AND OBRCLIPER_CLIENTE = {1}", Indice, Cliente);

                DataTable table = bd.getDataTable(Sql);

                foreach (DataRow reader in table.Rows)
                {
                    if (reader["OBRARQ_EXTENSAO"].ToString().ToLower().Trim() == "pdf")
                        Result = Types.Types.ArquivoModelo.Default;
                    else
                        Result = (Types.Types.ArquivoModelo)Convert.ToInt32(reader["OBR_MODELO"]);
                }
            }

            return Result;
        }
        #endregion

        public WebControl ViewerUrl()
        {
            if (HttpContext.Current.Request.QueryString["forceview"] == "1")
            {
                ServerPdf a = new ServerPdf();
                a.Cliente = Cliente;
                a.Indice = Indice;

                return a;
            }
            else
            {
                switch (GetModelo())
                {
                    case Types.Types.ArquivoModelo.Holerite:
                        {
                            Types.Types.HoleritesTipos tipo = (Types.Types.HoleritesTipos)GetHoleriteTipoObrigacaoClientePeriodoIndice();

                            int iMes;
                            int iAno;

                            if (tipo == Types.Types.HoleritesTipos.Abono || tipo == Types.Types.HoleritesTipos.PRL)
                            {
                                iMes = GetMesVencimentoObrigacaoClientePeriodoIndice();
                                iAno = GetAnoVencimentoObrigacaoClientePeriodoIndice();
                            }
                            else
                            {
                                iMes = GetMesObrigacaoClientePeriodoIndice();
                                iAno = GetAnoObrigacaoClientePeriodoIndice();
                            }

                            ServerHolerite hole = new ServerHolerite();

                            hole.Mes = iMes;
                            hole.Ano = iAno;
                            hole.HoleriteTipo = (int)tipo;

                            if (Funcionario <= 0)
                                hole.Cliente = Cliente;
                            else if (Funcionario > 0 && ViewCliente)
                            {
                                hole.Funcionario = Funcionario;
                                hole.Cliente = Cliente;
                            }
                            else
                                hole.Funcionario = Funcionario;

                            return hole;
                        }

                    case Types.Types.ArquivoModelo.Gps:
                        {
                            ServerGps gps = new ServerGps();
                            gps.Cliente = Cliente;
                            gps.Gps = GetDarfIndice();
                            gps.Recalculo = Recalculo;
                            gps.dataPagamento = dataPagamento;

                            return gps;
                        }

                    case Types.Types.ArquivoModelo.Darf:
                    case Types.Types.ArquivoModelo.DarfHtml:
                        {
                            ServerDarf darf = new ServerDarf();
                            darf.Cliente = Cliente;
                            darf.Darf = GetDarfIndice();
                            darf.Recalculo = Recalculo;
                            darf.dataPagamento = dataPagamento;

                            return darf;
                        }

                    case Types.Types.ArquivoModelo.InformeRendimentoFuncionario:
                        //case Types.Types.ArquivoModelo.InformeRendimentoSocio:
                        {
                            ServerInformeRedimento info = new ServerInformeRedimento();
                            info.ObrigacaoArquivo = Indice;
                            info.Funcionario = Funcionario;

                            return info;

                            //return new ServerDarf();
                        }

                    case Types.Types.ArquivoModelo.DarfPago:
                        {
                            if (isCliente)
                                Page.Response.Redirect(string.Format("http://www.assecont.com.br/assecontwebnovo/App/Cliente/DarfsPagos.aspx?ind={0}&cli={1}", Indice, Cliente));
                            else
                                Page.Response.Redirect(string.Format("http://www.assecont.com.br/assecontwebnovo/App/Obrigacoes/DarfsPagos.aspx?ind={0}&cli={1}", Indice, Cliente));

                            return null;
                        }

                    //case Types.Types.ArquivoModelo.SpedFiscal:
                    //    {
                    //if (ViewCliente)
                    //{
                    //    ServerSpedFiscalClientes spedCli = new ServerSpedFiscalClientes();
                    //    spedCli.Ano = GetAnoObrigacaoClientePeriodoIndice();
                    //    spedCli.Mes = GetMesObrigacaoClientePeriodoIndice();
                    //    spedCli.Cliente = Cliente;
                    //    spedCli.NotaFiscalTipo = NotaFiscalTipo;
                    //    return spedCli;
                    //}
                    //else
                    //{
                    //        ServerSpedFiscal spedProduto = new ServerSpedFiscal();
                    //        spedProduto.Ano = GetAnoObrigacaoClientePeriodoIndice();
                    //        spedProduto.Mes = GetMesObrigacaoClientePeriodoIndice();
                    //        spedProduto.Cliente = Cliente;
                    //        spedProduto.NotaFiscalTipo = NotaFiscalTipo;

                    //        return spedProduto;
                    //    }
                    //}
                    default:
                        {
                            ServerPdf a = new ServerPdf();
                            if (Indice > 0)
                            {
                                a.Cliente = Cliente;
                                a.Indice = Indice;
                                a.ArquivoTipo = ArquivoTipo;
                                return a;
                            }

                            return null;
                        }
                }
            }
        }

        #region gets wilder
        private int GetDarfIndice()
        {
            return String.IsNullOrEmpty(HttpContext.Current.Request["darf"]) ? bd.getFieldValueInteger(String.Format("SELECT DARF_IND FROM Darfs WHERE DARF_OBRIGACAOARQUIVO = {0}", Indice)) : Convert.ToInt32(HttpContext.Current.Request["darf"]);
        }

        private int GetObrigacaoClientePeriodoIndice()
        {
            return bd.getFieldValueInteger(String.Format("SELECT OBRARQ_OBRIGACAOCLIENTEPERIODO FROM ObrigacoesArquivos WHERE OBRARQ_IND = {0}", Indice));
        }

        private int GetMesObrigacaoClientePeriodoIndice()
        {
            return bd.getFieldValueInteger(String.Format("SELECT OBRCLIPER_MES_FINAL FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO WHERE OBRARQ_IND = {0}", Indice));
        }

        private int GetAnoObrigacaoClientePeriodoIndice()
        {
            return bd.getFieldValueInteger(String.Format("SELECT OBRCLIPER_ANO FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO WHERE OBRARQ_IND = {0}", Indice));
        }

        private int GetMesVencimentoObrigacaoClientePeriodoIndice()
        {
            return bd.getFieldValueInteger(String.Format("SELECT MONTH(OBRCLIPER_PRAZO_OU_VENCIMENTO) FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO WHERE OBRARQ_IND = {0}", Indice));
        }

        private int GetAnoVencimentoObrigacaoClientePeriodoIndice()
        {
            return bd.getFieldValueInteger(String.Format("SELECT YEAR(OBRCLIPER_PRAZO_OU_VENCIMENTO) FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO WHERE OBRARQ_IND = {0}", Indice));
        }

        private int GetHoleriteTipoObrigacaoClientePeriodoIndice()
        {
            return bd.getFieldValueInteger(String.Format("SELECT (CASE WHEN CHARINDEX('13', OBRCLIPER_PARCELADESCRICAO) > 0 AND OBRCLIPER_PARCELA = 1 THEN {1} WHEN CHARINDEX('13', OBRCLIPER_PARCELADESCRICAO) > 0 AND OBRCLIPER_PARCELA = 2 THEN {2} ELSE OBR_HOLERITE_TIPO END) FROM ObrigacoesArquivos INNER JOIN ObrigacoesClientesPeriodos ON OBRCLIPER_IND = OBRARQ_OBRIGACAOCLIENTEPERIODO INNER JOIN Obrigacoes ON OBR_IND = OBRCLIPER_OBRIGACAO WHERE OBRARQ_IND = {0}", Indice, (int)Assecontweb.Types.Types.HoleritesTipos.Salario131, (int)Assecontweb.Types.Types.HoleritesTipos.Salario132));
        }

        private int GetCliente()
        {
            return String.IsNullOrEmpty(HttpContext.Current.Request["cli"]) ? bd.getFieldValueInteger(String.Format("SELECT OBRCLIPER_CLIENTE FROM ObrigacoesClientesPeriodos INNER JOIN ObrigacoesArquivos ON OBRARQ_OBRIGACAOCLIENTEPERIODO = OBRCLIPER_IND WHERE OBRARQ_IND = {0}", Indice)) : -666;
        }

        public void UpdateAcesso()
        {
            bd.updateObrigacaoArquivoAcessoPor(Indice, !isCliente);
        }
        #endregion
    }
}