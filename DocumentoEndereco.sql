//NOSQLBDETOFF2 
drop table if exists documentoendereco;

create table documentoendereco
(
	Descricao varchar, --null
	CodigoDocumento	varchar(30), --not null
	CodigoContatoEndereco int, --not null
	CodigoContato varchar(30), --varchar(30) (int->varchar(30)) not null
	Logradouro varchar, --null
	Numero varchar, --null
	Complemento	varchar, --null
	Condominio varchar, --null
	Bairro varchar, --null
	CEP	varchar, --null
	IbgeCod	int, --null
	Municipio varchar, --null
	UF varchar, --null
	UFCod int, --null
	Pais varchar, --null
	Grupo varchar, --null
	CidadeCodChave int, --null
	Observacao varchar --null
);


--Cliente Endereço (carrello)
insert into documentoendereco
(
	select
		CAST(NULL as varchar) as Descricao, --varchar(255) --null
		'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
		CAST(NULL as int) as CodigoContatoEndereco, --int --not null
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as varchar) as Logradouro, --varchar(255) --null
		CAST(NULL as varchar) as Numero, --varchar(10) --null
		CAST(NULL as varchar) as Complemento, --varchar(255) --null
		CAST(NULL as varchar) as Condominio, --varchar(150) --null
		CAST(NULL as varchar) as Bairro, --varchar(255) --null
		CAST(NULL as varchar) as CEP, --varchar(50) --null
		CAST(NULL as int) as IbgeCod, --int --null
		CAST(NULL as varchar) as Municipio, --varchar(150) --null
		CAST(NULL as varchar) as UF, --varchar(50) --null
		CAST(NULL as int) as UFCod, --int --null
		CAST(NULL as varchar) as Pais, --varchar(150) --null
		CAST(NULL as varchar) as Grupo, --varchar(255) --null
		CAST(NULL as int) as CidadeCodChave, --int --null
		CAST(NULL as varchar) as Observacao --varchar(255) --null

	from carrello as car
		join clienti as c
		on(c."codice personale" = car."codice cliente")
);


--Cliente Endereço (storicocarrello)
insert into documentoendereco
(
	select
		CAST(NULL as varchar) as Descricao, --varchar(255) --null
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
		CAST(NULL as int) as CodigoContatoEndereco, --int --not null
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as varchar) as Logradouro, --varchar(255) --null
		CAST(NULL as varchar) as Numero, --varchar(10) --null
		CAST(NULL as varchar) as Complemento, --varchar(255) --null
		CAST(NULL as varchar) as Condominio, --varchar(150) --null
		CAST(NULL as varchar) as Bairro, --varchar(255) --null
		CAST(NULL as varchar) as CEP, --varchar(50) --null
		CAST(NULL as int) as IbgeCod, --int --null
		CAST(NULL as varchar) as Municipio, --varchar(150) --null
		CAST(NULL as varchar) as UF, --varchar(50) --null
		CAST(NULL as int) as UFCod, --int --null
		CAST(NULL as varchar) as Pais, --varchar(150) --null
		CAST(NULL as varchar) as Grupo, --varchar(255) --null
		CAST(NULL as int) as CidadeCodChave, --int --null
		CAST(NULL as varchar) as Observacao --varchar(255) --null

	from storicocarrello as scar
		join clienti as c
		on(c."codice personale" = scar."codice cliente")
);



--Matriz Endereço (carrello)
insert into documentoendereco
(
	select
		CAST(NULL as varchar) as Descricao, --varchar(255) --null
		'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
		CAST(NULL as int) as CodigoContatoEndereco, --int --not null
		'sede.' + CAST(s."codice filiale" as varchar(12)) as CodigoContato, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as varchar) as Logradouro, --varchar(255) --null
		CAST(NULL as varchar) as Numero, --varchar(10) --null
		CAST(NULL as varchar) as Complemento, --varchar(255) --null
		CAST(NULL as varchar) as Condominio, --varchar(150) --null
		CAST(NULL as varchar) as Bairro, --varchar(255) --null
		CAST(NULL as varchar) as CEP, --varchar(50) --null
		CAST(NULL as int) as IbgeCod, --int --null
		CAST(NULL as varchar) as Municipio, --varchar(150) --null
		CAST(NULL as varchar) as UF, --varchar(50) --null
		CAST(NULL as int) as UFCod, --int --null
		CAST(NULL as varchar) as Pais, --varchar(150) --null
		CAST(NULL as varchar) as Grupo, --varchar(255) --null
		CAST(NULL as int) as CidadeCodChave, --int --null
		CAST(NULL as varchar) as Observacao --varchar(255) --null

	from carrello as car
		join sede as s
		on (s."codice filiale" = car."filiale")
);


--Matriz Endereço (storicocarrello)
insert into documentoendereco
(
	select
		CAST(NULL as varchar) as Descricao, --varchar(255) --null
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as int) as CodigoContatoEndereco, --int --not null
		'sede.' + CAST(s."codice filiale" as varchar(12)) as CodigoContato, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as varchar) as Logradouro, --varchar(255) --null
		CAST(NULL as varchar) as Numero, --varchar(10) --null
		CAST(NULL as varchar) as Complemento, --varchar(255) --null
		CAST(NULL as varchar) as Condominio, --varchar(150) --null
		CAST(NULL as varchar) as Bairro, --varchar(255) --null
		CAST(NULL as varchar) as CEP, --varchar(50) --null
		CAST(NULL as int) as IbgeCod, --int --null
		CAST(NULL as varchar) as Municipio, --varchar(150) --null
		CAST(NULL as varchar) as UF, --varchar(50) --null
		CAST(NULL as int) as UFCod, --int --null
		CAST(NULL as varchar) as Pais, --varchar(150) --null
		CAST(NULL as varchar) as Grupo, --varchar(255) --null
		CAST(NULL as int) as CidadeCodChave, --int --null
		CAST(NULL as varchar) as Observacao --varchar(255) --null

	from storicocarrello as scar
		join sede as s
		on (s."codice filiale" = scar."filiale")
);


--Filial Endereço (carrello)
insert into documentoendereco
(
	select
		CAST(NULL as varchar) as Descricao, --varchar(255) --null
		'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
		CAST(NULL as int) as CodigoContatoEndereco, --int --not null
		'puntovendita.' + CAST(pv."codice filiale" as varchar(12)) as CodigoContato, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as varchar) as Logradouro, --varchar(255) --null
		CAST(NULL as varchar) as Numero, --varchar(10) --null
		CAST(NULL as varchar) as Complemento, --varchar(255) --null
		CAST(NULL as varchar) as Condominio, --varchar(150) --null
		CAST(NULL as varchar) as Bairro, --varchar(255) --null
		CAST(NULL as varchar) as CEP, --varchar(50) --null
		CAST(NULL as int) as IbgeCod, --int --null
		CAST(NULL as varchar) as Municipio, --varchar(150) --null
		CAST(NULL as varchar) as UF, --varchar(50) --null
		CAST(NULL as int) as UFCod, --int --null
		CAST(NULL as varchar) as Pais, --varchar(150) --null
		CAST(NULL as varchar) as Grupo, --varchar(255) --null
		CAST(NULL as int) as CidadeCodChave, --int --null
		CAST(NULL as varchar) as Observacao --varchar(255) --null

	from carrello as car
		join puntovendita as pv
		on (pv."codice filiale" = car."filiale")
);


--Filial Endereço (storicocarrello)
insert into documentoendereco
(
	select
		CAST(NULL as varchar) as Descricao, --varchar(255) --null
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as int) as CodigoContatoEndereco, --int --not null
		'puntovendita.' + CAST(pv."codice filiale" as varchar(12)) as CodigoContato, --varchar(30) (int->varchar(30)) not null
		CAST(NULL as varchar) as Logradouro, --varchar(255) --null
		CAST(NULL as varchar) as Numero, --varchar(10) --null
		CAST(NULL as varchar) as Complemento, --varchar(255) --null
		CAST(NULL as varchar) as Condominio, --varchar(150) --null
		CAST(NULL as varchar) as Bairro, --varchar(255) --null
		CAST(NULL as varchar) as CEP, --varchar(50) --null
		CAST(NULL as int) as IbgeCod, --int --null
		CAST(NULL as varchar) as Municipio, --varchar(150) --null
		CAST(NULL as varchar) as UF, --varchar(50) --null
		CAST(NULL as int) as UFCod, --int --null
		CAST(NULL as varchar) as Pais, --varchar(150) --null
		CAST(NULL as varchar) as Grupo, --varchar(255) --null
		CAST(NULL as int) as CidadeCodChave, --int --null
		CAST(NULL as varchar) as Observacao --varchar(255) --null

	from storicocarrello as scar
		join puntovendita as pv
		on (pv."codice filiale" = scar."filiale")
);