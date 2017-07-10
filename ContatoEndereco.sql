drop table if exists ContatoEndereco;

create table ContatoEndereco
(
	CodigoContato varchar(255), --[int] NOT NULL,
	Logradouro varchar(255), --[varchar](255) NULL,
	Numero varchar, --[varchar](15) NULL,
	Complemento varchar, --[varchar](255) NULL,
	Condominio varchar, --[varchar](150) NULL,
	Bairro varchar(255), --[varchar](255) NULL,
	CEP varchar(50), --[varchar](50) NULL,
	IbgeCod varchar(40), --[int] NULL,
	Municipio varchar(150), --[varchar](150) NULL,
	UF varchar(50), --[varchar](50) NULL,
	UFCod int, --[int] NULL,
	Pais varchar(150), --[varchar](150) NULL,
	Grupo varchar(255), --[varchar](255) NULL,
	CidadeCodChave int, --[int] NULL,
	Observacao varchar, --[varchar](255) NULL,
	CodigoAntigo varchar --[varchar](50) NULL
);

insert into ContatoEndereco
(
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		c."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		c."campo2_c" as Bairro, --[varchar](255) NULL,
		c."cap" as CEP, --[varchar](50) NULL,
		c."campo6_c" as IbgeCod, --[int] NULL,
		c."citta" as Municipio, --[varchar](150) NULL,
		c."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		c."stato" as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from clienti as c
	where
		(c."indirizzo" <> '')

	UNION

	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		c."indirizzo 2" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		c."campo3_c" as Bairro, --[varchar](255) NULL,
		c."cap 2" as CEP, --[varchar](50) NULL,
		CAST(NULL as varchar) as IbgeCod, --[int] NULL,
		c."citta 2" as Municipio, --[varchar](150) NULL,
		c."provincia 2" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		c."stato 2" as Pais, --[varchar](150) NULL,
		'Cobrança' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from clienti as c
	where
		(c."indirizzo 2" <> '')

	UNION

	select
		'fornitor.' + f."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		f."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		f."campo1_f" as Bairro, --[varchar](255) NULL,
		f."cap" as CEP, --[varchar](50) NULL,
		f."campo5_f" as IbgeCod, --[int] NULL,
		f."citta" as Municipio, --[varchar](150) NULL,
		f."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		f."stato" as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from fornitor as f
	where
		(f."indirizzo" <> '')

	UNION

	select
		'fornitor.' + f."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		f."indirizzo2" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		f."campo2_f" as Bairro, --[varchar](255) NULL,
		f."cap2" as CEP, --[varchar](50) NULL,
		CAST(NULL as varchar) as IbgeCod, --[int] NULL,
		f."citta2" as Municipio, --[varchar](150) NULL,
		f."provincia2" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		CAST(NULL as varchar) as Pais, --[varchar](150) NULL,
		'Matriz' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from fornitor as f
	where
		(f."indirizzo2" <> '')

	UNION

	select
		'clienti ingrosso.' + ci."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		ci."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		ci."campo1_f" as Bairro, --[varchar](255) NULL,
		ci."cap" as CEP, --[varchar](50) NULL,
		ci."campo5_f" as IbgeCod, --[int] NULL,
		ci."citta" as Municipio, --[varchar](150) NULL,
		ci."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		ci."stato" as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from "clienti ingrosso" as ci
	where
		(ci."indirizzo" <> '')

	UNION

	select
		'oculisti.' + o."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		o."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		o."campo1_o" as Bairro, --[varchar](255) NULL,
		o."cap" as CEP, --[varchar](50) NULL,
		CAST(NULL as varchar) as IbgeCod, --[int] NULL,
		o."citta" as Municipio, --[varchar](150) NULL,
		o."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		CAST(NULL as varchar) as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from oculisti as o
	where
		(o."indirizzo" <> '')

	UNION

	select
		'rubrica.' + CAST(r."codice" as varchar(192)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		r."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		r."campo1_r" as Bairro, --[varchar](255) NULL,
		r."cap" as CEP, --[varchar](50) NULL,
		CAST(NULL as varchar) as IbgeCod, --[int] NULL,
		r."citta" as Municipio, --[varchar](150) NULL,
		r."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		CAST(NULL as varchar) as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from rubrica as r
	where
		(r."indirizzo" <> '')

	UNION

	select
		'sede.' + s."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		s."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		CAST(NULL as varchar) as Bairro, --[varchar](255) NULL,
		s."cap" as CEP, --[varchar](50) NULL,
		CAST(NULL as varchar) as IbgeCod, --[int] NULL,
		s."citta" as Municipio, --[varchar](150) NULL,
		s."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		CAST(NULL as varchar) as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from sede as s
	where
		(s."indirizzo" <> '')

	UNION

	select
		'puntovendita.' + pv."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		pv."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		CAST(NULL as varchar) as Bairro, --[varchar](255) NULL,
		pv."cap" as CEP, --[varchar](50) NULL,
		CAST(NULL as varchar) as IbgeCod, --[int] NULL,
		pv."citta" as Municipio, --[varchar](150) NULL,
		pv."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		CAST(NULL as varchar) as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from puntovendita as pv
	where
		(pv."indirizzo" <> '')

	UNION

	select
		'vettori.' + CAST(v."codice" as varchar(192)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		v."indirizzo" as Logradouro, --[varchar](255) NULL,
		CAST(NULL as varchar) as Numero, --[varchar](15) NULL,
		CAST(NULL as varchar) as Complemento, --[varchar](255) NULL,
		CAST(NULL as varchar) as Condominio, --[varchar](150) NULL,
		CAST(NULL as varchar) as Bairro, --[varchar](255) NULL,
		v."cap" as CEP, --[varchar](50) NULL,
		CAST(NULL as varchar) as IbgeCod, --[int] NULL,
		v."citta" as Municipio, --[varchar](150) NULL,
		v."provincia" as UF, --[varchar](50) NULL,
		CAST(NULL as int) as UFCod, --[int] NULL,
		CAST(NULL as varchar) as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from vettori as v
	where
		(v."indirizzo" <> '')
);
