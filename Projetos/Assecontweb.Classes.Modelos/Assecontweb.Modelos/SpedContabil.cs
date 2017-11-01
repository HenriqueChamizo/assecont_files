using System;

namespace Assecontweb
{
    namespace Modelos
    {
        public class SpedContabil
        {
            private int empresaId = 0;
            private DateTime dataInicial;
            private DateTime dataFinal;
            private Decimal ativoCirculante = 0;
            private Decimal passivoCirculante = 0;
            private Decimal ativoNaoCirculante = 0;
            private Decimal passivoNaoCirculante = 0;
            private Decimal estoques = 0;
            private Decimal disponibilidades = 0;
            private Decimal ativoRealizavelLongoPrazo = 0;
            private Decimal passivoExigivelLongoPrazo = 0;
            private Decimal patrimonioLiquido = 0;
            private Decimal imobilizados = 0;
            private Decimal duplicatasReceber = 0;
            private Decimal ativoPermanente = 0;
            private Decimal ODRCD = 0;
            private Decimal creditoTributario = 0;
            private Decimal bancos = 0;
            private Decimal bancosVinculados = 0;

            private Decimal receitaLiquidaVendaServico = 0;
            private Decimal bensServicosVendidos = 0;
            private Decimal despesasReceitasOperacionais = 0;
            private Decimal provisaoIr = 0;
            private Decimal provisaoCsll = 0;
            private Decimal provisaoBalanco = 0;
            private Decimal outrasReceitasDespesas = 0;

            private Decimal deducao = 0;
            private Decimal devolucao = 0;
            private Decimal receitaBruta;
            private Decimal depreciacao = 0;
            private Decimal outrasReceitasNaoOperacionais = 0;
            private Decimal outrasDespesasNaoOperacionais = 0;

            public SpedContabil() { }

            //Getters & Setters
            public int getEmpresaId() { return empresaId; }
            public void setEmpresaId(int empresaId) { this.empresaId = empresaId; }

            public DateTime getDataInicial() { return dataInicial; }
            public void setDataInicial(DateTime dataInicial) { this.dataInicial = dataInicial; }

            public DateTime getDataFinal() { return dataFinal; }
            public void setDataFinal(DateTime dataFinal) { this.dataFinal = dataFinal; }

            public Decimal getAtivoCirculante() { return ativoCirculante; }
            public void setAtivoCirculante(Decimal ativoCirculante) { this.ativoCirculante = ativoCirculante; }

            public Decimal getPassivoCirculante() { return passivoCirculante; }
            public void setPassivoCirculante(Decimal passivoCirculante) { this.passivoCirculante = passivoCirculante; }

            public Decimal getAtivoNaoCirculante() { return ativoNaoCirculante; }
            public void setAtivoNaoCirculante(Decimal ativoNaoCirculante) { this.ativoNaoCirculante = ativoNaoCirculante; }

            public Decimal getPassivoNaoCirculante() { return passivoNaoCirculante; }
            public void setPassivoNaoCirculante(Decimal passivoNaoCirculante) { this.passivoNaoCirculante = passivoNaoCirculante; }

            public Decimal getEstoques() { return estoques; }
            public void setEstoques(Decimal estoques) { this.estoques = estoques; }

            public Decimal getDisponibilidades() { return disponibilidades; }
            public void setDisponibilidades(Decimal disponibilidades) { this.disponibilidades = disponibilidades; }

            public Decimal getAtivoRealizavelLongoPrazo() { return ativoRealizavelLongoPrazo; }
            public void setAtivoRealizavelLongoPrazo(Decimal ativoRealizavelLongoPrazo) { this.ativoRealizavelLongoPrazo = ativoRealizavelLongoPrazo; }

            public Decimal getPassivoExigivelLongoPrazo() { return passivoExigivelLongoPrazo; }
            public void setPassivoExigivelLongoPrazo(Decimal passivoExigivelLongoPrazo) { this.passivoExigivelLongoPrazo = passivoExigivelLongoPrazo; }

            public Decimal getPatrimonioLiquido() { return patrimonioLiquido; }
            public void setPatrimonioLiquido(Decimal patrimonioLiquido) { this.patrimonioLiquido = patrimonioLiquido; }

            public Decimal getImobilizados() { return imobilizados; }
            public void setImobilizados(Decimal imobilizados) { this.imobilizados = imobilizados; }

            public Decimal getDuplicatasReceber() { return duplicatasReceber; }
            public void setDuplicatasReceber(Decimal duplicatasReceber) { this.duplicatasReceber = duplicatasReceber; }

            public Decimal getAtivoPermanente() { return ativoPermanente; }
            public void setAtivoPermanente(Decimal ativoPermanente) { this.ativoPermanente = ativoPermanente; }

            public Decimal getODRCD() { return ODRCD; }
            public void setODRCD(Decimal ODRCD) { this.ODRCD = ODRCD; }

            public Decimal getCreditoTributario() { return creditoTributario; }
            public void setCreditoTributario(Decimal creditoTributario) { this.creditoTributario = creditoTributario; }

            public Decimal getBancos() { return bancos; }
            public void setBancos(Decimal bancos) { this.bancos = bancos; }

            public Decimal getBancosVinculados() { return bancosVinculados; }
            public void setBancosVinculados(Decimal bancosVinculados) { this.bancosVinculados = bancosVinculados; }

            public Decimal getReceitaLiquidaVendaServico() { return receitaLiquidaVendaServico; }
            public void setReceitaLiquidaVendaServico(Decimal receitaLiquidaVendaServico) { this.receitaLiquidaVendaServico = receitaLiquidaVendaServico; }

            public Decimal getBensServicosVendidos() { return bensServicosVendidos; }
            public void setBensServicosVendidos(Decimal bensServicosVendidos) { this.bensServicosVendidos = bensServicosVendidos; }

            public Decimal getOutrasDespesasNaoOperacionais() { return outrasDespesasNaoOperacionais; }
            public void setOutrasDespesasNaoOperacionais(Decimal outrasDespesasNaoOperacionais) { this.outrasDespesasNaoOperacionais = outrasDespesasNaoOperacionais; }

            public Decimal getProvisaoIr() { return provisaoIr; }
            public void setProvisaoIr(Decimal provisaoIr) { this.provisaoIr = provisaoIr; }

            public Decimal getProvisaoCsll() { return provisaoCsll; }
            public void setProvisaoCsll(Decimal provisaoCsll) { this.provisaoCsll = provisaoCsll; }

            public Decimal getProvisaoBalanco() { return provisaoBalanco; }
            public void setProvisaoBalanco(Decimal provisaoBalanco) { this.provisaoBalanco = provisaoBalanco; }

            public Decimal getDespesasReceitasOperacionais() { return despesasReceitasOperacionais; }
            public void setDespesasReceitasOperacionais(Decimal despesasReeitasOperacionais) { this.despesasReceitasOperacionais = despesasReeitasOperacionais; }

            public Decimal getOutrasReceitasNaoOperacionais() { return outrasReceitasNaoOperacionais; }
            public void setOutrasReceitasNaoOperacionais(Decimal outrasReceitasNaoOperacionais) { this.outrasReceitasNaoOperacionais = outrasReceitasNaoOperacionais; }

            public Decimal getDeducao() { return deducao; }
            public void setDeducao(Decimal deducao) { this.deducao = deducao; }

            public Decimal getDevolucao() { return devolucao; }
            public void setDevolucao(Decimal devolucao) { this.devolucao = devolucao; }

            public Decimal getReceitaBruta() { return receitaBruta; }
            public void setReceitaBruta(Decimal receitaBruta) { this.receitaBruta = receitaBruta; }

            public Decimal getDepreciacao() { return depreciacao; }
            public void setDepreciacao(Decimal depreciacao) { this.depreciacao = depreciacao; }

            public Decimal getImpostoSobreVendas() { return deducao - devolucao; }

            public Decimal getOutrasReceitasDespesas() { return outrasReceitasDespesas; }
            public void setOutrasReceitasDespesas(Decimal outrasReceitasDespesas) { this.outrasReceitasDespesas = outrasReceitasDespesas; }
        }
    }
}