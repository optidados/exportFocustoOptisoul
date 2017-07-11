//NOSQLBDETOFF2 
drop table if exists documentocontato;

create table documentocontato
(
	CodigoContato varchar(30), --(int->varchar(30)) not null
	Descricao varchar, --not null
	CodigoDocumento varchar(30), --(int->varchar(30)) not null
	Percentual decimal(18,4) --null
);


--medico x prescricao
insert into documentocontato
(
	select
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato, --int --not null
		CAST(NULL as varchar) as Descricao, --varchar(255) --not null
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --int --not null
		CAST(NULL as decimal(18,4)) as Percentual --decimal(18,4) --null
	
	from oculisti as o
		join occhiali as oc
		on(oc."prescrizione" = o."denominazione")
);