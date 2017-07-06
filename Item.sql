/*
Exportação do FOCUS para importar no Optisoul
30/01/2017 - Murilo

PENDENCIAS
- PEGAR DO CAMPO "PROCEDIMENTO" (D.DATI) O ESFERICO FINAL E O CILINDRICO
- PENSAR NOS PREÇOS DIFERENTES PARA FILIAL DIFERENTE
- PENSAR LENTES (PREZZI LENTI) PREÇOS DIFERENTES DEPENDENDO DE ALGUMAS VARIAÇÕES
*/
//NOSQLBDETOFF2
drop table if exists Item;

create table Item
(
	Referencia varchar(20), --[varchar](20) NULL,
	CodigoBarras varchar(50), --[varchar](50) NULL,
	CodigoNCM varchar(12), --[int] NULL,
	NCM varchar(8), --O FOCUS POSSUI A DESCRIÇÃO EM OUTRA TABELA, MAS ACREDITO QUE A DA GEEKS SEJA MELHOR [varchar](8) NULL,
	Descricao varchar(500), --[varchar](500) NOT NULL,
	DescricaoComercial varchar(500), --[varchar](500) NOT NULL,
	Tipo varchar(50), --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
	Grupo varchar(50), --[varchar](50) NULL,
	SubGrupo varchar(50), --[varchar](50) NULL,
	Marca varchar(50), --[varchar](50) NULL,
	Status varchar(20), --[varchar](20) NULL CONSTRAINT [DF_Item_Status]  DEFAULT ('Linha'),
	"Local" varchar(20), --[varchar](20) NULL,
	ValorCusto decimal(18, 2), --[decimal](18, 2) NULL,
	ValorCustoUltimo decimal(18, 2), --[decimal](18, 2) NULL,
	ValorCustoMedio decimal(18, 2), --[decimal](18, 2) NULL,
	ValorCustoReposicao decimal(18, 2), --[decimal](18, 2) NULL,
	ValorVenda decimal(18, 2), --[decimal](18, 2) NULL,
	PercentualMarkup decimal(18, 4), --[decimal](18, 4) NULL,
	PercentualMarkupReal decimal(18, 4), --[decimal](18, 4) NULL,
	Unidade varchar(10), --[varchar](10) NULL,
	QuantidadeDisponivel decimal(18, 4), --[decimal](18, 4) NULL CONSTRAINT [DF_Item_QuantidadeDisponivel]  DEFAULT ((0)),
	QuantidadeMinimaEstoque decimal(18, 4), --[decimal](18, 4) NULL,
	QuantidadeMinimaCompra decimal(18, 4), --[decimal](18, 4) NULL,
	TempoMedioReposicao int, --[int] NULL,
	TempoMedioReposicaoReal int, --[int] NULL,
	ConsumoMedio numeric(18, 4), --[numeric](18, 4) NULL,
	ConsumoMedioReal int, --[int] NULL,
	Aplicacao varchar(8000), --[varchar](max) NULL,
	Observacao varchar(255), --[varchar](255) NULL,
	ObservacaoCompra varchar(255), --[varchar](255) NULL,
	ObservacaoVenda varchar(255), --[varchar](255) NULL,
	UtilizaComposicaoPedido int, --[bit] NULL CONSTRAINT [DF_Item_UtilizaComposicaoPedido]  DEFAULT ((0)),
	GarantiaDias int, --[int] NULL,
	GarantiaDescricao varchar(255), --[varchar](255) NULL,
	ValidadeDias numeric(18, 4), --[numeric](18, 4) NULL,
	ValidadeMeses int, --[int] NULL,
	Ativo int, --[bit] NOT NULL CONSTRAINT [DF_Item_Ativo]  DEFAULT ((1)),
	DataCadastro datetime, --[datetime] NOT NULL,
	_CodigoSistema int, --[int] NULL,
	_DataHoraUltimaAlteracao datetime, --[datetime] NULL,
	_UsuarioUltimaAlteracao int, --[int] NULL,
	_UsuarioCriacao int, --[int] NULL,
	_ExcluidoDefinitivo int, --[bit] NULL,
	_UsuarioExcluidoDefinitivo int, --[int] NULL,
	_DataHoraExcluidoDefinitivo datetime, --[datetime] NULL,
	_LOG varchar(8000), --[varchar](max) NULL,
	UtilizaMarkup int, --[bit] NULL,
	Capacidade decimal(18, 4), --[decimal](18, 4) NULL,
	CapacidadeUnidade varchar(20), --[varchar](20) NULL,
	Densidade numeric(18, 4), --[numeric](18, 4) NULL,
	Procedimento varchar(8000), --[varchar](max) NULL,
	AliquotaIPI numeric(18, 4), --[numeric](18, 4) NULL,
	NumeroPop varchar(50), --[varchar](50) NULL,
	Peso numeric(18, 4), --[numeric](18, 4) NULL,
	Aliquota varchar(10), --[varchar](10) NULL,
	CodigoPerfilContabil int, --[int] NULL,
	CodigoOrigem int, --[int] NOT NULL CONSTRAINT [DF_Item_CodigoOrigem]  DEFAULT ((0)),
	CodigoANP varchar(9), --[varchar](9) NULL,
	CodigoAntigo varchar(255), --[varchar](50)->varchar(255) NULL,
	DataPrimeiraVenda datetime, --[datetime] NULL,
	Embalagem varchar(255), --[varchar](255) NULL,
	Modelo varchar(100), --[varchar](100) NULL,
	Genero varchar(100), --[varchar](100) NULL,
	Cor varchar(100), --COR DAS LENTES [varchar](100) NULL,
	Material varchar(100), --MATERIAL DAS LENTES [varchar](100) NULL,
	Tamanho numeric(18, 4), --[numeric](18, 4) NULL,
	Altura numeric(18, 4), --[numeric](18, 4) NULL,
	Largura numeric(18, 4), --PARA A ARMAÇÃO E ÓCULOS ISTO É A MESMA COISA QUE TAMANHO [numeric](18, 4) NULL,
	Comprimento numeric(18, 4), --O QUE É ESTE CAMPO? PARA MIM É IGUAL A LARGURA [numeric](18, 4) NULL,
	Diagonal numeric(18, 4), --[numeric](18, 4) NULL,
	Diametro varchar(10), --[numeric](18, 4) NULL,
	Eixo numeric(18, 4), --[numeric](18, 4) NULL,
	AdicaoInicial numeric(18, 4), --[numeric](18, 4) NULL,
	AdicaoFinal numeric(18, 4), --NULO OU O MESMO QUE AdicaoInicial? [numeric](18, 4) NULL,
	AlturaMinima numeric(18, 4), --[numeric](18, 4) NULL,
	EsfericoInicial numeric(18, 4), --[numeric](18, 4) NULL,
	EsfericoFinal numeric(18, 4), --NULO OU O MESMO QUE EsfericoInicial? [numeric](18, 4) NULL,
	Cilindrico numeric(18, 4), --[numeric](18, 4) NULL,
	AmarcaoCor varchar(100), --[varchar](100) NULL,
	ArmacaoMaterial varchar(100), --[varchar](100) NULL,
	Haste numeric(18, 4), --[numeric](18, 4) NULL,
	Ponte numeric(18, 4), --[numeric](18, 4) NULL,
	RB1 varchar(5), --numeric(18,4)->varchar(5) NULL,
	RB2 numeric(18, 4), --[numeric](18, 4) NULL,
	Geometria varchar(20), --[numeric](18, 4) NULL,
	IndiceRefracao numeric(18, 4), --[numeric](18, 4) NULL,
	PAF_SituacaoTributaria varchar(30), --[varchar](30) NULL,
	PAF_IAT varchar(1), --[varchar](1) NULL,
	PAF_IPPT varchar(1) --[varchar](1) NULL,
);

insert into Item
(
	select 
		CAST(NULL as varchar(20)) as Referencia, --[varchar](20) NULL,
		COALESCE(a."codice a barre", t."codice a barre") as CodigoBarras, --[varchar](50) NULL,
		COALESCE(a."codice doganale", t."codice doganale") as CodigoNCM, --[int] NULL,
		CAST(NULL as varchar(8)) as NCM, --O FOCUS POSSUI A DESCRIÇÃO EM OUTRA TABELA, MAS ACREDITO QUE A DA GEEKS SEJA MELHOR [varchar](8) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN TRIM(GetLinea(COALESCE(a."codice linea", t."codice linea", '')) + ' ' + COALESCE(a."modello", t."modello", '') + ' ' + COALESCE(a."colore", t."colore", '') + ' ' + CAST(COALESCE(a."calibro", t."calibro", '') as varchar(100)))
			ELSE TRIM(COALESCE(a."modello", t."modello", '') + ' ' + GetTrattamento(COALESCE(a."codice trattamento", t."codice trattamento", '')) + ' ' + COALESCE(a."descrizione", t."descrizione", ''))
		END as Descricao, --[varchar](500) NOT NULL
		'' as DescricaoComercial, --[varchar](500) NOT NULL
		CASE 
			WHEN (COALESCE(a."magazzino", t."magazzino") = 0) and (GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'vista') THEN 'Armação'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 0) THEN 'Óculos'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 1) THEN 'Lente Oftálmica'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 2) THEN 'Lente de Contato'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 3) THEN 'Outro Produto'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 4) THEN 'Serviço'
			ELSE 'Outro Produto'
			--E O TRATAMENTO? DIFÍCIL SEPARAR
		END as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti"))
			WHEN 1 THEN GetFamiglia(COALESCE(a."codice famiglia", t."codice famiglia"))
			WHEN 2 THEN GetFamigliaLac(COALESCE(a."codice famiglia", t."codice famiglia"))
			ELSE GetTipoProdotto(COALESCE(a."codice tipo prodotto", t."codice tipo prodotto"))
			--E O TRATAMENTO?
		END as Grupo, --[varchar](50) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN GetMontaggio(COALESCE(a."codice montaggio", t."codice montaggio"))
			--WHEN 1 THEN GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) --EH A MESMA COISA QUE FAMILIA
			WHEN 2 THEN GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti"))
		END as SubGrupo, --[varchar](50) NULL,
		GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) as Marca, --[varchar](50) NULL,
		'Linha' as Status, --[varchar](20) NULL CONSTRAINT [DF_Item_Status]  DEFAULT ('Linha'),
		CAST(NULL as varchar(20)) as "Local", --[varchar](20) NULL,
		COALESCE(am."prezzo listino acquisto", t."prezzo listino acquisto") as ValorCusto, --[decimal](18, 2) NULL,
		am."prezzo acquisto" as ValorCustoUltimo, --[decimal](18, 2) NULL,
		am."costo medio" as ValorCustoMedio, --[decimal](18, 2) NULL,
		COALESCE(am."prezzo listino acquisto", t."prezzo listino acquisto") as ValorCustoReposicao, --[decimal](18, 2) NULL,
		COALESCE(af."prezzo vendita", t."prezzo consigliato") as ValorVenda, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkup, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkupReal, --[decimal](18, 4) NULL,
		COALESCE(a."UM", t."UM") as Unidade, --[varchar](10) NULL,
		0 as QuantidadeDisponivel, --[decimal](18, 4) NULL CONSTRAINT [DF_Item_QuantidadeDisponivel]  DEFAULT ((0)),
		am."scorta minima" as QuantidadeMinimaEstoque, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaCompra, --[decimal](18, 4) NULL,
		CAST(NULL as int) as TempoMedioReposicao, --[int] NULL,
		CAST(NULL as int) as TempoMedioReposicaoReal, --[int] NULL,
		CAST(NULL as numeric(18, 4)) as ConsumoMedio, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ConsumoMedioReal, --[int] NULL,
		CAST(NULL as varchar(8000)) as Aplicacao, --[varchar](max) NULL,
		CAST(COALESCE(a."Note", t."Note") as varchar(255)) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoCompra, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoVenda, --[varchar](255) NULL,
		0 as UtilizaComposicaoPedido, --[bit] NULL CONSTRAINT [DF_Item_UtilizaComposicaoPedido]  DEFAULT ((0)),
		CAST(NULL as int) as GarantiaDias, --[int] NULL,
		CAST(NULL as varchar(255)) as GarantiaDescricao, --[varchar](255) NULL,
		CASE COALESCE(a."codice durata", t."codice durata")
			WHEN '01' THEN 1
			WHEN '07' THEN 7
			WHEN '15' THEN 15
			WHEN 'M1' THEN 30
			WHEN 'M2' THEN 60
			WHEN 'M3' THEN 90
			WHEN 'M6' THEN 180
			WHEN 'Y1' THEN 365
		END as ValidadeDias, --[numeric](18, 4) NULL,
		CASE COALESCE(a."codice durata", t."codice durata")
			WHEN '01' THEN 0
			WHEN '07' THEN 0
			WHEN '15' THEN 0
			WHEN 'M1' THEN 1
			WHEN 'M2' THEN 2
			WHEN 'M3' THEN 3
			WHEN 'M6' THEN 6
			WHEN 'Y1' THEN 12
		END as ValidadeMeses, --[int] NULL,
		1 as Ativo, --[bit] NOT NULL CONSTRAINT [DF_Item_Ativo]  DEFAULT ((1)),
		CAST(t."data inserimento" as datetime) as DataCadastro, --[datetime] NOT NULL,
		CAST(NULL as int) as _CodigoSistema, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraUltimaAlteracao, --[datetime] NULL,
		CAST(NULL as int) as _UsuarioUltimaAlteracao, --[int] NULL,
		CAST(NULL as int) as _UsuarioCriacao, --[int] NULL,
		CAST(NULL as byte) as _ExcluidoDefinitivo, --[bit] NULL,
		CAST(NULL as int) as _UsuarioExcluidoDefinitivo, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraExcluidoDefinitivo, --[datetime] NULL,
		CAST(NULL as varchar(8000)) as _LOG, --[varchar](max) NULL,
		CAST(NULL as byte) as UtilizaMarkup, --[bit] NULL,
		CAST(NULL as decimal(18, 4)) as Capacidade, --[decimal](18, 4) NULL,
		CAST(NULL as varchar(20)) as CapacidadeUnidade, --[varchar](20) NULL,
		CAST(NULL as numeric(18, 4)) as Densidade, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(8000)) as Procedimento, --[varchar](max) NULL,
		COALESCE(a."campo_1", t."campo_1") as AliquotaIPI, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(50)) as NumeroPop, --[varchar](50) NULL,
		CAST(NULL as numeric(18, 4)) as Peso, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(10)) as Aliquota, --[varchar](10) NULL,
		CAST(NULL as int) as CodigoPerfilContabil, --[int] NULL,
		CASE WHEN COALESCE(a."nazionale estero", t."nazionale estero")
			THEN 1 --ISSO É UM CHUTE, POIS NÃO SEI SE A PEÇA FOI ADQUIRIDA NO MERCADO INTERNO OU IMPORTAÇÃO DIRETA, NESTE CASO, IMPORTAÇÃO DIRETA
			ELSE 0
		END as CodigoOrigem, --[int] NOT NULL CONSTRAINT [DF_Item_CodigoOrigem]  DEFAULT ((0)),
		CAST(NULL as varchar(9)) as CodigoANP, --[varchar](9) NULL,
		COALESCE('articoli.' + a."codice filiale", 'articoli_fornitore.' + t."codice a barre") as CodigoAntigo, --[varchar](255) NULL,
		CAST(NULL as datetime) as DataPrimeiraVenda, --[datetime] NULL,
		CAST(NULL as varchar(255)) as Embalagem, --[varchar](255) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN COALESCE(a."modello", t."modello")
		END as Modelo, --[varchar](100) NULL,
		GetUtente(COALESCE(a."codice utente", t."codice utente")) as Genero, --[varchar](100) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN COALESCE(t."colore 2", a."colore 2")
			ELSE COALESCE(a."colore", t."colore")
		END as Cor, --COR DAS LENTES [varchar](100) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN CAST(NULL as varchar(25)) --PODEMOS TRATAR POLARIZADO, FOTOSENSÍVEL, ETC. POR AQUI?
			ELSE GetMateriale(COALESCE(a."codice materiale", t."codice materiale"))
		END as Material, --MATERIAL DAS LENTES [varchar](100) NULL,
		COALESCE(a."calibro", t."calibro") as Tamanho, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Altura, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Largura, --PARA A ARMAÇÃO E ÓCULOS ISTO É A MESMA COISA QUE TAMANHO [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Comprimento, --O QUE É ESTE CAMPO? PARA MIM É IGUAL A LARGURA [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Diagonal, --[numeric](18, 4) NULL,
		COALESCE(a."diametro", t."diametro") as Diametro, --[numeric](18, 4) NULL,
		CAST(COALESCE(a."asse", t."asse") as numeric(18,4)) as Eixo, --[numeric](18, 4) NULL,
		CAST(COALESCE(a."addizione", t."addizione") as numeric(18,4)) as AdicaoInicial, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AdicaoFinal, --NULO OU O MESMO QUE AdicaoInicial? [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AlturaMinima, --[numeric](18, 4) NULL,
		CAST(COALESCE(a."sfera", t."sfera") as numeric(18,4)) as EsfericoInicial, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as EsfericoFinal, --NULO OU O MESMO QUE EsfericoInicial? [numeric](18, 4) NULL,
		CAST(COALESCE(a."cilindro", t."cilindro") as numeric(18,4)) as Cilindrico, --[numeric](18, 4) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN COALESCE(a."colore", t."colore")
		END as AmarcaoCor, --[varchar](100) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN GetMateriale(COALESCE(a."codice materiale", t."codice materiale"))
		END as ArmacaoMaterial, --[varchar](100) NULL,
		CAST(COALESCE(a."asta", t."asta") as numeric(18,4)) as Haste, --[numeric](18, 4) NULL,
		CAST(COALESCE(a."ponte", t."ponte") as numeric(18,4)) as Ponte, --[numeric](18, 4) NULL,
		COALESCE(a."rb", t."rb") as RB1, --varchar(5) (numeric(18,4)->varchar(5)) NULL,
		CAST(COALESCE(a."rb2", t."rb2") as numeric(18,4)) as RB2, --[numeric](18, 4) NULL,
		GetGeometriaLac(COALESCE(a."codice geometria", t."codice geometria")) as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) NULL,
		CAST(COALESCE(a."indice rifrazione", t."indice rifrazione") as numeric(18,4)) as IndiceRefracao, --[numeric](18, 4) NULL,
		COALESCE(a."situazione tributaria", t."situazione tributaria") as PAF_SituacaoTributaria, --[varchar](30) NULL,
		COALESCE(a."IAT", t."IAT") as PAF_IAT, --[varchar](1) NULL,
		COALESCE(a."IPPT", t."IPPT") as PAF_IPPT --[varchar](1) NULL,
	from articoli_fornitore as t
		full outer join articoli as a
			on (a."codice a barre" = t."codice a barre")
		left join articoli_mag as am
			on (am."codice articolo" = a."codice filiale")
		left join articoli_fil as af
			on (af."codice articolo" = am."codice articolo") and (af."filiale" = am."filiale")
	where
		(am."filiale" = GetFiliale) --PEGANDO SÓ DE UMA FILIAL PRA NÃO DAR PROBLEMA DE DUPLICAÇÃO

	UNION

	select 
		CAST(NULL as varchar(20)) as Referencia, --[varchar](20) NULL,
		c."codice a barre" as CodigoBarras, --[varchar](50) NULL,
		c."codice doganale" as CodigoNCM, --[int] NULL,
		CAST(NULL as varchar(8)) as NCM, --O FOCUS POSSUI A DESCRIÇÃO EM OUTRA TABELA, MAS ACREDITO QUE A DA GEEKS SEJA MELHOR [varchar](8) NULL,
		TRIM(c."modello" + ' ' + c."trattamento" + ' ' + c."descrizione") as Descricao, --[varchar](500) NOT NULL,
		'' as DescricaoComercial, --[varchar](500) NOT NULL,
		'Lente Oftálmica' as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
		c."linea" as Grupo, --[varchar](50) NULL,
		CAST(NULL as varchar(50)) as SubGrupo, --[varchar](50) NULL,
		c."marca" as Marca, --[varchar](50) NULL,
		'Linha' as Status, --[varchar](20) NULL CONSTRAINT [DF_Item_Status]  DEFAULT ('Linha'),
		CAST(NULL as varchar(20)), --[varchar](20) NULL,
		COALESCE(p."prezzo acquisto", c."prezzo acquisto", 0.00) as ValorCusto, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoUltimo, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoMedio, --[decimal](18, 2) NULL,
		COALESCE(p."prezzo acquisto", c."prezzo acquisto", 0.00) as ValorCustoReposicao, --[decimal](18, 2) NULL,
		COALESCE(p."prezzo di vendita", c."prezzo di vendita", 0.00) as ValorVenda, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkup, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkupReal, --[decimal](18, 4) NULL,
		CAST(NULL as varchar(10)) as Unidade, --[varchar](10) NULL,
		0 as QuantidadeDisponivel, --[decimal](18, 4) NULL CONSTRAINT [DF_Item_QuantidadeDisponivel]  DEFAULT ((0)),
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaEstoque, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaCompra, --[decimal](18, 4) NULL,
		CAST(NULL as int) as TempoMedioReposicao, --[int] NULL,
		CAST(NULL as int) as TempoMedioReposicaoReal, --[int] NULL,
		CAST(NULL as numeric(18, 4)) as ConsumoMedio, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ConsumoMedioReal, --[int] NULL,
		CAST(NULL as varchar(8000)) as Aplicacao, --[varchar](max) NULL,
		CAST(c."note" as varchar(255)) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoCompra, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoVenda, --[varchar](255) NULL,
		0 as UtilizaComposicaoPedido, --[bit] NULL CONSTRAINT [DF_Item_UtilizaComposicaoPedido]  DEFAULT ((0)),
		CAST(NULL as int) as GarantiaDias, --[int] NULL,
		CAST(NULL as varchar(255)) as GarantiaDescricao, --[varchar](255) NULL,
		CAST(NULL as numeric(18, 4)) as ValidadeDias, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ValidadeMeses, --[int] NULL,
		1 as Ativo, --[bit] NOT NULL CONSTRAINT [DF_Item_Ativo]  DEFAULT ((1)),
		CAST(NULL as datetime) as DataCadastro, --[datetime] NOT NULL,
		CAST(NULL as int) as _CodigoSistema, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraUltimaAlteracao, --[datetime] NULL,
		CAST(NULL as int) as _UsuarioUltimaAlteracao, --[int] NULL,
		CAST(NULL as int) as _UsuarioCriacao, --[int] NULL,
		CAST(NULL as byte) as _ExcluidoDefinitivo, --[bit] NULL,
		CAST(NULL as int) as _UsuarioExcluidoDefinitivo, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraExcluidoDefinitivo, --[datetime] NULL,
		CAST(NULL as varchar(8000)) as _LOG, --[varchar](max) NULL,
		CAST(NULL as byte) as UtilizaMarkup, --[bit] NULL,
		CAST(NULL as decimal(18, 4)) as Capacidade, --[decimal](18, 4) NULL,
		CAST(NULL as varchar(20)) as CapacidadeUnidade, --[varchar](20) NULL,
		CAST(NULL as numeric(18, 4)) as Densidade, --[numeric](18, 4) NULL,
		CAST(COALESCE(d."dati", '') as varchar(8000)) as Procedimento, --[varchar](max) NULL,
		CAST(NULL as numeric(18, 4)) as AliquotaIPI, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(50)) as NumeroPop, --[varchar](50) NULL,
		CAST(NULL as numeric(18, 4)) as Peso, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(10)) as Aliquota, --[varchar](10) NULL,
		CAST(NULL as int) as CodigoPerfilContabil, --[int] NULL,
		0 as CodigoOrigem, --[int] NOT NULL CONSTRAINT [DF_Item_CodigoOrigem]  DEFAULT ((0)),
		CAST(NULL as varchar(9)) as CodigoANP, --[varchar](9) NULL,
		'c.' + c."codice filiale" + 
			COALESCE('.d.' + d."codice filiale", '') +
			COALESCE('.dx.' + dx."codice filiale", '') +
			COALESCE('.p.' + p."codice filiale", '') as CodigoAntigo, --[varchar](255) NULL,
		CAST(NULL as datetime) as DataPrimeiraVenda, --[datetime] NULL,
		CAST(NULL as varchar(255)) as Embalagem, --[varchar](255) NULL,
		CAST(NULL as varchar(100)) as Modelo, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as Genero, --[varchar](100) NULL,
		c."colore" as Cor, --COR DAS LENTES [varchar](100) NULL,
		c."materiale" as Material, --MATERIAL DAS LENTES [varchar](100) NULL,
		CAST(NULL as numeric(18, 4)) as Tamanho, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Altura, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Largura, --PARA A ARMAÇÃO E ÓCULOS ISTO É A MESMA COISA QUE TAMANHO [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Comprimento, --O QUE É ESTE CAMPO? PARA MIM É IGUAL A LARGURA [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Diagonal, --[numeric](18, 4) NULL,
		COALESCE(dx."diametro", d."diametro") as Diametro, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Eixo, --[numeric](18, 4) NULL,
		dx."da addizione" as AdicaoInicial, --[numeric](18, 4) NULL,
		dx."a addizione" as AdicaoFinal, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AlturaMinima, --[numeric](18, 4) NULL,
		dx."da sfero" as EsfericoInicial, --[numeric](18, 4) NULL,
		dx."a sfero" as EsfericoFinal, --[numeric](18, 4) NULL,
		dx."cilindro massimo" as Cilindrico, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(100)) as AmarcaoCor, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as ArmacaoMaterial, --[varchar](100) NULL,
		CAST(NULL as numeric(18, 4)) as Haste, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Ponte, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as RB1, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as RB2, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as Geometria, --[numeric](18, 4) NULL,
		CAST
		(
			(
				CASE WHEN ((c."tipo lenti" = '') or (POSITION('.' in c."tipo lenti") <> 0))
					THEN c."tipo lenti"
					ELSE 
						SUBSTRING
						(
							c."tipo lenti" from 0 for 
							(
								CASE WHEN POSITION(',' in c."tipo lenti") = 0 THEN CHAR_LENGTH(c."tipo lenti") ELSE POSITION(',' in c."tipo lenti")-1 END
							)
						) +
						'.' + 
						(
							CASE WHEN POSITION(',' in c."tipo lenti") = 0 
								THEN '0' 
								ELSE SUBSTRING(c."tipo lenti" from POSITION(',' in c."tipo lenti")+1 for CHAR_LENGTH(c."tipo lenti") - POSITION(',' in c."tipo lenti")) 
							END
						) 
				END
			) as numeric(18, 4)
		) as IndiceRefracao, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(30)) as PAF_SituacaoTributaria, --[varchar](30) NULL,
		CAST(NULL as varchar(1)) as PAF_IAT, --[varchar](1) NULL,
		CAST(NULL as varchar(1)) as PAF_IPPT --[varchar](1) NULL,
	from catalogo as c
		left join diametrirx as dx 
			on (diametrirx."codice articolo" = c."codice filiale")

		left join diametri as d
			on (d."codice articolo" = c."codice filiale")

		left join prezzilenti as p
			on (p."codice articolo" = c."codice filiale")

	where (c."magazzino" = 1)

	UNION

	select distinct 
		CAST(NULL as varchar(20)) as Referencia, --[varchar](20) NULL,
		CAST(NULL as varchar(50)) as CodigoBarras, --[varchar](50) NULL,
		CAST(NULL as varchar) as CodigoNCM, --[int] NULL,
		CAST(NULL as varchar(8)) as NCM, --O FOCUS POSSUI A DESCRIÇÃO EM OUTRA TABELA, MAS ACREDITO QUE A DA GEEKS SEJA MELHOR [varchar](8) NULL,
		TRIM(t."descrizione") as Descricao, --[varchar](500) NOT NULL,
		'' as DescricaoComercial, --[varchar](500) NOT NULL,
		'Tratamento' as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
		CAST(NULL as varchar(50)) as Grupo, --[varchar](50) NULL,
		CAST(NULL as varchar(50)) as SubGrupo, --[varchar](50) NULL,
		CAST(NULL as varchar(50)) as Marca, --[varchar](50) NULL,
		'Linha' as Status, --[varchar](20) NULL CONSTRAINT [DF_Item_Status]  DEFAULT ('Linha'),
		CAST(NULL as varchar(20)), --[varchar](20) NULL,
		t."prezzo acquisto" as ValorCusto, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoUltimo, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoMedio, --[decimal](18, 2) NULL,
		t."prezzo acquisto" as ValorCustoReposicao, --[decimal](18, 2) NULL,
		t."prezzo di vendita" as ValorVenda, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkup, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkupReal, --[decimal](18, 4) NULL,
		CAST(NULL as varchar(10)) as Unidade, --[varchar](10) NULL,
		0 as QuantidadeDisponivel, --[decimal](18, 4) NULL CONSTRAINT [DF_Item_QuantidadeDisponivel]  DEFAULT ((0)),
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaEstoque, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaCompra, --[decimal](18, 4) NULL,
		CAST(NULL as int) as TempoMedioReposicao, --[int] NULL,
		CAST(NULL as int) as TempoMedioReposicaoReal, --[int] NULL,
		CAST(NULL as numeric(18, 4)) as ConsumoMedio, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ConsumoMedioReal, --[int] NULL,
		CAST(NULL as varchar(8000)) as Aplicacao, --[varchar](max) NULL,
		CAST(NULL as varchar(255)) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoCompra, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoVenda, --[varchar](255) NULL,
		0 as UtilizaComposicaoPedido, --[bit] NULL CONSTRAINT [DF_Item_UtilizaComposicaoPedido]  DEFAULT ((0)),
		CAST(NULL as int) as GarantiaDias, --[int] NULL,
		CAST(NULL as varchar(255)) as GarantiaDescricao, --[varchar](255) NULL,
		CAST(NULL as numeric(18, 4)) as ValidadeDias, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ValidadeMeses, --[int] NULL,
		1 as Ativo, --[bit] NOT NULL CONSTRAINT [DF_Item_Ativo]  DEFAULT ((1)),
		CAST(NULL as datetime) as DataCadastro, --[datetime] NOT NULL,
		CAST(NULL as int) as _CodigoSistema, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraUltimaAlteracao, --[datetime] NULL,
		CAST(NULL as int) as _UsuarioUltimaAlteracao, --[int] NULL,
		CAST(NULL as int) as _UsuarioCriacao, --[int] NULL,
		CAST(NULL as byte) as _ExcluidoDefinitivo, --[bit] NULL,
		CAST(NULL as int) as _UsuarioExcluidoDefinitivo, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraExcluidoDefinitivo, --[datetime] NULL,
		CAST(NULL as varchar(8000)) as _LOG, --[varchar](max) NULL,
		CAST(NULL as byte) as UtilizaMarkup, --[bit] NULL,
		CAST(NULL as decimal(18, 4)) as Capacidade, --[decimal](18, 4) NULL,
		CAST(NULL as varchar(20)) as CapacidadeUnidade, --[varchar](20) NULL,
		CAST(NULL as numeric(18, 4)) as Densidade, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(8192)) as Procedimento, --[varchar](max) NULL,
		CAST(NULL as numeric(18, 4)) as AliquotaIPI, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(50)) as NumeroPop, --[varchar](50) NULL,
		CAST(NULL as numeric(18, 4)) as Peso, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(10)) as Aliquota, --[varchar](10) NULL,
		CAST(NULL as int) as CodigoPerfilContabil, --[int] NULL,
		0 as CodigoOrigem, --[int] NOT NULL CONSTRAINT [DF_Item_CodigoOrigem]  DEFAULT ((0)),
		CAST(NULL as varchar(9)) as CodigoANP, --[varchar](9) NULL,
		't.' + SUBSTRING(t."descrizione" from 0 for 33) + COALESCE('.f.' + f."codice filiale", '') as CodigoAntigo, --[varchar](255) NULL,
		CAST(NULL as datetime) as DataPrimeiraVenda, --[datetime] NULL,
		CAST(NULL as varchar(255)) as Embalagem, --[varchar](255) NULL,
		CAST(NULL as varchar(100)) as Modelo, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as Genero, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as Cor, --COR DAS LENTES [varchar](100) NULL,
		CAST(NULL as varchar(100)) as Material, --MATERIAL DAS LENTES [varchar](100) NULL,
		CAST(NULL as numeric(18, 4)) as Tamanho, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Altura, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Largura, --PARA A ARMAÇÃO E ÓCULOS ISTO É A MESMA COISA QUE TAMANHO [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Comprimento, --O QUE É ESTE CAMPO? PARA MIM É IGUAL A LARGURA [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Diagonal, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as Diametro, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Eixo, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AdicaoInicial, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AdicaoFinal, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AlturaMinima, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as EsfericoInicial, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as EsfericoFinal, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Cilindrico, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(100)) as AmarcaoCor, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as ArmacaoMaterial, --[varchar](100) NULL,
		CAST(NULL as numeric(18, 4)) as Haste, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Ponte, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as RB1, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as RB2, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as Geometria, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as IndiceRefracao, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(30)) as PAF_SituacaoTributaria, --[varchar](30) NULL,
		CAST(NULL as varchar(1)) as PAF_IAT, --[varchar](1) NULL,
		CAST(NULL as varchar(1)) as PAF_IPPT --[varchar](1) NULL,
	from trattamenti as t
		join catalogo as c
			on (t."codice articolo" = c."codice filiale")
		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")

	where (c."magazzino" = 1)

	UNION

	select distinct 
		CAST(NULL as varchar(20)) as Referencia, --[varchar](20) NULL,
		CAST(NULL as varchar(50)) as CodigoBarras, --[varchar](50) NULL,
		CAST(NULL as varchar) as CodigoNCM, --[int] NULL,
		CAST(NULL as varchar(8)) as NCM, --O FOCUS POSSUI A DESCRIÇÃO EM OUTRA TABELA, MAS ACREDITO QUE A DA GEEKS SEJA MELHOR [varchar](8) NULL,
		TRIM(s."descrizione") as Descricao, --[varchar](500) NOT NULL,
		'' as DescricaoComercial, --[varchar](500) NOT NULL,
		'Tratamento' as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
		CAST(NULL as varchar(50)) as Grupo, --[varchar](50) NULL,
		CAST(NULL as varchar(50)) as SubGrupo, --[varchar](50) NULL,
		CAST(NULL as varchar(50)) as Marca, --[varchar](50) NULL,
		'Linha' as Status, --[varchar](20) NULL CONSTRAINT [DF_Item_Status]  DEFAULT ('Linha'),
		CAST(NULL as varchar(20)), --[varchar](20) NULL,
		s."prezzo acquisto" as ValorCusto, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoUltimo, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoMedio, --[decimal](18, 2) NULL,
		s."prezzo acquisto" as ValorCustoReposicao, --[decimal](18, 2) NULL,
		s."prezzo di vendita" as ValorVenda, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkup, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkupReal, --[decimal](18, 4) NULL,
		CAST(NULL as varchar(10)) as Unidade, --[varchar](10) NULL,
		0 as QuantidadeDisponivel, --[decimal](18, 4) NULL CONSTRAINT [DF_Item_QuantidadeDisponivel]  DEFAULT ((0)),
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaEstoque, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaCompra, --[decimal](18, 4) NULL,
		CAST(NULL as int) as TempoMedioReposicao, --[int] NULL,
		CAST(NULL as int) as TempoMedioReposicaoReal, --[int] NULL,
		CAST(NULL as numeric(18, 4)) as ConsumoMedio, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ConsumoMedioReal, --[int] NULL,
		CAST(NULL as varchar(8000)) as Aplicacao, --[varchar](max) NULL,
		CAST(NULL as varchar(255)) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoCompra, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoVenda, --[varchar](255) NULL,
		0 as UtilizaComposicaoPedido, --[bit] NULL CONSTRAINT [DF_Item_UtilizaComposicaoPedido]  DEFAULT ((0)),
		CAST(NULL as int) as GarantiaDias, --[int] NULL,
		CAST(NULL as varchar(255)) as GarantiaDescricao, --[varchar](255) NULL,
		CAST(NULL as numeric(18, 4)) as ValidadeDias, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ValidadeMeses, --[int] NULL,
		1 as Ativo, --[bit] NOT NULL CONSTRAINT [DF_Item_Ativo]  DEFAULT ((1)),
		CAST(NULL as datetime) as DataCadastro, --[datetime] NOT NULL,
		CAST(NULL as int) as _CodigoSistema, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraUltimaAlteracao, --[datetime] NULL,
		CAST(NULL as int) as _UsuarioUltimaAlteracao, --[int] NULL,
		CAST(NULL as int) as _UsuarioCriacao, --[int] NULL,
		CAST(NULL as byte) as _ExcluidoDefinitivo, --[bit] NULL,
		CAST(NULL as int) as _UsuarioExcluidoDefinitivo, --[int] NULL,
		CAST(NULL as datetime) as _DataHoraExcluidoDefinitivo, --[datetime] NULL,
		CAST(NULL as varchar(8000)) as _LOG, --[varchar](max) NULL,
		CAST(NULL as byte) as UtilizaMarkup, --[bit] NULL,
		CAST(NULL as decimal(18, 4)) as Capacidade, --[decimal](18, 4) NULL,
		CAST(NULL as varchar(20)) as CapacidadeUnidade, --[varchar](20) NULL,
		CAST(NULL as numeric(18, 4)) as Densidade, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(8192)) as Procedimento, --[varchar](max) NULL,
		CAST(NULL as numeric(18, 4)) as AliquotaIPI, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(50)) as NumeroPop, --[varchar](50) NULL,
		CAST(NULL as numeric(18, 4)) as Peso, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(10)) as Aliquota, --[varchar](10) NULL,
		CAST(NULL as int) as CodigoPerfilContabil, --[int] NULL,
		0 as CodigoOrigem, --[int] NOT NULL CONSTRAINT [DF_Item_CodigoOrigem]  DEFAULT ((0)),
		CAST(NULL as varchar(9)) as CodigoANP, --[varchar](9) NULL,
		's.' + SUBSTRING(s."descrizione" from 0 for 33) + COALESCE('.f.' + f."codice filiale", '') as CodigoAntigo, --[varchar](255) NULL,
		CAST(NULL as datetime) as DataPrimeiraVenda, --[datetime] NULL,
		CAST(NULL as varchar(255)) as Embalagem, --[varchar](255) NULL,
		CAST(NULL as varchar(100)) as Modelo, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as Genero, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as Cor, --COR DAS LENTES [varchar](100) NULL,
		CAST(NULL as varchar(100)) as Material, --MATERIAL DAS LENTES [varchar](100) NULL,
		CAST(NULL as numeric(18, 4)) as Tamanho, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Altura, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Largura, --PARA A ARMAÇÃO E ÓCULOS ISTO É A MESMA COISA QUE TAMANHO [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Comprimento, --O QUE É ESTE CAMPO? PARA MIM É IGUAL A LARGURA [numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Diagonal, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as Diametro, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Eixo, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AdicaoInicial, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AdicaoFinal, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as AlturaMinima, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as EsfericoInicial, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as EsfericoFinal, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Cilindrico, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(100)) as AmarcaoCor, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as ArmacaoMaterial, --[varchar](100) NULL,
		CAST(NULL as numeric(18, 4)) as Haste, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as Ponte, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as RB1, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as RB2, --[numeric](18, 4) NULL,
		CAST(NULL as varchar) as Geometria, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18, 4)) as IndiceRefracao, --[numeric](18, 4) NULL,
		CAST(NULL as varchar(30)) as PAF_SituacaoTributaria, --[varchar](30) NULL,
		CAST(NULL as varchar(1)) as PAF_IAT, --[varchar](1) NULL,
		CAST(NULL as varchar(1)) as PAF_IPPT --[varchar](1) NULL,
	from supplementi as s
		join catalogo as c
			on (s."codice articolo" = c."codice filiale")
		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")

	where (c."magazzino" = 1)
);