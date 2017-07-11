drop table if exists ContatoGrupo;

create table ContatoGrupo
(
	CodigoContato varchar(30), --[int] NOT NULL,
	CodigoGrupo int, --[int] NULL,
	Descricao varchar(255) --[varchar](255) NOT NULL,
);

insert into ContatoGrupo
(
	select
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Clientes' as Descricao --[varchar](255) NOT NULL,
	from clienti as c

	UNION

	select
		'utente.' + CAST(ut."sigla" as varchar(6)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Vendedor' as Descricao --[varchar](255) NOT NULL,
	from utente as ut

	UNION

	select
		'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Clientes' as Descricao --[varchar](255) NOT NULL,
	from "clienti ingrosso" as ci

	UNION

	select
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Fornecedores' as Descricao --[varchar](255) NOT NULL,
	from fornitor as f

	UNION

	select
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Médico' as Descricao --[varchar](255) NOT NULL,
	from oculisti as o

	UNION

	select
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		c."problema visivo" as Descricao --[varchar](255) NOT NULL,
	from clienti as c
	where
		c."problema visivo" <> ''
);
