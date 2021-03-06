ALTER procedure [dbo].[C2_sp_Importa_Item] as
/*
articoli  (Cabeçalho produto, CodiceFiliale)  Estoque
articoli_fornitore (Cabeçalho produto, CodiceFiliale)  Tabela de preço

articoli_mag  Usando para pegar Preço de Custo  (Focus pode ter mais de um custo por Estoque ou filial)

articoli_fil Usado para pegar o Preço de Venda (Focus pode ter mais de um Venda por Estoque ou filial)  tá se usando o MAX
*/

--ARTICOLI & ARTICOLI_FORNITORE (ESTOQUE & TAB PREÇOS)
insert into Optisoul..Item (Referencia, CodigoBarras, 	NCM, 	Descricao,	DescricaoComercial, Tipo, 	Grupo, 	Marca, 	ValorCusto, ValorCustoUltimo, 	ValorCustoMedio, 	ValorCustoReposicao, 	ValorVenda, Unidade, 	QuantidadeMinimaEstoque, 	Observacao, ValidadeDias, 	ValidadeMeses, 	DataCadastro, 	AliquotaIPI, 	CodigoOrigem, 	CodigoAntigo, 	Modelo, Genero, Cor, 	TipoMontagem, 	Material, 	Tamanho, Diametro, Eixo, AdicaoInicial, AdicaoFinal, EsfericoInicial, EsfericoFinal, 	Cilindrico, AmarcaoCor, ArmacaoMaterial, 	Haste, 	Ponte, CurvaBase/*rb*/, CurvaBase2/*rb2*/, CurvaTipo/*texto de rb*/, Geometria, IndiceRefracao,  PAF_SituacaoTributaria, PAF_IAT, PAF_IPPT, LenteTipo)
select 
	LEFT(COALESCE(a."SKU", t."SKU"),20) as Referencia, --[varchar](20) NULL,
	COALESCE(a."codice a barre", t."codice a barre") as CodigoBarras, --[varchar](50) NULL,
	CAST(COALESCE(a."codice doganale", t."codice doganale") as varchar(8)) as NCM, --[varchar](8) NULL,
	(CASE COALESCE(a."magazzino", t."magazzino")
		WHEN(0)
		THEN 
			(LTRIM(RTRIM(
					(CASE
						WHEN( dbo.GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) = dbo.GetLinea(COALESCE(a."codice linea", t."codice linea")) )
						THEN( dbo.GetLinea(COALESCE(a."codice linea", t."codice linea", '')) )
						ELSE( (dbo.GetLinea(COALESCE(a."codice linea", t."codice linea", ''))) + ' ' +(dbo.GetMarchio(COALESCE(a."codice marchio", t."codice marchio"))) )
					END)
				))
			+ ' ' +COALESCE(a."modello", t."modello", '')
			+ ' ' +COALESCE(a."colore", t."colore", '')
			+ ' ' +CAST(COALESCE(a."calibro", t."calibro", '') as varchar(100)))
		ELSE
			(LTRIM(RTRIM(dbo.GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) + ' ' +COALESCE(a."modello", t."modello", '') + ' ' +dbo.GetTrattamento(COALESCE(a."codice trattamento", t."codice trattamento", '')) + ' ' +COALESCE(a."descrizione", t."descrizione", ''))))
	END) as Descricao, --[varchar](500) NOT NULL
	(CASE COALESCE(a."magazzino", t."magazzino")
		WHEN(0)
		THEN 
			(LTRIM(RTRIM(
					(CASE
						WHEN( dbo.GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) = dbo.GetLinea(COALESCE(a."codice linea", t."codice linea")) )
						THEN( dbo.GetLinea(COALESCE(a."codice linea", t."codice linea", '')) )
						ELSE( (dbo.GetLinea(COALESCE(a."codice linea", t."codice linea", ''))) + ' ' +(dbo.GetMarchio(COALESCE(a."codice marchio", t."codice marchio"))) )
					END)
				))
			+ ' ' +COALESCE(a."modello", t."modello", '')
			+ ' ' +COALESCE(a."colore", t."colore", '')
			+ ' ' +CAST(COALESCE(a."calibro", t."calibro", '') as varchar(100)))
		ELSE
			(LTRIM(RTRIM(dbo.GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) + ' ' +COALESCE(a."modello", t."modello", '') + ' ' +dbo.GetTrattamento(COALESCE(a."codice trattamento", t."codice trattamento", '')) + ' ' +COALESCE(a."descrizione", t."descrizione", ''))))
	END) as DescricaoComercial, --[varchar](500) NOT NULL
	CASE 
		WHEN (COALESCE(a."magazzino", t."magazzino") = 0) and (dbo.GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'vista') THEN 'Armação'
		WHEN (COALESCE(a."magazzino", t."magazzino") = 0) and ((dbo.GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'solar') or (dbo.GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'sol') or (dbo.GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'sole')) THEN 'Óculos Sol'
		WHEN (COALESCE(a."magazzino", t."magazzino") = 0) and ((dbo.GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'padrão') or (dbo.GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti")) = 'prediposti')) THEN 'Óculos Pronto'
		WHEN (COALESCE(a."magazzino", t."magazzino") = 1) THEN 'Lente'
		WHEN (COALESCE(a."magazzino", t."magazzino") = 2) THEN 'Lente Contato'
		WHEN (COALESCE(a."magazzino", t."magazzino") = 3) THEN 'Produto'
		WHEN (COALESCE(a."magazzino", t."magazzino") = 4) THEN 'Serviço'
		ELSE 'Produto'
		--E O TRATAMENTO? DIFÍCIL SEPARAR
	END as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
	CASE COALESCE(a."magazzino", t."magazzino")
		WHEN 2 THEN dbo.GetTipoLenti(COALESCE(a."codice tipo lenti", t."codice tipo lenti"))
		WHEN 3 THEN dbo.GetTipoProdotto(COALESCE(a."codice tipo prodotto", t."codice tipo prodotto"))
		--E O TRATAMENTO?
	END as Grupo, --[varchar](50) NULL,
	dbo.GetMarchio(COALESCE(a."codice marchio", t."codice marchio")) as Marca, --[varchar](50) NULL,
	MAX(COALESCE(am."prezzo listino acquisto", t."prezzo listino acquisto")) as ValorCusto, --[decimal](18, 2) NULL,
	MAX(am."prezzo acquisto") as ValorCustoUltimo, --[decimal](18, 2) NULL,
	MAX(am."costo medio") as ValorCustoMedio, --[decimal](18, 2) NULL,
	MAX(COALESCE(am."prezzo listino acquisto", t."prezzo listino acquisto")) as ValorCustoReposicao, --[decimal](18, 2) NULL,
	MAX(COALESCE(af."prezzo vendita", t."prezzo consigliato")) as ValorVenda, --[decimal](18, 2) NULL,
	COALESCE(a."UM", t."UM") as Unidade, --[varchar](10) NULL,
	MAX(am."scorta minima") as QuantidadeMinimaEstoque, --[decimal](18, 4) NULL,
	CAST(COALESCE(a."Note", t."Note") as varchar(255)) as Observacao, --[varchar](255) NULL,
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
	isnull(CAST(t."data inserimento" as datetime), CURRENT_TIMESTAMP) as DataCadastro, --[datetime] NOT NULL,
	COALESCE(a."campo_1", t."campo_1") as AliquotaIPI, --[numeric](18, 4) NULL,
	CASE WHEN isnull(COALESCE(a."nazionale estero", t."nazionale estero"),'')=''
		THEN 1 --ISSO É UM CHUTE, POIS NÃO SEI SE A PEÇA FOI ADQUIRIDA NO MERCADO INTERNO OU IMPORTAÇÃO DIRETA, NESTE CASO, IMPORTAÇÃO DIRETA
		ELSE 0
	END as CodigoOrigem, --[int] NOT NULL CONSTRAINT [DF_Item_CodigoOrigem]  DEFAULT ((0)),
	COALESCE('articoli.' + a."codice filiale", 'articoli_fornitore.' + t."codice a barre") as CodigoAntigo, --[varchar](255) NULL,
	CASE COALESCE(a."magazzino", t."magazzino")
		WHEN 0 THEN COALESCE(a."modello", t."modello")
	END as Modelo, --[varchar](100) NULL,
	CASE dbo.GetUtente(COALESCE(a."codice utente", t."codice utente"))
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
	dbo.GetMontaggio(COALESCE(a."codice montaggio", t."codice montaggio")) as TipoMontagem, --varchar NULL,
	CASE COALESCE(a."magazzino", t."magazzino")
		WHEN 0 THEN CAST(NULL as varchar(25)) --PODEMOS TRATAR POLARIZADO, FOTOSENSÍVEL, ETC. POR AQUI?
		ELSE dbo.GetMateriale(COALESCE(a."codice materiale", t."codice materiale"))
	END as Material, --MATERIAL DAS LENTES [varchar](100) NULL,
	COALESCE(a."calibro", t."calibro") as Tamanho,
	COALESCE(a."DiametroNum", t."DiametroNum") as Diametro, --[numeric](18, 4) NULL,
	CAST(COALESCE(a."asse", t."asse") as numeric(18,4)) as Eixo, --[numeric](18, 4) NULL,
	CASE WHEN (COALESCE(a."magazzino", t."magazzino") = 1 or COALESCE(a."magazzino", t."magazzino") = 2) and (COALESCE(a."codice famiglia", t."codice famiglia") <> 'M')
		THEN CAST(COALESCE(a."addizione", t."addizione", 0.75) as numeric(18,4))
	END as AdicaoInicial, --[numeric](18, 4) NULL,
	CASE WHEN (COALESCE(a."magazzino", t."magazzino") = 1 or COALESCE(a."magazzino", t."magazzino") = 2) and (COALESCE(a."codice famiglia", t."codice famiglia") <> 'M')
		THEN CAST(COALESCE(a."addizione", t."addizione", 4) as numeric(18,4))
	END as AdicaoFinal, --NULO OU O MESMO QUE AdicaoInicial? [numeric](18, 4) NULL,
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
		WHEN 0 THEN dbo.GetMateriale(COALESCE(a."codice materiale", t."codice materiale"))
	END as ArmacaoMaterial, --[varchar](100) NULL,
	CAST(COALESCE(a."asta", t."asta") as numeric(18,4)) as Haste, --[numeric](18, 4) NULL,
	CAST(COALESCE(a."ponte", t."ponte") as numeric(18,4)) as Ponte, --[numeric](18, 4) NULL,
	CASE WHEN isnumeric(COALESCE(a."rb", t."rb")) = 1 THEN CAST(COALESCE(a."rb", t."rb") as numeric(18,4)) END as CurvaBase,
	CAST(COALESCE(a."rb2", t."rb2") as numeric(18,4)) as CurvaBase2, --[numeric](18, 4) NULL,
	CASE WHEN isnumeric(COALESCE(a."rb", t."rb")) <> 1 THEN COALESCE(a."rb", t."rb") END as CurvaTipo,
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
	a."DiametroNum",
	t."DiametroNum",
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

--CATALOGO
insert into Optisoul..Item (CodigoBarras, NCM, Descricao, DescricaoComercial, Tipo, Marca, ValorCusto, ValorCustoReposicao, ValorVenda, Observacao, CodigoAntigo, Cor, Material, Diametro, AdicaoInicial, AdicaoFinal, EsfericoInicial, EsfericoFinal, Cilindrico, IndiceRefracao, LenteTipo, DataCadastro)
select 
	c."codice a barre" as CodigoBarras, --[varchar](50) NULL,
	CAST(c."codice doganale" as varchar(8)) as NCM, --[varchar](8) NULL,
	COALESCE(c."modello", '') + COALESCE(' ' + c."trattamento", '') + COALESCE(' ' + c."descrizione", '') + COALESCE(' ' + p2."descrizione", '') as Descricao, --[varchar](500) NOT NULL,
	COALESCE(c."modello", '') + COALESCE(' ' + c."trattamento", '') + COALESCE(' ' + c."descrizione", '') + COALESCE(' ' + p2."descrizione", '') as DescricaoComercial, --[varchar](500) NOT NULL,
	'Lente' as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
	c."marca" as Marca, --[varchar](50) NULL,
	COALESCE(p2."prezzo acquisto", c."prezzo acquisto", 0.00) as ValorCusto, --[decimal](18, 2) NULL,
	COALESCE(p2."prezzo acquisto", c."prezzo acquisto", 0.00) as ValorCustoReposicao, --[decimal](18, 2) NULL,
	COALESCE(p2."prezzo di vendita", c."prezzo di vendita", 0.00) as ValorVenda, --[decimal](18, 2) NULL,
	CAST(c."note" as varchar(255)) as Observacao, --[varchar](255) NULL,
	'c.' + c."codice filiale" + 
		COALESCE('.d.' + d."codice filiale", '') +
		COALESCE('.dx.' + dx."codice filiale", '') +
		COALESCE('.p.' + p2."codice filiale", '') as CodigoAntigo, --[varchar](255) NULL,
	c."colore" as Cor, --COR DAS LENTES [varchar](100) NULL,
	c."materiale" as Material, --MATERIAL DAS LENTES [varchar](100) NULL,
	COALESCE(dx."DiametroNum", d."DiametroNum") as Diametro, --[numeric](18, 4) NULL,
	dx."da addizione" as AdicaoInicial, --[numeric](18, 4) NULL,
	dx."a addizione" as AdicaoFinal, --[numeric](18, 4) NULL,
	COALESCE(dx."da sfero", d."esfde") as EsfericoInicial, --[numeric](18, 4) NULL,
	COALESCE(dx."a sfero", d."esfate") as EsfericoFinal, --[numeric](18, 4) NULL,
	COALESCE(dx."cilindro massimo", d."cilindrico") as Cilindrico, --[numeric](18, 4) NULL,
	CAST
	(
		(
			CASE 
				WHEN (ISNUMERIC(c."tipo lenti") = 0)
					THEN CAST(NULL as varchar)
				WHEN (CHARINDEX('.', c."tipo lenti") <> 0)
					THEN(c."tipo lenti")
				ELSE 
					SUBSTRING
					(
						c."tipo lenti", 0, 
						(
							CASE WHEN CHARINDEX(',', c."tipo lenti") = 0 THEN LEN(c."tipo lenti") ELSE CHARINDEX(',', c."tipo lenti")-1 END
						)
					) +
					'.' + 
					(
						CASE WHEN CHARINDEX(',', c."tipo lenti") = 0 
							THEN '0' 
							ELSE SUBSTRING(c."tipo lenti", CHARINDEX(',', c."tipo lenti")+1, LEN(c."tipo lenti") - CHARINDEX(',', c."tipo lenti")) 
						END
					) 
			END
		) as numeric(18, 4)
	) as IndiceRefracao, --[numeric](18, 4) NULL,
	CASE c."linea"
		WHEN 'Monofoc.' THEN 'Monofocal'
		WHEN 'Intermed.' THEN 'Intermediária'
		ELSE c."linea"
	END as LenteTipo, --varchar NULL
	CURRENT_TIMESTAMP as DataCadastro
from catalogo as c
	left join diametrirx as dx 
		on (dx."codice articolo" = c."codice filiale")

	left join diametri as d
		on (d."codice articolo" = c."codice filiale")

	left join prezzilenti2 as p2
		on (p2."codice articolo" = c."codice filiale")		
where (c."magazzino" = 1)

--TRATAMENTO
insert into Optisoul..Item (Descricao, DescricaoComercial, Tipo, ValorCusto, ValorCustoReposicao, ValorVenda, CodigoAntigo, DataCadastro)
select distinct 
	LTRIM(RTRIM(isnull(t."descrizione",''))) as Descricao, --[varchar](500) NOT NULL,
	LTRIM(RTRIM(isnull(t."descrizione",''))) as DescricaoComercial, --[varchar](500) NOT NULL,
	'Tratamento' as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
	t."prezzo acquisto" as ValorCusto, --[decimal](18, 2) NULL,
	t."prezzo acquisto" as ValorCustoReposicao, --[decimal](18, 2) NULL,
	t."prezzo di vendita" as ValorVenda, --[decimal](18, 2) NULL,
	't.' + SUBSTRING(t."descrizione", 0, 33) + COALESCE('.f.' + f."codice filiale", '') as CodigoAntigo, --[varchar](255) NULL,
	CURRENT_TIMESTAMP as DataCadastro
from trattamenti as t
	join catalogo as c
		on (t."codice articolo" = c."codice filiale")
	left join fornitor as f
		on (f."ragione sociale" = c."fornitore")
where (c."magazzino" = 1)

--SUPLEMENTO
insert into Optisoul..Item (Descricao, DescricaoComercial, Tipo, ValorCusto, ValorCustoReposicao, ValorVenda, CodigoAntigo, DataCadastro)
select distinct 
	LTRIM(RTRIM(s."descrizione")) as Descricao, --[varchar](500) NOT NULL,
	LTRIM(RTRIM(s."descrizione")) as DescricaoComercial, --[varchar](500) NOT NULL,
	'Tratamento' as Tipo, --[varchar](50) NOT NULL CONSTRAINT [DF_Item_Tipo]  DEFAULT ('Produto'),
	s."prezzo acquisto" as ValorCusto, --[decimal](18, 2) NULL,
	s."prezzo acquisto" as ValorCustoReposicao, --[decimal](18, 2) NULL,
	s."prezzo di vendita" as ValorVenda, --[decimal](18, 2) NULL,
	's.' + SUBSTRING(s."descrizione", 0, 33) + COALESCE('.f.' + f."codice filiale", '') as CodigoAntigo, --[varchar](255) NULL,
	CURRENT_TIMESTAMP as DataCadastro
from supplementi as s
	join catalogo as c
		on (s."codice articolo" = c."codice filiale")
	left join fornitor as f
		on (f."ragione sociale" = c."fornitore")
where (c."magazzino" = 1)