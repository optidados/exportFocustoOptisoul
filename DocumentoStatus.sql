//NOSQLBDETOFF2
drop table if exists documentostatus;

create table documentostatus
(
	CodigoDocumento	int, --not null
	CodigoDocumentoItem	int, --null
	CodigoContatoResponsavel int, --null
	Operacao varchar(255), --null
	StatusOriginal varchar(255), --null
	StatusFinalizado varchar(255), --null
	DataHoraEmissao	datetime, --not null
	CodigoUsuarioAlterou int, --null
	CodigoDocumentoCaixa int --null
);