//NOSQLBDETOFF2 
drop table if exists documentoendereco;

create table documentoendereco
(
	Descricao varchar(255), --null
	CodigoDocumento	int, --not null
	CodigoContatoEndereco int, --not null
	CodigoContato int, --not null
	Logradouro varchar(255), --null
	Numero varchar(10), --null
	Complemento	varchar(255), --null
	Condominio varchar(150), --null
	Bairro varchar(255), --null
	CEP	varchar(50), --null
	IbgeCod	int, --null
	Municipio varchar(150), --null
	UF varchar(50), --null
	UFCod int, --null
	Pais varchar(150), --null
	Grupo varchar(255), --null
	CidadeCodChave int, --null
	Observacao varchar(255) --null
);


insert into documentoendereco
(
	select
	from
	where
);