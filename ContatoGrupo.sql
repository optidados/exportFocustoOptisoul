drop table if exists ContatoGrupo;

create table ContatoGrupo
(
	CodigoContato varchar(30), --[int] NOT NULL,
	CodigoGrupo int, --[int] NULL,
	Descricao varchar(20) --[varchar](255) NOT NULL,
);


--CLIENTES
insert into ContatoGrupo
(
	select
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Cliente' as Descricao --[varchar](255) NOT NULL,
	from clienti as c
);


--VENDEDOR
insert into ContatoGrupo
(
	select
		'utente.' + CAST(ut."sigla" as varchar(6)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Vendedor' as Descricao --[varchar](255) NOT NULL,
	from utente as ut
);


--CLIENTE
insert into ContatoGrupo
(
	select
		'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Cliente' as Descricao --[varchar](255) NOT NULL,
	from "clienti ingrosso" as ci
);


--FORNECEDORES
insert into ContatoGrupo
(
	select
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Fornecedor' as Descricao --[varchar](255) NOT NULL,
	from fornitor as f
);

--CONVÊNIO
insert into ContatoGrupo
(
	select
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Convênio' as Descricao --[varchar](255) NOT NULL,
	from fornitor as f
	where f."campo3_f" is not null
);

--MÉDICO
insert into ContatoGrupo
(
	select
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		'Médico' as Descricao --[varchar](255) NOT NULL,
	from oculisti as o
);

--PROBLEMA VISUAL
insert into ContatoGrupo
(
	select
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
		CAST(NULL as int) as CodigoGrupo, --[int] NULL,
		c."problema visivo" as Descricao --varchar(20) (varchar(255)->varchar(20)) NOT NULL,
	from clienti as c
	where
		c."problema visivo" <> ''
);