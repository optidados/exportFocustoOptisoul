ALTER procedure [dbo].[D7_sp_importa_DocumentoStatus] as

--insert carrello (ORÇAMENTO)
insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	d.CodigoDocumento, --varchar(30) not null
	'Venda de Mercadoria' as Operacao, -- varchar(20) null
	CAST(NULL as varchar) as StatusOriginal, --varchar(10) null
	'Orçamento' as StatusFinalizado, --varchar(255) null
	car.data DataHoraEmissao, --datetime not null
	CAST(NULL as int) as CodigoUsuarioAlterou --int null

from carrello as car
	inner join Optisoul..Documento d
		on (d.idant = 'car.' + CAST(car."codice filiale" as varchar(12)))


--insert carrello (Aguardando Faturamento)
insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	d.CodigoDocumento, --varchar(30) not null
	'Venda de Mercadoria' as Operacao, -- varchar(20) null
	'Orçamento' as StatusOriginal, --varchar(10) null
	'Aguardando Faturamento' as StatusFinalizado, --varchar(255) null
	car.data as DataHoraEmissao, --datetime not null
	d.CodigoContatoDigitador as CodigoUsuarioAlterou --varchar(10) (int->varchar(10)) null

from carrello as car
	inner join Optisoul..Documento d
		on (d.idant = 'car.' + CAST(car."codice filiale" as varchar(12)))


--insert carrello (Faturado)
insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	d.CodigoDocumento, --varchar(30) not null
	'Venda de Mercadoria' as Operacao, -- varchar(20) null
	'Aguardando Faturamento' as StatusOriginal, --varchar(10) null
	'Faturado' as StatusFinalizado, --varchar(255) null
	MAX(trans."data") as DataHoraEmissao, --datetime not null
	c.CodigoContato as CodigoUsuarioAlterou --varchar(10) (int->varchar(10)) null

from carrello2 as car2
	join transazioni as trans
		on (trans."codice filiale" = car2."codice transazione")

	inner join Optisoul..Documento d
		on (d.idant = 'car.' + CAST(car2."codice carrello" as varchar(12)))

	left join Optisoul..Contato c
		on (c.CodigoAntigo = 'utente.' + trans."operatore")

where car2."pagato" = 1

group by
	d.CodigoDocumento,
	c.CodigoContato

--insert storicocarrello
insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	d.CodigoDocumento, --varchar(30) not null
	'Venda de Mercadoria' as Operacao, -- varchar(20) null
	CAST(NULL as varchar) as StatusOriginal, --varchar(10) null
	'Orçamento' as StatusFinalizado, --varchar(255) null
	scar.data as DataHoraEmissao, --datetime not null
	CAST(NULL as int) as CodigoUsuarioAlterou --int null

from storicocarrello as scar
	inner join Optisoul..Documento d
		on (d.idant = 'scar.' + CAST(scar."codice filiale" as varchar(12)))

--insert storicocarrello (Aguardando Faturamento)
insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	d.CodigoDocumento, --varchar(30) not null
	'Venda de Mercadoria' as Operacao, -- varchar(20) null
	'Orçamento' as StatusOriginal, --varchar(10) null
	'Aguardando Faturamento' as StatusFinalizado, --varchar(255) null
	scar.data as DataHoraEmissao, --datetime not null
	d.CodigoContatoDigitador as CodigoUsuarioAlterou --varchar(10) (int->varchar(10)) null

from storicocarrello as scar
	inner join Optisoul..Documento d
		on (d.idant = 'scar.' + CAST(scar."codice filiale" as varchar(12)))

--insert storicocarrello (Faturado)
insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	d.CodigoDocumento, --varchar(30) not null
	'Venda de Mercadoria' as Operacao, -- varchar(20) null
	'Aguardando Faturamento' as StatusOriginal, --varchar(10) null
	'Faturado' as StatusFinalizado, --varchar(255) null
	MAX(trans."data") as DataHoraEmissao, --datetime not null
	c.CodigoContato as CodigoUsuarioAlterou --varchar(10) (int->varchar(10)) null

from storicocarrello2 as scar2
	join transazioni as trans
		on (trans."codice filiale" = scar2."codice transazione")

	inner join Optisoul..Documento d
		on (d.idant = 'scar.' + CAST(scar2."codice carrello" as varchar(12)))

	left join Optisoul..Contato c
		on (c.CodigoAntigo = 'utente.' + trans."operatore")

where scar2."pagato" = 1

group by
	d.CodigoDocumento,
	c.CodigoContato

--STATUS DOS ENVELOPES
insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	doc."CodigoDocumento", --varchar(30) not null
	'Mudança status envelope' as Operacao, -- varchar(20) null
	'Orçamento' as StatusOriginal, --varchar(10) null
	'Aguardando Envio' as StatusFinalizado, --varchar(255) null
	doc."DataHoraEmissao", --datetime not null
	doc."CodigoContatoDigitador" --varchar(10) (int->varchar(10)) null

from Optisoul..Documento as doc
where
	(doc."Tipo" = 'Envelope')


insert into Optisoul..DocumentoStatus
	(CodigoDocumento, Operacao, StatusOriginal, StatusFinalizado, DataHoraEmissao, CodigoUsuarioAlterou)
select
	doc."CodigoDocumento", --varchar(30) not null
	'Mudança status envelope' as Operacao, -- varchar(20) null
	'Aguardando Envio' as StatusOriginal, --varchar(10) null
	doc."Status" as StatusFinalizado, --varchar(255) null
	doc."DataHoraEmissao", --datetime not null
	doc."CodigoContatoDigitador" --varchar(10) (int->varchar(10)) null

from Optisoul..Documento as doc
where
	(doc."Tipo" = 'Envelope') and
	(doc."Status" <> 'Aguardando Envio')