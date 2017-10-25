USE [Focus]
GO
/****** Object:  StoredProcedure [dbo].[D4_sp_importa_DocumentoOptisoul]    Script Date: 25/10/2017 17:36:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[D4_sp_importa_DocumentoOptisoul] as

ALTER TABLE Optisoul..Documento DISABLE TRIGGER ALL

INSERT INTO optisoul.dbo.[Documento]
           ([CodigoNFe]
           ,[Numero]
           ,[NotaNumero]
           ,[Revisao]
           ,[CodigoEmpresa]
           ,[CodigoMunicipioEmpresa]
           ,[CodigoEmpresaEndereco]
           ,[CodigoContato]
           ,[CodigoContatoEndereco]
           ,[CodigoContatoResponsavel]
           ,[CodigoContatoFinalizado]
           ,[CodigoContatoComprador]
           ,[CodigoContatoVendedor]
           ,[CodigoContatoDigitador]
           ,[CodigoContatoCobranca]
           ,[CodigoContatoEnderecoEntrega]
           ,[CodigoContatoTransportadora]
           ,[NumeroVolumeTransporte]
           ,[CodigoMinuta]
           ,[PrazoMedio]
           ,[CodigoFatura]
           ,[CodigoFinanceiroPlanoContaFaturamento]
           ,[CodigoItemTabelaPreco]
           ,[CodigoContatoResponsavelMinuta]
           ,[CodigoCaixa]
           ,[CodigoFinanceiroPlanoContaCaixa]
           ,[CodigoDocumentoOperacao]
           ,[CodigoDocumentoMobile]
           ,[OptanteSimplesNacional]
           ,[FreteSeparado]
           ,[ProvisaoCompra]
           ,[TransferenciaCaixa]
           ,[DataHoraEmissao]
           ,[DataHoraFinalizado]
           ,[DataHoraPrevisto]
           ,[DataHoraRealizado]
           ,[DataHoraAvisado]
           ,[DataCompra]
           ,[emissaoANt]
           ,[NotaSerie]
           ,[Tipo]
           ,[Descricao]
           ,[Operacao]
           ,[Status]
           ,[DescricaoEmpresa]
           ,[NumeroDocumentoEmpresa]
           ,[InscricaoMunicipalEmpresa]
           ,[DescricaoContato]
           ,[NumeroDocumentoContato]
           ,[EmailContato]
           ,[TelefoneContato]
           ,[RegimeContato]
           ,[DescricaoContatoEndereco]
           ,[ContatoResponsavelEmail]
           ,[Observacao]
           ,[ObservacaoInterna]
           ,[ObservacaoEntrega]
           ,[ObservacaoFaturamento]
           ,[DescricaoContatoEnderecoEntrega]
           ,[TipoFrete]
           ,[TipoTransporte]
           ,[CondicaoPagamento]
           ,[FormadePagamento]
           ,[NumeroOrdemCompra]
           ,[NumeroPedidoVendaFornecedor]
           ,[PalavraChave]
           ,[CalcularAutomatico]
           ,[DocumentoCodigo]
           ,[DocumentoTipo]
           ,[NaturezaOperacao]
           ,[MotivoCancelamento]
           ,[ObservacaoCancelamento]
           ,[CalculoAcabado]
           ,[CalculoEnvasado]
           ,[CodigoAntigo]
           ,[CRMContatoStatus]
           ,[DocumentoNotaPaulista]
           ,[NomeNotaPaulista]
           ,[PercentualDescontoProduto]
           ,[PercentualDescontoServico]
           ,[PesoTotalTransporte]
           ,[SubTotalProduto]
           ,[SubTotalServico]
           ,[SubTotal]
           ,[TotalCustoMedio]
           ,[TotalCustoReposicao]
           ,[TotalCustoTerceiro]
           ,[TotalCustoUltimo]
           ,[TotalDesconto]
           ,[TotalDocumento]
           ,[TotalOutroAbatimento]
           ,[TotalPercentualDesconto]
           ,[TotalPercentualOutroAbatimento]
           ,[TotalProduto]
           ,[TotalServico]
           ,[TotalTroco]
           ,[ValorAbertura]
           ,[ValorBaseIcmsSt]
           ,[ValorBaseIcms]
           ,[ValorDescontoProduto]
           ,[ValorDescontoServico]
           ,[ValorFrete]
           ,[ValorIPI]
           ,[ValorIcmsSt]
           ,[ValorIcms]
           ,[ValorOutrasDespesas]
           ,[ValorSeguro]
           ,[idant]
           ,[pedidoant]
           ,[empresaant]
           ,[clienteant]
           ,[ordemant])
	select 
			 [CodigoNFe]                             
			,[Numero]                                
			,[NotaNumero]                            
			,[Revisao]                               
			,isnull(CE.[CodigoContato],1) as [CodigoEmpresa]                         
			,[CodigoMunicipioEmpresa]                
			,[CodigoEmpresaEndereco]                 
			
			
			,
			(isnull((select codigocontato from optisoul..contato where
				  contato.codigoantigo collate Latin1_General_CI_AS = 
				  DT.CodigoContato  collate Latin1_General_CI_AS),1))  as CodigoContato

			,[CodigoContatoEndereco]                 

			,
			(isnull((select codigocontato from Optisoul..contato where
				  contato.codigoantigo collate Latin1_General_CI_AS = 
				  DT.[CodigoContatoResponsavel]  collate Latin1_General_CI_AS),0))  as [CodigoContatoResponsavel]			
			
          
			,
			(isnull((select codigocontato from Optisoul..contato where
				  contato.codigoantigo collate Latin1_General_CI_AS = 
				  DT.[CodigoContatoFinalizado]  collate Latin1_General_CI_AS),0))  as [CodigoContatoFinalizado]				
		
		
			               
			,[CodigoContatoComprador]                
			,CCV.[CodigoContato] as [CodigoContatoVendedor]                 
			,CCD.[CodigoContato] as [CodigoContatoDigitador]                
			,[CodigoContatoCobranca]                 
			,[CodigoContatoEnderecoEntrega]          
			,DT.[CodigoContatoTransportadora]           
			,[NumeroVolumeTransporte]                
			,[CodigoMinuta]                          
			,[PrazoMedio]                            
			,[CodigoFatura]                          
			,[CodigoFinanceiroPlanoContaFaturamento] 
			,DT.[CodigoItemTabelaPreco]  -- ambiguo               
			,[CodigoContatoResponsavelMinuta]        
			,[CodigoCaixa]                           
			,[CodigoFinanceiroPlanoContaCaixa]       
			,[CodigoDocumentoOperacao]      
 
			,cast([CodigoDocumentoMobile] as bigint) CodigoDocumentoMobile
			,isnull(cast([OptanteSimplesNacional] as bit),1) OptanteSimplesNacional
			,cast([FreteSeparado] as bit) FreteSeparado	 
			,cast([ProvisaoCompra] as bit) ProvisaoCompra	
			,cast([TransferenciaCaixa] as bit) TransferenciaCaixa

			,case when [DataHoraEmissao] is null then null else cast([DataHoraEmissao] as datetime) end as [DataHoraEmissao]
			,case when [DataHoraFinalizado] is null then null else cast([DataHoraFinalizado] as datetime) end as [DataHoraFinalizado]
			,case when [DataHoraPrevisto] is null then null else cast([DataHoraPrevisto] as datetime) end as [DataHoraPrevisto]
			,case when [DataHoraRealizado] is null then null else cast([DataHoraRealizado] as datetime) end as [DataHoraRealizado]
			,case when [DataHoraAvisado] is null then null else cast([DataHoraAvisado] as datetime) end as [DataHoraAvisado]
			--,case when [DataHoraRetorno] is null or isdate([DataHoraRetorno]) = 0 then null else cast([DataHoraRetorno] as datetime) end as [DataHoraRetorno]
			,case when [DataCompra] is null then null else cast([DataCompra] as date) end as [DataCompra]
			,case when [emissaoANt] is null then null else cast([emissaoANt] as date) end as [emissaoANt]

			,[NotaSerie]                       
			,[Tipo]                            
			,[Descricao]                       
			,[Operacao]                        
			,[Status]                          
			,[DescricaoEmpresa]                
			,[NumeroDocumentoEmpresa]          
			,[InscricaoMunicipalEmpresa]       
			,[DescricaoContato]                
			,[NumeroDocumentoContato]          
			,[EmailContato]                    
			,[TelefoneContato]                 
			,[RegimeContato]                   
			,[DescricaoContatoEndereco]        
			,[ContatoResponsavelEmail]         
			,DT.[Observacao]                      
			,[ObservacaoInterna]               
			,[ObservacaoEntrega]               
			,[ObservacaoFaturamento]           
			,[DescricaoContatoEnderecoEntrega] 
			,[TipoFrete]                       
			,[TipoTransporte]                  
			,DT.[CondicaoPagamento]               
			,[FormadePagamento]                
			,[NumeroOrdemCompra]               
			,[NumeroPedidoVendaFornecedor]     
			,[PalavraChave]                    
			,[CalcularAutomatico]              
			,[DocumentoCodigo]                 
			,[DocumentoTipo]                   
			,[NaturezaOperacao]                
			,[MotivoCancelamento]              
			,[ObservacaoCancelamento]          
			,[CalculoAcabado]                  
			,[CalculoEnvasado]                 
			,DT.[CodigoAntigo]                    
			,[CRMContatoStatus]                
			,[DocumentoNotaPaulista]           
			,[NomeNotaPaulista]                
			,case when isnumeric([PercentualDescontoProduto]) = 1 then cast((select(replace( [PercentualDescontoProduto] ,',','.'))) as numeric(18,4)) else null end as [PercentualDescontoProduto] 
			,case when isnumeric([PercentualDescontoServico]) = 1 then cast((select(replace( [PercentualDescontoServico] ,',','.'))) as numeric(18,4)) else null end as [PercentualDescontoServico] 
			,case when isnumeric([PesoTotalTransporte]) = 1 then cast((select(replace( [PesoTotalTransporte] ,',','.'))) as numeric(18,4)) else null end as [PesoTotalTransporte] 
			,case when isnumeric([SubTotalProduto]) = 1 then cast((select(replace( [SubTotalProduto] ,',','.'))) as numeric(18,4)) else null end as [SubTotalProduto] 
			,case when isnumeric([SubTotalServico]) = 1 then cast((select(replace( [SubTotalServico] ,',','.'))) as numeric(18,4)) else null end as [SubTotalServico] 
			,case when isnumeric([SubTotal]) = 1 then cast((select(replace( [SubTotal] ,',','.'))) as numeric(18,4)) else null end as [SubTotal] 
			,case when isnumeric([TotalCustoMedio]) = 1 then cast((select(replace( [TotalCustoMedio] ,',','.'))) as numeric(18,4)) else null end as [TotalCustoMedio] 
			,case when isnumeric([TotalCustoReposicao]) = 1 then cast((select(replace( [TotalCustoReposicao] ,',','.'))) as numeric(18,4)) else null end as [TotalCustoReposicao] 
			,case when isnumeric([TotalCustoTerceiro]) = 1 then cast((select(replace( [TotalCustoTerceiro] ,',','.'))) as numeric(18,4)) else null end as [TotalCustoTerceiro] 
			,case when isnumeric([TotalCustoUltimo]) = 1 then cast((select(replace( [TotalCustoUltimo] ,',','.'))) as numeric(18,4)) else null end as [TotalCustoUltimo] 
			,case when isnumeric([TotalDesconto]) = 1 then cast((select(replace( [TotalDesconto] ,',','.'))) as numeric(18,4)) else null end as [TotalDesconto] 
			,case when isnumeric([TotalDocumento]) = 1 then cast((select(replace( [TotalDocumento] ,',','.'))) as numeric(18,4)) else null end as [TotalDocumento] 
			,case when isnumeric([TotalOutroAbatimento]) = 1 then cast((select(replace( [TotalOutroAbatimento] ,',','.'))) as numeric(18,4)) else null end as [TotalOutroAbatimento] 
			,case when isnumeric([TotalPercentualDesconto]) = 1 then cast((select(replace( [TotalPercentualDesconto] ,',','.'))) as numeric(18,4)) else null end as [TotalPercentualDesconto] 
			,case when isnumeric([TotalPercentualOutroAbatimento]) = 1 then cast((select(replace( [TotalPercentualOutroAbatimento] ,',','.'))) as numeric(18,4)) else null end as [TotalPercentualOutroAbatimento] 
			,case when isnumeric([TotalProduto]) = 1 then cast((select(replace( [TotalProduto] ,',','.'))) as numeric(18,4)) else null end as [TotalProduto] 
			,case when isnumeric([TotalServico]) = 1 then cast((select(replace( [TotalServico] ,',','.'))) as numeric(18,4)) else null end as [TotalServico] 
			,case when isnumeric([TotalTroco]) = 1 then cast((select(replace( [TotalTroco] ,',','.'))) as numeric(18,4)) else null end as [TotalTroco] 
			,case when isnumeric([ValorAbertura]) = 1 then cast((select(replace( [ValorAbertura] ,',','.'))) as numeric(18,4)) else null end as [ValorAbertura] 
			,case when isnumeric([ValorBaseIcmsSt]) = 1 then cast((select(replace( [ValorBaseIcmsSt] ,',','.'))) as numeric(18,4)) else null end as [ValorBaseIcmsSt] 
			,case when isnumeric([ValorBaseIcms]) = 1 then cast((select(replace( [ValorBaseIcms] ,',','.'))) as numeric(18,4)) else null end as [ValorBaseIcms] 
			,case when isnumeric([ValorDescontoProduto]) = 1 then cast((select(replace( [ValorDescontoProduto] ,',','.'))) as numeric(18,4)) else null end as [ValorDescontoProduto] 
			,case when isnumeric([ValorDescontoServico]) = 1 then cast((select(replace( [ValorDescontoServico] ,',','.'))) as numeric(18,4)) else null end as [ValorDescontoServico] 
			,case when isnumeric([ValorFrete]) = 1 then cast((select(replace( [ValorFrete] ,',','.'))) as numeric(18,4)) else null end as [ValorFrete] 
			,case when isnumeric([ValorIPI]) = 1 then cast((select(replace( [ValorIPI] ,',','.'))) as numeric(18,4)) else null end as [ValorIPI] 
			,case when isnumeric([ValorIcmsSt]) = 1 then cast((select(replace( [ValorIcmsSt] ,',','.'))) as numeric(18,4)) else null end as [ValorIcmsSt] 
			,case when isnumeric([ValorIcms]) = 1 then cast((select(replace( [ValorIcms] ,',','.'))) as numeric(18,4)) else null end as [ValorIcms] 
			,case when isnumeric([ValorOutrasDespesas]) = 1 then cast((select(replace( [ValorOutrasDespesas] ,',','.'))) as numeric(18,4)) else null end as [ValorOutrasDespesas] 
			,case when isnumeric([ValorSeguro]) = 1 then cast((select(replace( [ValorSeguro] ,',','.'))) as numeric(18,4)) else null end as [ValorSeguro]
	
			,DT.codigodocumento			 as idant
			,DT.codigodocumentoadicional as pedidoant
			,DT.codigoempresa			 as empresaant
			,DT.codigocontato			 as clienteant
			,DT.codigocontatovendedor	 as ordemant

		from documentotmp DT 
	    left join optisoul..Contato CE on DT.CodigoEmpresa collate Latin1_General_CI_AS = CE.codigoantigo collate Latin1_General_CI_AS 
		left join optisoul..Contato CCV on DT.CodigoContatoVendedor  collate Latin1_General_CI_AS = CCV.codigoantigo collate Latin1_General_CI_AS 
		left join optisoul..Contato CCD on DT.CodigoContatodigitador collate Latin1_General_CI_AS = CCD.codigoantigo collate Latin1_General_CI_AS 
		where dt.tipo is not null
		order by DT.codigodocumento desc

update Optisoul..documento set codigodocumentoadicional = do.codigodocumento
		from (select * from Optisoul..documento)  do 
		where do.idant=documento.pedidoant

ALTER TABLE Optisoul..Documento ENABLE TRIGGER ALL