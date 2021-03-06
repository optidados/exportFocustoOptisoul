ALTER procedure [dbo].[C3_sp_Importa_ItemComposicao] as

insert into Optisoul..ItemComposicao (CodigoItem, CodigoItemUtilizado, Quantidade)
select distinct
	a.CodigoItem, --[int] NOT NULL,
	b.CodigoItem as CodigoItemUtilizado, --CODIGO DO TRATAMENTO [int] NOT NULL,
	1 as Quantidade --[decimal](18, 6) NOT NULL,
from catalogo as c
	join trattamenti as t
		on (t."codice articolo" = c."codice filiale")

	left join fornitor as f
		on (f."ragione sociale" = c."fornitore")

	left join diametrirx as dx 
		on (dx."codice articolo" = c."codice filiale")

	left join diametri as d
		on (d."codice articolo" = c."codice filiale")

	left join prezzilenti as p
		on (p."codice articolo" = c."codice filiale")

	inner join Optisoul..Item a
		on (a.CodigoAntigo = (
			'c.' + c."codice filiale" + COALESCE('.d.' + d."codice filiale", '') + COALESCE('.dx.' + dx."codice filiale", '') + COALESCE('.p.' + p."codice filiale", '')
		))

	inner join Optisoul..Item b
		on (b.CodigoAntigo = (
			't.' + SUBSTRING(t."descrizione", 0, 33) + COALESCE('.f.' + f."codice filiale", '')
		))
where (c."magazzino" = 1)

insert into Optisoul..ItemComposicao (CodigoItem, CodigoItemUtilizado, Quantidade)
select distinct
	a.CodigoItem, --[int] NOT NULL,
	b.CodigoItem as CodigoItemUtilizado, --CODIGO DO TRATAMENTO [int] NOT NULL,
	1 as Quantidade --[decimal](18, 6) NOT NULL,
from catalogo as c
	join supplementi as s
		on (s."codice articolo" = c."codice filiale")

	left join fornitor as f
		on (f."ragione sociale" = c."fornitore")
			
	left join diametrirx as dx 
		on (dx."codice articolo" = c."codice filiale")

	left join diametri as d
		on (d."codice articolo" = c."codice filiale")

	left join prezzilenti as p
		on (p."codice articolo" = c."codice filiale")

	inner join Optisoul..Item a
		on (a.CodigoAntigo = (
			'c.' + c."codice filiale" + COALESCE('.d.' + d."codice filiale", '') + COALESCE('.dx.' + dx."codice filiale", '') + COALESCE('.p.' + p."codice filiale", '')
		))

	inner join Optisoul..Item b
		on (b.CodigoAntigo = (
			's.' + SUBSTRING(s."descrizione", 0, 33) + COALESCE('.f.' + f."codice filiale", '')
		))
where (c."magazzino" = 1)
