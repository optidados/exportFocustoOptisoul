/*
Ligar o tratamento com a respectiva lente onde é possível realizar o tratamento
Murilo - 10/02/2017
*/
//NOSQLBDETOFF2
drop table if exists ItemComposicao;

create table ItemComposicao
(
	CodigoItem varchar(200), --[int] NOT NULL,
	CodigoItemUtilizado varchar(200), --CODIGO DO TRATAMENTO [int] NOT NULL,
	Quantidade decimal(18, 6), --[decimal](18, 6) NOT NULL,
	Ordem int --[int] NULL	
);

insert into ItemComposicao
(
	select distinct
		'c.' + c."codice filiale" + 
			COALESCE('.d.' + d."codice filiale", '') +
			COALESCE('.dx.' + dx."codice filiale", '') +
			COALESCE('.p.' + p."codice filiale", '') as CodigoItem, --[int] NOT NULL,
		't.' + SUBSTRING(t."descrizione" from 0 for 33) + COALESCE('.f.' + f."codice filiale", '') as CodigoItemUtilizado, --CODIGO DO TRATAMENTO [int] NOT NULL,
		1 as Quantidade, --[decimal](18, 6) NOT NULL,
		CAST(NULL as int) as Ordem --[int] NULL
	from catalogo as c
		join trattamenti as t
			on (t."codice articolo" = c."codice filiale")

		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")

		left join diametrirx as dx 
			on (diametrirx."codice articolo" = c."codice filiale")

		left join diametri as d
			on (d."codice articolo" = c."codice filiale")

		left join prezzilenti as p
			on (p."codice articolo" = c."codice filiale")
	where (c."magazzino" = 1)
);

insert into ItemComposicao
(
	select distinct
		'c.' + c."codice filiale" +
			COALESCE('.d.' + d."codice filiale", '') +
			COALESCE('.dx.' + dx."codice filiale", '') +
			COALESCE('.p.' + p."codice filiale", '') as CodigoItem, --[int] NOT NULL,
		's.' + SUBSTRING(s."descrizione" from 0 for 33) + COALESCE('.f.' + f."codice filiale", '') as CodigoItemUtilizado, --CODIGO DO TRATAMENTO [int] NOT NULL,
		1 as Quantidade, --[decimal](18, 6) NOT NULL,
		CAST(NULL as int) as Ordem --[int] NULL
	from catalogo as c
		join supplementi as s
			on (s."codice articolo" = c."codice filiale")

		left join fornitor as f
			on (f."ragione sociale" = c."fornitore")
			
		left join diametrirx as dx 
			on (diametrirx."codice articolo" = c."codice filiale")

		left join diametri as d
			on (d."codice articolo" = c."codice filiale")

		left join prezzilenti as p
			on (p."codice articolo" = c."codice filiale")
	where (c."magazzino" = 1)
);