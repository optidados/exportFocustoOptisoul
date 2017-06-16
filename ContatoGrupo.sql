drop table if exists ContatoGrupo;

create table ContatoGrupo
(
	CodigoContato varchar(255), --[int] NOT NULL,
	CodigoGrupo int, --[int] NULL,
	Descricao varchar(255) --[varchar](255) NOT NULL,
);

insert into ContatoGrupo
(
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Clientes' as Descricao --[varchar](255) NOT NULL,
	from clienti as c

	UNION

	select
		'clienti ingrosso.' + ci."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Clientes' as Descricao --[varchar](255) NOT NULL,
	from "clienti ingrosso" as ci

	UNION

	select
		'fornitor.' + f."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Fornecedores' as Descricao --[varchar](255) NOT NULL,
	from fornitor as f

	UNION

	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		c."problema visivo" as Descricao --[varchar](255) NOT NULL,
	from clienti as c
	where
		c."problema visivo" <> ''
);
