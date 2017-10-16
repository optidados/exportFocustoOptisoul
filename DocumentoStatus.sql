//NOSQLBDETOFF2
drop table if exists DocumentoStatus;

create table DocumentoStatus
(
	CodigoDocumentoStatus int, --not null
	CodigoDocumento	varchar(30), --not null
	CodigoDocumentoItem	int, --null
	CodigoContatoResponsavel int, --null
	Operacao varchar(255), --null
	StatusOriginal varchar(255), --null
	StatusFinalizado varchar(255), --null
	DataHoraEmissao	date, --not null
	CodigoUsuarioAlterou varchar(13), --null
	CodigoDocumentoCaixa int --null
);

create index CodDocIdx on DocumentoStatus("CodigoDocumento");

--insert carrello (ORÇAMENTO)
insert into DocumentoStatus
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

--insert carrello (Aguardando Faturamento)
insert into DocumentoStatus
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
		'utente.' + car."operatore" as CodigoUsuarioAlterou, --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null

	from carrello as car
);

--insert carrello (Faturado)
insert into DocumentoStatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		'car.' + CAST(car2."codice carrello" as varchar(12)) as CodigoDocumento, --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Venda de Mercadoria' as Operacao, -- varchar(20) null
		'Aguardando Faturamento' as StatusOriginal, --varchar(10) null
		'Faturado' as StatusFinalizado, --varchar(255) null
		MAX(trans."data") as DataHoraEmissao, --datetime not null
		'utente.' + trans."operatore" as CodigoUsuarioAlterou, --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null

	from carrello2 as car2
	join transazioni as trans
		on (trans."codice filiale" = car2."codice transazione")

	where car2."pagato" = True

	group by
		car2."codice carrello",
		trans."operatore"
);

--insert storicocarrello
insert into DocumentoStatus
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
insert into DocumentoStatus
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
		'utente.' + scar."operatore" as CodigoUsuarioAlterou, --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null

	from storicocarrello as scar
);

--insert storicocarrello (Faturado)
insert into DocumentoStatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		'scar.' + CAST(scar2."codice carrello" as varchar(12)) as CodigoDocumento, --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Venda de Mercadoria' as Operacao, -- varchar(20) null
		'Aguardando Faturamento' as StatusOriginal, --varchar(10) null
		'Faturado' as StatusFinalizado, --varchar(255) null
		MAX(trans."data") as DataHoraEmissao, --datetime not null
		'utente.' + trans."operatore" as CodigoUsuarioAlterou, --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null

	from storicocarrello2 as scar2
	join transazioni as trans
		on (trans."codice filiale" = scar2."codice transazione")

	group by
		scar2."codice carrello",
		trans."operatore"
);

insert into DocumentoStatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		doc."CodigoDocumento", --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Mudança status envelope' as Operacao, -- varchar(20) null
		'Orçamento' as StatusOriginal, --varchar(10) null
		'Aguardando Envio' as StatusFinalizado, --varchar(255) null
		doc."DataHoraEmissao", --datetime not null
		doc."CodigoContatoDigitador", --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null
	
	from Documento as doc
	where
		(doc."Tipo" = 'Envelope')
);

insert into DocumentoStatus
(
	select
		CAST(NULL as int) as CodigoDocumentoStatus, --int not null
		doc."CodigoDocumento", --varchar(30) not null
		CAST(NULL as int) as CodigoDocumentoItem, --int null
		CAST(NULL as int) as CodigoContatoResponsavel, --int null
		'Mudança status envelope' as Operacao, -- varchar(20) null
		'Aguardando Envio' as StatusOriginal, --varchar(10) null
		doc."Status" as StatusFinalizado, --varchar(255) null
		doc."DataHoraEmissao", --datetime not null
		doc."CodigoContatoDigitador", --varchar(10) (int->varchar(10)) null
		CAST(NULL as int) as CodigoDocumentoCaixa --int null
	
	from Documento as doc
	where
		(doc."Tipo" = 'Envelope') and
		(doc."Status" <> 'Aguardando Envio')
);

delete from DocumentoStatus as docs
where
	NOT EXISTS
	(
		select *
		from Documento as doc
		where 
			doc."CodigoDocumento" = docs."CodigoDocumento" and
			(doc."Tipo" = 'Venda' or doc."Tipo" = 'Envelope')
	);

update Documento as doc
set doc."Status" = 
	(
		select MAX(docit."Status")
		from DocumentoItem as docit
		where
			docit."CodigoDocumento" = doc."CodigoDocumento" and
			docit."Operacao" = 'Venda de Mercadoria'
		group by docit."CodigoDocumento"
	)
where
	doc."Tipo" IN ('Item Venda', 'Devolução');

update Documento as doc
set doc."Status" = 
	(
		select
			MAX(docit."Status")
		from DocumentoItem as docit
		join Documento as doc2
			on docit."CodigoDocumento" = doc2."CodigoDocumento"
		where
			doc2."CodigoDocumentoAdicional" = doc."CodigoDocumento" and
			doc2."Tipo" = 'Item Venda' and
			docit."Operacao" = 'Venda de Mercadoria'
		group by docit."CodigoDocumento"
	)
where
	doc."Tipo" = 'Venda';