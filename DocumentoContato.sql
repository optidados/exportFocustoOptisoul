//NOSQLBDETOFF2 
drop table if exists documentocontato;

create table docuemtnocontato
(
	CodigoContato int, --not null
	Descricao varchar(255), --not null
	CodigoDocumento	int, --not null
	Percentual decimal(18,4) --null
);