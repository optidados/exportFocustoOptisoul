USE [ElisPedreira]
GO
/****** Object:  StoredProcedure [dbo].[Focus_Importa_W_Documento_item]    Script Date: 25/10/2017 17:33:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Focus_Importa_W_Documento_item] as 
set nocount on
		insert into ImportacaoLog (banco,Nregistros,tabela)
		select DB_NAME() ,(0) ,'Iniciando Documento item'
/*
		alter table documentoitem add [CodigoItemant] varchar(50)
		alter table documentoitem add [CodigoDocumentoant] varchar(50)
		alter table documentoitem add [CodigoDocumentoAdicionalant] varchar(50)
*/
	-- popula a documentoitemtemp

		if exists (select * from dbo.sysobjects where name like('DocumentoitemTemp')) drop table DocumentoitemTemp
		Select * into DocumentoitemTemp
		From Openrowset('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Optidados\ElisPedreira;HDR=Yes;Format=Delimited(;);FMT=Delimited"""',
		'Select * from [Documentoitem.txt]') as A
		ALTER TABLE DocumentoitemTemp ADD Cod [int] IDENTITY(1,1) NOT NULL;
		-- select * from DocumentoitemTemp

		insert into ImportacaoLog (banco,Nregistros,tabela)
		select DB_NAME() ,(select count(*) from DocumentoitemTemp) ,'DocumentoitemTemp'

		TRUNCATE TABLE DocumentoItem
		TRUNCATE TABLE DocumentoEndereco
		TRUNCATE TABLE DocumentoContato

		DBCC CHECKIDENT('[DocumentoItem]', RESEED, 1);
		DBCC CHECKIDENT('[DocumentoEndereco]', RESEED, 1);
		DBCC CHECKIDENT('[DocumentoContato]', RESEED, 1);

ALTER TABLE [documentoitem] DISABLE TRIGGER ALL

		INSERT INTO [dbo].[documentoitem]
				   (CodigoDocumento
				   ,[AmarcaoCor]
				   ,[ArmacaoMaterial]
				   ,[CRMGrupoMetaAssistente]
				   ,[CRMGrupoMetaVendedor]
				   ,[Cor]
				   ,[DescricaoAgrupamento]
				   ,[DescricaoItem]
				   ,[Genero]
				   ,[LenteTipo]
				   ,[LoteEmpresa]
				   ,[Lote]
				   ,[Marca]
				   ,[Material]
				   ,[Modelo]
				   ,[NCM]
				   ,[Observacao]
				   ,[Oculos]
				   ,[Operacao]
				   ,[Prisma]
				   ,[ReferenciaFornecedor]
				   ,[Status]
				   ,[Tamanho]
				   ,[TipoItem]
				   ,[TipoMontagem]
				   ,[TipoOculos]
				   ,[UnidadeTributada]
				   ,[Unidade]
				   ,[DataHoraEmissao]
				   ,[DataUltimaVenda]
				   ,[DataHoraFinalizado]
				   ,[DataValidadeLote]
				   ,[DescontoFaturaRateado]
				   ,[DescontoItem]
				   ,[DescontoPercentualItem]
				   ,[DescontoPercentualSubTotal]
				   ,[DescontoSubTotal]
				   ,[DescontoTotalRateado]
				   ,[PercentualICMS]
				   ,[PercentualIPI]
				   ,[PercentualIVA]
				   ,[PercentualIcmsSt]
				   ,[QuantidadeTributada]
				   ,[QuantidadeUltimo]
				   ,[SubTotal]
				   ,[Total]
				   ,[ValorBaseICMS]
				   ,[ValorBaseIPI]
				   ,[ValorBaseIcmsSt]
				   ,[ValorCustoMedio]
				   ,[ValorCustoReposicao]
				   ,[ValorCustoTerceiro]
				   ,[ValorCustoUltimo]
				   ,[ValorCusto]
				   ,[ValorFreteRateado]
				   ,[ValorICMS]
				   ,[ValorIPI]
				   ,[ValorIcmsSt]
				   ,[ValorItemTributado]
				   ,[ValorItemUltimo]
				   ,[ValorItem]
				   ,[ValorOriginal]
				   ,[ValorOutrasDespesasRateado]
				   ,[ValorRealTotalImpostos]
				   ,[ValorRealTotal]
				   ,[ValorReal]
				   ,[ValorSeguroRateado]
				   ,[Quantidade]
				   ,[QuantidadeConferido]
				   ,[QuantidadeRealizado]
				   ,[Altura]
				   ,[Largura]
				   ,[Comprimento]
				   ,[Diagonal]
				   ,[Diametro]
				   ,[Eixo]
				   ,[AdicaoInicial]
				   ,[AdicaoFinal]
				   ,[AlturaMinima]
				   ,[EsfericoInicial]
				   ,[EsfericoFinal]
				   ,[Cilindrico]
				   ,[Haste]
				   ,[Ponte]
				   ,[RB1]
				   ,[RB2]
				   ,[Geometria]
				   ,[IndiceRefracao]
				   ,[Adicao]
				   ,[Esferico]
				   ,[Base]
				   ,[DI]
				   ,[DIOD]
				   ,[DIOE]
				   ,[CRMItemNovo]
				   ,[PrescricaoAlterada]
				   ,[CodigoCST]
				   ,[ModalidadeBaseCalculo]
				   ,[CodigoCSTIPI]
				 --  ,[CodigoContatoFornecedor]
				 --  ,[CodigoDocumentoVenda]
				 --  ,[CodigoDocumentoItemVenda]
				--   ,[CodigoDocumentoRemessa]
				--   ,[CodigoDocumentoCompra]
				--   ,[CodigoDocumentoTriagem]
				   ,[ModalidadeBaseCalculoST]
				   ,[CodigoPlanoContaEstoque]
				   ,[CodigoPlanoContaDestino]
				--   ,[CodigoItemDNA]
				   ,[CodigoCFOP]
				   ,[OperacaoFator]
				--   ,[CodigoDocumentoItemPai]
				   ,[CodigoAntigo]
				   ,[CodigoItemant]
				   ,[CodigoDocumentoant]
				   ,[CodigoDocumentoAdicionalant])

					select 
					1 as [codigodocumento] -- engana a pk
					 -- Varchar
					,[AmarcaoCor]                  
					,[ArmacaoMaterial]             
					,[CRMGrupoMetaAssistente]      
					,[CRMGrupoMetaVendedor]        
					,[Cor]                         
					,[DescricaoAgrupamento]        
					,isnull([DescricaoItem],'NULO')
					,[Genero]                      
					,[LenteTipo]                   
					,[LoteEmpresa]                 
					,[Lote]                        
					,[Marca]                       
					,[Material]                    
					,[Modelo]                      
					,[NCM]                         
					,[Observacao]                  
					,[Oculos]                      
					,[Operacao]                    
					,[Prisma]                      
					,[ReferenciaFornecedor]        
					,[Status]                      
					,[Tamanho]                     
					,[TipoItem]                    
					,[TipoMontagem]                
					,[TipoOculos]                  
					,[UnidadeTributada]            
					,[Unidade]                     

--  datetime
,case when [DataHoraEmissao] is null or isdate([DataHoraEmissao]) = 0 then null else cast([DataHoraEmissao] as datetime) end as [DataHoraEmissao]
,case when [DataUltimaVenda] is null or isdate([DataUltimaVenda]) = 0 then null else cast([DataUltimaVenda] as datetime) end as [DataUltimaVenda]
,case when [DataHoraFinalizado] is null or isdate([DataHoraFinalizado]) = 0 then null else cast([DataHoraFinalizado] as datetime) end as [DataHoraFinalizado]
,case when [DataValidadeLote] is null or isdate([DataValidadeLote]) = 0 then null else cast([DataValidadeLote] as date) end as [DataValidadeLote]

-- decimal 18,4 
,case when isnumeric([DescontoFaturaRateado]) = 1 then cast((select(replace( [DescontoFaturaRateado] ,',','.'))) as Decimal(18,4)) else 0  end as [DescontoFaturaRateado] 
,case when isnumeric([DescontoItem]) = 1 then cast((select(replace( [DescontoItem] ,',','.'))) as Decimal(18,4)) else 0 end as [DescontoItem] 
,case when isnumeric([DescontoPercentualItem]) = 1 then cast((select(replace( [DescontoPercentualItem] ,',','.'))) as Decimal(18,4)) else 0 end as [DescontoPercentualItem] 
,case when isnumeric([DescontoPercentualSubTotal]) = 1 then cast((select(replace( [DescontoPercentualSubTotal] ,',','.'))) as Decimal(18,4)) else 0  end as [DescontoPercentualSubTotal] 
,case when isnumeric([DescontoSubTotal]) = 1 then cast((select(replace( [DescontoSubTotal] ,',','.'))) as Decimal(18,4)) else 0  end as [DescontoSubTotal] 
,case when isnumeric([DescontoTotalRateado]) = 1 then cast((select(replace( [DescontoTotalRateado] ,',','.'))) as Decimal(18,4)) else 0  end as [DescontoTotalRateado] 
,case when isnumeric([PercentualICMS]) = 1 then cast((select(replace( [PercentualICMS] ,',','.'))) as Decimal(18,4)) else 0  end as [PercentualICMS] 
,case when isnumeric([PercentualIPI]) = 1 then cast((select(replace( [PercentualIPI] ,',','.'))) as Decimal(18,4)) else 0  end as [PercentualIPI] 
,case when isnumeric([PercentualIVA]) = 1 then cast((select(replace( [PercentualIVA] ,',','.'))) as Decimal(18,4)) else 0  end as [PercentualIVA] 
,case when isnumeric([PercentualIcmsSt]) = 1 then cast((select(replace( [PercentualIcmsSt] ,',','.'))) as Decimal(18,4)) else 0  end as [PercentualIcmsSt] 
,case when isnumeric([QuantidadeTributada]) = 1 then cast((select(replace( [QuantidadeTributada] ,',','.'))) as Decimal(18,4)) else 0  end as [QuantidadeTributada] 
,case when isnumeric([QuantidadeUltimo]) = 1 then cast((select(replace( [QuantidadeUltimo] ,',','.'))) as Decimal(18,4)) else 0  end as [QuantidadeUltimo] 
,case when isnumeric([SubTotal]) = 1 then cast((select(replace( [SubTotal] ,',','.'))) as Decimal(18,4)) else 0  end as [SubTotal] 
,case when isnumeric([Total]) = 1 then cast((select(replace( [Total] ,',','.'))) as Decimal(18,4)) else 0  end as [Total] 
,case when isnumeric([ValorBaseICMS]) = 1 then cast((select(replace( [ValorBaseICMS] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorBaseICMS] 
,case when isnumeric([ValorBaseIPI]) = 1 then cast((select(replace( [ValorBaseIPI] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorBaseIPI] 
,case when isnumeric([ValorBaseIcmsSt]) = 1 then cast((select(replace( [ValorBaseIcmsSt] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorBaseIcmsSt] 
,case when isnumeric([ValorCustoMedio]) = 1 then cast((select(replace( [ValorCustoMedio] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorCustoMedio] 
,case when isnumeric([ValorCustoReposicao]) = 1 then cast((select(replace( [ValorCustoReposicao] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorCustoReposicao] 
,case when isnumeric([ValorCustoTerceiro]) = 1 then cast((select(replace( [ValorCustoTerceiro] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorCustoTerceiro] 
,case when isnumeric([ValorCustoUltimo]) = 1 then cast((select(replace( [ValorCustoUltimo] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorCustoUltimo] 
,case when isnumeric([ValorCusto]) = 1 then cast((select(replace( [ValorCusto] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorCusto] 
,case when isnumeric([ValorFreteRateado]) = 1 then cast((select(replace( [ValorFreteRateado] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorFreteRateado] 
,case when isnumeric([ValorICMS]) = 1 then cast((select(replace( [ValorICMS] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorICMS] 
,case when isnumeric([ValorIPI]) = 1 then cast((select(replace( [ValorIPI] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorIPI] 
,case when isnumeric([ValorIcmsSt]) = 1 then cast((select(replace( [ValorIcmsSt] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorIcmsSt] 
,case when isnumeric([ValorItemTributado]) = 1 then cast((select(replace( [ValorItemTributado] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorItemTributado] 
,case when isnumeric([ValorItemUltimo]) = 1 then cast((select(replace( [ValorItemUltimo] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorItemUltimo] 
,case when isnumeric([ValorItem]) = 1 then cast((select(replace( [ValorItem] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorItem] 
,case when isnumeric([ValorOriginal]) = 1 then cast((select(replace( [ValorOriginal] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorOriginal] 
,case when isnumeric([ValorOutrasDespesasRateado]) = 1 then cast((select(replace( [ValorOutrasDespesasRateado] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorOutrasDespesasRateado] 
,case when isnumeric([ValorRealTotalImpostos]) = 1 then cast((select(replace( [ValorRealTotalImpostos] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorRealTotalImpostos] 
,case when isnumeric([ValorRealTotal]) = 1 then cast((select(replace( [ValorRealTotal] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorRealTotal] 
,case when isnumeric([ValorReal]) = 1 then cast((select(replace( [ValorReal] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorReal] 
,case when isnumeric([ValorSeguroRateado]) = 1 then cast((select(replace( [ValorSeguroRateado] ,',','.'))) as Decimal(18,4)) else 0  end as [ValorSeguroRateado] 
-- decimal 18,6 
,case when isnumeric([Quantidade]) = 1 then cast((select(replace( [Quantidade] ,',','.'))) as Decimal(18,6)) else null end as [Quantidade] 
,case when isnumeric([QuantidadeConferido]) = 1 then cast((select(replace( [QuantidadeConferido] ,',','.'))) as Decimal(18,6)) else null end as [QuantidadeConferido] 
,case when isnumeric([QuantidadeRealizado]) = 1 then cast((select(replace( [QuantidadeRealizado] ,',','.'))) as Decimal(18,6)) else null end as [QuantidadeRealizado] 
-- numeric 18,4
,case when isnumeric( [Altura] ) = 1 then cast((select(replace([Altura] ,',','.'))) as Decimal(18,4)) else null end as [Altura] 
,case when isnumeric( [Largura] ) = 1 then cast((select(replace([Largura] ,',','.'))) as Decimal(18,4)) else null end as [Largura] 
,case when isnumeric( [Comprimento] ) = 1 then cast((select(replace([Comprimento] ,',','.'))) as Decimal(18,4)) else null end as [Comprimento] 
,case when isnumeric( [Diagonal] ) = 1 then cast((select(replace([Diagonal] ,',','.'))) as Decimal(18,4)) else null end as [Diagonal] 
,case when isnumeric( [Diametro] ) = 1 then cast((select(replace([Diametro] ,',','.'))) as Decimal(18,4)) else null end as [Diametro] 
,case when isnumeric( [Eixo] ) = 1 then cast((select(replace([Eixo] ,',','.'))) as Decimal(18,4)) else null end as [Eixo] 
,case when isnumeric( [AdicaoInicial] ) = 1 then cast((select(replace([AdicaoInicial] ,',','.'))) as Decimal(18,4)) else null end as [AdicaoInicial] 
,case when isnumeric( [AdicaoFinal] ) = 1 then cast((select(replace([AdicaoFinal] ,',','.'))) as Decimal(18,4)) else null end as [AdicaoFinal] 
,case when isnumeric( [AlturaMinima] ) = 1 then cast((select(replace([AlturaMinima] ,',','.'))) as Decimal(18,4)) else null end as [AlturaMinima] 
,case when isnumeric( [EsfericoInicial] ) = 1 then cast((select(replace([EsfericoInicial] ,',','.'))) as Decimal(18,4)) else null end as [EsfericoInicial] 
,case when isnumeric( [EsfericoFinal] ) = 1 then cast((select(replace([EsfericoFinal] ,',','.'))) as Decimal(18,4)) else null end as [EsfericoFinal] 
,case when isnumeric( [Cilindrico] ) = 1 then cast((select(replace([Cilindrico] ,',','.'))) as Decimal(18,4)) else null end as [Cilindrico] 
,case when isnumeric( [Haste] ) = 1 then cast((select(replace([Haste] ,',','.'))) as Decimal(18,4)) else null end as [Haste] 
,case when isnumeric( [Ponte] ) = 1 then cast((select(replace([Ponte] ,',','.'))) as Decimal(18,4)) else null end as [Ponte] 
,case when isnumeric( [RB1] ) = 1 then cast((select(replace([RB1] ,',','.'))) as Decimal(18,4)) else null end as [RB1] 
,case when isnumeric( [RB2] ) = 1 then cast((select(replace([RB2] ,',','.'))) as Decimal(18,4)) else null end as [RB2] 
,case when isnumeric( [Geometria] ) = 1 then cast((select(replace([Geometria] ,',','.'))) as Decimal(18,4)) else null end as [Geometria] 
,case when isnumeric( [IndiceRefracao] ) = 1 then cast((select(replace([IndiceRefracao] ,',','.'))) as Decimal(18,4)) else null end as [IndiceRefracao] 
,case when isnumeric( [Adicao] ) = 1 then cast((select(replace([Adicao] ,',','.'))) as Decimal(18,4)) else null end as [Adicao] 
,case when isnumeric( [Esferico] ) = 1 then cast((select(replace([Esferico] ,',','.'))) as Decimal(18,4)) else null end as [Esferico] 
,case when isnumeric( [Base] ) = 1 then cast((select(replace([Base] ,',','.'))) as Decimal(18,4)) else null end as [Base] 
,case when isnumeric( [DI] ) = 1 then cast((select(replace([DI] ,',','.'))) as Decimal(18,4)) else null end as [DI] 
,case when isnumeric( [DIOD] ) = 1 then cast((select(replace([DIOD] ,',','.'))) as Decimal(18,4)) else null end as [DIOD] 
,case when isnumeric( [DIOE] ) = 1 then cast((select(replace([DIOE] ,',','.'))) as Decimal(18,4)) else null end as [DIOE] 
		-- bit
		,cast([CRMItemNovo] as bit) as [CRMItemNovo]	   
		,case when [PrescricaoAlterada] = 'Sim' then 1 else 0 end  as [PrescricaoAlterada]	      
		-- int
		,cast( [CodigoCST] as int ) as [CodigoCST] 
		,cast( [ModalidadeBaseCalculo] as int ) as [ModalidadeBaseCalculo] 
		,cast( [CodigoCSTIPI] as int ) as [CodigoCSTIPI] 
		--,cast( [CodigoContatoFornecedor] as int ) as [CodigoContatoFornecedor] 
		--,cast( [CodigoDocumentoVenda] as int ) as [CodigoDocumentoVenda] 
		--,cast( [CodigoDocumentoItemVenda] as int ) as [CodigoDocumentoItemVenda] 
		--,cast( [CodigoDocumentoRemessa] as int ) as [CodigoDocumentoRemessa] 
		--,cast( [CodigoDocumentoCompra] as int ) as [CodigoDocumentoCompra] 
		--,cast( [CodigoDocumentoTriagem] as int ) as [CodigoDocumentoTriagem] 
		
		,cast( [ModalidadeBaseCalculoST] as int ) as [ModalidadeBaseCalculoST] 
		,cast( [CodigoPlanoContaEstoque] as int ) as [CodigoPlanoContaEstoque] 
		,cast( [CodigoPlanoContaDestino] as int ) as [CodigoPlanoContaDestino] 
		--,cast( [CodigoItemDNA] as int ) as [CodigoItemDNA] 
		,cast( [CodigoCFOP] as int ) as [CodigoCFOP] 
		,cast( [OperacaoFator] as int ) as [OperacaoFator] 
		--,cast( [CodigoDocumentoItemPai] as int ) as [CodigoDocumentoItemPai]
		,[CodigoAntigo] 
		,cast( [CodigoItem] as varchar(50) )				as [CodigoItemant] 
		,cast( [CodigoDocumento] as varchar(50) )			as [CodigoDocumentoant] 
		,cast( [CodigoDocumentoAdicional] as varchar(50) )	as [CodigoDocumentoAdicionalant] 

		from documentoitemtemp

		Select codigodocumento,codigodocumentoadicional, idant, pedidoant into ##t from documento

		update documentoitem set codigodocumento = 
		isnull((select top 1 codigodocumento from ##t where documentoitem.codigodocumentoant = ##t.idant),0)

		update documentoitem set codigodocumentoadicional = 
		(select top 1 codigodocumento from ##t where documentoitem.codigodocumentoadicionalant = ##t.idant)
		Drop table ##t

		insert into ImportacaoLog (banco,Nregistros,tabela)
		select DB_NAME() ,(select count(*) from DocumentoItem) ,'DocumentoItem'


       update documentoitem set codigoitem =  (select codigoitem from item i where i.codigoantigo = documentoitem.codigoitemant)
-- select * from item


-- popula a documentocontatotemp

			if exists (select * from dbo.sysobjects where name like('DocumentocontatoTemp')) drop table DocumentocontatoTemp
			Select * into DocumentocontatoTemp
			From Openrowset('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Optidados\ElisPedreira;HDR=Yes;Format=Delimited(;);FMT=Delimited"""',
			'Select * from [Documentocontato.txt] where CodigoContato is not null and codigodocumento is not null  ' ) as A
			ALTER TABLE DocumentocontatoTemp ADD Cod [int] IDENTITY(1,1) NOT NULL;
			-- select * from documentocontatotemp

			insert into ImportacaoLog (banco,Nregistros,tabela)
			select DB_NAME() ,(select count(*) from documentocontatotemp) ,'documentocontatotemp'

			INSERT INTO [dbo].[DocumentoContato]
					   ([CodigoContato]
					   ,[Descricao]
					   ,[CodigoDocumento]
					   ,[Percentual])
			select
						(isnull((select codigocontato from contato 
						where contato.codigoantigo  collate Latin1_General_CI_AS = documentocontatotemp.CodigoContato  
													 collate Latin1_General_CI_AS),0))  as CodigoContato
					   ,left(Descricao,255) as descricao
					   ,(isnull((select codigodocumento from Documento 
						 where Documento.idant collate Latin1_General_CI_AS = documentocontatotemp.codigodocumento 
						 collate Latin1_General_CI_AS),0)) as CodigoDocumento
					   ,case when isnumeric(Percentual) = 1 then cast((select(replace(Percentual ,',','.'))) as Decimal(18,4)) else null end as Percentual
			from documentocontatotemp

/*
select  CodigoDocumento, idant  from  documento  where idant collate Latin1_General_CI_AS  in 
(select distinct CodigoDocumento  collate Latin1_General_CI_AS   from documentoitemtemp) 
order by CodigoDocumento desc
*/




			insert into ImportacaoLog (banco,Nregistros,tabela)
			select DB_NAME() ,(select count(*) from DocumentoContato) ,'DocumentoContato'

-- popula a documentoenderecotemp

			if exists (select * from dbo.sysobjects where name like('documentoenderecotemp')) drop table documentoenderecotemp
			Select * into DocumentoEnderecoTemp
			From Openrowset('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Optidados\ElisPedreira;HDR=Yes;Format=Delimited(;);FMT=Delimited"""',
			'Select * from [DocumentoEndereco.txt] where CodigoContato is not null and CodigoDocumento is not null  ' ) as A
			ALTER TABLE documentoenderecotemp ADD Cod [int] IDENTITY(1,1) NOT NULL;
			--select * from documentoenderecotemp
			
			insert into ImportacaoLog (banco,Nregistros,tabela)
			select DB_NAME() ,(select count(*) from DocumentoEnderecoTemp) ,'DocumentoEnderecoTemp'

			INSERT INTO [dbo].[DocumentoEndereco]
					   ([Descricao]
					   ,[CodigoDocumento]
					   ,[CodigoContatoEndereco]
					   ,[CodigoContato]
					   ,[Logradouro]
					   ,[Numero]
					   ,[Complemento]
					   ,[Condominio]
					   ,[Bairro]
					   ,[CEP]
					   ,[IbgeCod]
					   ,[Municipio]
					   ,[UF]
					   ,[UFCod]
					   ,[Pais]
					   ,[Grupo]
					   ,[CidadeCodChave]
					   ,[Observacao])
			select  
					   left(Descricao,255) as descricao
					   ,(isnull((select codigodocumento from Documento 
								  where Documento.idant 
									collate Latin1_General_CI_AS = documentoenderecotemp.codigodocumento 
									collate Latin1_General_CI_AS),0)) as CodigoDocumento
					   ,0 as CodigoContatoEndereco
					   ,(isnull((select codigocontato from contato 
									where contato.codigoantigo  
										collate Latin1_General_CI_AS = documentoenderecotemp.CodigoContato  
										collate Latin1_General_CI_AS),0))  as CodigoContato
					   ,Left(Logradouro,255)          as [Logradouro]
					   ,Left(Numero, 10)			  as [Numero]
					   ,Left(Complemento, 255)		  as [Complemento]
					   ,Left(Condominio, 150)		  as [Condominio]
					   ,Left(Bairro, 255)			  as [Bairro]
					   ,Left(CEP, 50)				  as [CEP]
					   ,Cast(IbgeCod as int)		  as [IbgeCod]
					   ,Left(Municipio, 150)		  as [Municipio]
					   ,Left(UF, 50)				  as [UF]
					   ,cast(UFCod as  int)			  as [UFCod]
					   ,Left(Pais, 150)				  as [Pais]
					   ,Left(Grupo, 255)			  as [Grupo]
					   ,Cast(CidadeCodChave as int)   as [CidadeCodChave]
					   ,Left(Observacao, 255)		  as [Observacao] 

				from documentoenderecotemp

				insert into ImportacaoLog (banco,Nregistros,tabela)
				select DB_NAME() ,(select count(*) from DocumentoEndereco) ,'DocumentoEndereco'

-- popula a DocumentoStatusTemp

				if exists (select * from dbo.sysobjects where name like('DocumentoStatusTemp')) drop table DocumentoStatusTemp
				Select * into DocumentoStatusTemp
				From Openrowset('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\Optidados\ElisPedreira;HDR=Yes;Format=Delimited(;);FMT=Delimited"""',
				'Select  * from [DocumentoStatus.txt] where  CodigoDocumento is not null  ' ) as A
				ALTER TABLE DocumentoStatusTemp ADD Cod [int] IDENTITY(1,1) NOT NULL;
				-- select * from DocumentoStatusTemp
				
				insert into ImportacaoLog (banco,Nregistros,tabela)
				select DB_NAME() ,(select count(*) from DocumentoStatusTemp) ,'DocumentoStatusTemp'

				INSERT INTO [dbo].[DocumentoStatus]
						   ([CodigoDocumento]
						   ,[CodigoDocumentoItem]
						   ,[CodigoContatoResponsavel]
						   ,[Operacao]
						   ,[StatusOriginal]
						   ,[StatusFinalizado]
						   ,[DataHoraEmissao]
						   ,[CodigoUsuarioAlterou]
						   ,[CodigoDocumentoCaixa])
				select
							(isnull((select codigodocumento from Documento 
							where Documento.idant 
							collate Latin1_General_CI_AS = DocumentoStatusTemp.CodigoDocumento 
							collate Latin1_General_CI_AS),0)) as CodigoDocumento
							,
							(isnull((select codigodocumentoitem from DocumentoItem where 
							DocumentoItem.CodigoAntigo              collate Latin1_General_CI_AS = 
							DocumentoStatusTemp.CodigoDocumentoItem collate Latin1_General_CI_AS),0)) as CodigoDocumentoItem
							,
							(isnull((select codigocontato from contato 
							where contato.codigoantigo  
							collate Latin1_General_CI_AS = DocumentoStatusTemp.CodigoContatoResponsavel  
							collate Latin1_General_CI_AS),0))  as CodigoContatoResponsavel

						   ,left(Operacao,255)			as Operacao
						   ,left(StatusOriginal, 255)	as StatusOriginal
						   ,left(StatusFinalizado,255)	as StatusFinalizado
						   ,
						   case when DataHoraEmissao is null or isdate(DataHoraEmissao) = 0 then null else cast(DataHoraEmissao as datetime) end as DataHoraEmissao
						   ,
							(isnull((select codigocontato from contato 
							where contato.codigoantigo  
							collate Latin1_General_CI_AS = DocumentoStatusTemp.CodigoUsuarioAlterou  
							collate Latin1_General_CI_AS),0))  as CodigoUsuarioAlterou
						   ,0 as CodigoDocumentoCaixa

				 from DocumentoStatusTemp

				insert into ImportacaoLog (banco,Nregistros,tabela)
				select DB_NAME() ,(select count(*) from DocumentoStatus) ,'DocumentoStatus'


ALTER TABLE [documentoitem] Enable TRIGGER ALL
