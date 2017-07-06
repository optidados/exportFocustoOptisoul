/*
TELEFONES DOS CONTATOS
Murilo - 10/02/2017
*/
//NOSQLBDETOFF2 
drop table if exists ContatoTelefone;

create table ContatoTelefone
(
	TipoTelefone varchar(100), --[varchar](100) NULL,
	Telefone varchar(50), --[varchar](50) NULL,
	Observacao varchar, --[varchar](max) NULL,
	CodigoContato varchar(30) --[int] NOT NULL
);

insert into ContatoTelefone
(
	select
		'Telefone' as TipoTelefone, --[varchar](100) NULL,
		c."telefono" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from clienti as c
	where
		c."telefono" <> ''

	UNION

	select
		'Telefone 2' as TipoTelefone, --[varchar](100) NULL,
		c."telefono2" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from clienti as c
	where
		c."telefono2" <> ''

	UNION

	select
		'Celular' as TipoTelefone, --[varchar](100) NULL,
		c."telefonino gsm" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from clienti as c
	where
		c."telefonino gsm" <> ''

	UNION

	select
		'Telefone' as TipoTelefone, --[varchar](100) NULL,
		f."telefono" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from fornitor as f
	where
		f."telefono" <> ''

	UNION

	select
		'Fax' as TipoTelefone, --[varchar](100) NULL,
		f."fax" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from fornitor as f
	where
		f."fax" <> ''

	UNION

	select
		'0800' as TipoTelefone, --[varchar](100) NULL,
		f."linea verde" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from fornitor as f
	where
		f."linea verde" <> ''

	UNION

	select
		'Telefone Matriz' as TipoTelefone, --[varchar](100) NULL,
		f."telefono2" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from fornitor as f
	where
		f."telefono2" <> ''

	UNION

	select
		'Fax Matriz' as TipoTelefone, --[varchar](100) NULL,
		f."fax2" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from fornitor as f
	where
		f."fax2" <> ''

	UNION

	select
		'0800 Matriz' as TipoTelefone, --[varchar](100) NULL,
		f."linea verde2" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from fornitor as f
	where
		f."linea verde2" <> ''

	UNION

	select
		'Telefone' as TipoTelefone, --[varchar](100) NULL,
		ci."telefono" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from "clienti ingrosso" as ci
	where
		ci."telefono" <> ''

	UNION

	select
		'Telefone 2' as TipoTelefone, --[varchar](100) NULL,
		ci."telefono1" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from "clienti ingrosso" as ci
	where
		ci."telefono1" <> ''

	UNION

	select
		'Fax' as TipoTelefone, --[varchar](100) NULL,
		ci."fax" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from "clienti ingrosso" as ci
	where
		ci."fax" <> ''

	UNION

	select
		'Telefone' as TipoTelefone, --[varchar](100) NULL,
		o."telefono" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from oculisti as o
	where
		o."telefono" <> ''

	UNION

	select
		'Celular' as TipoTelefone, --[varchar](100) NULL,
		o."telefono2" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from oculisti as o
	where
		o."telefono2" <> ''

	UNION

	select
		'Fax' as TipoTelefone, --[varchar](100) NULL,
		o."fax" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from oculisti as o
	where
		o."fax" <> ''

	UNION

	select
		'Telefone' as TipoTelefone, --[varchar](100) NULL,
		r."telefono" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'rubrica.' + CAST(r."codice" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from rubrica as r
	where
		r."telefono" <> ''

	UNION

	select
		'Celular' as TipoTelefone, --[varchar](100) NULL,
		r."telefono2" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'rubrica.' + CAST(r."codice" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from rubrica as r
	where
		r."telefono2" <> ''

	UNION

	select
		'Fax' as TipoTelefone, --[varchar](100) NULL,
		r."fax" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'rubrica.' + CAST(r."codice" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from rubrica as r
	where
		r."fax" <> ''

	UNION

	select
		'Telefone' as TipoTelefone, --[varchar](100) NULL,
		v."telefono" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'vettori.' + CAST(v."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from vettori as v
	where
		v."telefono" <> ''

	UNION

	select
		'Fax' as TipoTelefone, --[varchar](100) NULL,
		v."fax" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'vettori.' + CAST(v."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from vettori as v
	where
		v."fax" <> ''

	UNION

	select
		'Telefone' as TipoTelefone, --[varchar](100) NULL,
		ag."tel agente" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'agente.' + CAST(ag."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from agente as ag
	where
		ag."tel agente" <> ''

	UNION

	select
		'Celular' as TipoTelefone, --[varchar](100) NULL,
		ag."cel agente" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'agente.' + CAST(ag."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from agente as ag
	where
		ag."cel agente" <> ''

	UNION

	select
		'Fax' as TipoTelefone, --[varchar](100) NULL,
		ag."fax agente" as Telefone, --[varchar](50) NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](max) NULL,
		'agente.' + CAST(ag."codice filiale" as varchar(12)) as CodigoContato --[int] (int->varchar(255)) NOT NULL
	from agente as ag
	where
		ag."fax agente" <> ''
);