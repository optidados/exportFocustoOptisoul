drop table if exists ItemFornecedor;

create table ItemFornecedor
(
	CodigoItem varchar(200), --[bigint] NOT NULL,
	CodigoContato varchar(255), --[int] NOT NULL,
	Descricao varchar(50), --[varchar](50) NULL,
	Referencia varchar(30) --[varchar](30) NULL
);

insert into ItemFornecedor
(	
	select
		COALESCE('articoli.' + a."codice filiale", 'articoli_fornitore.' + t."codice a barre") as CodigoItem, --[bigint] NOT NULL,
		'fornitor.' + COALESCE(a."codice fornitore", t."codice fornitore") as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as varchar(50)) as Descricao, --[varchar](50) NULL,
		COALESCE(a."sku", t."sku") as Referencia --[varchar](30) NULL
	from articoli_fornitore as t
		full outer join articoli as a
			on (a."codice a barre" = t."codice a barre")
	where
		COALESCE(a."codice fornitore", t."codice fornitore") <> ''

	UNION

	select
		'c.' + c."codice filiale" + 
			COALESCE('.d.' + d."codice filiale", '') +
			COALESCE('.dx.' + dx."codice filiale", '') +
			COALESCE('.p.' + p."codice filiale", '') as CodigoItem, --[bigint] NOT NULL,
		'fornitor.' + f."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as varchar(50)) as Descricao, --[varchar](50) NULL,
		CAST(NULL as varchar(30)) as Referencia --[varchar](30) NULL
	from catalogo as c
		join fornitor as f
			on (f."ragione sociale" = c."fornitore")

		left join diametrirx as dx 
			on (diametrirx."codice articolo" = c."codice filiale")

		left join diametri as d
			on (d."codice articolo" = c."codice filiale")

		left join prezzilenti as p
			on (p."codice articolo" = c."codice filiale")

	where (c."magazzino" = 1)

	UNION

	select distinct
		't.' + SUBSTRING(t."descrizione" from 0 for 33) + '.f.' + f."codice filiale" as CodigoItem, --[bigint] NOT NULL,
		'fornitor.' + COALESCE(f."codice filiale", '') as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as varchar(50)) as Descricao, --[varchar](50) NULL,
		CAST(NULL as varchar(30)) as Referencia --[varchar](30) NULL
	from trattamenti as t
		join catalogo as c
			on (t."codice articolo" = c."codice filiale")
		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")

	where (c."magazzino" = 1)

	UNION

	select distinct
		's.' + SUBSTRING(s."descrizione" from 0 for 33) + '.f.' + f."codice filiale" as CodigoItem, --[bigint] NOT NULL,
		'fornitor.' + COALESCE(f."codice filiale", '') as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as varchar(50)) as Descricao, --[varchar](50) NULL,
		CAST(NULL as varchar(30)) as Referencia --[varchar](30) NULL
	from supplementi as s
		join catalogo as c
			on (s."codice articolo" = c."codice filiale")
		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")

	where (c."magazzino" = 1)
);
