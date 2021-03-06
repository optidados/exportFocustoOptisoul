ALTER procedure [dbo].[C4_sp_Importa_ItemFornecedor] as

insert into Optisoul..ItemFornecedor (CodigoItem, CodigoContato)	
select
	 i.CodigoItem, --[bigint] NOT NULL,
	 c.CodigoContato --[int] (int->varchar(255)) NOT NULL,
from articoli_fornitore as t
	full outer join articoli as a
		on (a."codice a barre" = t."codice a barre")
	inner join Optisoul..Item i
		on (i.CodigoAntigo = COALESCE('articoli.' + a."codice filiale", 'articoli_fornitore.' + t."codice a barre"))
	inner join Optisoul..Contato c
		on (c.CodigoAntigo = COALESCE('fornitor.' + a."codice fornitore", 'fornitor.' + t."codice fornitore"))
where
	COALESCE(a."codice fornitore", t."codice fornitore") <> ''


insert into Optisoul..ItemFornecedor (CodigoItem, CodigoContato)
select
	 i.CodigoItem, --[bigint] NOT NULL,
	 co.CodigoContato --[int] (int->varchar(255)) NOT NULL,
from catalogo as c
	join fornitor as f
		on (f."ragione sociale" = c."fornitore")

	left join diametrirx as dx 
		on (dx."codice articolo" = c."codice filiale")

	left join diametri as d
		on (d."codice articolo" = c."codice filiale")

	left join prezzilenti as p
		on (p."codice articolo" = c."codice filiale")

	inner join Optisoul..Item i
		on (i.CodigoAntigo = 'c.' + c."codice filiale" + COALESCE('.d.' + d."codice filiale", '') + COALESCE('.dx.' + dx."codice filiale", '') + COALESCE('.p.' + p."codice filiale", ''))

	inner join Optisoul..Contato co
		on (co.CodigoAntigo = 'fornitor.' + f."codice filiale")

where (c."magazzino" = 1)



insert into Optisoul..ItemFornecedor (CodigoItem, CodigoContato)
select distinct
	 i.CodigoItem, --[bigint] NOT NULL,
	 co.CodigoContato --[int] (int->varchar(255)) NOT NULL,
from trattamenti as t
	join catalogo as c
		on (t."codice articolo" = c."codice filiale")

	left join fornitor as f
		on (f."ragione sociale" = c."fornitore")

	inner join Optisoul..Item i
		on (i.CodigoAntigo = 't.' + SUBSTRING(t."descrizione", 0, 33) + COALESCE('.f.' + f."codice filiale", ''))

	inner join Optisoul..Contato co
		on (co.CodigoAntigo = COALESCE('fornitor.' + f."codice filiale", ''))

where (c."magazzino" = 1)



insert into Optisoul..ItemFornecedor (CodigoItem, CodigoContato)
select distinct
	 i.CodigoItem, --[bigint] NOT NULL,
	co.CodigoContato --[int] (int->varchar(255)) NOT NULL,
from supplementi as s
	join catalogo as c
		on (s."codice articolo" = c."codice filiale")
	left join fornitor as f
		on (f."ragione sociale" = c."fornitore")
	inner join Optisoul..Item i
		on (i.CodigoAntigo = 's.' + SUBSTRING(s."descrizione", 0, 33) + COALESCE('.f.' + f."codice filiale", ''))
	inner join Optisoul..Contato co
		on (co.CodigoAntigo = COALESCE('fornitor.' + f."codice filiale", ''))

where (c."magazzino" = 1)
