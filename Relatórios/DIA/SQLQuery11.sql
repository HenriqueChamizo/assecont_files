use ponto4;

--LARGURA#200,100,100#
--TITULO#Total Mensal de Horas Trabalhadas e Banco de Horas#
DECLARE @DATAINICIAL SMALLDATETIME = '01/07/2016',
        @DATAFINAL SMALLDATETIME = '30/07/2016',
        @DEPSELECIONADOIND INT = 1
--DECLARE @DATAINICIAL SMALLDATETIME = %DATAINICIAL%,
--        @DATAFINAL SMALLDATETIME = %DATAFINAL%,
--        @DEPSELECIONADOIND INT = %DEPSELECIONADOIND%

select EMP_NOME as Nome, 
	   --trab.HorasMais as 'Horas Mais', 
	   trab.HorasTrabalhadas as 'Horas Trabalhadas', 
	   banco.HorasPositivas as 'Banco (Mais)', 
	   banco.HorasNegativas as 'Banco (Menos)', 
	   banco.HorasSaldos as 'Banco (Saldo)' 
from Empresas 
outer apply(
    select dbo.fn_minutetohourlong(a.HorasNegativas) as HorasNegativas, 
		   dbo.fn_minutetohourlong(a.HorasPositivas) as HorasPositivas, 
		   dbo.fn_minutetohourlong(a.HorasPositivas + a.HorasNegativas) as HorasSaldos  
	from (
		select sum(case when substring(BCO_VALOR, 1, 1) = '-'
						then -(convert(int, replace(replace(BCO_VALOR, '-', ''), substring(BCO_VALOR, (len(BCO_VALOR) - 3), 3), '')) * 60) 
							 +(convert(int, replace(substring(BCO_VALOR, (len(BCO_VALOR) - 1), 2), '-', '')))
						else 0
					end) as HorasNegativas,
			   sum(case when substring(BCO_VALOR, 1, 1) != '-'
						then (convert(int, replace(BCO_VALOR, substring(BCO_VALOR, (len(BCO_VALOR) - 3), 3), '')) * 60) 
							+(convert(int, substring(BCO_VALOR, (len(BCO_VALOR) - 1), 2)))
						else 0
					end) as HorasPositivas
		from BcoHoras
		inner join Funcionarios on FUNC_IND = BCO_FUNC
		where BCO_DATA >= @DATAINICIAL and BCO_DATA <= @DATAFINAL and
				FUNC_DT_DEM is null and FUNC_EMPRESA = EMP_IND and FUNC_MARCADO_EXCLUSAO = 0
	) a 
)banco
outer apply(
    select dbo.fn_minutetohourlong(a.HorasMenos) as HorasMenos, 
		   dbo.fn_minutetohourlong(a.HorasMais) as HorasMais, 
		   dbo.fn_minutetohourlong(a.HorasTrabalhadas) as HorasTrabalhadas 
	from (
		select sum(case when dbo.fn_smalldatetimetominute(CAL_TRAB) < dbo.fn_smalldatetimetominute(CAL_ATRB)
						then dbo.fn_smalldatetimetominute(CAL_ATRB) - dbo.fn_smalldatetimetominute(CAL_TRAB)
						else 0
			   end) as HorasMenos, 
			   sum(case when dbo.fn_smalldatetimetominute(CAL_TRAB) >= dbo.fn_smalldatetimetominute(CAL_ATRB)
						then dbo.fn_smalldatetimetominute(CAL_EXTRA) + dbo.fn_smalldatetimetominute(CAL_EXTRAF) +
							 dbo.fn_smalldatetimetominute(CAL_EXTRAN) + dbo.fn_smalldatetimetominute(CAL_EXTRANF)
						else 0
			   end) as HorasMais, 
			   sum(dbo.fn_smalldatetimetominute(CAL_TRAB)) as HorasTrabalhadas 
		from Calculo 
		inner join Funcionarios on FUNC_IND = CAL_FUNC
		where CAL_DATA >= @DATAINICIAL and CAL_DATA <= @DATAFINAL 
		AND FUNC_EMPRESA = EMP_IND and FUNC_MARCADO_EXCLUSAO = 0
	) a
)trab
where trab.HorasTrabalhadas is not null