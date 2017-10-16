//NOSQLBDETOFF2
drop table if exists Item;
create table Item
(
	Referencia varchar(25), --[varchar](20) NULL,
	CodigoBarras varchar(50), --[varchar](50) NULL,
	CodigoBarrasAntigo varchar, --[varchar](50) NULL,
	CodigoNCM int, --[int] NULL,
	NCM varchar(8), --[varchar](8) NULL,
	CEST varchar, --varchar NULL,
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
	UtilizaComposicaoValorReposicao varchar, --varchar NULL,
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
	Procedimento varchar, --[varchar](max) NULL,
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
	TipoMontagem varchar(25), --varchar NULL
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
	AlturaMontagem numeric(18,4), --numeric(18,4) NULL,
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
	PAF_IPPT varchar(1), --[varchar](1) NULL,
	LenteTipo varchar(20) --varchar NULL
);

create index CodAntIdx on Item("CodigoAntigo");

--ARTICOLI & ARTICOLI_FORNITORE (ESTOQUE & TAB PREÇOS)
insert into Item
(
	select 
		COALESCE(a."SKU", t."SKU") as Referencia, --[varchar](20) NULL,
		COALESCE(a."codice a barre", t."codice a barre") as CodigoBarras, --[varchar](50) NULL,
		CAST(NULL as varchar) as CodigoBarrasAntigo, --[varchar] NULL,
		CAST(NULL as int) as CodigoNCM, --[int] NULL,
		CAST(COALESCE(a."codice doganale", t."codice doganale") as varchar(8)) as NCM, --[varchar](8) NULL,
		CAST(NULL as varchar) as CEST, --varchar NULL
		(CASE COALESCE(a."magazzino", t."magazzino")
			WHEN(0)
			THEN 
				(TRIM(
						(CASE
							WHEN( GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) = GetLinea(COALESCE(a."codice linea", t."codice linea")) )
							THEN( GetLinea(COALESCE(a."codice linea", t."codice linea", '')) )
							ELSE( COALESCE((GetLinea(COALESCE(a."codice linea", t."codice linea", ''))), (GetMarchio(COALESCE(a."codice marchio", t."codice marchio")))) )
						END)
					)
				+ ' ' +COALESCE(a."modello", t."modello", '')
				+ ' ' +COALESCE(a."colore", t."colore", '')
				+ ' ' +CAST(COALESCE(a."calibro", t."calibro", '') as varchar(100)))
			ELSE
				(TRIM(COALESCE(a."modello", t."modello", '') + ' ' +GetTrattamento(COALESCE(a."codice trattamento", t."codice trattamento", '')) + ' ' +COALESCE(a."descrizione", t."descrizione", '')))
		END) as Descricao, --[varchar](500) NOT NULL
		(CASE COALESCE(a."magazzino", t."magazzino")
			WHEN(0)
			THEN 
				(TRIM(
						(CASE
							WHEN( GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) = GetLinea(COALESCE(a."codice linea", t."codice linea")) )
							THEN( GetLinea(COALESCE(a."codice linea", t."codice linea", '')) )
							ELSE( COALESCE((GetLinea(COALESCE(a."codice linea", t."codice linea", ''))), (GetMarchio(COALESCE(a."codice marchio", t."codice marchio")))) )
						END)
					)
				+ ' ' +COALESCE(a."modello", t."modello", '')
				+ ' ' +COALESCE(a."colore", t."colore", '')
				+ ' ' +CAST(COALESCE(a."calibro", t."calibro", '') as varchar(100)))
			ELSE
				(TRIM(COALESCE(a."modello", t."modello", '') + ' ' +GetTrattamento(COALESCE(a."codice trattamento", t."codice trattamento", '')) + ' ' +COALESCE(a."descrizione", t."descrizione", '')))
		END) as DescricaoComercial, --[varchar](500) NOT NULL
		CASE 
			WHEN (COALESCE(a."magazzino", t."magazzino") = 0) and (GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'vista') THEN 'Armação'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 0) and ((GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'solar') or (GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'sol') or (GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'sole')) THEN 'Óculos Sol'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 0) and ((GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'padrão') or (GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'prediposti')) THEN 'Óculos Pronto'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 1) THEN 'Lente'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 2) THEN 'Lente Contato'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 3) THEN 'Produto'
			WHEN (COALESCE(a."magazzino", t."magazzino") = 4) THEN 'Serviço'
			ELSE 'Produto'
			--E O TRATAMENTO? DIFÍCIL SEPARAR
		END as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 2 THEN GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti"))
			WHEN 3 THEN GetTipoProdotto(COALESCE(a."codice tipo prodotto", t."codice tipo prodotto"))
			--E O TRATAMENTO?
		END as Grupo, --[varchar](50) NULL,
		CAST(NULL as varchar) as SubGrupo, --[varchar](50) NULL,
		GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) as Marca, --[varchar](50) NULL,
		'Linha' as Status, --[varchar](20) NULL CONSTRAINT [DF_Item_Status]  DEFAULT ('Linha'),
		CAST(NULL as varchar(20)) as "Local", --[varchar](20) NULL,
		MAX(COALESCE(am."prezzo listino acquisto", t."prezzo listino acquisto")) as ValorCusto, --[decimal](18, 2) NULL,
		MAX(am."prezzo acquisto") as ValorCustoUltimo, --[decimal](18, 2) NULL,
		MAX(am."costo medio") as ValorCustoMedio, --[decimal](18, 2) NULL,
		MAX(COALESCE(am."prezzo listino acquisto", t."prezzo listino acquisto")) as ValorCustoReposicao, --[decimal](18, 2) NULL,
		MAX(COALESCE(af."prezzo vendita", t."prezzo consigliato")) as ValorVenda, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkup, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as PercentualMarkupReal, --[decimal](18, 4) NULL,
		COALESCE(a."UM", t."UM") as Unidade, --[varchar](10) NULL,
		0 as QuantidadeDisponivel, --[decimal](18, 4) NULL CONSTRAINT [DF_Item_QuantidadeDisponivel]  DEFAULT ((0)),
		MAX(am."scorta minima") as QuantidadeMinimaEstoque, --[decimal](18, 4) NULL,
		CAST(NULL as decimal(18, 4)) as QuantidadeMinimaCompra, --[decimal](18, 4) NULL,
		CAST(NULL as int) as TempoMedioReposicao, --[int] NULL,
		CAST(NULL as int) as TempoMedioReposicaoReal, --[int] NULL,
		CAST(NULL as numeric(18, 4)) as ConsumoMedio, --[numeric](18, 4) NULL,
		CAST(NULL as int) as ConsumoMedioReal, --[int] NULL,
		CAST(NULL as varchar(8000)) as Aplicacao, --[varchar](max) NULL,
		CAST(COALESCE(a."Note", t."Note") as varchar(255)) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoCompra, --[varchar](255) NULL,
		CAST(NULL as varchar(255)) as ObservacaoVenda, --[varchar](255) NULL,
		CAST(NULL as varchar) as UtilizaComposicaoValorReposicao, --varchar NULL
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
		CAST(NULL as varchar) as Procedimento, --[varchar](max) NULL,
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
		CASE GetUtente(COALESCE(a."codice utente", t."codice utente"))
			WHEN 'garota' THEN 'Feminino'
			WHEN 'garoto' THEN 'Masculino'
			WHEN 'homem' THEN 'Masculino'
			WHEN 'menina' THEN 'FemininoKids'
			WHEN 'menino' THEN 'MasculinoKids'
			WHEN 'mulher' THEN 'Feminino'
			WHEN 'unissex' THEN 'Unisex'
			WHEN 'unissex adulto' THEN 'Unisex'
			WHEN 'unissex jovem' THEN 'Unisex'
			WHEN 'unissex menino' THEN 'UnisexKids'
			ELSE ''
		END as Genero, --[varchar](100) NULL,
		CASE COALESCE(a."magazzino", t."magazzino")
			WHEN 0 THEN COALESCE(t."colore 2", a."colore 2")
			ELSE COALESCE(a."colore", t."colore")
		END as Cor, --COR DAS LENTES [varchar](100) NULL,
		GetMontaggio(COALESCE(a."codice montaggio", t."codice montaggio")) as TipoMontagem, --varchar NULL,
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
		CASE WHEN (COALESCE(a."magazzino", t."magazzino") = 1 or COALESCE(a."magazzino", t."magazzino") = 2) and (COALESCE(a."codice famiglia", t."codice famiglia") <> 'M')
			THEN CAST(COALESCE(a."addizione", t."addizione", 0.75) as numeric(18,4))
		END as AdicaoInicial, --[numeric](18, 4) NULL,
		CASE WHEN (COALESCE(a."magazzino", t."magazzino") = 1 or COALESCE(a."magazzino", t."magazzino") = 2) and (COALESCE(a."codice famiglia", t."codice famiglia") <> 'M')
			THEN CAST(COALESCE(a."addizione", t."addizione", 4) as numeric(18,4))
		END as AdicaoFinal, --NULO OU O MESMO QUE AdicaoInicial? [numeric](18, 4) NULL,
		CAST(NULL as numeric(18,4)) as AlturaMinima, --[numeric](18, 4) NULL,
		CAST(NULL as numeric(18,4)) as AlturaMontagem, --numeric(18,4) NULL,
		CASE WHEN (COALESCE(a."magazzino", t."magazzino") = 1 or COALESCE(a."magazzino", t."magazzino") = 2)
			THEN CAST(COALESCE(a."sfera", t."sfera", -25.00) as numeric(18,4))
		END as EsfericoInicial, --[numeric](18, 4) NULL,
		CASE WHEN (COALESCE(a."magazzino", t."magazzino") = 1 or COALESCE(a."magazzino", t."magazzino") = 2)
			THEN CAST(COALESCE(a."sfera", t."sfera", 25.00) as numeric(18,4))
		END as EsfericoFinal, --NULO OU O MESMO QUE EsfericoInicial? [numeric](18, 4) NULL,
		CASE WHEN (COALESCE(a."magazzino", t."magazzino") = 1 or COALESCE(a."magazzino", t."magazzino") = 2)
			THEN CAST(COALESCE(a."cilindro", t."cilindro", -8.00) as numeric(18,4))
		END as Cilindrico, --[numeric](18, 4) NULL,
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
		CASE COALESCE(a."codice geometria", t."codice geometria")
			WHEN 'S' THEN 'Esférica'
			WHEN 'A' THEN 'Asférica'
			WHEN 'T' THEN 'Tórica'
		END as Geometria, --varchar(20) (numeric(18,4)->varchar(20)) NULL,
		CAST(COALESCE(a."indice rifrazione", t."indice rifrazione") as numeric(18,4)) as IndiceRefracao, --[numeric](18, 4) NULL,
		CASE COALESCE(a."situazione tributaria", t."situazione tributaria")
			WHEN 'T' THEN 'TributaçãoICMS'
			WHEN 'N' THEN 'NãoTributada'
			WHEN 'F' THEN 'SubstituiçãoTributada'
			WHEN 'S' THEN 'TributaçãoISSQN'
			WHEN 'I' THEN 'Isento'
			ELSE ''
		END as PAF_SituacaoTributaria, --[varchar](30) NULL,
		COALESCE(a."IAT", t."IAT") as PAF_IAT, --[varchar](1) NULL,
		COALESCE(a."IPPT", t."IPPT") as PAF_IPPT, --[varchar](1) NULL,
		CASE COALESCE(a."codice famiglia", t."codice famiglia")
			WHEN 'M' THEN 'Monofocal'
			WHEN 'B' THEN 'Bifocal'
			WHEN 'P' THEN 'Multifocal'
			WHEN 'I' THEN 'Intermediária'
			WHEN 'T' THEN 'Multifocal'
			WHEN 'C' THEN 'Cosmética'
			WHEN 'F' THEN 'Multifocal'
			--E O TRATAMENTO?
		END as LenteTipo --varchar NULL
	from articoli_fornitore as t
		full outer join articoli as a
			on (a."codice a barre" = t."codice a barre")
		left join articoli_mag as am
			on (am."codice articolo" = a."codice filiale")
		left join articoli_fil as af
			on (af."codice articolo" = am."codice articolo") and (af."filiale" = am."filiale")
			
	group by
		a."SKU",
		t."SKU",
		a."codice a barre",
		t."codice a barre",
		a."codice doganale",
		t."codice doganale",
		a."magazzino",
		t."magazzino",
		a."codice linea",
		t."codice linea",
		a."modello",
		t."modello",
		a."colore",
		t."colore",
		a."calibro",
		t."calibro",
		a."codice trattamento",
		t."codice trattamento",
		a."descrizione",
		t."descrizione",
		a."codice tipo lenti",
		t."codice tipo lenti",
		a."codice tipo prodotto",
		t."codice tipo prodotto",
		a."codice marchio",
		t."codice marchio",
		a."UM",
		t."UM",
		a."Note",
		t."Note",
		a."codice durata",
		t."codice durata",
		t."data inserimento",
		a."campo_1",
		t."campo_1",
		a."nazionale estero",
		t."nazionale estero",
		a."codice filiale",
		a."codice utente",
		t."codice utente",
		t."colore 2",
		a."colore 2",
		a."codice montaggio",
		t."codice montaggio",
		a."codice materiale",
		t."codice materiale",
		a."diametro",
		t."diametro",
		a."asse",
		t."asse",
		a."codice famiglia",
		t."codice famiglia",
		a."addizione",
		t."addizione",
		a."sfera",
		t."sfera",
		a."cilindro",
		t."cilindro",
		a."asta",
		t."asta",
		a."ponte",
		t."ponte",
		a."rb",
		t."rb",
		a."rb2",
		t."rb2",
		a."codice geometria",
		t."codice geometria",
		a."indice rifrazione",
		t."indice rifrazione",
		a."situazione tributaria",
		t."situazione tributaria",
		a."IAT",
		t."IAT",
		a."IPPT",
		t."IPPT"
);


--CATALOGO
insert into Item
(
	select 
		CAST(NULL as varchar(25)) as Referencia, --[varchar](20) NULL,
		c."codice a barre" as CodigoBarras, --[varchar](50) NULL,
		CAST(NULL as varchar) as CodigoBarrasAntigo, --[varchar] NULL,
		CAST(NULL as int) as CodigoNCM, --[int] NULL,
		CAST(c."codice doganale" as varchar(8)) as NCM, --[varchar](8) NULL,
		CAST(NULL as varchar) as CEST, --varchar NULL
		COALESCE(c."modello", '') + COALESCE(' ' + c."trattamento", '') + COALESCE(' ' + c."descrizione", '') + COALESCE(' ' + p2."descrizione", '') as Descricao, --[varchar](500) NOT NULL,
		COALESCE(c."modello", '') + COALESCE(' ' + c."trattamento", '') + COALESCE(' ' + c."descrizione", '') + COALESCE(' ' + p2."descrizione", '') as DescricaoComercial, --[varchar](500) NOT NULL,
		'Lente' as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
		CAST(NULL as varchar) as Grupo, --[varchar](50) NULL,
		CAST(NULL as varchar) as SubGrupo, --[varchar](50) NULL,
		c."marca" as Marca, --[varchar](50) NULL,
		'Linha' as Status, --[varchar](20) NULL CONSTRAINT [DF_Item_Status]  DEFAULT ('Linha'),
		CAST(NULL as varchar(20)), --[varchar](20) NULL,
		COALESCE(p2."prezzo acquisto", c."prezzo acquisto", 0.00) as ValorCusto, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoUltimo, --[decimal](18, 2) NULL,
		CAST(NULL as decimal(18, 2)) as ValorCustoMedio, --[decimal](18, 2) NULL,
		COALESCE(p2."prezzo acquisto", c."prezzo acquisto", 0.00) as ValorCustoReposicao, --[decimal](18, 2) NULL,
		COALESCE(p2."prezzo di vendita", c."prezzo di vendita", 0.00) as ValorVenda, --[decimal](18, 2) NULL,
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
		CAST(NULL as varchar) as UtilizaComposicaoValorReposicao, --varchar NULL
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
		CAST(NULL as varchar) as Procedimento, --[varchar](max) NULL,
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
			COALESCE('.p.' + p2."codice filiale", '') as CodigoAntigo, --[varchar](255) NULL,
		CAST(NULL as datetime) as DataPrimeiraVenda, --[datetime] NULL,
		CAST(NULL as varchar(255)) as Embalagem, --[varchar](255) NULL,
		CAST(NULL as varchar(100)) as Modelo, --[varchar](100) NULL,
		CAST(NULL as varchar(100)) as Genero, --[varchar](100) NULL,
		c."colore" as Cor, --COR DAS LENTES [varchar](100) NULL,
		CAST(NULL as varchar) as TipoMontagem, --varchar NULL,
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
		CAST(NULL as numeric(18,4)) as AlturaMontagem, --numeric(18,4) NULL,
		COALESCE(dx."da sfero", d."esf_de") as EsfericoInicial, --[numeric](18, 4) NULL,
		COALESCE(dx."a sfero", d."esf_ate") as EsfericoFinal, --[numeric](18, 4) NULL,
		COALESCE(dx."cilindro massimo", d."cilindrico") as Cilindrico, --[numeric](18, 4) NULL,
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
				CASE 
					WHEN (POSITION('.' in c."tipo lenti") <> 0)
						THEN c."tipo lenti"
					WHEN (c."tipo lenti" = '')
						THEN CAST(NULL as varchar)
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
		CAST(NULL as varchar(1)) as PAF_IPPT, --[varchar](1) NULL,
		CASE c."linea"
			WHEN 'Monofoc.' THEN 'Monofocal'
			WHEN 'Intermed.' THEN 'Intermediária'
			ELSE c."linea"
		END as LenteTipo --varchar NULL
	from catalogo as c
		left join diametrirx as dx 
			on (diametrirx."codice articolo" = c."codice filiale")

		left join diametri2 as d
			on (d."codice articolo" = c."codice filiale")

		left join prezzilenti2 as p2
			on (p2."codice articolo" = c."codice filiale")		

	where (c."magazzino" = 1)
);


--TRATAMENTO
insert into Item
(
	select distinct 
		CAST(NULL as varchar(25)) as Referencia, --[varchar](20) NULL,
		CAST(NULL as varchar(50)) as CodigoBarras, --[varchar](50) NULL,
		CAST(NULL as varchar) as CodigoBarrasAntigo, --[varchar] NULL,
		CAST(NULL as varchar) as CodigoNCM, --[int] NULL,
		CAST(NULL as varchar(8)) as NCM, --O FOCUS POSSUI A DESCRIÇÃO EM OUTRA TABELA, MAS ACREDITO QUE A DA GEEKS SEJA MELHOR [varchar](8) NULL,
		CAST(NULL as varchar) as CEST, --varchar NULL
		TRIM(t."descrizione") as Descricao, --[varchar](500) NOT NULL,
		TRIM(t."descrizione") as DescricaoComercial, --[varchar](500) NOT NULL,
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
		CAST(NULL as varchar) as UtilizaComposicaoValorReposicao, --varchar NULL
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
		CAST(NULL as varchar) as Procedimento, --[varchar](max) NULL,
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
		CAST(NULL as varchar) as TipoMontagem, --varchar NULL,
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
		CAST(NULL as numeric(18,4)) as AlturaMontagem, --numeric(18,4) NULL,
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
		CAST(NULL as varchar(1)) as PAF_IPPT, --[varchar](1) NULL,
		CAST(NULL as varchar) as LenteTipo --varchar NULL
	from trattamenti as t
		join catalogo as c
			on (t."codice articolo" = c."codice filiale")
		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")

	where (c."magazzino" = 1)
);


--SUPLEMENTO
insert into Item
(
	select distinct 
		CAST(NULL as varchar(25)) as Referencia, --[varchar](20) NULL,
		CAST(NULL as varchar(50)) as CodigoBarras, --[varchar](50) NULL,
		CAST(NULL as varchar) as CodigoBarrasAntigo, --[varchar] NULL,
		CAST(NULL as varchar) as CodigoNCM, --[int] NULL,
		CAST(NULL as varchar(8)) as NCM, --O FOCUS POSSUI A DESCRIÇÃO EM OUTRA TABELA, MAS ACREDITO QUE A DA GEEKS SEJA MELHOR [varchar](8) NULL,
		CAST(NULL as varchar) as CEST, --varchar NULL
		TRIM(s."descrizione") as Descricao, --[varchar](500) NOT NULL,
		TRIM(s."descrizione") as DescricaoComercial, --[varchar](500) NOT NULL,
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
		CAST(NULL as varchar) as UtilizaComposicaoValorReposicao, --varchar NULL
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
		CAST(NULL as varchar) as Procedimento, --[varchar](max) NULL,
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
		CAST(NULL as varchar) as TipoMontagem, --varchar NULL,
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
		CAST(NULL as numeric(18,4)) as AlturaMontagem, --numeric(18,4) NULL,
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
		CAST(NULL as varchar(1)) as PAF_IPPT, --[varchar](1) NULL,
		CAST(NULL as varchar) as LenteTipo --varchar NULL
	from supplementi as s
		join catalogo as c
			on (s."codice articolo" = c."codice filiale")
		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")

	where (c."magazzino" = 1)
);