//NOSQLBDETOFF2
drop table if exists ContatoEndereco;

create table ContatoEndereco
(
	CodigoContato varchar(30), --[int] NOT NULL,
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

--CLIENTI
insert into ContatoEndereco
(
	select
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from clienti as c
	where
		(c."indirizzo" <> '')
);


--CLIENTI
insert into ContatoEndereco
(
	select
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Cobrança' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from clienti as c
	where
		(c."indirizzo 2" <> '')
);


--FORNITOR
insert into ContatoEndereco
(
	select
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from fornitor as f
	where
		(f."indirizzo" <> '')
);


--FORNITOR
insert into ContatoEndereco
(
	select
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Matriz' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from fornitor as f
	where
		(f."indirizzo2" <> '')
);


--CLIENTI INGROSSO
insert into ContatoEndereco
(
	select
		'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from "clienti ingrosso" as ci
	where
		(ci."indirizzo" <> '')
);


--OCULISTI
insert into ContatoEndereco
(
	select
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from oculisti as o
	where
		(o."indirizzo" <> '')
);


--RUBRICA
insert into ContatoEndereco
(
	select
		'rubrica.' + CAST(r."codice" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from rubrica as r
	where
		(r."indirizzo" <> '')
);


--SEDE
insert into ContatoEndereco
(
	select
		'sede.' + CAST(s."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from sede as s
	where
		(s."indirizzo" <> '')
);


--PUNTOVENDITA
insert into ContatoEndereco
(
	select
		'puntovendita.' + CAST(pv."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from puntovendita as pv
	where
		(pv."indirizzo" <> '')
);


--VETTORI
insert into ContatoEndereco
(
	select
		'vettori.' + CAST(v."codice" as varchar(12)) as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
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
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo, --[varchar](255) NULL,
		CAST(NULL as int) as CidadeCodChave, --[int] NULL,
		CAST(NULL as varchar) as Observacao, --[varchar](255) NULL,
		CAST(NULL as varchar) as CodigoAntigo --[varchar](50) NULL
	from vettori as v
	where
		(v."indirizzo" <> '')
);
