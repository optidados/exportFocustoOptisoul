//NOSQLBDETOFF2
drop table if exists documentostatus;

create table documentostatus
(
	CodigoDocumentoStatus int, --not null
	CodigoDocumento	varchar(30), --not null
	CodigoDocumentoItem	int, --null
	CodigoContatoResponsavel int, --null
	Operacao varchar(255), --null
	StatusOriginal varchar(10), --null
	StatusFinalizado varchar(255), --null
	DataHoraEmissao	date, --not null
	CodigoUsuarioAlterou varchar(10), --null
	CodigoDocumentoCaixa int --null
);


--insert carrello (ORÇAMENTO)
insert into documentostatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Venda de Mercadoria' as Operacao, -- varchar(20) null
		CAST(NULL as varchar) as StatusOriginal, --varchar(10) null
		'Orçamento' as StatusFinalizado, --varchar(255) null
		car."data" as DataHoraEmissao, --datetime not null
		CAST(NULL as int) as CodigoUsuarioAlterou, --int null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null

	from carrello as car
);


--insert storicocarrello (Aguardando Faturamento)
insert into documentostatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Venda de Mercadoria' as Operacao, -- varchar(20) null
		'Orçamento' as StatusOriginal, --varchar(10) null
		'Aguardando Faturamento' as StatusFinalizado, --varchar(255) null
		car."data" as DataHoraEmissao, --datetime not null
		'utenti' + car."operatore" as CodigoUsuarioAlterou, --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null

	from carrello as car
);



--insert storicocarrello
insert into documentostatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Venda de Mercadoria' as Operacao, -- varchar(20) null
		CAST(NULL as varchar) as StatusOriginal, --varchar(10) null
		'Orçamento' as StatusFinalizado, --varchar(255) null
		scar."data" as DataHoraEmissao, --datetime not null
		CAST(NULL as int) as CodigoUsuarioAlterou, --int null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null
		
	from storicocarrello as scar
);


--insert storicocarrello (Aguardando Faturamento)
insert into documentostatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Venda de Mercadoria' as Operacao, -- varchar(20) null
		'Orçamento' as StatusOriginal, --varchar(10) null
		'Aguardando Faturamento' as StatusFinalizado, --varchar(255) null
		scar."data" as DataHoraEmissao, --datetime not null
		'utenti' + scar."operatore" as CodigoUsuarioAlterou, --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null

	from storicocarrello as scar
);