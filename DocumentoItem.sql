--Create table documentoitem (principal)
//NOSQLBDETOFF2
drop table if exists documentoitem;
create table documentoitem
(
	CodigoDocumentoItem	varchar(20), --not null
	CodigoDocumento	varchar(20), --not null
	CodigoDocumentoAdicional int, --null
	CodigoPlanoContaEstoque	int, --null
	CodigoPlanoContaDestino	int, --null
	CodigoItem varchar(14), -- int->varchar(14) not null
	CodigoItemDNA int, --null
	Lote varchar(50), --null
	LoteEmpresa	varchar(50), --null
	ReferenciaFornecedor varchar(30), --null
	DescricaoItem varchar(255), --not null
	TipoItem varchar(255), --null
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
	CodigoDocumentoVenda int, --null
	CodigoDocumentoRemessa int, --null
	CodigoDocumentoCompra int, --null
	CodigoDocumentoTriagem int, --null
	CodigoAntigo varchar(150), --null
	CRMGrupoMetaVendedor varchar(100), --null
	CRMGrupoMetaAssistent varchar(100), --null
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



--Insert carrello2 -> documentoitem
insert into documentoitem
(
	select
		'car2.'+ CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoItem, --varchar(255) --not null
		'car2.'+ CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --int (int->varchar(255)) --not null
CAST(NULL as int) as CodigoDocumentoAdicional, --int --null é o código da prescrição é o occhiali."codice filiale", mas isso não tem no carrinho, nem na busta, nem em nada, preciso pensar melhor, como faremos, ignora por enquanto, ok
		CASE
			WHEN((COALESCE(it."tipo",it2."tipo") = 'Armação') or (COALESCE(it."tipo",it2."tipo") = 'Óculos')) THEN(146)
			WHEN((COALESCE(it."tipo",it2."tipo") <> 'Armação') or (COALESCE(it."tipo",it2."tipo") <> 'Óculos')) THEN(0)
		END as CodigoPlanoContaEstoque, --int --null
		CASE
			WHEN((COALESCE(it."tipo",it2."tipo") = 'Armação') or (COALESCE(it."tipo",it2."tipo") = 'Óculos')) THEN(139)
			WHEN((COALESCE(it."tipo",it2."tipo") <> 'Armação') or (COALESCE(it."tipo",it2."tipo") <> 'Óculos')) THEN(0)
		END as CodigoPlanoContaDestino, --int --null
		car2."codice articolo", --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
CAST(NULL as int) as CodigoItemDNA, --int --null
CAST(NULL as varchar) as Lote, --varchar(50) --null
CAST(NULL as varchar) as LoteEmpresa, --varchar(50) --null
CAST(NULL as varchar) as ReferenciaFornecedor, --varchar(30) --null
		car2."descrizione" as DescricaoItem, --varchar(255) --not null
		CASE 
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Armação') THEN('Armação')
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Óculos') THEN('Óculos de Sol')
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Lente Oftálmica' and car2."Tipo fornitura dettaglio" = 2) THEN('LOD')
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Lente Oftálmica' and car2."Tipo fornitura dettaglio" = 3) THEN('LOE')
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Lente de Contato') THEN('Lente de Contato Pronta')
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Outro Produto') THEN('Produto')
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Serviço') THEN('Serviço')
			ELSE('Outro Produto')
		END as TipoItem, --varchar(255) --null
		COALESCE(it."NCM",it2."NCM") as NCM, --varchar(8) --null
		0 as CodigoDocumentoItemPai, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --not null
		-1 as OperacaoFator, --int --null
		'Orçamento' as Status, --varchar(255), --null
		261 as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		CAST(car2."prezzo" as decimal(18,4)) as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		CAST(car2."prezzo" as decimal(18,4)) as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		CAST(car2."totale" as decimal(18,4)) as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		CAST(car2."sconto" as decimal(18,4)) as DescontoItem, --decimal(18,4), --not null
		CAST(car2."sconto percentuale" as decimal(18,4)) as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
		0.0000 as ValorFreteRateado, --decimal(18,4), --not null
		0.0000 as ValorSeguroRateado, --decimal(18,4), --not null
		0.0000 as ValorOutrasDespesasRateado, --decimal(18,4), --not null
		CAST(car2."quantita" as decimal(18,6)) as Quantidade, --decimal(18,6) --not null
		0.0000 as QuantidadeRealizado, --decimal(18,6) --not null
		0.0000 as QuantidadeConferido, --decimal(18,6) --not null
		CAST(NULL as varchar) as Unidade, --varchar(10) --null
		CAST((car2."prezzo" * car2."quantita") as decimal(18,4)) as SubTotal, --decimal(18,4) --not null
		CAST((car2."sconto" * car2."quantita") as decimal(18,4)) as DescontoSubTotal, --decimal(18,4) --not null
		CAST(car2."sconto percentuale" as decimal(18,4)) as DescontoPercentualSubTotal, --decimal(18,4) --not null
		CAST(car2."totale" as decimal(18,4)) as Total, --decimal(18,4) --not null
		CAST(b."note" as varchar(8000)) as Observacao, --varchar(8000) --null
CAST(NULL as decimal(18,4))as ValorReal, --decimal(18,4) --not null
CAST(NULL as decimal(18,4))as ValorRealTotal, --decimal(18,4) --not null
CAST(NULL as decimal(18,4))as ValorRealTotalImpostos, --decimal(18,4) --not null
		CAST(COALESCE(it."ValorCusto", it2."ValorCusto") as decimal(18,4)) as ValorCusto, --decimal(18,4) --not null
		CAST(COALESCE(it."ValorCustoUltimo", it2."ValorCustoUltimo") as decimal(18,4)) as ValorCustoUltimo, --decimal(18,4) --not null
		CAST(COALESCE(it."ValorCustoMedio", it2."ValorCustoMedio") as decimal(18,4)) as ValorCustoMedio, --decimal(18,4) --not null
		0.0000 as ValorCustoTerceiro, --decimal(18,4) --not null
		CAST(COALESCE(it."ValorCustoReposicao",it2."ValorCustoReposicao") as decimal(18,4)) as ValorCustoReposicao, --decimal(18,4) --not null
		car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
		car2."data pagamento" as DataHoraFinalizado, --datetime (datetime->date) --null
CAST(NULL as int) as CodigoCST, --int --null
CAST(NULL as int) as ModalidadeBaseCalculo, --int --null
CAST(NULL as decimal(18,4)) as ValorBaseICMS, --decimal(18,4) --null
CAST(NULL as int) as CodigoCSTIPI, --int --null
CAST(NULL as decimal(18,4)) as ValorBaseIPI, --decimal(18,4) --null
CAST(NULL as decimal(18,4)) as PercentualICMS, --decimal(18,4) --not null
CAST(NULL as decimal(18,4)) as ValorICMS, --decimal(18,4) --not null
CAST(NULL as decimal(18,4)) as PercentualIPI, --decimal(18,4) --not null
CAST(NULL as decimal(18,4)) as ValorIPI, --decimal(18,4) --not null
CAST(NULL as varchar(100)) as UnidadeTributada, --varchar(100) --null
CAST(NULL as decimal(18,4)) as QuantidadeTributada, --decimal(18,4) --not null
CAST(NULL as decimal(18,4)) as ValorItemTributado, --decimal(18,4) --not null
CAST(NULL as date) as DataValidadeLote, --date --null
CAST(NULL as decimal(18,4)) as QuantidadeUltimo, --decimal(18,4) --null
CAST(NULL as date) as DataUltimaVenda, --datetime, --null
CAST(NULL as int) as ModalidadeBaseCalculoST, --int, --null
CAST(NULL as decimal(18,4)) as PercentualIVA, --decimal(18,4), --null
CAST(NULL as decimal(18,4)) as ValorBaseIcmsSt, --decimal(18,4), --null
CAST(NULL as decimal(18,4)) as PercentualIcmsSt, --decimal(18,4), --null
CAST(NULL as decimal(18,4)) as ValorIcmsSt, --decimal(18,4), --null
CAST(NULL as int) as CodigoDocumentoVenda, --int, --null
CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
	CAST(NULL as varchar) as CodigoAntigo, --varchar(150) --null /*DEVEMOS CRIAR UM CÓDIGO ANTIGO NESTA TABELA? COM QUAIS CAMPOS?*/
		CAST(NULL as varchar) as CRMGrupoMetaVendedor, --varchar(100) --null
		CAST(NULL as varchar) as CRMGrupoMetaAssistent, --varchar(100) --null
		CAST(NULL as int) as CRMItemNovo, --int --null
		CAST(NULL as int) as CodigoContatoFornecedor, --int --null
		COALESCE(it."Marca",it2."Marca") as Marca, --varchar(100) --null
		COALESCE(it."Descricao",it2."Descricao") as Modelo, --varchar(100) --null
		COALESCE(it."Genero",it2."Genero") as Genero, --varchar(100) --null
		COALESCE(it."Cor",it2."Cor") as Cor, --varchar(100) --null
		COALESCE(it."Material",it2."Material") as Material, --varchar(100) --null
		CAST(COALESCE(it."Tamanho",it2."Tamanho") as varchar(100)) as Tamanho, --varchar(100) --null
CAST(NULL as numeric(18,4)) as Altura, --numeric(18,4) --null
CAST(NULL as numeric(18,4)) as Largura, --numeric(18,4) --null
CAST(NULL as numeric(18,4)) as Comprimento, --numeric(18,4) --null
CAST(NULL as numeric(18,4)) as Diagonal, --numeric(18,4) --null
		COALESCE(it."Diametro",it2."Diametro") as Diametro, --varhcar(10) (numeric(18,4)->varchar(10)) --null
		COALESCE(it."Eixo",it2."Eixo") as Eixo, --numeric(18,4) --null
		COALESCE(it."AdicaoInicial",it2."AdicaoInicial") as AdicaoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AdicaoFinal, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as AlturaMinima, --numeric(18,4) --null
		COALESCE(it."EsfericoInicial",it2."EsfericoInicial") as EsfericoInicial, --numeric(18,4) --null
		CAST(NULL as numeric(18,4)) as EsfericoFinal, --numeric(18,4) --null
		COALESCE(it."Cilindrico",it2."Cilindrico") as Cilindrico, --numeric(18,4) --null
		COALESCE(it."Cor",it2."Cor") as AmarcaoCor, --varchar(100) --null
		COALESCE(it."Material",it2."Material") as ArmacaoMaterial, --varchar(100) --null
		COALESCE(it."Haste",it2."Haste") as Haste, --numeric(18,4) --null
		COALESCE(it."Ponte",it2."Ponte") as Ponte, --numeric(18,4) --null
		CAST(NULL as varchar) as RB1, --varchar(5) (numeric(18,4)->varchar(5)) --null
		CAST(NULL as numeric(18,4)) as RB2, --numeric(18,4) --null
		CAST(NULL as varchar) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) --null
		CAST(NULL as numeric(18,4)) as IndiceRefracao, --numeric(18,4) --null
		COALESCE(it."AdicaoInicial",it2."AdicaoInicial") as Adicao, --numeric(18,4) --null
		COALESCE(it."EsfericoInicial",it2."EsfericoInicial") as Esferico, --numeric(18,4) --null
		CAST(NULL as varchar) as Prisma, --varchar(100) --null
		CAST(NULL as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
		CAST(NULL as Numeric(18,4)) as DI, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOD, --numeric(18,4) --null
		CAST(NULL as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CASE
			GetTipoProdotto(COALESCE(art."codice tipo prodotto", art_f."codice tipo prodotto"))
			WHEN('Lentes monofocais') THEN('Monofocal')
			WHEN('lentes bifocais') THEN('Bifocal')
			WHEN('Lentes progressivas') THEN('Multifocal')
			WHEN('Lentes dinámicas') THEN('Intermediário')
			ELSE(CAST(NULL as varchar))
		END as Oculos, --varchar(100) --null
		CASE 
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Armação') THEN('Vista')
			WHEN(COALESCE(it."tipo",it2."tipo") = 'Óculos') THEN('Sol')
			ELSE(CAST(NULL as varchar))
		END as TipoOculos, --varchar(100) --null
		GetMontaggio(COALESCE(art."codice montaggio", art_f."codice montaggio", '')) as TipoMontagem, --varchar(100) --null
		(
			CASE
				GetTipoProdotto(COALESCE(art."codice tipo prodotto", art_f."codice tipo prodotto", ''))
				WHEN('Lentes monofocais') THEN('Monofocal')
				WHEN('lentes bifocais') THEN('Bifocal')
				WHEN('Lentes progressivas') THEN('Multifocal')
				WHEN('Lentes dinámicas') THEN('Intermediário')
				ELSE('')
			END
			+''+
			CASE
				WHEN(b."occhiale da lontano" = True) THEN(' Longe')
				WHEN(b."occhiale da medio" = True) THEN(' Média')
				WHEN(b."occhiale da vicino" = True) THEN(' Perto')
				WHEN(b."occhiale da sole" = True) THEN(' Sol')
				ELSE('')
			END
		) as LenteTipo --varchar(100) --null

	from carrello2 as car2
		left join busta as b
		on ( b."codice filiale" = car2."codice fornitura" )

		left join articoli as art
		on ( (art."codice filiale" = car2."codice articolo") or (art."codice a barre" = car2."codice a barre") )

		full outer join articoli_fornitore as art_f
		on ( art."codice a barre" = art_f."codice a barre" )
		
		left join item as it
    	on ( it."CodigoAntigo" = 'articoli.'+ car2."codice articolo" )

    	left join item as it2
    	on ( it2."CodigoAntigo" = 'articoli_fornitore.'+ car2."codice a barre" )



    UNION


	--Prescrição (LONGE - OLHO DIREITO)
	select
	'car2.'+ CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoItem, --varchar(255) --not null
	'car2.'+ CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --int (int->varchar(255)) --not null
		CAST(NULL as int) as CodigoDocumentoAdicional, --int --null é o código da prescrição é o occhiali."codice filiale", mas isso não tem no carrinho, nem na busta, nem em nada, preciso pensar melhor, como faremos, ignora por enquanto, ok
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		CAST(NULL as varchar) as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
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
	'Longe' as Status, --varchar(255), --null
		CAST(NULL as int) as CodigoCFOP, --int --null
		CAST(NULL as varchar) as DescricaoAgrupamento, --varchar(255) --null
		0.0000 as ValorItem, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorOriginal, --decimal(18,4) --not null "QUE VALOR SERIA ESSE?"
		0.0000 as ValorItemUltimo, --decimal(18,4), --not null "QUE VALOR SERIA ESSE?"
		0.0000 as DescontoItem, --decimal(18,4), --not null
		0.0000 as DescontoPercentualItem, --decimal(18,4), --not null
		0.0000 as DescontoTotalRateado, --decimal(18,4), --not null
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
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
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
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(150) --null /*DEVEMOS CRIAR UM CÓDIGO ANTIGO NESTA TABELA? COM QUAIS CAMPOS?*/
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
	CAST(oc."Prisma L DX" as varchar(100)) as Prisma, --varchar(100) --null
	CAST(oc."Base L DX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI L" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI L DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI L SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from busta as b
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		left join clienti as cli
		on ( cli."codice personale" = b."codice cliente" )

		left join carrello2 as car2
		on ( car2."codice cliente" = b."codice cliente")

	where
		(CAST(b."data" as integer) - CAST(oc."data" as integer) >= 0)


	UNION


	--Prescrição (LONGE - OLHO ESQUERDO)
	select
	'car2.'+ CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoItem, --varchar(255) --not null
	'car2.'+ CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --int (int->varchar(255)) --not null
		CAST(NULL as int) as CodigoDocumentoAdicional, --int --null é o código da prescrição é o occhiali."codice filiale", mas isso não tem no carrinho, nem na busta, nem em nada, preciso pensar melhor, como faremos, ignora por enquanto, ok
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		CAST(NULL as varchar) as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
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
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
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
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(150) --null /*DEVEMOS CRIAR UM CÓDIGO ANTIGO NESTA TABELA? COM QUAIS CAMPOS?*/
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
	CAST(oc."Prisma L SX" as varchar(100)) as Prisma, --varchar(100) --null
	CAST(oc."Base L SX" as varchar(10)) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI L" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI L DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI L SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from busta as b
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		left join clienti as cli
		on ( cli."codice personale" = b."codice cliente" )

		left join carrello2 as car2
		on ( car2."codice cliente" = b."codice cliente")

	where
		(CAST(b."data" as integer) - CAST(oc."data" as integer) >= 0)


	UNION


	--Prescrição (MEDIO - OLHO DIREITO)
	select
	'car2.'+ CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoItem, --varchar(255) --not null
	'car2.'+ CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --int (int->varchar(255)) --not null
		CAST(NULL as int) as CodigoDocumentoAdicional, --int --null é o código da prescrição é o occhiali."codice filiale", mas isso não tem no carrinho, nem na busta, nem em nada, preciso pensar melhor, como faremos, ignora por enquanto, ok
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		CAST(NULL as varchar) as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
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
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
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
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(150) --null /*DEVEMOS CRIAR UM CÓDIGO ANTIGO NESTA TABELA? COM QUAIS CAMPOS?*/
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
	CAST(oc."Prisma M DX" as varchar) as Prisma, --varchar(100) --null
	CAST(oc."Base M DX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI M" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI M DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI M SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from busta as b
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		left join clienti as cli
		on ( cli."codice personale" = b."codice cliente" )

		left join carrello2 as car2
		on ( car2."codice cliente" = b."codice cliente")

	where
		(CAST(b."data" as integer) - CAST(oc."data" as integer) >= 0)


	UNION


    --Prescrição (MÉDIO - OLHO ESQUERDO)
	select
	'car2.'+ CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoItem, --varchar(255) --not null
	'car2.'+ CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --int (int->varchar(255)) --not null
		CAST(NULL as int) as CodigoDocumentoAdicional, --int --null é o código da prescrição é o occhiali."codice filiale", mas isso não tem no carrinho, nem na busta, nem em nada, preciso pensar melhor, como faremos, ignora por enquanto, ok
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		CAST(NULL as varchar) as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
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
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
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
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(150) --null /*DEVEMOS CRIAR UM CÓDIGO ANTIGO NESTA TABELA? COM QUAIS CAMPOS?*/
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
	CAST(oc."Prisma M SX" as varchar) as Prisma, --varchar(100) --null
	CAST(oc."Base M SX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI M" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI M DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI M SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from busta as b
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		left join clienti as cli
		on ( cli."codice personale" = b."codice cliente" )

		left join carrello2 as car2
		on ( car2."codice cliente" = b."codice cliente")

	where
		(CAST(b."data" as integer) - CAST(oc."data" as integer) >= 0)


	UNION


	--Prescrição (PERTO - OLHO DIREITO)
	select
	'car2.'+ CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoItem, --varchar(255) --not null
	'car2.'+ CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --int (int->varchar(255)) --not null
		CAST(NULL as int) as CodigoDocumentoAdicional, --int --null é o código da prescrição é o occhiali."codice filiale", mas isso não tem no carrinho, nem na busta, nem em nada, preciso pensar melhor, como faremos, ignora por enquanto, ok
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		CAST(NULL as varchar) as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
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
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
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
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(150) --null /*DEVEMOS CRIAR UM CÓDIGO ANTIGO NESTA TABELA? COM QUAIS CAMPOS?*/
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
	CAST(oc."Prisma V DX" as varchar) as Prisma, --varchar(100) --null
	CAST(oc."Base V DX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI V" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI V DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI V SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from busta as b
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		left join clienti as cli
		on ( cli."codice personale" = b."codice cliente" )

		left join carrello2 as car2
		on ( car2."codice cliente" = b."codice cliente")

	where
		(CAST(b."data" as integer) - CAST(oc."data" as integer) >= 0)


	UNION


    --Prescrição (PERTO - OLHO ESQUERDO)
	select
	'car2.'+ CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoItem, --varchar(255) --not null
	'car2.'+ CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --int (int->varchar(255)) --not null
		CAST(NULL as int) as CodigoDocumentoAdicional, --int --null é o código da prescrição é o occhiali."codice filiale", mas isso não tem no carrinho, nem na busta, nem em nada, preciso pensar melhor, como faremos, ignora por enquanto, ok
		CAST(NULL as int) as CodigoPlanoContaEstoque, --int --null
		CAST(NULL as int) as CodigoPlanoContaDestino, --int --null
		CAST(NULL as varchar) as CodigoItem, --car2."codice a barre" ou car2."codice articolo" as CodigoItem --int not null "QUAL DEVEMOS UTILIZAR?"
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
	car2."data" as DataHoraEmissao, --datetime (datetime->date) --not null
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
		CAST(NULL as int) as CodigoDocumentoRemessa, --int, --null
		CAST(NULL as int) as CodigoDocumentoCompra, --int --null
		CAST(NULL as int) as CodigoDocumentoTriagem, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(150) --null /*DEVEMOS CRIAR UM CÓDIGO ANTIGO NESTA TABELA? COM QUAIS CAMPOS?*/
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
	CAST(oc."Prisma V SX" as varchar) as Prisma, --varchar(100) --null
	CAST(oc."Base V SX" as varchar) as Base, --varchar(10) (numeric(18,4)->varchar(10)) --null
	CAST(oc."DI V" as Numeric(18,4)) as DI, --numeric(18,4) --null
	CAST(oc."DI V DX" as Numeric(18,4)) as DIOD, --numeric(18,4) --null
	CAST(oc."DI V SX" as Numeric(18,4)) as DIOE, --numeric(18,4) --null
		CAST(NULL as varchar) as Oculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoOculos, --varchar(100) --null
		CAST(NULL as varchar) as TipoMontagem, --varchar(100) --null
		CAST(NULL as varchar) as LenteTipo --varchar(100) --null

	from busta as b
		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		left join clienti as cli
		on ( cli."codice personale" = b."codice cliente" )

		left join carrello2 as car2
		on ( car2."codice cliente" = b."codice cliente")

	where
		(CAST(b."data" as integer) - CAST(oc."data" as integer) >= 0)
);