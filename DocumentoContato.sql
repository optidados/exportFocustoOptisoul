//NOSQLBDETOFF2 
drop table if exists DocumentoContato;

create table DocumentoContato
(
	CodigoContato varchar(30), --(int->varchar(30)) not null
	Descricao varchar(6), --not null
	CodigoDocumento varchar(30), --(int->varchar(30)) not null
	Percentual decimal(18,4) --null
);

--medico x prescricao
insert into DocumentoContato
(
	select
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato, --int --not null
		'Medico' as Descricao, --varchar(255) --not null
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --int --not null
		CAST(NULL as decimal(18,4)) as Percentual --decimal(18,4) --null
	
	from oculisti as o
	join occhiali as oc
		on (oc."prescrizione" = o."denominazione")
	where oc."prescrizione" <> ''
);

delete from DocumentoContato as docc
where
	NOT EXISTS
	(
		select *
		from Documento as doc
		where 
			(doc."CodigoDocumento" = docc."CodigoDocumento")
	);