ALTER procedure [dbo].[D5_sp_importa_DocumentoContato] as

--medico x prescricao
insert into Optisoul..DocumentoContato
select
	co.CodigoContato, --int --not null
	'Medico' as Descricao, --varchar(255) --not null
	d.CodigoDocumento, --int --not null
	CAST(NULL as decimal(18,4)) as Percentual --decimal(18,4) --null

from oculisti as o
	join occhiali as oc
		on (oc."prescrizione" = o."denominazione")

	inner join Optisoul..Contato as co
		on (co.CodigoAntigo = 'oculisti.' + CAST(o."codice filiale" as varchar(12)))

	inner join Optisoul..Documento as d
		on (d.idant = 'occhiali.' + CAST(oc."codice filiale" as varchar(12)))

where oc."prescrizione" <> ''
