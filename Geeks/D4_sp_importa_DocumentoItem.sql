ALTER procedure [dbo].[D4_sp_importa_DocumentoItem] as

drop table if exists DocumentoItemTmp;
--Create table documentoitem (principal)
create table DocumentoItemTmp
(
	CodigoDocumento	varchar(30), --not null
	CodigoDocumentoAdicional varchar(30), --null
	CodigoPlanoContaEstoque	int, --null
	CodigoPlanoContaDestino	int, --null
	CodigoItem int, -- int not null
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
	Observacao varchar(max), --null [varchar(max)]--> varchar(8000)
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
	Diametro numeric(18,4), --numeric(18,4) null
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
	RB1	numeric(18,4), --numeric(18,4) --null
	RB2	numeric(18,4), --null
	Geometria varchar(20), --varchar(20) --null
	IndiceRefracao numeric(18,4), --null
	Adicao numeric(18,4), --null
	Esferico numeric(18,4), --null
	PrescricaoAlterada bit,
	Prisma numeric(18,4), --null
	Base varchar(10), --null
	DI numeric(18,4), --null
	DIOD numeric(18,4), --null
	DIOE numeric(18,4), --null
	Oculos varchar(100), --null
	TipoOculos varchar(100), --null
	TipoMontagem varchar(100), --null
	LenteTipo varchar(100) --null
);
/*
create index CodDocIdx on DocumentoItem("CodigoDocumento");
create index CodDocAntIdx on DocumentoItem("CodigoAntigo");	
create index CodItIdx on DocumentoItem("CodigoItem");
*/
--VENDAS (DIRETO NO CARRINHO) E DEVOLUCAO CARRELLO2
--SEM BUSTA E LENTIBUSTA
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	OperacaoFator,	Status,	CodigoCFOP,	ValorItem,	ValorOriginal,	DescontoItem,	DescontoPercentualItem,	Quantidade,	QuantidadeRealizado,	Unidade,	SubTotal,	Total,	ValorReal,	ValorRealTotal,	ValorCusto,	ValorCustoUltimo,	ValorCustoMedio,	ValorCustoReposicao,	DataHoraEmissao,	DataHoraFinalizado,	CodigoAntigo,	Marca,	Modelo,	Genero,	Cor,	Material,	Tamanho,	Altura,	Diagonal,	Diametro,	Eixo,	Cilindrico,	AmarcaoCor,	ArmacaoMaterial,	Haste,	Ponte,	RB1,	RB2,	Geometria,	IndiceRefracao,	Adicao,	Esferico,	TipoOculos,	TipoMontagem,	LenteTipo)

select
	v.CodigoDocumento as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
	--r.CodigoDocumento as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	COALESCE(Item."CodigoItem", /*car2."codice a barre",*/ 0) as CodigoItem, --codice a barre nao eh int
	COALESCE(Item."DescricaoComercial", car2."descrizione", '') as DescricaoItem, --varchar(255) --not null
	CASE
		WHEN car2."tipo fornitura" = 0 and (car2."magazzino" = 1 or Item."Tipo" = 'Lente') THEN 'Produto'
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
	'Venda de Mercadoria' as Operacao, --varchar(255) --not null
	-1 as OperacaoFator, --int --null
	CASE WHEN car2."pagato" = 1 THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
	261 as CodigoCFOP, --int --null
	CAST(car2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), CAST(item."ValorVenda" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
	CAST(car2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
	CAST(car2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
	CAST(car2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
	CAST(car2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
	'UN' as Unidade, --varchar(10) --null
	CAST(car2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
	CAST(car2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
	CAST(car2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
	CAST(car2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCusto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoUltimo" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
	COALESCE(CAST(mov."costo medio" as decimal(18,4)), CAST(item."ValorCustoMedio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoReposicao" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	car2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
	'car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	Item."Marca" as Marca, --varchar(100) --null
	Item."Modelo" as Modelo, --varchar(100) --null
	Item."Genero" as Genero, --varchar(100) --null
	Item."Cor" as Cor, --varchar(100) --null
	Item."Material" as Material, --varchar(100) --null
	CAST(Item."Tamanho" as varchar(100)) as Tamanho, --varchar(100) --null
	Item."Altura" as Altura, --numeric(18,4) --null
	Item."Diagonal" as Diagonal, --numeric(18,4) --null
	Item."Diametro" as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
	Item."Eixo", --numeric(18,4) --null
	Item."Cilindrico", --numeric(18,4) --null
	Item."AmarcaoCor" as AmarcaoCor, --varchar(100) --null
	Item."ArmacaoMaterial" as ArmacaoMaterial, --varchar(100) --null
	Item."Haste" as Haste, --numeric(18,4) --null
	Item."Ponte" as Ponte, --numeric(18,4) --null
	Item."RB1" as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
	Item."RB2" as RB2, --numeric(18,4) --null
	Item."Geometria" as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
	Item."IndiceRefracao" as IndiceRefracao, --numeric(18,4) --null
	CASE WHEN Item."AdicaoInicial" = Item."AdicaoFinal" THEN Item."AdicaoInicial" ELSE CAST(NULL as numeric(18,4)) END as Adicao, --numeric(18,4) --null	
	CASE WHEN Item."EsfericoInicial" = Item."EsfericoFinal" THEN Item."EsfericoInicial" ELSE CAST(NULL as numeric(18,4)) END as Esferico, --numeric(18,4) --null
	CASE
		WHEN ((car2."magazzino" = 0) and (Item."Tipo" = 'Armação')) THEN 'Vista'
		WHEN ((car2."magazzino" = 0) and (Item."Tipo" = 'Óculos Sol')) THEN 'Sol'
	END as TipoOculos, --varchar(100) --null
	Item."TipoMontagem" as TipoMontagem, --varchar(100) --null
	Item."LenteTipo" as LenteTipo --varchar(100) --null

from carrello2 as car2 
	inner join Optisoul..Documento as v 
	on v.idant = ('item.car.' + CAST(car2."codice carrello" as varchar(12)))
	/*
	left join busta as b
	on (b."codice filiale" = car2."codice fornitura")

	left join lentibusta as lb
	on (lb."codice filiale" = car2."codice fornitura")

	left join occhiali as oc
	on (oc."codice cliente" = COALESCE(b."codice cliente", lb."codice cliente"))
	
	left join Optisoul..Documento as r 
	on r.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12))
	*/
	left join movimenti as mov
	on (car2."codice filiale" = mov."codice riga carrello")

	left join Optisoul..Item
	on (('articoli.' + car2."codice articolo") = Item."CodigoAntigo")
	/*
	join PrescricaoEnvelope as pe
	on ((COALESCE(b."codice filiale", lb."codice filiale") = pe."CodigoEnvelope") and (pe."Dias" = (DATEDIFF(day, COALESCE(b."data", lb."data"), oc."data"))))
	*/
where
	( /*devolucoes*/ 
		((car2."tipo fornitura" <> 100) or (car2."tipo fornitura" = 100 and car2."quantita" < 0))
		and (car2."tipo fornitura" <> 0)
		--and(car2."tipo fornitura" <> 10)
		and (COALESCE(car2."codice fornitura",'') = '')
	)
	or ( /*venda direta no carrinho*/
		(car2."tipo fornitura" = 0)
	)


--Produtos CARRELLO2
--COM BUSTA e LENTIBUSTA
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoDocumentoAdicional,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	OperacaoFator,	Status,	CodigoCFOP,	ValorItem,	ValorOriginal,	DescontoItem,	DescontoPercentualItem,	Quantidade,	QuantidadeRealizado,	Unidade,	SubTotal,	Total,	ValorReal,	ValorRealTotal,	ValorCusto,	ValorCustoUltimo,	ValorCustoMedio,	ValorCustoReposicao,	DataHoraEmissao,	DataHoraFinalizado,	CodigoAntigo,	Marca,	Modelo,	Genero,	Cor,	Material,	Tamanho,	Altura,	Diagonal,	Diametro,	Eixo,	Cilindrico,	AmarcaoCor,	ArmacaoMaterial,	Haste,	Ponte,	RB1,	RB2,	Geometria,	IndiceRefracao,	Adicao,	Esferico,	Oculos,	TipoOculos,	TipoMontagem,	LenteTipo)
select
	v.CodigoDocumento as CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
	CASE car2."tipo fornitura"
		WHEN 1 THEN r.CodigoDocumento
		WHEN 3 THEN r.CodigoDocumento
		WHEN 10 THEN r.CodigoDocumento
	END as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	COALESCE(Item."CodigoItem", /*car2."codice a barre",*/ 0) as CodigoItem, --codice a barre nao eh int
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
	'Venda de Mercadoria' as Operacao, --varchar(255) --not null
	-1 as OperacaoFator, --int --null
	CASE WHEN car2."pagato" = 1 THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
	261 as CodigoCFOP, --int --null
	CAST(car2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), CAST(item."ValorVenda" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
	CAST(car2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
	CAST(car2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
	CAST(car2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
	CAST(car2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
	'UN' as Unidade, --varchar(10) --null
	CAST(car2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
	CAST(car2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
	CAST(car2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
	CAST(car2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCusto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoUltimo" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
	COALESCE(CAST(mov."costo medio" as decimal(18,4)), CAST(item."ValorCustoMedio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoReposicao" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	car2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
	'car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	Item."Marca" as Marca, --varchar(100) --null
	Item."Modelo" as Modelo, --varchar(100) --null
	Item."Genero" as Genero, --varchar(100) --null
	Item."Cor" as Cor, --varchar(100) --null
	Item."Material" as Material, --varchar(100) --null
	CAST(Item."Tamanho" as varchar(100)) as Tamanho, --varchar(100) --null
	Item."Altura" as Altura, --numeric(18,4) --null
	Item."Diagonal" as Diagonal, --numeric(18,4) --null
	Item."Diametro" as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
	CASE car2."magazzino"
		WHEN 1 THEN
		(
			CASE car2."tipo fornitura dettaglio"
			    WHEN 2 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1 
						THEN b."Asse1 L Dx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1 
								THEN b."Asse1 M Dx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Asse1 V Dx"
									END
								) 
							END
						) 
					END		    		
			    )		
				WHEN 3 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1 
						THEN b."Asse1 L Sx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Asse1 M Sx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Asse1 V Sx"
									END
								) 
							END
						) 
					END		    		
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE car2."tipo fornitura dettaglio"
			    WHEN 2 THEN lb."Asse Dx"
				WHEN 3 THEN lb."Asse Sx"
			END
		)
	END as Eixo, --numeric(18,4) --null
	CASE car2."magazzino"
		WHEN 1 THEN
		(
			CASE car2."tipo fornitura dettaglio"
			    WHEN 2 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1 
						THEN b."Cilindro L Dx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Cilindro M Dx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Cilindro V Dx"
									END
								) 
							END
						) 
					END		    		
			    )		
				WHEN 3 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Cilindro L Sx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Cilindro M Sx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Cilindro V Sx"
									END
								) 
							END
						) 
					END		    		
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE car2."tipo fornitura dettaglio"
				WHEN 2 THEN lb."Cilindro Dx"
				WHEN 3 THEN lb."Cilindro Sx"
			END
		)
	END as Cilindrico, --numeric(18,4) --null
	Item."AmarcaoCor" as AmarcaoCor, --varchar(100) --null
	Item."ArmacaoMaterial" as ArmacaoMaterial, --varchar(100) --null
	Item."Haste" as Haste, --numeric(18,4) --null
	Item."Ponte" as Ponte, --numeric(18,4) --null
	Item."RB1" as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
	Item."RB2" as RB2, --numeric(18,4) --null
	Item."Geometria" as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
	Item."IndiceRefracao" as IndiceRefracao, --numeric(18,4) --null
	CASE car2."magazzino"
		WHEN 1 THEN
		(
			CASE car2."tipo fornitura dettaglio"
			    WHEN 2 THEN 
			    (
			    	CASE WHEN b."occhiale da lontano" = 1
			    		THEN 
			    		(
			    			CASE WHEN b."occhiale da medio" = 1
			    				THEN b."Add M Dx" 
			    				ELSE 
		    					(
		    						CASE WHEN b."occhiale da vicino" = 1
		    							THEN b."Add V Dx"
		    						END
		    					)
			    			END
			    		)
			    	END
			    )
			    WHEN 3 THEN
		    	(
			    	CASE WHEN b."occhiale da lontano" = 1
			    		THEN 
			    		(
			    			CASE WHEN b."occhiale da medio" = 1
			    				THEN b."Add M Sx" 
			    				ELSE 
		    					(
		    						CASE WHEN b."occhiale da vicino" = 1
		    							THEN b."Add V Sx"
		    						END
		    					)
			    			END
			    		)
			    	END
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE car2."tipo fornitura dettaglio"
			    WHEN 2 THEN lb."Add Dx"
			    WHEN 3 THEN lb."Add Sx"
			END
		)
	END as Adicao, --numeric(18,4) --null
	CASE car2."magazzino"
		WHEN 1 THEN
		(	
			CASE car2."tipo fornitura dettaglio"
			    WHEN 2 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Sfera L Dx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Sfera M Dx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Sfera V Dx"
									END
								) 
							END
						) 
					END		    		
			    )		
				WHEN 3 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Sfera L Sx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Sfera M Sx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Sfera V Sx"
									END
								) 
							END
						) 
					END		    		
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE car2."tipo fornitura dettaglio"
			    WHEN 2 THEN lb."Sfera Dx"
				WHEN 3 THEN lb."Sfera Sx"
			END
		)
	END as Esferico, --numeric(18,4) --null		
	CASE WHEN car2."magazzino" = 0
		THEN 
			CASE 
				WHEN (NOT(b."lente propria dx" = 1) AND NOT(b."lente propria sx" = 1) AND (b."tipo lente dx" >= b."tipo lente sx")) 
					THEN 
					(
						CASE b."tipo lente dx"
							WHEN 1 THEN 
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)
		     	WHEN (NOT(b."lente propria dx" = 1) AND NOT(b."lente propria sx" = 1) AND (b."tipo lente dx" < b."tipo lente sx"))
		     		THEN 
		     		(
						CASE b."tipo lente sx"
							WHEN 1 THEN
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)
		     	WHEN (NOT(b."lente propria dx" = 1) AND (b."lente propria sx" = 1))
		     		THEN
					(
						CASE b."tipo lente dx"
							WHEN 1 THEN
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)     			
		     	WHEN ((b."lente propria dx" = 1) AND NOT(b."lente propria sx" = 1)) 
		     	THEN 
		     		(
						CASE b."tipo lente sx"
							WHEN 1 THEN
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)                                                              
		    END
	END as Oculos, --varchar(100) --null
	CASE
		WHEN ((car2."magazzino" = 0) and (b."occhiale da sole" = 0)) THEN 'Vista'
		WHEN ((car2."magazzino" = 0) and (b."occhiale da sole" = 1)) THEN 'Sol'
	END as TipoOculos, --varchar(100) --null
	Item."TipoMontagem" as TipoMontagem, --varchar(100) --null
	Item."LenteTipo" as LenteTipo --varchar(100) --null

from carrello2 as car2 
	inner join Optisoul..Documento as v 
	on v.idant = ('item.car.' + CAST(car2."codice carrello" as varchar(12)))

	left join busta as b
	on (b."codice filiale" = car2."codice fornitura")
	
	left join lentibusta as lb
	on (lb."codice filiale" = car2."codice fornitura")

	inner join PrescricaoEnvelope as pe
	on (COALESCE(b."codice filiale", lb."codice filiale") = pe."CodigoEnvelope")
	
	left join occhiali as oc
	on (oc."codice filiale" = pe."CodigoReceita")

	left join Optisoul..Documento as r 
	on r.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12))

	left join movimenti as mov
	on (car2."codice filiale" = mov."codice riga carrello")

	left join Optisoul..Item
	on (('articoli.' + car2."codice articolo") = Item."CodigoAntigo")

where
	(car2."tipo fornitura" > 0)
	and (car2."tipo fornitura" <= 10)

--Prescrição (LONGE - OLHO DIREITO CARRELLO2)
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	Status,	Unidade,	DataHoraEmissao,	CodigoAntigo,	Eixo,	Cilindrico,	Esferico,	Prisma,	Base,	DI,	DIOD,	DIOE)
select
	d.CodigoDocumento, --varchar(30) (int->varchar(20))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	0 as CodigoItem, --int not null
	'' as DescricaoItem, --varchar(255) --not null
	'Prescrição' as TipoItem, --varchar(255) --null
	'Olho Direito' as Operacao, --varchar(255) --not null
	'Longe' as Status, --varchar(255), --null
	'UN' as Unidade, --varchar(10) --null
	oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	'odl.occhiali.'+ CAST(oc."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	CAST(oc."Asse1 L DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
	CAST(oc."Cilindro L DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
	CAST(oc."Sfera L DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
	CAST(oc."Prisma L DX" as numeric(18,4)) as Prisma, --varchar(100) --null
	CAST(oc."Base L DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI L" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI L DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI L SX" as Numeric(18,4)) as DIOE --numeric(18,4) --null

from occhiali as oc inner join
	Optisoul..Documento as d on (d.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12)))

where oc."Sfera L DX" is not null

--Prescrição (LONGE - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem, DescricaoItem,	TipoItem,	Operacao,	Status,	Unidade,	DataHoraEmissao,	CodigoAntigo,	Eixo,	Cilindrico,	Esferico,	Prisma,	Base)
select
	d.CodigoDocumento, --varchar(30) (int->varchar(20))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	0 as CodigoItem, --int not null
	'' as DescricaoItem, --varchar(255) --not null
	'Prescrição' as TipoItem, --varchar(255) --null
	'Olho Esquerdo' as Operacao, --varchar(255) --not null
	'Longe' as Status, --varchar(255), --null
	'UN' as Unidade, --varchar(10) --null
	oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	'oel.occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	CAST(oc."Asse1 L SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
	CAST(oc."Cilindro L SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
	CAST(oc."Sfera L SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
	CAST(oc."Prisma L SX" as numeric(18,4)) as Prisma, --varchar(100) --null
	CAST(oc."Base L SX" as varchar(10)) as Base --varchar(10) (numeric(18,4)->varchar(10)) --null
	
from occhiali as oc inner join
	Optisoul..Documento as d on (d.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12)))

where oc."Sfera L SX" is not null

--Prescrição (MEDIO - OLHO DIREITO CARRELLO2)
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	Status,	Unidade,	DataHoraEmissao,	CodigoAntigo,	Eixo,	Cilindrico,	Esferico,	Prisma,	Base,	DI,	DIOD,	DIOE)
select
	d.CodigoDocumento, --varchar(30) (int->varchar(20))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	0 as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
	'' as DescricaoItem, --varchar(255) --not null
	'Prescrição' as TipoItem, --varchar(255) --null
	'Olho Direito' as Operacao, --varchar(255) --not null
	'Médio' as Status, --varchar(255), --null
	'UN' as Unidade, --varchar(10) --null
	oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	'odm.occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	CAST(oc."Asse1 M DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
	CAST(oc."Cilindro M DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
	CAST(oc."Sfera M DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
	CAST(oc."Prisma M DX" as numeric(18,4)) as Prisma, --varchar(100) --null
	CAST(oc."Base M DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI M" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI M DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI M SX" as Numeric(18,4)) as DIOE --numeric(18,4) --null

from occhiali as oc inner join
	Optisoul..Documento as d on (d.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12)))

where oc."Sfera M DX" is not null

--Prescrição (MÉDIO - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	Status,	Unidade,	DataHoraEmissao,	CodigoAntigo,	Eixo,	Cilindrico,	Esferico,	Prisma,	Base)
select
	d.CodigoDocumento, --varchar(30) (int->varchar(30))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	0 as CodigoItem, --int not null 
	'' as DescricaoItem, --varchar(255) --not null
	'Prescrição' as TipoItem, --varchar(255) --null
	'Olho Esquerdo' as Operacao, --varchar(255) --not null
	'Médio' as Status, --varchar(255), --null
	'UN' as Unidade, --varchar(10) --null
	oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	'oem.occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	CAST(oc."Asse1 M SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
	CAST(oc."Cilindro M SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
	CAST(oc."Sfera M SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
	CAST(oc."Prisma M SX" as numeric(18,4)) as Prisma, --varchar(100) --null
	CAST(oc."Base M SX" as varchar(10)) as Base --varchar(10) (numeric(18,4)->varchar(10)) --null

from occhiali as oc inner join
	Optisoul..Documento as d on (d.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12)))

where oc."Sfera M SX" is not null

--Prescrição (PERTO - OLHO DIREITO CARRELLO2)
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	Status,	Unidade,	DataHoraEmissao,	CodigoAntigo,	Eixo,	Cilindrico,	Esferico,	Prisma,	Base,	DI,	DIOD,	DIOE)
select
	d.CodigoDocumento, --varchar(30) (int->varchar(30))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	0 as CodigoItem, --int not null
	'' as DescricaoItem, --varchar(255) --not null
	'Prescrição' as TipoItem, --varchar(255) --null
	'Olho Direito' as Operacao, --varchar(255) --not null
	'Perto' as Status, --varchar(255), --null
	'UN' as Unidade, --varchar(10) --null
	oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	'odp.occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	CAST(oc."Asse1 V DX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
	CAST(oc."Cilindro V DX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
	CAST(oc."Sfera V DX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
	CAST(oc."Prisma V DX" as numeric(18,4)) as Prisma, --varchar(100) --null
	CAST(oc."Base V DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI V" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI V DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI V SX" as Numeric(18,4)) as DIOE --numeric(18,4) --null
		
from occhiali as oc inner join
	Optisoul..Documento as d on (d.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12)))

where oc."Sfera V DX" is not null

--Prescrição (PERTO - OLHO ESQUERDO CARRELLO2)
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	Status,	Unidade,	DataHoraEmissao,	CodigoAntigo,	Eixo,	Cilindrico,	Esferico,	Prisma,	Base)
select
	d.CodigoDocumento, --varchar(30) (int->varchar(30))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	0 as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
	'' as DescricaoItem,
	'Prescrição' as TipoItem, --varchar(255) --null
	'Olho Esquerdo' as Operacao, --varchar(255) --not null
	'Perto' as Status, --varchar(255), --null
	'UN' as Unidade, --varchar(10) --null
	oc."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	'oep.occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	CAST(oc."Asse1 V SX" as numeric(18,4)) as Eixo, --numeric(18,4) --null
	CAST(oc."Cilindro V SX" as numeric(18,4)) as Cilindrico, --numeric(18,4) --null
	CAST(oc."Sfera V SX" as numeric(18,4)) as Esferico, --numeric(18,4) --null
	CAST(oc."Prisma V SX" as numeric(18,4)) as Prisma, --varchar(100) --null
	CAST(oc."Base V SX" as varchar(10)) as Base --varchar(10) (numeric(18,4)->varchar(10)) --null
		
from occhiali as oc inner join
	Optisoul..Documento as d on (d.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12)))

where oc."Sfera V SX" is not null


--VENDAS (DIRETO NO CARRINHO) E DEVOLUCAO STORICOCARRELLO2
--SEM BUSTA E LENTIBUSTA
insert into DocumentoItemTmp
	(CodigoDocumento,	/*CodigoDocumentoAdicional,*/	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	OperacaoFator,	Status,	CodigoCFOP,	ValorItem,	ValorOriginal,	DescontoItem,	DescontoPercentualItem,	Quantidade,	QuantidadeRealizado,	Unidade,	SubTotal,	Total,	ValorReal,	ValorRealTotal,	ValorCusto,	ValorCustoUltimo,	ValorCustoMedio,	ValorCustoReposicao,	DataHoraEmissao,	DataHoraFinalizado,	CodigoAntigo,	Marca,	Modelo,	Genero,	Cor,	Material,	Tamanho,	Altura,	Diagonal,	Diametro,	Eixo,	Cilindrico,	AmarcaoCor,	ArmacaoMaterial,	Haste,	Ponte,	RB1,	RB2,	Geometria,	IndiceRefracao,	Adicao,	Esferico,	TipoOculos,	TipoMontagem,	LenteTipo)
select
	v.CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
	--r.CodigoDocumento as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	COALESCE(Item."CodigoItem", /*scar2."codice a barre",*/ 0) as CodigoItem, --int not null
	COALESCE(Item."DescricaoComercial", scar2."descrizione", '') as DescricaoItem, --varchar(255) --not null
	CASE
		WHEN scar2."tipo fornitura" = 0 and (scar2."magazzino" = 1 or Item."Tipo" = 'Lente') THEN 'Produto'
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
	'Venda de Mercadoria' as Operacao, --varchar(255) --not null
	-1 as OperacaoFator, --int --null
	CASE WHEN scar2."pagato" = 1 THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
	261 as CodigoCFOP, --int --null
	CAST(scar2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), CAST(item."ValorVenda" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
	CAST(scar2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
	CAST(scar2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
	CAST(scar2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
	CAST(scar2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
	'UN' as Unidade, --varchar(10) --null
	CAST(scar2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
	CAST(scar2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
	CAST(scar2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
	CAST(scar2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCusto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoUltimo" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
	COALESCE(CAST(mov."costo medio" as decimal(18,4)), CAST(item."ValorCustoMedio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoReposicao" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
	scar2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	scar2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
	'scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	Item."Marca" as Marca, --varchar(100) --null
	Item."Modelo" as Modelo, --varchar(100) --null
	Item."Genero" as Genero, --varchar(100) --null
	Item."Cor" as Cor, --varchar(100) --null
	Item."Material" as Material, --varchar(100) --null
	CAST(Item."Tamanho" as varchar(100)) as Tamanho, --varchar(100) --null
	Item."Altura" as Altura, --numeric(18,4) --null
	Item."Diagonal" as Diagonal, --numeric(18,4) --null
	Item."Diametro" as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
	Item."Eixo", --numeric(18,4) --null
	Item."Cilindrico", --numeric(18,4) --null
	Item."AmarcaoCor" as AmarcaoCor, --varchar(100) --null
	Item."ArmacaoMaterial" as ArmacaoMaterial, --varchar(100) --null
	Item."Haste" as Haste, --numeric(18,4) --null
	Item."Ponte" as Ponte, --numeric(18,4) --null
	Item."RB1" as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
	Item."RB2" as RB2, --numeric(18,4) --null
	Item."Geometria" as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
	Item."IndiceRefracao" as IndiceRefracao, --numeric(18,4) --null
	CASE WHEN Item."AdicaoInicial" = Item."AdicaoFinal" THEN Item."AdicaoInicial" ELSE CAST(NULL as numeric(18,4)) END as Adicao, --numeric(18,4) --null	
	CASE WHEN Item."EsfericoInicial" = Item."EsfericoFinal" THEN Item."EsfericoInicial" ELSE CAST(NULL as numeric(18,4)) END as Esferico, --numeric(18,4) --null		
	CASE
		WHEN ((scar2."magazzino" = 0) and (Item."Tipo" = 'Armação')) THEN 'Vista'
		WHEN ((scar2."magazzino" = 0) and (Item."Tipo" = 'Óculos Sol')) THEN 'Sol'
	END as TipoOculos, --varchar(100) --null
	Item."TipoMontagem" as TipoMontagem, --varchar(100) --null
	Item."LenteTipo" as LenteTipo --varchar(100) --null

from storicocarrello2 as scar2
	inner join Optisoul..Documento as v
	on v.idant = ('item.scar.' + CAST(scar2."codice carrello" as varchar(12)))
	/*
	left join busta as b
	on (b."codice filiale" = scar2."codice fornitura")

	left join lentibusta as lb
	on (lb."codice filiale" = scar2."codice fornitura")

	left join occhiali as oc
	on (oc."codice cliente" = COALESCE(b."codice cliente", lb."codice cliente"))

	left join Optisoul..Documento as r
	on r.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12))
	*/
	left join movimenti as mov
	on (scar2."codice filiale" = mov."codice riga carrello")

	left join Optisoul..Item
	on (('articoli.' + scar2."codice articolo") = Item."CodigoAntigo")
	/*
	left join PrescricaoEnvelope as pe
	on ((COALESCE(b."codice filiale", lb."codice filiale") = pe."CodigoEnvelope") and (pe."Dias" = (DATEDIFF(day, COALESCE(b."data", lb."data"), oc."data"))))
	*/
where
	( /*devolucoes*/ 
		((scar2."tipo fornitura" <> 100) or (scar2."tipo fornitura" = 100 and scar2."quantita" < 0))
		and (scar2."tipo fornitura" <> 0)
		--and(car2."tipo fornitura" <> 10)
		and (COALESCE(scar2."codice fornitura",'') = '')
	)
	or ( /*venda direta no carrinho*/
		(scar2."tipo fornitura" = 0)
	)

--Produtos STORICOCARRELLO2
--COM BUSTA e LENTIBUSTA
insert into DocumentoItemTmp
	(CodigoDocumento,	CodigoDocumentoAdicional,	CodigoPlanoContaEstoque,	CodigoPlanoContaDestino,	CodigoItem,	DescricaoItem,	TipoItem,	Operacao,	OperacaoFator,	Status,	CodigoCFOP,	ValorItem,	ValorOriginal,	DescontoItem,	DescontoPercentualItem,	Quantidade,	QuantidadeRealizado,	Unidade,	SubTotal,	Total,	ValorReal,	ValorRealTotal,	ValorCusto,	ValorCustoUltimo,	ValorCustoMedio,	ValorCustoReposicao,	DataHoraEmissao,	DataHoraFinalizado,	CodigoAntigo,	Marca,	Modelo,	Genero,	Cor,	Material,	Tamanho,	Altura,	Diagonal,	Diametro,	Eixo,	Cilindrico,	AmarcaoCor,	ArmacaoMaterial,	Haste,	Ponte,	RB1,	RB2,	Geometria,	IndiceRefracao,	Adicao,	Esferico,	Oculos,	TipoOculos,	TipoMontagem,	LenteTipo)
select
	v.CodigoDocumento, --varhcar(30) (int->varchar(20)) --not null
	CASE scar2."tipo fornitura"
		WHEN 1 THEN r.CodigoDocumento
		WHEN 3 THEN r.CodigoDocumento
		WHEN 10 THEN r.CodigoDocumento
	END as CodigoDocumentoAdicional, --varchar(30) (int->varchar(20))--null
	146 as CodigoPlanoContaEstoque, --int --null
	139 as CodigoPlanoContaDestino, --int --null
	COALESCE(Item."CodigoItem", /*scar2."codice a barre",*/ 0) as CodigoItem, --int not null
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
	'Venda de Mercadoria' as Operacao, --varchar(255) --not null
	-1 as OperacaoFator, --int --null
	CASE WHEN scar2."pagato" = 1 THEN 'Faturado' ELSE 'Aguardando Faturamento' END as Status, --varchar(255), --null
	261 as CodigoCFOP, --int --null
	CAST(scar2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino vendita" as decimal(18,4)), CAST(item."ValorVenda" as decimal(18,4)), 0.0000) as ValorOriginal, --decimal(18,4) --not null
	CAST(scar2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
	CAST(scar2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
	CAST(scar2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
	CAST(scar2."quantita" as decimal(18,6)) as QuantidadeRealizado, --decimal(18,6) --not null
	'UN' as Unidade, --varchar(10) --null
	CAST(scar2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
	CAST(scar2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
	CAST(scar2."totale" as decimal(18,4)) as ValorReal, --decimal(18,4) --not null
	CAST(scar2."totale" as decimal(18,4)) as ValorRealTotal, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCusto" as decimal(18,4)), 0.0000) as ValorCusto, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoUltimo" as decimal(18,4)), 0.0000) as ValorCustoUltimo, --decimal(18,4) --not null
	COALESCE(CAST(mov."costo medio" as decimal(18,4)), CAST(item."ValorCustoMedio" as decimal(18,4)), 0.0000) as ValorCustoMedio, --decimal(18,4) --not null
	COALESCE(CAST(mov."prezzo listino acquisto" as decimal(18,4)), CAST(item."ValorCustoReposicao" as decimal(18,4)), 0.0000) as ValorCustoReposicao, --decimal(18,4) --not null
	scar2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
	scar2."data" as DataHoraFinalizado, --datetime (datetime->date) --null
	'scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoAntigo, --varchar(150) --null
	Item."Marca" as Marca, --varchar(100) --null
	Item."Modelo" as Modelo, --varchar(100) --null
	Item."Genero" as Genero, --varchar(100) --null
	Item."Cor" as Cor, --varchar(100) --null
	Item."Material" as Material, --varchar(100) --null
	CAST(Item."Tamanho" as varchar(100)) as Tamanho, --varchar(100) --null
	Item."Altura" as Altura, --numeric(18,4) --null
	Item."Diagonal" as Diagonal, --numeric(18,4) --null
	Item."Diametro" as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
	CASE scar2."magazzino"
		WHEN 1 THEN
		(
			CASE scar2."tipo fornitura dettaglio"
			    WHEN 2 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1 
						THEN b."Asse1 L Dx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Asse1 M Dx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Asse1 V Dx"
									END
								) 
							END
						) 
					END		    		
			    )		
				WHEN 3 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Asse1 L Sx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Asse1 M Sx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Asse1 V Sx"
									END
								) 
							END
						) 
					END		    		
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE scar2."tipo fornitura dettaglio"
			    WHEN 2 THEN lb."Asse Dx"
				WHEN 3 THEN lb."Asse Sx"
			END
		)
	END as Eixo, --numeric(18,4) --null
	CASE scar2."magazzino"
		WHEN 1 THEN
		(
			CASE scar2."tipo fornitura dettaglio"
			    WHEN 2 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Cilindro L Dx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Cilindro M Dx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Cilindro V Dx"
									END
								) 
							END
						) 
					END		    		
			    )		
				WHEN 3 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Cilindro L Sx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Cilindro M Sx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Cilindro V Sx"
									END
								) 
							END
						) 
					END		    		
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE scar2."tipo fornitura dettaglio"
				WHEN 2 THEN lb."Cilindro Dx"
				WHEN 3 THEN lb."Cilindro Sx"
			END
		)
	END as Cilindrico, --numeric(18,4) --null
	Item."AmarcaoCor" as AmarcaoCor, --varchar(100) --null
	Item."ArmacaoMaterial" as ArmacaoMaterial, --varchar(100) --null
	Item."Haste" as Haste, --numeric(18,4) --null
	Item."Ponte" as Ponte, --numeric(18,4) --null
	Item."RB1" as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
	Item."RB2" as RB2, --numeric(18,4) --null
	Item."Geometria" as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
	Item."IndiceRefracao" as IndiceRefracao, --numeric(18,4) --null
	CASE scar2."magazzino"
		WHEN 1 THEN
		(
			CASE scar2."tipo fornitura dettaglio"
			    WHEN 2 THEN 
			    (
			    	CASE WHEN b."occhiale da lontano" = 1
			    		THEN 
			    		(
			    			CASE WHEN b."occhiale da medio" = 1
			    				THEN b."Add M Dx" 
			    				ELSE 
		    					(
		    						CASE WHEN b."occhiale da vicino" = 1
		    							THEN b."Add V Dx"
		    						END
		    					)
			    			END
			    		)
			    	END
			    )
			    WHEN 3 THEN
		    	(
			    	CASE WHEN b."occhiale da lontano" = 1
			    		THEN 
			    		(
			    			CASE WHEN b."occhiale da medio" = 1
			    				THEN b."Add M Sx" 
			    				ELSE 
		    					(
		    						CASE WHEN b."occhiale da vicino" = 1
		    							THEN b."Add V Sx"
		    						END
		    					)
			    			END
			    		)
			    	END
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE scar2."tipo fornitura dettaglio"
			    WHEN 2 THEN lb."Add Dx"
			    WHEN 3 THEN lb."Add Sx"
			END
		)
	END as Adicao, --numeric(18,4) --null	
	CASE scar2."magazzino"
		WHEN 1 THEN
		(	
			CASE scar2."tipo fornitura dettaglio"
			    WHEN 2 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Sfera L Dx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Sfera M Dx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Sfera V Dx"
									END
								) 
							END
						) 
					END		    		
			    )		
				WHEN 3 THEN
			    (
					CASE WHEN b."occhiale da lontano" = 1
						THEN b."Sfera L Sx" 
						ELSE 
						(
							CASE WHEN b."occhiale da medio" = 1
								THEN b."Sfera M Sx"
								ELSE 
								(
									CASE WHEN b."occhiale da vicino" = 1
										THEN b."Sfera V Sx"
									END
								) 
							END
						) 
					END		    		
			    )
			END
		)
		WHEN 2 THEN
		(
			CASE scar2."tipo fornitura dettaglio"
			    WHEN 2 THEN lb."Sfera Dx"
				WHEN 3 THEN lb."Sfera Sx"
			END
		)
	END as Esferico, --numeric(18,4) --null		
	CASE WHEN scar2."magazzino" = 0
		THEN 
			CASE 
				WHEN (NOT(b."lente propria dx" = 1) AND NOT(b."lente propria sx" = 1) AND (b."tipo lente dx" >= b."tipo lente sx")) 
					THEN 
					(
						CASE b."tipo lente dx"
							WHEN 1 THEN 
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)
		     	WHEN (NOT(b."lente propria dx" = 1) AND NOT(b."lente propria sx" = 1) AND (b."tipo lente dx" < b."tipo lente sx"))
		     		THEN 
		     		(
						CASE b."tipo lente sx"
							WHEN 1 THEN
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)
		     	WHEN (NOT(b."lente propria dx" = 1) AND (b."lente propria sx" = 1))
		     		THEN
					(
						CASE b."tipo lente dx"
							WHEN 1 THEN
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)     			
		     	WHEN ((b."lente propria dx" = 1) AND NOT(b."lente propria sx" = 1)) 
		     	THEN 
		     		(
						CASE b."tipo lente sx"
							WHEN 1 THEN
								CASE 
									WHEN (b."occhiale da lontano" = 1) THEN 'MonofocalLonge'
									WHEN (b."occhiale da vicino" = 1) THEN 'MonofocalPerto'
								END
							WHEN 2 THEN 'Bifocal'
							WHEN 3 THEN 'Multifocal'
							WHEN 4 THEN 'Intermediario'
						END
					)                                                              
		    END
	END as Oculos, --varchar(100) --null
	CASE
		WHEN ((scar2."magazzino" = 0) and (b."occhiale da sole" = 0)) THEN 'Vista'
		WHEN ((scar2."magazzino" = 0) and (b."occhiale da sole" = 1)) THEN 'Sol'
	END as TipoOculos, --varchar(100) --null
	Item."TipoMontagem" as TipoMontagem, --varchar(100) --null
	Item."LenteTipo" as LenteTipo --varchar(100) --null

from storicocarrello2 as scar2
	inner join Optisoul..Documento as v
	on v.idant = ('item.scar.' + CAST(scar2."codice carrello" as varchar(12)))

	left join busta as b
	on (b."codice filiale" = scar2."codice fornitura")
	
	left join lentibusta as lb
	on (lb."codice filiale" = scar2."codice fornitura")

	inner join PrescricaoEnvelope as pe
	on (COALESCE(b."codice filiale", lb."codice filiale") = pe."CodigoEnvelope")
	
	left join occhiali as oc
	on (oc."codice filiale" = pe."CodigoReceita")

	left join Optisoul..Documento as r
	on r.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12))

	left join movimenti as mov
	on (scar2."codice filiale" = mov."codice riga carrello")

	left join Optisoul..Item
	on (('articoli.' + scar2."codice articolo") = Item."CodigoAntigo")

where
	(scar2."tipo fornitura" > 0)
	and (scar2."tipo fornitura" <= 10)


--IMPORTA OPTISOUL

ALTER TABLE Optisoul..[documentoitem] DISABLE TRIGGER ALL

		INSERT INTO Optisoul.[dbo].[documentoitem]
				   (CodigoDocumento
				   ,[CodigoDocumentoAdicional]
				   ,[AmarcaoCor]
				   ,[ArmacaoMaterial]
				   ,[CRMGrupoMetaAssistente]
				   ,[CRMGrupoMetaVendedor]
				   ,[Cor]
				   ,[DescricaoAgrupamento]
				   ,[CodigoItem]
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
				   )

					select
					[CodigoDocumento]
					,[CodigoDocumentoAdicional]
					,[AmarcaoCor]                  
					,[ArmacaoMaterial]             
					,[CRMGrupoMetaAssistente]      
					,[CRMGrupoMetaVendedor]        
					,[Cor]                         
					,[DescricaoAgrupamento]       
					,[CodigoItem] 
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
,case when [DataHoraEmissao] is null then null else cast([DataHoraEmissao] as datetime) end as [DataHoraEmissao]
,case when [DataUltimaVenda] is null then null else cast([DataUltimaVenda] as datetime) end as [DataUltimaVenda]
,case when [DataHoraFinalizado] is null then null else cast([DataHoraFinalizado] as datetime) end as [DataHoraFinalizado]
,case when [DataValidadeLote] is null then null else cast([DataValidadeLote] as date) end as [DataValidadeLote]

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
,case when isnumeric([Quantidade]) = 1 then cast((select(replace( [Quantidade] ,',','.'))) as Decimal(18,6)) else 0 end as [Quantidade] 
,case when isnumeric([QuantidadeConferido]) = 1 then cast((select(replace( [QuantidadeConferido] ,',','.'))) as Decimal(18,6)) else 0 end as [QuantidadeConferido] 
,case when isnumeric([QuantidadeRealizado]) = 1 then cast((select(replace( [QuantidadeRealizado] ,',','.'))) as Decimal(18,6)) else 0 end as [QuantidadeRealizado] 
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
,[Base]
,case when isnumeric( [DI] ) = 1 then cast((select(replace([DI] ,',','.'))) as Decimal(18,4)) else null end as [DI] 
,case when isnumeric( [DIOD] ) = 1 then cast((select(replace([DIOD] ,',','.'))) as Decimal(18,4)) else null end as [DIOD] 
,case when isnumeric( [DIOE] ) = 1 then cast((select(replace([DIOE] ,',','.'))) as Decimal(18,4)) else null end as [DIOE]
		-- bit
		,cast([CRMItemNovo] as bit) as [CRMItemNovo]	   
		,[PrescricaoAlterada] as [PrescricaoAlterada]	      
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

		from documentoitemtmp

/*		Select codigodocumento,codigodocumentoadicional, idant, pedidoant into ##t from optisoul..documento

		update optisoul..documentoitem set codigodocumento = 
		isnull((select top 1 codigodocumento from ##t where documentoitem.codigodocumentoant = ##t.idant),0)

		update optisoul..documentoitem set codigodocumentoadicional = 
		(select top 1 codigodocumento from ##t where documentoitem.codigodocumentoadicionalant = ##t.idant)
		Drop table ##t


       update optisoul..documentoitem set codigoitem =  (select codigoitem from optisoul..item i where i.codigoantigo = documentoitem.codigoitemant)
*/

ALTER TABLE Optisoul..[documentoitem] ENABLE TRIGGER ALL