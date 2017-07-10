drop table if exists ContatoFilho;

create table ContatoFilho
(
	CodigoContato varchar(255), --[int] NOT NULL,
	CodigoContatoRelacionado varchar(200), --[int] NOT NULL,
	Observacao varchar(8000) --[varchar](max) NULL,
);

insert into ContatoFilho
(
	--EMPRESA
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'fornitor.' + an."codice azienda" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Empresa' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice azienda" <> ''

	UNION

	select
		'fornitor.' + an."codice azienda" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Funcionário' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice azienda" <> ''

	UNION

	--TITULAR
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + an."codice titolare" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Titular' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice titolare" <> ''

	UNION

	select
		'clienti.' + an."codice titolare" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Dependente' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice titolare" <> ''

	UNION

	--CONJUGE
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + an."codice coniuge" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Cônjuge' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice coniuge" <> ''

	UNION

	select
		'clienti.' + an."codice coniuge" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Cônjuge' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice coniuge" <> ''

	UNION

	--PAI
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + an."codice padre" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Pai' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice padre" <> ''

	UNION

	select
		'clienti.' + an."codice padre" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Filho' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice padre" <> ''

	UNION

	--MAE
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + an."codice madre" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Mãe' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice madre" <> ''

	UNION

	select
		'clienti.' + an."codice madre" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Filho' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice madre" <> ''

	UNION

	--AGENTE
	select
		'agente.' + a."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'fornitor.' + a."codice fornitore" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Empresa' as Observacao --[varchar](max) NULL,
	from agente as a

	UNION

	select
		'fornitor.' + a."codice fornitore" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'agente.' + a."codice filiale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Representante' as Observacao --[varchar](max) NULL,
	from agente as a
);
