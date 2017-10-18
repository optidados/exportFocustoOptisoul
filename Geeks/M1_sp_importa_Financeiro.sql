
ALTER  procedure M1_sp_importa_Financeiro as

set nocount off--on

INSERT INTO Optisoul..FinanceiroPlanoConta
(PaiCodigo,Tradutor,Apelido,Descricao,Classificacao,Ativo,FluxodeCaixa
,DataVigenciaInicial,SPEDCodigoReferencial,Caminho,Fator)

Select * from (
Select 
'33' PaiCodigo
,'5.0.0.00.00.00004' Tradutor
,'ImpPagar' Apelido
,'Importacao Despesas' Descricao
,'DESPESA' Classificacao
,1 Ativo
,0 FluxodeCaixa
,'15/07/2016' DataVigenciaInicial
,0 SPEDCodigoReferencial
,'DESPESAS' Caminho
,1 Fator
union 
Select 
'25' PaiCodigo
,'4.0.0.00.00.00004' Tradutor
,'ImpReceber' Apelido
,'Importacao Receitas' Descricao
,'RECEITA' Classificacao
,1 Ativo
,0 FluxodeCaixa
,'15/07/2016' DataVigenciaInicial
,0 SPEDCodigoReferencial
,' RECEITAS' Caminho
,1 Fator
union 
Select 
'2' PaiCodigo
,'1.1.0.00.00.00008' Tradutor
,'ImpTransf' Apelido
,'Importacao Transferencias' Descricao
,null Classificacao
,1 Ativo
,0 FluxodeCaixa
,'15/07/2016' DataVigenciaInicial
,0 SPEDCodigoReferencial
,' CAIXAS -> ATIVO' Caminho
,1 Fator
) ss where not exists (Select 1 from Optisoul..FinanceiroPlanoConta where ss.Apelido=FinanceiroPlanoConta.Apelido)


begin --Contatos Ok
 
 	Insert into Optisoul..ContatoGrupo (CodigoContato,Descricao)
	Select CodigoContato,'Emitente' From Optisoul..Contato c where Codigoantigo  like 'emp.%' and
	not exists (Select 1 from Optisoul..ContatoGrupo cg where cg.CodigoContato=c.CodigoContato and cg.Descricao='Emitente')

end 

begin 
	--Select * from FinanceiroPlanoConta
	--Select * from Conti5

	INSERT INTO Optisoul..FinanceiroPlanoConta
			   ([PaiCodigo]
			   ,[Apelido]
			   ,[Descricao]
			   ,[Classificacao]
			   ,[Ativo]
			   ,[FluxodeCaixa]
			   ,[DataVigenciaInicial]
			   ,[Fator])

	Select 2 PaiCod
		,[Codice Filiale] Apelido
		,Nome + ' - ' + Filiale Descricao
		,'CAIXA' Classificacao
		,1 Ativo
		,1 FluxodeCaixa
		,cast(getdate() as date) DataVigenciaInicial
		,1 Fator
	from Conti5  c5 where not exists (Select 1 from Optisoul..FinanceiroPlanoConta p where p.Apelido=c5.[Codice Filiale]) 

	insert into ImportacaoLog (banco,Nregistros,tabela)
	select DB_NAME() ,(select count(*) from FinanceiroPlanoConta) ,'FinanceiroPlanoConta'
end 

--Contas a Pagar e Receber
begin

	truncate table Optisoul..FinanceiroTitulo 
	Alter Table Optisoul..FinanceiroTitulo DISABLE TRIGGER [FinanceiroTitulo_Update]
	Alter Table Optisoul..FinanceiroTitulo DISABLE TRIGGER [FinanceiroTitulo_Delete]
	Alter Table Optisoul..FinanceiroTitulo DISABLE TRIGGER [LancaMovimentacaoAutomatica]
	Alter Table Optisoul..FinanceiroMovimentacao Disable Trigger FinanceiroMovimentacao_Consolidado

	Declare @CodigoFinanceiroPlanoContaPagar int = (select top 1 CodigoFinanceiroPlanoConta from Optisoul..FinanceiroPlanoConta where Apelido='ImpPagar')
	Declare @CodigoFinanceiroPlanoContaReceber int = (select top 1 CodigoFinanceiroPlanoConta from Optisoul..FinanceiroPlanoConta where Apelido='ImpReceber')
	Declare @CodigoFinanceiroPlanoContaTransf int = (Select top 1 CodigoFinanceiroPlanoConta from Optisoul..FinanceiroPlanoConta where apelido='ImpTransf')

	INSERT INTO Optisoul..FinanceiroTitulo
			   (CodigoEmpresa
			   ,CodigoContato
			   ,CodigoFinanceiroPlanoConta
			   ,DataEmissao
			   ,DataCompetencia
			   ,DataVencimento
			   ,DataPagamento
			   ,DataVencimentoOriginal
			   ,Valor
			   ,ValorRealizado
			   ,ValorProtesto
			   ,TipoJuros
			   ,JurosPorValor
			   ,CalculoTipoJuros
			   ,ValorTotalJuros
			   ,PercentualJuros
			   ,PercentualDesconto
			   ,ValorDesconto
			   ,Parcela
			   ,Descricao
			   ,ReceberPagar
			   ,ValorJurosaoDia
			   ,ValorOriginal
			   ,ValorTotal
			   ,ValoraRealizar
			   ,ValorJuros
			   ,ValorAcrescimo
			   ,ValorMulta
			   ,PercentualMulta
			   ,Automatico
			   ,FinanceiroMovimentacaoCodigoAgrupamento
			   ,Observacao
			   ,DocumentoCodigo
	           ,DocumentoTipo
			   ,CodigoParcelaAntigo			
			   ,CodigoParcelaClienteAntigo	
			   ,CodigoMovimentacaoAntigo		
			   ,CodigoMovimentoAntigo
			   )
     
	Select isnull(m_c.CodigoContato,0)   CodigoEmpresa
		  ,coalesce(cl.CodigoContato,fo.CodigoContato,m_c.CodigoContato) CodigoContato	  
		  ,Case When m.[Importo] > 0 
		  then @CodigoFinanceiroPlanoContaReceber 
		  else @CodigoFinanceiroPlanoContaPagar 
		  end CodigoFinanceiroPlanoConta

		,coalesce( cast(fc.Data as date)  ,  cast(f.Data as date)  ,  cast(m.Data as date) )  DataEmissao
		,coalesce( cast(fc.Data as date)  ,  cast(f.Data as date)  ,  cast(m.Data as date) )  DataCompetencia	
		,coalesce( cast(rc.Data as date)  ,  cast(r.Data as date)  ,  cast(m.Data as date) )  DataVencimento	
		,cast(m.Data as date) DataPagamento
		,coalesce( cast(rc.Data as date)  ,  cast(r.Data as date)  ,  cast(m.Data as date) )  DataVencimentoOriginal	

		  ,abs(m.[Importo]) Valor
		  ,abs(m.[Importo])  ValorRealizado
		  ,0 ValorProtesto
		  ,'D' TipoJuros
		  ,0 JurosPorValor
		  ,0 CalculoTipoJuros
		  ,0 ValorTotalJuros
		  ,0 PercentualJuros
		  ,0 PercentualDesconto
		  ,0 ValorDesconto
		  ,coalesce(rc.[Numero rata] ,r.[Numero rata] ,0) Parcela
		  ,'MovimentoConti.' + isnull(m.[Codice PrimaNota],' ') Descricao
		  ,Case When m.[Importo] > 0 then 1	else 0 end ReceberPagar
		  ,0 ValorJurosaoDia
		  ,abs(m.[Importo]) ValorOriginal
		  ,abs(m.[Importo]) ValorTotal
		  ,abs(m.[Importo]) ValoraRealizar
		  ,0 ValorJuros
		  ,0 ValorAcrescimo
		  ,0 ValorMulta
		  ,0 PercentualMulta
		  ,0 Automatico
		  ,m.Codice + 100000 FinanceiroMovimentacaoCodigoAgrupamento
		  ,'Primanot.' + isnull(pn.[Codice filiale],' ') Observacao

		  ,D.CodigoDocumento DocumentoCodigo
	      ,'MovimentoC' DocumentoTipo
		  ,r.[Codice filiale]  CodigoParcelaAntigo			
		  ,rc.[Codice filiale] CodigoParcelaClienteAntigo	
		  ,pn.[Codice filiale] CodigoMovimentacaoAntigo		
		  ,m.[Codice filiale]  CodigoMovimentoAntigo		

		 from MovimentoConti M left join
		 Primanot pn on m.[Codice PrimaNota] = pn.[Codice filiale] left join 
		 rata r on r.[Codice filiale] = pn.[Codice rata] left join 		
		 Fattura F on f.[Codice filiale]= r.[Codice fattura] left join 
		 optisoul..Contato fo on 'Fornitor.' + F.[codice fornitore] = fo.CodigoAntigo left join
		 rataclienti rc on rc.[Codice filiale] = pn.[Codice rata cliente] left join
		 FatturaClienti fc on fc.[Codice filiale]= rc.[Codice fattura] left join  --FatturaClienti Fc
		 optisoul..Contato cl on 'Clienti.' + fc.[codice fornitore] = cl.CodigoAntigo left join
		 Conti5 m_ct on m.[Codice Conto] = m_ct.[Codice filiale]  left join
		 optisoul..Contato m_C on m_C.CodigoAntigo = 'sede.' + m_ct.Filiale 
		 left join optisoul..Documento D on D.CodigoAntigo = 'scar.' + M.[Codice filiale] 
		 where
		 isnull(pn.[Tipo Controparte],'') <> 'Transferência' and isnull(m.[Codice PrimaNota],'')  <> '' -- Transferência
		 and coalesce(fc.[data],'1990-01-02')  > '1990-01-01'
		 and coalesce(f.[data], '1990-01-02')  > '1990-01-01'
		 and coalesce(m.[data], '1990-01-02')  > '1990-01-01'
		 and coalesce(r.[data], '1990-01-02')  > '1990-01-01'
		 and coalesce(rc.[data],'1990-01-02')  > '1990-01-01'
         and M.Categoria not like 'Vendas em Dinheiro do%'  -- não importa pois eta agrupado todas as 
														    -- vendas em dinheiro de um determinado dia





--  aqui faz a importacao das vendas em dinheiro, desagrupando por documento
declare @DataEx as date, @CodigoClienteEx as varchar(100), @ValorEx numeric(18,2)
      , @CodigoContaEx as varchar(100), @Codigofilial as varchar(100),  @CodigoMovimento as varchar(100)
declare Xcursor1 cursor fast_forward local for

Select data, [Codice filiale], [Codice PrimaNota] From movimentoconti 
where Categoria like 'Vendas em Dinheiro do%' order by cast(data as date)

open Xcursor1;
fetch next from Xcursor1 into @DataEx, @Codigofilial, @CodigoMovimento
while @@fetch_status = 0 begin

			declare Xcursor2 cursor fast_forward local for
			-- select * from transdet where tipo = 'Dinheiro'
			Select [Codice cliente], Totale From Transdet 
			where cast(data as date) = cast(@DataEx as date) and Tipo = 'Dinheiro'
 			
			open Xcursor2;
			fetch next from Xcursor2 into @CodigoClienteEx, @ValorEx
			while @@fetch_status = 0 begin


              begin

			INSERT INTO Optisoul..FinanceiroTitulo
					   (CodigoEmpresa
					   ,CodigoContato
					   ,CodigoFinanceiroPlanoConta
					   ,DataEmissao
					   ,DataCompetencia
					   ,DataVencimento
					   ,DataPagamento
					   ,DataVencimentoOriginal
					   ,Valor
					   ,ValorRealizado
					   ,ValorProtesto
					   ,TipoJuros
					   ,JurosPorValor
					   ,CalculoTipoJuros
					   ,ValorTotalJuros
					   ,PercentualJuros
					   ,PercentualDesconto
					   ,ValorDesconto
					   ,Parcela
					   ,Descricao
					   ,ReceberPagar
					   ,ValorJurosaoDia
					   ,ValorOriginal
					   ,ValorTotal
					   ,ValoraRealizar
					   ,ValorJuros
					   ,ValorAcrescimo
					   ,ValorMulta
					   ,PercentualMulta
					   ,Automatico
					   ,FinanceiroMovimentacaoCodigoAgrupamento
					   ,Observacao
					   ,DocumentoCodigo
					   ,DocumentoTipo
					   --,CodigoParcelaAntigo			
					   --,CodigoParcelaClienteAntigo	
					   --,CodigoMovimentacaoAntigo		
					   --,CodigoMovimentoAntigo
					   )
	             Select 
					D.CodigoEmpresa   CodigoEmpresa
					,D.CodigoContato CodigoContato	  
					,Case When @ValorEx > 0 
						then @CodigoFinanceiroPlanoContaReceber 
						else @CodigoFinanceiroPlanoContaPagar 
					 end CodigoFinanceiroPlanoConta
					,D.DataHoraEmissao as  DataEmissao
					,D.DataHoraEmissao as  DataCompetencia
					,D.DataHoraEmissao as  DataVencimento
					,D.DataHoraEmissao as  DataVencimentoOriginal
					,D.DataHoraEmissao as  DataPagamento

					,abs(@ValorEx) Valor
					,abs(@ValorEx)  ValorRealizado
					,0 ValorProtesto
					,'D' TipoJuros
					,0 JurosPorValor
					,0 CalculoTipoJuros
					,0 ValorTotalJuros
					,0 PercentualJuros
					,0 PercentualDesconto
					,0 ValorDesconto
					,0 Parcela
					,'MovimentoConti.'  + isnull(@Codigofilial,' ') Descricao
					,1 ReceberPagar
					,0 ValorJurosaoDia
					,abs(@ValorEx) ValorOriginal
					,abs(@ValorEx) ValorTotal
					,abs(@ValorEx) ValoraRealizar
					,0 ValorJuros
					,0 ValorAcrescimo
					,0 ValorMulta
					,0 PercentualMulta
					,0 Automatico
					,D.CodigoDocumento + 110000 FinanceiroMovimentacaoCodigoAgrupamento
					,'MovimentoConti.'  + isnull(@CodigoMovimento,' ') Observacao
		        --  ,m.CodigoFilial DocumentoCodigo
		            ,D.CodigoDocumento DocumentoCodigo
	                ,'Venda' DocumentoTipo
				  --,r.CodigoFilial  CodigoParcelaAntigo			
				  --,rc.CodigoFilial CodigoParcelaClienteAntigo	
				  --,pn.CodigoFilial CodigoMovimentacaoAntigo		
				  --,m.CodigoFilial  CodigoMovimentoAntigo		

                   from documento D where codigodocumento =                   
				   (select codigodocumento from documentoitem where codigoantigo =
				   (select ('scar2.' + [Codice filiale]) from storicocarrello where
				   data =  @DataEx and  @CodigoClienteEx = [Codice cliente] and total = @ValorEx))
              end 

			fetch next from Xcursor2 into @CodigoClienteEx, @ValorEx
			end
			
			close Xcursor2;
			deallocate Xcursor2;


        
	fetch next from Xcursor1 into @DataEx, @Codigofilial, @CodigoMovimento

end

close Xcursor1;
deallocate Xcursor1;
		 
		 Update RataClienti Set ValorPago = 0
		 Update RataClienti Set ValorPago = ss.Valor
		 From (
		     Select sum(Valor) Valor,isnull(CodigoParcelaClienteAntigo,'') CodigoParcelaCliente from optisoul..FinanceiroTitulo group by CodigoParcelaClienteAntigo
		 ) ss
		 where RataClienti.[Codice filiale]= ss.CodigoParcelaCliente
 
 		Update Rata Set ValorPago = 0
		Update Rata Set ValorPago = ss.Valor
		From (
			Select sum(Valor) Valor,isnull(CodigoParcelaAntigo,'') CodigoParcela from  optisoul..FinanceiroTitulo group by CodigoParcelaAntigo
		) ss
		where Rata.[Codice filiale]= ss.CodigoParcela

		INSERT INTO Optisoul..FinanceiroTitulo
			   (CodigoEmpresa
			   ,CodigoContato
			   ,CodigoFinanceiroPlanoConta
			   ,DataEmissao
			   ,DataCompetencia
			   ,DataVencimento
			   ,DataPagamento
			   ,DataVencimentoOriginal
			   ,Valor
			   ,ValorRealizado
			   ,ValorProtesto
			   ,TipoJuros
			   ,JurosPorValor
			   ,CalculoTipoJuros
			   ,ValorTotalJuros
			   ,PercentualJuros
			   ,PercentualDesconto
			   ,ValorDesconto
			   ,Parcela
			   ,ReceberPagar
			   ,ValorJurosaoDia
			   ,ValorOriginal
			   ,ValorTotal
			   ,ValoraRealizar
			   ,ValorJuros
			   ,ValorAcrescimo
			   ,ValorMulta
			   ,PercentualMulta
			   ,Automatico
			   ,CodigoAntigo
			   ,Observacao
			   ,DocumentoCodigo
	           ,DocumentoTipo
			   ,CodigoParcelaAntigo			
			   ,CodigoParcelaClienteAntigo
			   ,Descricao	
			   )
     
	
	Select r.CodigoEmpresa
		  ,r.CodigoContato	  
		  ,Case When Tipo='RC'
		  then @CodigoFinanceiroPlanoContaReceber 
		  else @CodigoFinanceiroPlanoContaPagar 
		  end CodigoFinanceiroPlanoConta  
		  ,fData DataEmissao
		  ,fData DataCompetencia
		  ,r.Data DataVencimento
		  ,Null   DataPagamento
		  ,r.Data DataVencimentoOriginal
		  ,r.ValorTitulo Valor
		  ,0 ValorRealizado
		  ,0 ValorProtesto
		  ,'D' TipoJuros
		  ,0 JurosPorValor
		  ,0 CalculoTipoJuros
		  ,0 ValorTotalJuros
		  ,0 PercentualJuros
		  ,0 PercentualDesconto
		  ,0 ValorDesconto
		  ,r.[Numero rata] Parcela
		  ,Case When Tipo='RC' then 1 else 0  end  ReceberPagar
		  ,0 ValorJurosaoDia
		  ,r.ValorTitulo  ValorOriginal
		  ,r.ValorTitulo ValorTotal
		  ,r.ValorTitulo ValoraRealizar
		  ,0 ValorJuros
		  ,0 ValorAcrescimo
		  ,0 ValorMulta
		  ,0 PercentualMulta
		  ,0 Automatico
		  ,r.[Codice filiale] CodigoAntigo
		  ,r.Categoria
		  ,r.DocumentoCodigoX DocumentoCodigo
	      ,r.DocumentoTipoX DocumentoTipo
		  ,CodigoParcelaAntigo			
		  ,CodigoParcelaClienteAntigo	
		  ,Descricao
		 from 
		 ( Select 
		       c.CodigoContato CodigoEmpresa 
			   ,isnull(fo.CodigoContato,c.CodigoContato) CodigoContato
			   ,f.Data FData
			   ,r.Data ,r.[Numero rata] , r.[Codice filiale] , f.Categoria
			   ,'R' Tipo,
			  Case When Pagato='Sim' then 0  --Renegociação
			  else [Importo Rata]-ValorPago 
			  end ValorTitulo
			  ,r.[Codice filiale] + '_Parcela' ObsX 
			  ,r.[Codice filiale] DocumentoCodigoX
			  ,'Parcela' DocumentoTipoX
			  ,r.[Codice filiale]  CodigoParcelaAntigo			
			  ,'' CodigoParcelaClienteAntigo
			  ,'Rata.' + isnull(r.[Codice filiale],' ') 	descricao
			  from Rata R inner join
			  optisoul..Contato C on c.CodigoAntigo =  'Sede.' + R.Filiale inner join 
			  Fattura F on f.[Codice filiale]= r.[Codice fattura] left join 
			  optisoul..Contato fo on 'Fornitor.' + F.[codice fornitore] = fo.CodigoAntigo --left join 
		      where r.ValorPago < r.[Importo Rata]    --Parte em Aberto
          union all
		   Select 
		       c.CodigoContato CodigoEmpresa 
		       ,isnull(cl.CodigoContato,c.CodigoContato) CodigoContato
			   ,f.Data FData
		       ,r.Data ,r.[Numero rata] , r.[Codice filiale] , f.Categoria
			   , 'RC' Tipo, 
    		   Case When Pagato='Sim' then 0  --Renegociação
	    		 else [Importo Rata]-ValorPago 
			     end ValorTitulo
			   ,r.[Codice filiale] + '_Parcela' ObsX 
			   ,D.CodigoDocumento DocumentoCodigoX
			   ,'ParcelaCliente' DocumentoTipoX
			   ,''  CodigoParcelaAntigo			
		       ,r.[Codice filiale] CodigoParcelaClienteAntigo	
			   ,'Rata.' + isnull(r.[Codice filiale],' ') 	descricao
	       from RataClienti R inner join 
		   optisoul..Contato C on c.CodigoAntigo =  'Sede.' + R.Filiale inner join 
		   FatturaClienti F on f.[Codice filiale]= r.[Codice fattura] left join 
		   optisoul..Contato cl on +'Clienti.' + F.[codice fornitore] = cl.CodigoAntigo left join
           optisoul..Documento D  on D.PedidoAnt = 'scar.' + R.[Codice prima nota] 


		   where r.ValorPago < R.[Importo Rata]    --Parte em Aberto
		   and not r.data is null
		 ) R 
	
	insert into ImportacaoLog (banco,Nregistros,tabela)
	select DB_NAME() ,(select count(*) from FinanceiroTitulo) ,'FinanceiroTitulo'
end 
truncate table Optisoul..FinanceiroMovimentacao

-- insert no financeiromovimentacao das vendas em dinheiro desagrupando por documento
-- aqui
declare @CodigoFinanceiroPlanoConta as varchar(100)
declare Xcursor1 cursor fast_forward local for

Select data, [Codice Conto] , CodigoFilial, CodigoMovimento  From movimentoconti 
where Categoria like 'Vendas em Dinheiro do%' order by cast(data as date)

open Xcursor1;
fetch next from Xcursor1 into @DataEx, @CodigoContaEx ,@CodigoFilial, @CodigoMovimento
while @@fetch_status = 0 begin

            select @CodigoFinanceiroPlanoConta = CodigoFinanceiroPlanoConta from FinanceiroPlanoConta where apelido = @CodigoContaEx 

			declare Xcursor2 cursor fast_forward local for
			-- select * from transdet where tipo = 'Dinheiro'
			Select CodigoCliente, Total From Transdet 
			where cast(data as date) = cast(@DataEx as date) and Tipo = 'Dinheiro'
 			
			open Xcursor2;
			fetch next from Xcursor2 into @CodigoClienteEx, @ValorEx
			while @@fetch_status = 0 begin

            begin

			INSERT INTO FinanceiroMovimentacao
           (CodigoFinanceiroMovimentacaoN
           ,CodigoEmpresa
           ,CodigoContato
           ,CodigoFinanceiroPlanoConta
           ,CodigoFinanceiroCentroCusto
           ,Ordem
           ,DataCompetencia
           ,DataEmissao
           ,DataVencimento
           ,DataMovimento
           ,ValorDebito
           ,ValorCredito
           ,ValorSaldo
           ,Descricao
           ,Observacao
           ,DocumentoTipo
           ,DocumentoCodigo
           ,CodigoFinanceiroTitulo
           ,Automatico
           ,Liquidando
		   --,TituloCodigoAntigo
		   --,CodigoAntigo
		   --,MovimentacaoCodigoAntigo
		   )
-- select * from documento 
Select 
			 D.CodigoDocumento + 110000 CodigoFinanceiroMovimentacaoN
			,D.CodigoEmpresa   CodigoEmpresa
			,D.CodigoContato CodigoContato	  
			,Case When @ValorEx > 0 then cast(@CodigoFinanceiroPlanoConta as int) else 22 end CodigoFinanceiroPlanoConta 
			,0 CodigoFinanceiroCentroCusto
			,0 Ordem
			,D.DataHoraEmissao as  DataCompetencia
			,D.DataHoraEmissao as  DataEmissao
			,D.DataHoraEmissao as  DataVencimento
			,D.DataHoraEmissao as  DataPagamento
			,IsNull(abs(@ValorEx),0) ValorDebito
			,0 ValorCredito
			,0 ValorSaldo
            ,'MovimentoConti.'  + isnull(@CodigoMovimento,' ') Descricao
            ,'MovimentoConti.'  + isnull(@Codigofilial,' ') Observacao
			,'Venda' DocumentoTipo
			,D.CodigoDocumento DocumentoCodigo
			,(select codigofinanceirotitulo from financeirotitulo where DocumentoCodigo = D.CodigoDocumento and valor = @ValorEx) CodigoFinanceiroTitulo
			,0 Automatico
			,0 Liquidando
			----,'x' TituloCodigoAntigo
			--,m.CodigoFilial 
			--,m.CodigoMovimento MovimentacaoCodigoAntigo

                   from documento D where d.tipo = 'Venda' and 
				   codigodocumento =                   
				   (select codigodocumento from documentoitem where codigoantigo =
				           (select ('scar2.' + codigofilial) from storicocarrello where
				            data =  @DataEx and  @CodigoClienteEx = [Codice cliente] and total = @ValorEx))

union all

Select 
			 D.CodigoDocumento + 110000 CodigoFinanceiroMovimentacaoN
			,D.CodigoEmpresa   CodigoEmpresa
			,D.CodigoContato CodigoContato	  
			,Case When @ValorEx > 0 then 12 else cast(@CodigoFinanceiroPlanoConta as int) end CodigoFinanceiroPlanoConta 
			,0 CodigoFinanceiroCentroCusto
			,0 Ordem
			,D.DataHoraEmissao as  DataCompetencia
			,D.DataHoraEmissao as  DataEmissao
			,D.DataHoraEmissao as  DataVencimento
			,D.DataHoraEmissao as  DataPagamento
			,0 ValorDebito
			,IsNull(abs(@ValorEx),0) ValorCredito
			,0 ValorSaldo
            ,'MovimentoConti.'  + isnull(@CodigoMovimento,' ') Descricao
            ,'MovimentoConti.'  + isnull(@Codigofilial,' ') Observacao
			,'Venda' DocumentoTipo
			,D.CodigoDocumento DocumentoCodigo
			,(select codigofinanceirotitulo from financeirotitulo where DocumentoCodigo = D.CodigoDocumento and valor = @ValorEx) CodigoFinanceiroTitulo
			,0 Automatico
			,0 Liquidando
			--,'' TituloCodigoAntigo
			--,m.CodigoFilial 
			--,m.CodigoMovimento MovimentacaoCodigoAntigo

                   from documento D where d.tipo = 'Venda' and 
				   codigodocumento =                   
				   (select codigodocumento from documentoitem where codigoantigo =
				   (select ('scar2.' + codigofilial) from storicocarrello where
				   data =  @DataEx and  @CodigoClienteEx = [Codice cliente] and total = @ValorEx))
              end 

			fetch next from Xcursor2 into @CodigoClienteEx, @ValorEx
			end
			
			close Xcursor2;
			deallocate Xcursor2;

	fetch next from Xcursor1 into  @DataEx, @CodigoContaEx ,@CodigoFilial, @CodigoMovimento

end

close Xcursor1;
deallocate Xcursor1;

-- fim do insert desagrupando -----


INSERT INTO FinanceiroMovimentacao
           (CodigoFinanceiroMovimentacaoN
           ,CodigoEmpresa
           ,CodigoContato
           ,CodigoFinanceiroPlanoConta
           ,CodigoFinanceiroCentroCusto
           ,Ordem
           ,DataCompetencia
           ,DataEmissao
           ,DataVencimento
           ,DataMovimento
           ,ValorDebito
           ,ValorCredito
           ,ValorSaldo
           ,Descricao
           ,Observacao
           ,DocumentoTipo
           ,DocumentoCodigo
           ,CodigoFinanceiroTitulo
           ,Automatico
           ,Liquidando
		   ,TituloCodigoAntigo
		   ,CodigoAntigo
		   ,MovimentacaoCodigoAntigo)

Select 
	 M.Codigo + 100000 CodigoFinanceiroMovimentacaoN
    ,c.CodigoContato CodigoEmpresa
    ,CodigoContato
    ,Case When M.Valor > 0 then fpc.CodigoFinanceiroPlanoConta else 22 end CodigoFinanceiroPlanoConta --Caixa
    ,0 CodigoFinanceiroCentroCusto
    ,0 Ordem
    ,m.Data DataCompetencia
    ,m.Data DataEmissao
    ,m.Data DataVencimento
    ,m.Data DataPagamento  
    ,IsNull(abs(m.Valor),0) ValorDebito
    ,0 ValorCredito
    ,0 ValorSaldo
    ,M.Referencia Descricao
    ,'MovimentoConti.' + isnull(M.CodigoFilial,'') +' ' + isnull(M.Categoria,'') Observacao
    ,'' DocumentoTipo
    ,0 DocumentoCodigo
    ,0 CodigoFinanceiroTitulo
    ,0 Automatico
    ,0 Liquidando
	, '' TituloCodigoAntigo
	,m.CodigoFilial 
	,m.CodigoMovimento MovimentacaoCodigoAntigo
-- select * from movimentoconti
  from movimentoconti m left join
  Conti5 Ct on m.CodigoConta = ct.CodigoFilial  left join
  Contato C on c.CodigoAntigo = 'Sede.' + ct.Filial    left join 
  FinanceiroPlanoConta fpc on fpc.apelido=m.CodigoConta
  where c.CodigoContato is not null 
  and CaTEGORIA not like 'Fechamento caixa%'
  and CaTEGORIA not like 'Fundo caixa%'
  and M.Categoria not like 'Vendas em Dinheiro do%'
   
  union all

  Select 
	 M.Codigo + 100000 CodigoFinanceiroMovimentacaoN
    ,c.CodigoContato CodigoEmpresa
    ,CodigoContato
    ,Case When M.Valor >0 then 12 else fpc.CodigoFinanceiroPlanoConta end CodigoFinanceiroPlanoConta --Caixa
    ,0 CodigoFinanceiroCentroCusto
    ,0 Ordem
    ,m.Data DataCompetencia
    ,m.Data DataEmissao
    ,m.Data DataVencimento
    ,m.Data DataPagamento
    ,0 ValorDebito
    ,IsNull(abs(m.Valor),0) ValorCredito
    ,0 ValorSaldo
    ,M.Referencia Descricao
    ,'MovimentoConti.' + isnull(M.CodigoFilial,'') +' ' + isnull(M.Categoria,'') Observacao
    ,'' DocumentoTipo
    ,0 DocumentoCodigo
    ,0 CodigoFinanceiroTitulo
    ,0 Automatico
    ,0 Liquidando
	,'' TituloCodigoAntigo
	,m.CodigoFilial 
	,m.CodigoMovimento MovimentacaoCodigoAntigo
	    
  from movimentoconti m left join 
  Conti5 Ct on m.CodigoConta = ct.CodigoFilial left join
  Contato C on c.CodigoAntigo  =  'Sede.' + ct.Filial  left join 
  FinanceiroPlanoConta fpc on fpc.apelido=m.CodigoConta
  where c.CodigoContato is not null  
  and CaTEGORIA not like 'Fechamento caixa%'
  and CaTEGORIA not like 'Fundo caixa%'
  and M.Categoria not like 'Vendas em Dinheiro do%'


Update FinanceiroMovimentacao Set CodigoFinanceiroPlanoConta = @CodigoFinanceiroPlanoContaTransf
where CodigoAntigo in (
Select m.CodigoFilial from movimentoConti m left join
primanot pn on m.CodigoMovimento = pn.CodigoFilial
where 
isnull(pn.TipoContraparte,'')='Transferência' or isnull(m.CodigoMovimento,'')  = ''
)
and CodigoFinanceiroPlanoConta in (12,22)



--Lança nas movimentações os lançamento de criação dos titulos..subindo contabilmente a pagar e a receber do balanço
begin 

	
	--Delete FinanceiroMovimentacao where Automatico=1
	--Update FinanceiroTitulo Set FinanceiroMovimentacaoCodigoAgrupamentoAutomatico = null

	 Declare @max int = IsNull((Select max(CodigoFinanceiroMovimentacaoN) from FinanceiroMovimentacao),0) + 1

	--Cria os Codigos FinanceiroMovimentacaoCodigoAgrupamentoAutomatico para ser lançando posteriormente
	
	--drop table #t
	Select CodigoFinanceiroTitulo + 0 CodigoFinanceiroTitulo , IDENTITY(int,1,1) Ordx into #t 
	from FinanceiroTitulo where FinanceiroMovimentacaoCodigoAgrupamentoAutomatico is null
	--select * from #t

	Update FinanceiroTitulo Set FinanceiroMovimentacaoCodigoAgrupamentoAutomatico = Ordx +@max From #t
	where FinanceiroTitulo.CodigoFinanceiroTitulo=#t.CodigoFinanceiroTitulo
	Drop table #t
	
	INSERT INTO FinanceiroMovimentacao
	(CodigoFinanceiroMovimentacaoN, CodigoEmpresa, CodigoContato, CodigoFinanceiroPlanoConta,
	CodigoFinanceiroCentroCusto, DataMovimento, DataCompetencia, DataEmissao, DataVencimento,
	ValorDebito, ValorCredito, Descricao, Observacao, DocumentoTipo, DocumentoCodigo, CodigoFinanceiroTitulo,
	Automatico, Ordem )
	
	Select   ft.FinanceiroMovimentacaoCodigoAgrupamentoAutomatico CodigoFinanceiroMovimentacaoN
			,ft.CodigoEmpresa
			,ft.CodigoContato
			,Case When ReceberPagar=1 then ft.CodigoFinanceiroPlanoConta else CreditoPagar.Conta end  CodigoFinanceiroPlanoConta
			,ft.CodigoFinanceiroCentroCusto
			,ft.DataPagamento
			,ft.DataCompetencia
			,ft.DataEmissao
			,ft.DataVencimento
			,0 ValorDebito
			,ft.Valor ValorCredito    ---CREDITANDO
			,Case When ReceberPagar=1 then ltrim(pc.Descricao) else ltrim(CreditoPagar.Descricao) end  Descricao
			,'Contabilização automatica' Observacao
			,ft.DocumentoTipo
			,ft.DocumentoCodigo
			,ft.CodigoFinanceiroTitulo 
			,1 Automatico
			,0 Ordem
	From FinanceiroTitulo ft left join 
	     FinanceiroPlanoConta pc on ft.CodigoFinanceiroPlanoConta=pc.CodigoFinanceiroPlanoConta
	    ,(Select CodigoFinanceiroPlanoConta Conta,Descricao from FinanceiroPlanoConta 
		  inner join Configuracoes on Configuracoes.Valor = FinanceiroPlanoConta.CodigoFinanceiroPlanoConta 
		  where Configuracoes.Nome = 'financeiro.planocontas.duplicatapagar') CreditoPagar 

	union all      

	Select ft.FinanceiroMovimentacaoCodigoAgrupamentoAutomatico CodigoFinanceiroMovimentacaoN
			,ft.CodigoEmpresa
			,ft.CodigoContato
			,Case When ReceberPagar = 1 then  DebitoReceber.Conta else ft.CodigoFinanceiroPlanoConta end  CodigoFinanceiroPlanoConta
			,ft.CodigoFinanceiroCentroCusto
			,ft.DataPagamento
			,ft.DataCompetencia
			,ft.DataEmissao
			,ft.DataVencimento
			,ft.Valor ValorDebito
			,0 ValorCredito
			,Case When ReceberPagar=1 then ltrim(DebitoReceber.Descricao) else ltrim(pc.Descricao) end  Descricao
			,'Contabilização automatica' Observacao
			,ft.DocumentoTipo
			,ft.DocumentoCodigo
			,ft.CodigoFinanceiroTitulo
			,1 Automatico
			,0 Ordem
	From FinanceiroTitulo ft left join 
	FinanceiroPlanoConta pc on ft.CodigoFinanceiroPlanoConta=pc.CodigoFinanceiroPlanoConta
	,(Select CodigoFinanceiroPlanoConta Conta,Descricao from FinanceiroPlanoConta inner join Configuracoes on Configuracoes.Valor = FinanceiroPlanoConta.CodigoFinanceiroPlanoConta where Configuracoes.Nome = 'financeiro.planocontas.duplicatareceber') DebitoReceber;
	--where FinanceiroMovimentacaoCodigoAgrupamentoAutomatico=1 and CodigoEmpresa=28396

	insert into ImportacaoLog (banco,Nregistros,tabela)
	select DB_NAME() ,(select count(*) from FinanceiroMovimentacao) ,'FinanceiroMovimentacao'


end

	
--Marca os titulos com diferença de valor para facilitar o diagnostico
update FinanceiroMovimentacao Set Liquidando = 1 
where CodigoFinanceiroMovimentacao in (
	Select b.CodigoFinanceiroMovimentacao
		--a.ValorRealizado
		--,(B.ValorDebito  + b.ValorCredito)
		--, a.* 
		--, B.* 
		From 
	(
	Select * --FinanceiroMovimentacaoCodigoAgrupamento,ValorRealizado,DataVencimento 
	from FinanceiroTitulo --where FinanceiroTitulo.DocumentoTipo='MovimentoConti'
	) A inner join
	 FinanceiroMovimentacao b on FinanceiroMovimentacaoCodigoAgrupamento =  b.CodigoFinanceiroMovimentacaoN 
	 and b.CodigoFinanceiroPlanoConta in (12,22)
	 where (a.ValorRealizado - (B.ValorDebito  + b.ValorCredito)) <> 0
 )


--Gera os movimentos automáticos
--Alter Table FinanceiroTitulo enable TRIGGER [LancaMovimentacaoAutomatica]
if (1=1) Update FinanceiroTitulo set Observacao=Observacao


if (1=1) exec Sp__Optidados_Financeiro_LancaMovimentacaoAutomatica_RodarAposImportacao
 

/*
if (1=0) --Testes de alguns casos dos Titulos
Begin

	--- em Aberto 100%
	Select top 10 * from RataClienti where ValorParcela > ValorPago and Pago='Não' and CodigoFilial='0100P2660A'
	Select * From FinanceiroTitulo where DocumentoCodigo='0100P2660A'

	--- em Aberto 100% porem é Renegociação
	Select top 10 * from RataClienti where ValorParcela > ValorPago and Pago='Sim' and CodigoFilial='0400A2620A'
	Select * From FinanceiroTitulo where DocumentoCodigo='0400A2620A'

	--- Pago Parcial
	Select top 10 * from RataClienti where ValorParcela > ValorPago and ValorPago >0 and CodigoFilial='040FX2770A'
	Select * From FinanceiroTitulo where DocumentoCodigo='040FX2770A'

	--Juros
	Select top 10 * from RataClienti where ValorParcela < ValorPago and CodigoFilial='050072620A'
	Select * From FinanceiroTitulo where DocumentoCodigo='050072620A'
	
	--Mais de pagamento
	Select CodigoParcelaCliente from primanot where isnull(CodigoParcelaCliente,'') <> '' group by CodigoParcelaCliente having COUNT(*) >1
	Select top 10 * from RataClienti where CodigoFilial='0103E26F0A'
	Select * From FinanceiroTitulo where DocumentoCodigo='0103E26F0A'
	
end

if (1=0) --Testes de alguns casos dos Titulos a Pagar
Begin

	--- em Aberto 100%
	Select top 10 * from Rata where ValorParcela > ValorPago and Pago='Não' and CodigoFilial='1222S2MK0A'
	Select * From FinanceiroTitulo where DocumentoCodigo='1222S2MK0A'

	--- em Aberto 100% porem é Renegociação
	Select top 10 * from Rata where ValorParcela > ValorPago and Pago='Sim' and not CodigoMovimento is null and CodigoFilial='0309M28K0A'
	Select * From FinanceiroTitulo where DocumentoCodigo=''

	--- Pago Parcial
	Select top 10 * from Rata where ValorParcela > ValorPago and ValorPago >0 and CodigoFilial='0209028I0A'
	Select * From FinanceiroTitulo where DocumentoCodigo='0209028I0A'
	
	--Juros
	Select top 10 * from Rata where ValorParcela < ValorPago and CodigoFilial='0409O28K0A'
	Select * From FinanceiroTitulo where DocumentoCodigo='0409O28K0A'
	
	--Mais de pagamento
	Select CodigoParcela,sum(Valor) from primanot where isnull(CodigoParcela,'') <> '' group by CodigoParcela having COUNT(*) >1
	Select top 10 * from Rata where CodigoFilial='031ZP2LS0A'
	Select * From FinanceiroTitulo where DocumentoCodigo='031ZP2LS0A'

	--Confere Diferença entre Titulo e movimentação
	Select a.ValorRealizado, (B.ValorDebito  + b.ValorCredito), a.* , B.* From 
       (Select FinanceiroMovimentacaoCodigoAgrupamento,ValorRealizado
               from FinanceiroTitulo where FinanceiroTitulo.DocumentoTipo='MovimentoConti'
               ) A inner join
 FinanceiroMovimentacao b on FinanceiroMovimentacaoCodigoAgrupamento =  b.CodigoFinanceiroMovimentacaoN 
 and b.CodigoFinanceiroPlanoConta in (12,22)
 where (a.ValorRealizado - (B.ValorDebito  + b.ValorCredito)) <> 0

end
	*/