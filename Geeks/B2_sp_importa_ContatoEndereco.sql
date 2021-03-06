ALTER procedure [dbo].[B2_sp_importa_ContatoEndereco] as

--CLIENTI endereço 1
insert into Optisoul..ContatoEndereco 
	(CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		c."indirizzo" as Logradouro, --[varchar](255) NULL,
		c."campo2_c" as Bairro, --[varchar](255) NULL,
		c."cap" as CEP, --[varchar](50) NULL,
		CASE WHEN isnumeric(c."campo6_c")=1 THEN c."campo6_c" ELSE CAST(NULL as int) END as IbgeCod, --[int] NULL,
		c."citta" as Municipio, --[varchar](150) NULL,
		c."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from clienti as c inner join 
	Optisoul..contato o on 'clienti.' + CAST(c."codice personale" as varchar(12)) = O.CodigoAntigo
	where
		(c."indirizzo" <> '')


--CLIENTI  endereço 2
insert into Optisoul..ContatoEndereco 
	(CodigoContato, Logradouro, Bairro, CEP, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		c."indirizzo 2" as Logradouro, --[varchar](255) NULL,
		c."campo3_c" as Bairro, --[varchar](255) NULL,
		c."cap 2" as CEP, --[varchar](50) NULL,
		c."citta 2" as Municipio, --[varchar](150) NULL,
		c."provincia 2" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Cobrança' as Grupo --[varchar](255) NULL,
	from clienti as c inner join 
	Optisoul..contato o on 'clienti.' + CAST(c."codice personale" as varchar(12)) = O.CodigoAntigo
	where
		c."indirizzo 2" <> ''


--FORNITOR
insert into Optisoul..ContatoEndereco 
	(CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		f."indirizzo" as Logradouro, --[varchar](255) NULL,
		f."campo1_f" as Bairro, --[varchar](255) NULL,
		f."cap" as CEP, --[varchar](50) NULL,
		f."campo5_f" as IbgeCod, --[int] NULL,
		f."citta" as Municipio, --[varchar](150) NULL,
		f."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from fornitor as f inner join 
	Optisoul..contato o on 'fornitor.' + CAST(f."codice filiale" as varchar(12)) = O.CodigoAntigo
	where
		f."indirizzo" <> ''


--FORNITOR
insert into Optisoul..ContatoEndereco (CodigoContato, Logradouro, Bairro, CEP, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		f."indirizzo2" as Logradouro, --[varchar](255) NULL,
		f."campo2_f" as Bairro, --[varchar](255) NULL,
		f."cap2" as CEP, --[varchar](50) NULL,
		f."citta2" as Municipio, --[varchar](150) NULL,
		f."provincia2" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Matriz' as Grupo --[varchar](255) NULL,
	from fornitor f  inner join 
	Optisoul..contato o on 'fornitor.' + CAST(f."codice filiale" as varchar(12)) = O.CodigoAntigo
	where
		f."indirizzo2" <> ''


--CLIENTI INGROSSO
insert into Optisoul..ContatoEndereco (CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		ci."indirizzo" as Logradouro, --[varchar](255) NULL,
		ci."campo1_f" as Bairro, --[varchar](255) NULL,
		ci."cap" as CEP, --[varchar](50) NULL,
		ci."campo5_f" as IbgeCod, --[int] NULL,
		ci."citta" as Municipio, --[varchar](150) NULL,
		ci."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from [Clienti Ingrosso] as ci inner join 
	Optisoul..contato o on 'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) = O.CodigoAntigo
	where
		(ci."indirizzo" <> '')



--OCULISTI
insert into Optisoul..ContatoEndereco (CodigoContato, Logradouro, Bairro, CEP, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		oc."indirizzo" as Logradouro, --[varchar](255) NULL,
		oc."campo1_o" as Bairro, --[varchar](255) NULL,
		oc."cap" as CEP, --[varchar](50) NULL,
		oc."citta" as Municipio, --[varchar](150) NULL,
		oc."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from oculisti as oc inner join 
	Optisoul..contato o on 'oculisti.' + CAST(oc."codice filiale" as varchar(12)) = o.CodigoAntigo
	where
		(oc."indirizzo" <> '')



--RUBRICA
insert into Optisoul..ContatoEndereco (CodigoContato, Logradouro, Bairro, CEP, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		r."indirizzo" as Logradouro, --[varchar](255) NULL,
		r."campo1_r" as Bairro, --[varchar](255) NULL,
		r."cap" as CEP, --[varchar](50) NULL,
		r."citta" as Municipio, --[varchar](150) NULL,
		r."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from rubrica as r inner join 
	Optisoul..contato o on 'rubrica.' + CAST(r."codice" as varchar(12)) = o.CodigoAntigo
	where
		(r."indirizzo" <> '')



--SEDE
insert into Optisoul..ContatoEndereco (CodigoContato, Logradouro, CEP, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		s."indirizzo" as Logradouro, --[varchar](255) NULL,
		s."cap" as CEP, --[varchar](50) NULL,
		s."citta" as Municipio, --[varchar](150) NULL,
		s."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from sede as s inner join 
	Optisoul..contato o on 'sede.' + CAST(s."codice filiale" as varchar(12)) = o.CodigoAntigo
	where
		(s."indirizzo" <> '')



--PUNTOVENDITA
insert into Optisoul..ContatoEndereco (CodigoContato, Logradouro, CEP, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		pv."indirizzo" as Logradouro, --[varchar](255) NULL,
		pv."cap" as CEP, --[varchar](50) NULL,
		pv."citta" as Municipio, --[varchar](150) NULL,
		pv."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from puntovendita as pv inner join 
	Optisoul..contato o on 'puntovendita.' + CAST(pv."codice filiale" as varchar(12)) = o.CodigoAntigo
	where
		(pv."indirizzo" <> '')



--VETTORI
insert into Optisoul..ContatoEndereco (CodigoContato, Logradouro, CEP, Municipio, UF, Pais, Grupo)

	select
		o.CodigoContato as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		v."indirizzo" as Logradouro, --[varchar](255) NULL,
		v."cap" as CEP, --[varchar](50) NULL,
		v."citta" as Municipio, --[varchar](150) NULL,
		v."provincia" as UF, --[varchar](50) NULL,
		'Brasil' as Pais, --[varchar](150) NULL,
		'Principal' as Grupo --[varchar](255) NULL,
	from vettori as v inner join 
	Optisoul..contato o on 'vettori.' + CAST(v."codice" as varchar(12)) = o.CodigoAntigo
	where
		(v."indirizzo" <> '')
