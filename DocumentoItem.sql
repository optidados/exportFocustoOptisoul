//NOSQLBDETOFF2
drop table if exists DocumentoItem;
--Create table documentoitem (principal)
create table DocumentoItem
(
	CodigoDocumento	varchar(30), --not null
	CodigoDocumentoAdicional varchar(30), --null
	CodigoPlanoContaEstoque	int, --null
	CodigoPlanoContaDestino	int, --null
	CodigoItem varchar(255), -- int->varchar(14) not null
	CodigoItemDNA int, --null
	Lote varchar(50), --null
	LoteEmpresa	varchar(50), --null
	ReferenciaFornecedor varchar(30), --null
	DescricaoItem varchar(255), --not null
	TipoItem varchar(45), --null
	NCM	varchar(8), --null
	CodigoDocumentoItemPai int, --null
	Operacao varchar(255), --not null
	OperacaoFator int, --null
	Status varchar(255), --null
	CodigoCFOP int, --null
	DescricaoAgrupamento varchar(255), --null
	ValorItem decimal(18,4), --not null
	ValorOriginal decimal(18,4), --not null
	ValorItemUltimo	decimal(18,4), --not null
	DescontoItem decimal(18,4), --not null
	DescontoPercentualItem decimal(18,4), --not null
	DescontoTotalRateado decimal(18,4), --not null
	DescontoFaturaRateado decimal(18,4),
	ValorFreteRateado decimal(18,4), --not null
	ValorSeguroRateado decimal(18,4), --not null
	ValorOutrasDespesasRateado decimal(18,4), --not null
	Quantidade decimal(18,6), --not null
	QuantidadeRealizado	decimal(18,6), --not null
	QuantidadeConferido	decimal(18,6), --not null
	Unidade	varchar(10), --null
	SubTotal decimal(18,4), --not null
	DescontoSubTotal decimal(18,4), --not null
	DescontoPercentualSubTotal decimal(18,4), --not null
	Total decimal(18,4), --not null
	Observacao varchar(8000), --null [varchar(max)]--> varchar(8000)
	ValorReal decimal(18,4), --not null
	ValorRealTotal decimal(18,4), --not null
	ValorRealTotalImpostos decimal(18,4), --not null
	ValorCusto decimal(18,4), --not null
	ValorCustoUltimo decimal(18,4), --not null
	ValorCustoMedio	decimal(18,4), --not null
	ValorCustoTerceiro decimal(18,4), --not null
	ValorCustoReposicao	decimal(18,4), --not null
	DataHoraEmissao	date, --not null
	DataHoraFinalizado date, --null
	CodigoCST int, --null
	ModalidadeBaseCalculo int, --null
	ValorBaseICMS decimal(18,4), --null
	CodigoCSTIPI int, --null
	ValorBaseIPI decimal(18,4), --null
	PercentualICMS decimal(18,4), --not null
	ValorICMS decimal(18,4), --not null
	PercentualIPI decimal(18,4), --not null
	ValorIPI decimal(18,4), --not null
	UnidadeTributada varchar(100), --null
	QuantidadeTributada	decimal(18,4), --not null
	ValorItemTributado decimal(18,4), --not null
	DataValidadeLote date, --null
	QuantidadeUltimo decimal(18,4), --null
	DataUltimaVenda	date, --null
	ModalidadeBaseCalculoST	int, --null
	PercentualIVA decimal(18,4), --null
	ValorBaseIcmsSt	decimal(18,4), --null
	PercentualIcmsSt decimal(18,4), --null
	ValorIcmsSt	decimal(18,4), --null
	CodigoDocumentoVenda varchar(30), --null
	CodigoDocumentoItemVenda varchar(150),
	CodigoDocumentoRemessa int, --null
	CodigoDocumentoCompra int, --null
	CodigoDocumentoTriagem int, --null
	CodigoAntigo varchar(150), --null
	CRMGrupoMetaVendedor varchar(100), --null
	CRMGrupoMetaAssistente varchar(100), --null
	CRMItemNovo	int, --bit->int --null
	CodigoContatoFornecedor	int, --null
	Marca varchar(100), --null
	Modelo varchar(100), --null
	Genero varchar(100), --null
	Cor	varchar(100), --null
	Material varchar(100), --null
	Tamanho	varchar(100), --null
	Altura numeric(18,4), --null
	Largura	numeric(18,4), --null
	Comprimento	numeric(18,4), --null
	Diagonal numeric(18,4), --null
	Diametro varchar(10), --numeric(18,4)->varhcar(10) --null
	Eixo numeric(18,4), --null
	AdicaoInicial numeric(18,4), --null
	AdicaoFinal	numeric(18,4), --null
	AlturaMinima numeric(18,4), --null
	EsfericoInicial	numeric(18,4), --null
	EsfericoFinal numeric(18,4), --null
	Cilindrico numeric(18,4), --null
	AmarcaoCor varchar(100), --null
	ArmacaoMaterial	varchar(100), --null
	Haste numeric(18,4), --null
	Ponte numeric(18,4), --null
	RB1	varchar(5), --numeric(18,4)->varchar(5) --null
	RB2	numeric(18,4), --null
	Geometria varchar(20), --numeric(18,4)->varchar(20) --null
	IndiceRefracao numeric(18,4), --null
	Adicao numeric(18,4), --null
	Esferico numeric(18,4), --null
	PrescricaoAlterada boolean,
	Prisma varchar(100), --null
	Base varchar(10), --null
	DI numeric(18,4), --null
	DIOD numeric(18,4), --null
	DIOE numeric(18,4), --null
	Oculos varchar(100), --null
	TipoOculos varchar(100), --null
	TipoMontagem varchar(100), --null
	LenteTipo varchar(100) --null
);

create index CodDocIdx on DocumentoItem("CodigoDocumento");
create index CodDocAntIdx on DocumentoItem("CodigoAntigo");	
create index CodItIdx on DocumentoItem("CodigoItem");

--Produtos (carrello2, busta) e Devolução com tipo fornitura <> 0
insert into DocumentoItem
(
	select
		'item.car.' + CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		COALESCE(Item."CodigoAntigo", car2."codice a barre", '') as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		COALESCE(Item."DescricaoComercial", car2."descrizione", '') as DescricaoItem, --varchar(255) --not null
		CASE
			WHEN car2."tipo fornitura" = 5 THEN 'Serviço'
			WHEN (Item."Tipo" = 'Armação' or Item."Tipo" = 'Óculos Sol' or Item."Tipo" = 'Óculos Pronto' or car2."magazzino" = 0) THEN 'Armação'
			WHEN (((car2."magazzino" = 1) or (car2."magazzino" = 2)) and (car2."tipo fornitura dettaglio" = 2)) THEN 'LOD'
			WHEN (((car2."magazzino" = 1) or (car2."magazzino" = 2)) and (car2."tipo fornitura dettaglio" = 3)) THEN 'LOE'
			WHEN car2."tipo fornitura dettaglio" = 5 THEN 'TLOD'
			WHEN car2."tipo fornitura dettaglio" = 6 THEN 'TLOE'
			WHEN car2."magazzino" = 3 THEN 'Produto'
			WHEN car2."magazzino" = 4  THEN 'Serviço'
			WHEN Item."Tipo" = 'Lente Contato' THEN 'Lente de Contato Pronta'
			ELSE Item."Tipo"
		END as TipoItem, --varchar(45) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --not null
		-1 as OperacaoFator, --int --null
		CASE WHEN car2."pagato" THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
		261 as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		CAST(car2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null
		CAST(car2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
		CAST(car2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		CAST(car2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
		CAST(car2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
		0.0000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		CAST(car2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		CAST(car2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(car2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
		CAST(car2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
		COALESCE(CAST(mov."costo medio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
		car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		car2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar(100)) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		CAST(NULL as int) as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		'car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Asse1 L Dx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Asse1 M Dx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Asse1 V Dx"
								END
							) 
						END
					) 
				END		    		
	    	)		
			WHEN 3 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Asse1 L Sx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Asse1 M Sx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Asse1 V Sx"
								END
							) 
						END
					) 
				END		    		
	    	)
		END as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Cilindro L Dx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Cilindro M Dx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Cilindro V Dx"
								END
							) 
						END
					) 
				END		    		
	    	)		
			WHEN 3 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Cilindro L Sx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Cilindro M Sx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Cilindro V Sx"
								END
							) 
						END
					) 
				END		    		
	    	)
		END as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
	    CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN 
	    	(
	    		CASE WHEN b."occhiale da lontano" IS TRUE 
	    			THEN 
	    			(
	    				CASE WHEN b."occhiale da medio" IS TRUE 
	    					THEN b."Add M Dx" 
	    					ELSE 
    						(
    							CASE WHEN b."occhiale da vicino" IS TRUE
    								THEN b."Add V Dx"
    							END
    						)
	    				END
	    			)
	    		END
	    	)
	    	WHEN 3 THEN
    		(
	    		CASE WHEN b."occhiale da lontano" IS TRUE 
	    			THEN 
	    			(
	    				CASE WHEN b."occhiale da medio" IS TRUE 
	    					THEN b."Add M Sx" 
	    					ELSE 
    						(
    							CASE WHEN b."occhiale da vicino" IS TRUE
    								THEN b."Add V Sx"
    							END
    						)
	    				END
	    			)
	    		END
	    	)
		    ELSE CAST(NULL as numeric(18,4))
		END as Adicao, --numeric(18,4) --null	
	    CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Sfera L Dx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Sfera M Dx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Sfera V Dx"
								END
							) 
						END
					) 
				END		    		
	    	)		
			WHEN 3 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Sfera L Sx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Sfera M Sx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Sfera V Sx"
								END
							) 
						END
					) 
				END		    		
	    	)
		END as Esferico, --numeric(18,4) --null		
		False as PrescricaoAlterada, --boolean
		CAST(NULL as varchar) as Prisma, --varchar(100) --null
		CAST(NULL as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CASE WHEN car2."magazzino" = 0
			THEN 
				CASE 
					WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" >= b."tipo lente sx")) 
						THEN 
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN 
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" < b."tipo lente sx"))
		     			THEN 
		     			(
							CASE b."tipo lente sx"
								WHEN 1 THEN
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (b."lente propria sx"))
		     			THEN
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)     			
		     		WHEN ((b."lente propria dx") AND (NOT b."lente propria sx")) 
		     		THEN 
		     		    (
							CASE b."tipo lente sx"
								WHEN 1 THEN
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)                                                              
		     	END
		END as Oculos, --varchar(100) --null
		CASE
			WHEN ((car2."magazzino" = 0) and (b."occhiale da sole" = False)) THEN 'Vista'
			WHEN ((car2."magazzino" = 0) and (b."occhiale da sole" = True)) THEN 'Sol'
		END as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CASE WHEN car2."magazzino" = 1
			THEN 
				CASE 
					WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" >= b."tipo lente sx")) 
						THEN 
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" < b."tipo lente sx"))
		     			THEN 
		     			(
							CASE b."tipo lente sx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (b."lente propria sx"))
		     			THEN
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)     			
		     		WHEN ((b."lente propria dx") AND (NOT b."lente propria sx")) 
		     		THEN 
		     		    (
							CASE b."tipo lente sx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)                                                              
		     	END
		END as LenteTipo --varchar(100) --null

	from carrello2 as car2
		left join busta as b
		on (b."codice filiale" = car2."codice fornitura")

		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		left join movimenti as mov
		on (car2."codice filiale" = mov."codice riga carrello")

		left join Item
		on (('articoli.' + car2."codice articolo") = Item."CodigoAntigo")

		left join PrescricaoEnvelope as pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."Dias" = (CAST(b."data" as integer) - CAST(oc."data" as integer))))

	where
		((car2."tipo fornitura" <> 100) or (car2."tipo fornitura" = 100 and car2."quantita" < 0))
		and (car2."tipo fornitura" <> 0)
  	and(car2."tipo fornitura" <> 10)
);

--PRODUTOS (CARRELLO2, LENTIBUSTA) tipo fornitura = 10 LENTE DE CONTATO SURFAÇADA
insert into DocumentoItem
(
	select
		'item.car.' + CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		COALESCE(Item."CodigoAntigo", car2."codice a barre", '') as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		COALESCE(Item."DescricaoComercial", car2."descrizione", '') as DescricaoItem, --varchar(255) --not null
		CASE
			WHEN ((car2."magazzino" = 2) and (car2."tipo fornitura dettaglio" = 2)) THEN 'LOD'
			WHEN ((car2."magazzino" = 2) and (car2."tipo fornitura dettaglio" = 3)) THEN 'LOE'
		END as TipoItem, --varchar(45) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --not null
		-1 as OperacaoFator, --int --null
		CASE WHEN car2."pagato" THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
		261 as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		CAST(car2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null
		CAST(car2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
		CAST(car2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		CAST(car2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
		CAST(car2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
		0.0000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		CAST(car2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		CAST(car2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(car2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
		CAST(car2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
		COALESCE(CAST(mov."costo medio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
		car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		car2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar(100)) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		CAST(NULL as int) as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		'car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Asse Dx" as numeric(18,4)) )
			WHEN 3 THEN( CAST(lb."Asse Sx" as numeric(18,4)) )
		END as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Cilindro Dx" as numeric(18,4)) )
			WHEN 3 THEN( CAST(lb."Cilindro Sx" as numeric(18,4)) )
		END as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
	    CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Add Dx" as numeric(18,4)) )
	    	WHEN 3 THEN( CAST(lb."Add Sx" as numeric(18,4)) )
		END as Adicao, --numeric(18,4) --null	
	    CASE car2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Sfera Dx" as numeric(18,4)) )		
			WHEN 3 THEN( CAST(lb."Sfera Sx" as numeric(18,4)) )
		END as Esferico, --numeric(18,4) --null		
		False as PrescricaoAlterada, --boolean
		CAST(NULL as varchar) as Prisma, --varchar(100) --null
		CAST(NULL as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CASE
			WHEN car2."magazzino" = 2
			THEN
			(	
				CASE lb."Famiglia Dx"
					WHEN 'monofocal' THEN 'Monofocal'
					WHEN 'bifocal' THEN 'Bifocal'
					WHEN 'trifocal' THEN 'Multifocal'
					WHEN 'multifocal' THEN 'Multifocal'
					WHEN 'cosmética' THEN 'Cosmética'
				END
	 		)
			WHEN car2."magazzino" = 2
			THEN
			(
				CASE lb."Famiglia Sx"
					WHEN 'monofocal' THEN 'Monofocal'
					WHEN 'bifocal' THEN 'Bifocal'
					WHEN 'trifocal' THEN 'Multifocal'
					WHEN 'multifocal' THEN 'Multifocal'
					WHEN 'cosmética' THEN 'Cosmética'
				END
			)
		END as LenteTipo --varchar(100) --null

	from carrello2 as car2
		left join lentibusta as lb
		on (lb."codice filiale" = car2."codice fornitura")

		left join occhiali as oc
		on (oc."codice cliente" = lb."codice cliente")

		left join movimenti as mov
		on (car2."codice filiale" = mov."codice riga carrello")

		left join Item
		on (('articoli.' + car2."codice articolo") = Item."CodigoAntigo")

		left join PrescricaoEnvelope as pe
		on ((lb."codice filiale" = pe."CodigoEnvelope") and (pe."Dias" = (CAST(lb."data" as integer) - CAST(oc."data" as integer))))

	where
		(car2."tipo fornitura" = 10)
);

--Produtos (CARRELLO2) tipo fornitura = 0 VENDA DIRETA PELO CARRINHO
insert into DocumentoItem
(
	select
		CASE 
			WHEN (car2."magazzino" = 0 or car2."magazzino" = 2 or Item."Tipo" = 'Armação' or Item."Tipo" = 'Óculos Sol' or Item."Tipo" = 'Óculos Pronto' or Item."Tipo" = 'Lente Contato') THEN 'item.car2.' + CAST(car2."codice filiale" as varchar(12))
			ELSE 'item.car.' + CAST(car2."codice carrello" as varchar(12))
		END as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		COALESCE(Item."CodigoAntigo", car2."codice a barre", '') as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		COALESCE(Item."DescricaoComercial", car2."descrizione", '') as DescricaoItem, --varchar(255) --not null
		CASE 
			WHEN (Item."Tipo" = 'Armação' or Item."Tipo" = 'Óculos Sol' or Item."Tipo" = 'Óculos Pronto' or car2."magazzino" = 0) THEN 'Armação'
			WHEN (car2."magazzino" = 1 or Item."Tipo" = 'Lente') THEN 'Produto'
			WHEN (Item."Tipo" = 'Lente Contato' or car2."magazzino" = 2) THEN 'Lente de Contato Pronta'
			WHEN car2."magazzino" = 3 THEN 'Produto'
			WHEN car2."magazzino" = 4 THEN 'Serviço'
			ELSE Item."Tipo"
		END as TipoItem, --varchar(45) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --not null
		-1 as OperacaoFator, --int --null
		CASE WHEN car2."pagato" THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
		261 as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		CAST(car2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null
		CAST(car2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
		CAST(car2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		CAST(car2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
		CAST(car2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
		0.0000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		CAST(car2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		CAST(car2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(car2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
		CAST(car2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
		COALESCE(CAST(mov."costo medio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
		car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		car2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar(100)) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		CAST(NULL as int) as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as int) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		'car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
	    CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null	
	    CAST(NULL as numeric(18,4)) as Esferico, --numeric(18,4) --null		
		False as PrescricaoAlterada, --boolean
		CAST(NULL as varchar) as Prisma, --varchar(100) --null
		CAST(NULL as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CASE
			WHEN ((car2."magazzino" = 0) and (Item."Tipo" = 'Armação')) THEN 'Vista'
			WHEN ((car2."magazzino" = 0) and (Item."Tipo" = 'Óculos Sol')) THEN 'Sol'
		END as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from carrello2 as car2
		left join movimenti as mov
		on (car2."codice filiale" = mov."codice riga carrello")

		left join Item
		on (('articoli.' + car2."codice articolo") = Item."CodigoAntigo")

	where
		(car2."tipo fornitura" = 0)
		--and (car2."magazzino" <> 1)
);

--Prescrição (LONGE - OLHO DIREITO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(20))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --int (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		'' as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Direito' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Longe' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('odl.car.'+ CAST(car."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 L DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro L DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera L DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma L DX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base L DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."DI L" as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(oc."DI L DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(oc."DI L SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from carrello as car
		left join busta as b
		on (b."codice filiale" = car."codice fornitura")
		
		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		join PrescricaoEnvelope pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(car."tipo fornitura" <> 100)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 L DX",
		oc."Cilindro L DX",
		oc."Sfera L DX",
		oc."Prisma L DX",
		oc."Base L DX",
		oc."DI L",
		oc."DI L DX",
		oc."DI L SX"
);

--Prescrição (LONGE - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(20))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Esquerdo' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Longe' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('oel.car.'+ CAST(car."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 L SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro L SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera L SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma L SX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base L SX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from carrello as car
		left join busta as b
		on ( b."codice filiale" = car."codice fornitura" )
		
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		join PrescricaoEnvelope pe
		on (( b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(car."tipo fornitura" <> 100)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 L SX",
		oc."Cilindro L SX",
		oc."Sfera L SX",
		oc."Prisma L SX",
		oc."Base L SX"
);

--Prescrição (MEDIO - OLHO DIREITO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(20))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0'as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Direito' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Médio' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('odm.car.'+ CAST(car."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 M DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro M DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera M DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma M DX" as varchar) as Prisma, --varchar(100) --null
		CAST(oc."Base M DX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."DI M" as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(oc."DI M DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(oc."DI M SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from carrello as car
		left join busta as b
		on ( b."codice filiale" = car."codice fornitura" )
		
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		join PrescricaoEnvelope pe
		on (( b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(car."tipo fornitura" <> 100)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 M DX",
		oc."Cilindro M DX",
		oc."Sfera M DX",
		oc."Prisma M DX",
		oc."Base M DX",
		oc."DI M",
		oc."DI M DX",
		oc."DI M SX"
);

--Prescrição (MÉDIO - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --int (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Esquerdo' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Médio' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('oem.car.'+ CAST(car."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 M SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro M SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera M SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma M SX" as varchar) as Prisma, --varchar(100) --null
		CAST(oc."Base M SX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from carrello as car
		left join busta as b
		on ( b."codice filiale" = car."codice fornitura" )
		
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		join PrescricaoEnvelope pe
		on (( b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(car."tipo fornitura" <> 100)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 M SX",
		oc."Cilindro M SX",
		oc."Sfera M SX",
		oc."Prisma M SX",
		oc."Base M SX"
);

--Prescrição (PERTO - OLHO DIREITO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Direito' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Perto' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('odp.car.'+ CAST(car."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 V DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro V DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera V DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma V DX" as varchar) as Prisma, --varchar(100) --null
		CAST(oc."Base V DX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."DI V" as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(oc."DI V DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(oc."DI V SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from carrello as car
		left join busta as b
		on ( b."codice filiale" = car."codice fornitura" )
		
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		join PrescricaoEnvelope pe
		on (( b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(car."tipo fornitura" <> 100)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 V DX",
		oc."Cilindro V DX",
		oc."Sfera V DX",
		oc."Prisma V DX",
		oc."Base V DX",
		oc."DI V",
		oc."DI V DX",
		oc."DI V SX"
);

--Prescrição (PERTO - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar (int->varchar(30)) --null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Esquerdo' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Perto' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as int) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('oep.car.'+ CAST(car."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 V SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro V SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera V SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma V SX" as varchar) as Prisma, --varchar(100) --null
		CAST(oc."Base V SX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from carrello as car
		left join busta as b
		on ( b."codice filiale" = car."codice fornitura" )
		
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		join PrescricaoEnvelope pe
		on (( b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(car."tipo fornitura" <> 100)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 V SX",
		oc."Cilindro V SX",
		oc."Sfera V SX",
		oc."Prisma V SX",
		oc."Base V SX"
);

--Produtos (STORICOCARRELLO2, BUSTA) e Devolução com tipo fornitura <> 10
insert into DocumentoItem
(
	select
		'item.scar.' + CAST(scar2."codice carrello" as varchar(12)) as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		COALESCE(Item."CodigoAntigo", scar2."codice a barre", '') as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		COALESCE(Item."DescricaoComercial", scar2."descrizione", '') as DescricaoItem, --varchar(255) --not null
		CASE
			WHEN scar2."tipo fornitura" = 5 THEN 'Serviço'
			WHEN (Item."Tipo" = 'Armação' or Item."Tipo" = 'Óculos Sol' or Item."Tipo" = 'Óculos Pronto' or scar2."magazzino" = 0) THEN 'Armação'
			WHEN (((scar2."magazzino" = 1) or (scar2."magazzino" = 2)) and (scar2."tipo fornitura dettaglio" = 2)) THEN 'LOD'
			WHEN (((scar2."magazzino" = 1) or (scar2."magazzino" = 2)) and (scar2."tipo fornitura dettaglio" = 3)) THEN 'LOE'
			WHEN scar2."tipo fornitura dettaglio" = 5 THEN 'TLOD'
			WHEN scar2."tipo fornitura dettaglio" = 6 THEN 'TLOE'
			WHEN scar2."magazzino" = 3 THEN 'Produto'
			WHEN scar2."magazzino" = 4  THEN 'Serviço'
			WHEN Item."Tipo" = 'Lente Contato' THEN 'Lente de Contato Pronta'
			ELSE Item."Tipo"
		END as TipoItem, --varchar(45) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --not null
		-1 as OperacaoFator, --int --null
		CASE WHEN scar2."pagato" THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
		261 as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		CAST(scar2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null
		CAST(scar2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
		CAST(scar2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		CAST(scar2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
		CAST(scar2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
		0.0000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		CAST(scar2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		CAST(scar2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(scar2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
		CAST(scar2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
		COALESCE(CAST(mov."costo medio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
		scar2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		scar2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar(100)) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		CAST(NULL as int) as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		'scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Asse1 L Dx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Asse1 M Dx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Asse1 V Dx"
								END
							) 
						END
					) 
				END		    		
	    	)		
			WHEN 3 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Asse1 L Sx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Asse1 M Sx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Asse1 V Sx"
								END
							) 
						END
					) 
				END		    		
	    	)
		END as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Cilindro L Dx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Cilindro M Dx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Cilindro V Dx"
								END
							) 
						END
					) 
				END		    		
	    	)		
			WHEN 3 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Cilindro L Sx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Cilindro M Sx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Cilindro V Sx"
								END
							) 
						END
					) 
				END		    		
	    	)
		END as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
	    CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN 
	    	(
	    		CASE WHEN b."occhiale da lontano" IS TRUE 
	    			THEN 
	    			(
	    				CASE WHEN b."occhiale da medio" IS TRUE 
	    					THEN b."Add M Dx" 
	    					ELSE 
    						(
    							CASE WHEN b."occhiale da vicino" IS TRUE
    								THEN b."Add V Dx"
    							END
    						)
	    				END
	    			)
	    		END
	    	)
	    	WHEN 3 THEN
    		(
	    		CASE WHEN b."occhiale da lontano" IS TRUE 
	    			THEN 
	    			(
	    				CASE WHEN b."occhiale da medio" IS TRUE 
	    					THEN b."Add M Sx" 
	    					ELSE 
    						(
    							CASE WHEN b."occhiale da vicino" IS TRUE
    								THEN b."Add V Sx"
    							END
    						)
	    				END
	    			)
	    		END
	    	)
		    ELSE CAST(NULL as numeric(18,4))
		END as Adicao, --numeric(18,4) --null	
	    CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Sfera L Dx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Sfera M Dx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Sfera V Dx"
								END
							) 
						END
					) 
				END		    		
	    	)		
			WHEN 3 THEN
	    	(
				CASE WHEN b."occhiale da lontano" IS TRUE 
					THEN b."Sfera L Sx" 
					ELSE 
					(
						CASE WHEN b."occhiale da medio" IS TRUE 
							THEN b."Sfera M Sx"
							ELSE 
							(
								CASE WHEN b."occhiale da vicino" IS TRUE
									THEN b."Sfera V Sx"
								END
							) 
						END
					) 
				END		    		
	    	)
		END as Esferico, --numeric(18,4) --null		
		False as PrescricaoAlterada, --boolean
		CAST(NULL as varchar) as Prisma, --varchar(100) --null
		CAST(NULL as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CASE WHEN scar2."magazzino" = 0
			THEN 
				CASE 
					WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" >= b."tipo lente sx")) 
						THEN 
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN 
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" < b."tipo lente sx"))
		     			THEN 
		     			(
							CASE b."tipo lente sx"
								WHEN 1 THEN
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (b."lente propria sx"))
		     			THEN
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)     			
		     		WHEN ((b."lente propria dx") AND (NOT b."lente propria sx")) 
		     		THEN 
		     		    (
							CASE b."tipo lente sx"
								WHEN 1 THEN
									CASE 
										WHEN (b."occhiale da lontano") THEN 'MonofocalLonge'
										WHEN (b."occhiale da vicino") THEN 'MonofocalPerto'
									END
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Intermediario'
							END
						)                                                              
		     	END
		END as Oculos, --varchar(100) --null
		CASE
			WHEN ((scar2."magazzino" = 0) and (b."occhiale da sole" = False)) THEN 'Vista'
			WHEN ((scar2."magazzino" = 0) and (b."occhiale da sole" = True)) THEN 'Sol'
		END as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CASE WHEN scar2."magazzino" = 1
			THEN 
				CASE 
					WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" >= b."tipo lente sx")) 
						THEN 
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (NOT b."lente propria sx") AND (b."tipo lente dx" < b."tipo lente sx"))
		     			THEN 
		     			(
							CASE b."tipo lente sx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)
		     		WHEN ((NOT b."lente propria dx") AND (b."lente propria sx"))
		     			THEN
						(
							CASE b."tipo lente dx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)     			
		     		WHEN ((b."lente propria dx") AND (NOT b."lente propria sx")) 
		     		THEN 
		     		    (
							CASE b."tipo lente sx"
								WHEN 1 THEN 'Monofocal'
								WHEN 2 THEN 'Bifocal'
								WHEN 3 THEN 'Multifocal'
								WHEN 4 THEN 'Monofocal'
							END
						)                                                              
		     	END
		END as LenteTipo --varchar(100) --null

	from storicocarrello2 as scar2
		left join busta as b
		on (b."codice filiale" = scar2."codice fornitura")

		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		left join movimenti as mov
		on (scar2."codice filiale" = mov."codice riga carrello")

		left join Item
		on (('articoli.' + scar2."codice articolo") = Item."CodigoAntigo")

		left join PrescricaoEnvelope as pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."Dias" = (CAST(b."data" as integer) - CAST(oc."data" as integer))))

	where
		((scar2."tipo fornitura" <> 100) or (scar2."tipo fornitura" = 100 and scar2."quantita" < 0)) and
		(scar2."tipo fornitura" <> 101) and
		(scar2."tipo fornitura" <> 0)
);

--Produtos (STORICOCARRELLO2, LENTIBUSTA) = TF10 LENTE DE CONTATO SURFAÇADA
insert into DocumentoItem
(
	select
		'item.scar.' + CAST(scar2."codice carrello" as varchar(12)) as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		COALESCE(Item."CodigoAntigo", scar2."codice a barre", '') as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		COALESCE(Item."DescricaoComercial", scar2."descrizione", '') as DescricaoItem, --varchar(255) --not null
		CASE
			WHEN ((scar2."magazzino" = 2) and (scar2."tipo fornitura dettaglio" = 2)) THEN 'LOD'
			WHEN ((scar2."magazzino" = 2) and (scar2."tipo fornitura dettaglio" = 3)) THEN 'LOE'
		END as TipoItem, --varchar(45) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --not null
		-1 as OperacaoFator, --int --null
		CASE WHEN scar2."pagato" THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
		261 as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		CAST(scar2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null
		CAST(scar2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
		CAST(scar2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		CAST(scar2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
		CAST(scar2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
		0.0000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		CAST(scar2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		CAST(scar2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(scar2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
		CAST(scar2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
		COALESCE(CAST(mov."costo medio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
		scar2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		scar2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar(100)) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		CAST(NULL as int) as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		'scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Asse Dx" as numeric(18,4)) )
			WHEN 3 THEN( CAST(lb."Asse Sx" as numeric(18,4)) )
		END as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Cilindro Dx" as numeric(18,4)) )
			WHEN 3 THEN( CAST(lb."Cilindro Sx" as numeric(18,4)) )
		END as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
	    CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Add Dx" as numeric(18,4)) )
	    	WHEN 3 THEN( CAST(lb."Add Sx" as numeric(18,4)) )
		END as Adicao, --numeric(18,4) --null	
	    CASE scar2."tipo fornitura dettaglio"
	    	WHEN 2 THEN( CAST(lb."Sfera Dx" as numeric(18,4)) )		
			WHEN 3 THEN( CAST(lb."Sfera Sx" as numeric(18,4)) )
		END as Esferico, --numeric(18,4) --null		
		False as PrescricaoAlterada, --boolean
		CAST(NULL as varchar) as Prisma, --varchar(100) --null
		CAST(NULL as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CASE
			WHEN scar2."magazzino" = 2
			THEN
			(
				CASE lb."Famiglia Dx"
					WHEN 'monofocal' THEN 'Monofocal'
					WHEN 'bifocal' THEN 'Bifocal'
					WHEN 'trifocal' THEN 'Multifocal'
					WHEN 'multifocal' THEN 'Multifocal'
					WHEN 'cosmética' THEN 'Cosmética'
				END
			)
			WHEN scar2."magazzino" = 2
			THEN
 			(
				CASE lb."Famiglia Sx"
					WHEN 'monofocal' THEN 'Monofocal'
					WHEN 'bifocal' THEN 'Bifocal'
					WHEN 'trifocal' THEN 'Multifocal'
					WHEN 'multifocal' THEN 'Multifocal'
					WHEN 'cosmética' THEN 'Cosmética'
				END
			)
		END as LenteTipo --varchar(100) --null

	from storicocarrello2 as scar2
		left join lentibusta as lb
		on (lb."codice filiale" = scar2."codice fornitura")

		left join occhiali as oc
		on (oc."codice cliente" = lb."codice cliente")

		left join movimenti as mov
		on (scar2."codice filiale" = mov."codice riga carrello")

		left join Item
		on (('articoli.' + scar2."codice articolo") = Item."CodigoAntigo")

		left join PrescricaoEnvelope as pe
		on ((lb."codice filiale" = pe."CodigoEnvelope") and (pe."Dias" = (CAST(lb."data" as integer) - CAST(oc."data" as integer))))

	where
		(scar2."tipo fornitura" = 10)
);

--produtos (STORICOCARRELLO2) TIPO FORNITURA = 0
insert into DocumentoItem
(
	select
		CASE 
			WHEN (scar2."magazzino" = 0 or scar2."magazzino" = 2 or Item."Tipo" = 'Armação' or Item."Tipo" = 'Óculos Sol' or Item."Tipo" = 'Óculos Pronto' or Item."Tipo" = 'Lente Contato') THEN 'item.scar2.' + CAST(scar2."codice filiale" as varchar(12))
			ELSE 'item.scar.' + CAST(scar2."codice carrello" as varchar(12))
		END as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		COALESCE(Item."CodigoAntigo", scar2."codice a barre", '') as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		COALESCE(Item."DescricaoComercial", scar2."descrizione", '') as DescricaoItem, --varchar(255) --not null
		CASE 
			WHEN (Item."Tipo" = 'Armação' or Item."Tipo" = 'Óculos Sol' or Item."Tipo" = 'Óculos Pronto' or scar2."magazzino" = 0) THEN 'Armação'
			WHEN (scar2."magazzino" = 1 or Item."Tipo" = 'Lente') THEN 'Produto'
			WHEN (Item."Tipo" = 'Lente Contato' or scar2."magazzino" = 2) THEN 'Lente de Contato Pronta'
			WHEN scar2."magazzino" = 3 THEN 'Produto'
			WHEN scar2."magazzino" = 4 THEN 'Serviço'
			ELSE Item."Tipo"
		END as TipoItem, --varchar(45) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --not null
		-1 as OperacaoFator, --int --null
		CASE WHEN scar2."pagato" THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
		261 as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		CAST(scar2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null
		CAST(scar2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
		CAST(scar2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		CAST(scar2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
		CAST(scar2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
		0.0000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		CAST(scar2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		CAST(scar2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(scar2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
		CAST(scar2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
		COALESCE(CAST(mov."costo medio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
		scar2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		scar2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar(100)) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		CAST(NULL as int) as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		'scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
	    CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null	
	    CAST(NULL as numeric(18,4)) as Esferico, --numeric(18,4) --null		
		False as PrescricaoAlterada, --boolean
		CAST(NULL as varchar) as Prisma, --varchar(100) --null
		CAST(NULL as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CASE
			WHEN ((scar2."magazzino" = 0) and (Item."Tipo" = 'Armação')) THEN 'Vista'
			WHEN ((scar2."magazzino" = 0) and (Item."Tipo" = 'Óculos Sol')) THEN 'Sol'
		END as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from storicocarrello2 as scar2
		left join movimenti as mov
		on (scar2."codice filiale" = mov."codice riga carrello")

		left join Item
		on (('articoli.' + scar2."codice articolo") = Item."CodigoAntigo")

	where
		(scar2."tipo fornitura" = 0)
		--and (scar2."magazzino" <> 1)
);

--Prescrição (LONGE - OLHO DIREITO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(20))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --int (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --int not null
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		'' as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Direito' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Longe' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('odl.scar.'+ CAST(scar."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 L DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro L DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera L DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma L DX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base L DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."DI L" as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(oc."DI L DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(oc."DI L SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")
		
		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		join PrescricaoEnvelope pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 L DX",
		oc."Cilindro L DX",
		oc."Sfera L DX",
		oc."Prisma L DX",
		oc."Base L DX",
		oc."DI L",
		oc."DI L DX",
		oc."DI L SX"
);

--Prescrição (LONGE - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(20))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --scar2."codice a barre" ou scar2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Esquerdo' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Longe' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('oel.scar.'+ CAST(scar."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 L SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro L SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera L SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma L SX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base L SX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")
		
		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		join PrescricaoEnvelope pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 L SX",
		oc."Cilindro L SX",
		oc."Sfera L SX",
		oc."Prisma L SX",
		oc."Base L SX"
);

--Prescrição (MEDIO - OLHO DIREITO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(20))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0'as CodigoItem, --scar2."codice a barre" ou scar2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Direito' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Médio' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('odm.scar.'+ CAST(scar."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 M DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro M DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera M DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma M DX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base M DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."DI M" as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(oc."DI M DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(oc."DI M SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")
		
		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		join PrescricaoEnvelope pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 M DX",
		oc."Cilindro M DX",
		oc."Sfera M DX",
		oc."Prisma M DX",
		oc."Base M DX",
		oc."DI M",
		oc."DI M DX",
		oc."DI M SX"
);

--Prescrição (MÉDIO - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --int (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --scar2."codice a barre" ou scar2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Esquerdo' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Médio' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('oem.scar.'+ CAST(scar."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 M SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro M SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera M SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma M SX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base M SX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")
		
		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		join PrescricaoEnvelope pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 M SX",
		oc."Cilindro M SX",
		oc."Sfera M SX",
		oc."Prisma M SX",
		oc."Base M SX"
);

--Prescrição (PERTO - OLHO DIREITO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))--null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --scar2."codice a barre" ou scar2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Direito' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Perto' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('odp.scar.'+ CAST(scar."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 V DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro V DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera V DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma V DX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base V DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."DI V" as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(oc."DI V DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(oc."DI V SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")
		
		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		join PrescricaoEnvelope pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 V DX",
		oc."Cilindro V DX",
		oc."Sfera V DX",
		oc."Prisma V DX",
		oc."Base V DX",
		oc."DI V",
		oc."DI V DX",
		oc."DI V SX"
);

--Prescrição (PERTO - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItem
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30))--null
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar (int->varchar(30)) --null
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		'0' as CodigoItem, --scar2."codice a barre" ou scar2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
		CAST(NULL as int) as CodigoItemDNA, --int --null
		CAST(NULL as varchar) as Lote, --varchar(50) --null
		CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
		CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		CAST(NULL as varchar) as DescricaoItem, --varchar(255) --not null
		'Prescrição' as TipoItem, --varchar(255) --null
		CAST(NULL as varchar) as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Olho Esquerdo' as Operacao, --varchar(255) --not null
		CAST(NULL as int) as OperacaoFator, --int --null
		'Perto' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as DescontoFaturaRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		0.000000 as Quantidade, --decimal(18,6) --not null
		0.000000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.000000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		0.0000 as SubTotal, --decimal(18,4) --not null
		0.0000 as DescontoSubTotal, --decimal(18,4) --not null
		0.0000 as DescontoPercentualSubTotal, --decimal(18,4) --not null
		0.0000 as Total, --decimal(18,4) --not null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		0.0000 as ValorReal, --decimal(18,4) --not null
		0.0000 as ValorRealTotal, --decimal(18,4) --not null
		0.0000 as ValorRealTotalImpostos, --decimal(18,4) --not null
		0.0000 as ValorCusto, --decimal(18,4) --not null
		0.0000 as ValorCustoUltimo, --decimal(18,4) --not null
		0.0000 as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		0.0000 as ValorCustoReposicao, --decimal(18,4) --not null
		oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (datetime->date) --null
		CAST(NULL as int) as CodigoCST, --int --null
		CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
		0.0000 as ValorBaseICMS, --decimal(18,4) --null
		CAST(NULL as int) as CodigoCSTIPI, --int --null
		CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
		0.0000 as PercentualICMS, --decimal(18,4) --not null
		0.0000 as ValorICMS, --decimal(18,4) --not null
		0.0000 as PercentualIPI, --decimal(18,4) --not null
		0.0000 as ValorIPI, --decimal(18,4) --not null
		CAST(NULL as varchar) as UnidadeTributada, --varchar(100) --null
		0.0000 as QuantidadeTributada, --decimal(18,4) --not null
		0.0000 as ValorItemTributado, --decimal(18,4) --not null
		CAST(NULL as date) as DataValidadeLote, --date --null
		CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
		CAST(NULL as date) as DataUltimaVenda, --datetime, --null
		0 as ModalidadeBaseCalculoST, --int, --null
		CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
		CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
		CAST(NULL as varchar) as CodigoDocumentoVenda, --int, --null
		CAST(NULL as varchar) as CodigoDocumentoItemVenda,
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		MIN('oep.scar.'+ CAST(scar."codice filiale" as varchar(12))) as CodigoAntigo, --varchar(150) --null
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		CAST(NULL as varchar) as Marca, --varchar(100) --null
		CAST(NULL as varchar) as Modelo, --varchar(100) --null
		CAST(NULL as varchar) as Genero, --varchar(100) --null
		CAST(NULL as varchar) as Cor, --varchar(100) --null
		CAST(NULL as varchar) as Material, --varchar(100) --null
		CAST(NULL as varchar) as Tamanho, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		CAST(NULL as varchar) as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		CAST(oc."Asse1 V SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		CAST(oc."Cilindro V SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
		CAST(NULL as varchar) as AmarcaoCor, --varchar(100) --null
		CAST(NULL as varchar) as ArmacaoMaterial, --varchar(100) --null
		CAST(NULL as numeric(18,4)) as Haste, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as Adicao, --numeric(18,4) --null
		CAST(oc."Sfera V SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
		False as PrescricaoAlterada, --boolean
		CAST(oc."Prisma V SX" as varchar(100)) as Prisma, --varchar(100) --null
		CAST(oc."Base V SX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")
		
		left join occhiali as oc
		on (oc."codice cliente" = b."codice cliente")

		join PrescricaoEnvelope pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."dias" = (CAST(b."data" as int) - CAST(oc."data" as int))))

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)

	group by
		oc."codice filiale",
		oc."data",
		oc."Asse1 V SX",
		oc."Cilindro V SX",
		oc."Sfera V SX",
		oc."Prisma V SX",
		oc."Base V SX"
);