ALTER procedure [dbo].[B1_sp_importa_Contato] as

--SEDE
insert into Optisoul..Contato
	(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Email, EmailNFe, Segmento, CodigoAntigo, Ativo)
select	
	isnull(s."ragione sociale", s."sede") as Nome, --[varchar](255) NOT NULL,
	s."sede" as Apelido, --[varchar](255) NULL,
	s."codice fiscale" as NumeroDocumentoNacional, --[varchar](150) NULL,
	CASE 
		WHEN s."codice fiscale" IS NOT NULL and s."codice fiscale" <> ''
		THEN 'CNPJ'
	END as TipoDocumentoNacional, --[varchar](4) NULL,
	s."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
	s."e-mail" as Email, --[varchar](255) NULL,
	s."e-mail" as EmailNFe, --[varchar](255) NULL,
	'Matriz' as Segmento, --[varchar](100) NULL, 
	'sede.' + CAST(s.[codice filiale] as varchar(12)) as CodigoAntigo, --[varchar](255) NULL,
	s.attivo as Ativo --[bit] NULL CONSTRAINT [DF_Contato_Ativo]  DEFAULT ((1)),
from sede as s

--PUNTOVENDITA
insert into Optisoul..Contato
(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Email, EmailNFe, Segmento, CodigoAntigo, Ativo)
	select	
		isnull(pv."ragione sociale",pv.[punto vendita]) as Nome, --[varchar](255) NOT NULL,
		pv.[punto vendita] as Apelido, --[varchar](255) NULL,
		pv."codice fiscale" as NumeroDocumentoNacional, --[varchar](150) NULL,
		CASE 
			WHEN pv."codice fiscale" IS NOT NULL and pv."codice fiscale" <> ''
			THEN 'CNPJ'
		END as TipoDocumentoNacional, --[varchar](4) NULL,
		pv."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
		pv."e-mail" as Email, --[varchar](255) NULL,
		pv."e-mail" as EmailNFe, --[varchar](255) NULL,
		'Filial' as Segmento, --[varchar](100) NULL, 
		'puntovendita.' + CAST(pv."codice filiale" as varchar(12)) as CodigoAntigo, --[varchar](255) NULL,
		pv."attivo" as Ativo --[bit] NULL CONSTRAINT [DF_Contato_Ativo]  DEFAULT ((1)),
	from puntovendita as pv
	

--UTENTE
insert into Optisoul..Contato
(Nome, Apelido, CodigoAntigo)
select
	LTRIM(RTRIM(COALESCE(ut."utente", ''))) as Nome, --[varchar](255) NOT NULL,
	LTRIM(RTRIM(COALESCE(ut."utente", ''))) as Apelido, --[varchar](255) NULL,
	'utente.' + CAST(ut."sigla" as varchar(6)) as CodigoAntigo --[varchar](255) NULL,
from utente as ut


--FONITOR
insert into Optisoul..Contato
(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Site, Email, EmailNFe, Segmento, Observacao, CondicaoPagamento, CodigoAntigo, Ativo)

	select	
		f."ragione sociale" as Nome, --[varchar](255) NOT NULL,
		f."ragione sociale" as Apelido, --[varchar](255) NULL,
		f."codice fiscale" as NumeroDocumentoNacional, --[varchar](150) NULL,
		CASE 
			WHEN f."codice fiscale" IS NOT NULL and f."codice fiscale" <> ''
			THEN 'CNPJ'
		END as TipoDocumentoNacional, --[varchar](4) NULL,
		f."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
		f."pagina web" as Site, --[varchar](255) NULL,
		f."e-mail" as Email, --[varchar](255) NULL,
		f."e-mail" as EmailNFe, --[varchar](255) NULL,
		CASE 
			WHEN f."montature"=1 and NOT(f."lenti oftalmiche"=1) and NOT(f."lac"=1) and NOT f."Liquidi e acc"=1 and NOT f."Servizi"=1 THEN 'Armações'
			WHEN NOT f."montature"=1 and f."lenti oftalmiche"=1 and NOT f."lac"=1 and NOT f."Liquidi e acc"=1 and NOT f."Servizi"=1 THEN 'Lentes Oftálmicas'
			WHEN NOT f."montature"=1 and NOT f."lenti oftalmiche"=1 and f."lac"=1 and NOT f."Liquidi e acc"=1 and NOT f."Servizi"=1 THEN 'Lentes de Contato'
			WHEN NOT f."montature"=1 and NOT f."lenti oftalmiche"=1 and f."lac"=1 and f."Liquidi e acc" =1 and NOT f."Servizi"=1 THEN 'Líquidos e Acessórios'
			WHEN NOT f."montature"=1 and NOT f."lenti oftalmiche"=1 and f."lac"=1 and NOT f."Liquidi e acc" =1 and f."Servizi"=1 THEN 'Serviços'
		END as Segmento, --SE POR EXEMPLO UM FORNECEDOR QUE É LABORATÓRIO, LABORATÓRIO SERIA UM SEGMENTO DOS FORNECEDORES [varchar](100) NULL, 
		CAST(f."note" as varchar(max)) as Observacao, --[varchar](max) NULL,
		tp."descrizione" as CondicaoPagamento, --[varchar](50) NULL,
		'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoAntigo, --[varchar](255) NULL,
		f."attivo" as Ativo --[bit] NULL CONSTRAINT [DF_Contato_Ativo]  DEFAULT ((1)),
	from fornitor as f
		left join tipopagamento as tp
		on (tp."codice filiale" = f."codice pagamento")

--CLIENTI
insert into Optisoul..Contato
(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Email, EmailNFe, Sexo, Segmento, CondutaObservacao, CondutaRestricao, Observacao, ObservacaoConsulta, DataAbertura, DataCadastro, CodigoAntigo, LimiteCredito)

	select
		lTRIM(rtrim(COALESCE(c."nome", '') + ' ' + COALESCE(c."cognome", ''))) as Nome, --[varchar](255) NOT NULL,
		lTRIM(rtrim(COALESCE(c."nome", '') + ' ' + COALESCE(c."cognome", ''))) as Apelido, --[varchar](255) NULL,
		c."codfiva" as NumeroDocumentoNacional, --[varchar](150) NULL,
		CASE
			WHEN c."codfiva" IS NOT NULL and c."codfiva" <> ''
			THEN 'CPF'
		END as TipoDocumentoNacional, --[varchar](4) NULL,
		c."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
		c."e mail" as Email, --[varchar](255) NULL,
		c."e mail" as EmailNFe, --[varchar](255) NULL,
		CASE c."sesso"
			WHEN 'M' THEN 'Masculino'
			WHEN 'F' THEN 'Feminino'
		END as Sexo, --[varchar](100) NULL,
		c."professione" as Segmento, --SEGMENTO DE CLIENTE? [varchar](100) NULL, 
		CASE c."campo4_c"
			WHEN 0 THEN 'Não Consultado'
			WHEN 3 THEN 'Com Pendência'
		END as CondutaObservacao, --ALERTAS NA HORA DO PEDIDO -- JOGAR O COM PENDENCIA, NÃO CONSULTADO [varchar](255) NULL,
		CASE c."campo4_c"
			WHEN 2 THEN 'Bloqueado'
		END as CondutaRestricao, --RESTRINGE O PEDIDO -- JOGAR O BLOQUEADO SPC AQUI [varchar](255) NULL,
		CAST(c."note" as varchar(max)) as Observacao, --[varchar](max) NULL,
		CAST(c."note riservate" as varchar(max)) as ObservacaoConsulta, --[varchar](max) NULL,
		CAST(c."data nascita" as datetime) as DataAbertura, --[datetime] NULL,
		--case when isdate(c."data nascita")=1 then CAST(c."data nascita" as datetime) else null end as DataAbertura,
		CAST(c."data inserimento" as datetime) as DataCadastro, --[datetime] NULL CONSTRAINT [DF_Contato_DataCadastro]  DEFAULT (getdate()),
		'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoAntigo, --[varchar](255) NULL,
		c."credito" as LimiteCredito --[numeric](18, 2) NULL,
	from clienti as c

--CLIENTE INGROSSO
insert into Optisoul..Contato
	(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Email, EmailNFe, Observacao, CodigoAntigo)

	select	
		ci."ragione sociale" as Nome, --[varchar](255) NOT NULL,
		ci."ragione sociale" as Apelido, --[varchar](255) NULL,
		ci."codice fiscale" as NumeroDocumentoNacional, --[varchar](150) NULL,
		CASE 
			WHEN ci."codice fiscale" IS NOT NULL and ci."codice fiscale" <> ''
			THEN 'CNPJ'
		END as TipoDocumentoNacional, --[varchar](4) NULL,
		ci."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
		ci."e-mail" as Email, --[varchar](255) NULL,
		ci."e-mail" as EmailNFe, --[varchar](255) NULL,
		CAST(ci."note" as varchar(max)) as Observacao, --[varchar](max) NULL,
		'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12)) as CodigoAntigo --[varchar](255) NULL,
	from [Clienti Ingrosso] as ci

--OCULISTI
insert into Optisoul..Contato
	(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Email, EmailNFe, Segmento, Observacao, CodigoAntigo)

	select
		o."denominazione" as Nome, --[varchar](255) NOT NULL,
		o."denominazione" as Apelido, --[varchar](255) NULL,
		o."codice fiscale" as NumeroDocumentoNacional, --[varchar](150) NULL,
		CASE 
			WHEN o."codice fiscale" IS NOT NULL and o."codice fiscale" <> ''
			THEN 'CPF'
		END as TipoDocumentoNacional, --[varchar](4) NULL,
		o."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
		o."email" as Email, --[varchar](255) NULL,
		o."email" as EmailNFe, --[varchar](255) NULL,
		'Oftalmologista' as Segmento, --[varchar](100) NULL, 
		CAST(o."note" as varchar(max)) as Observacao, --[varchar](max) NULL,
		'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoAntigo --[varchar](255) NULL,
	from oculisti as o

--RUBRICA
insert into Optisoul..Contato 
	(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Email, EmailNFe, Segmento, Observacao, DataAbertura, CodigoAntigo)

	select	
		lTRIM(rtrim(COALESCE(r."nome", '') + ' ' + COALESCE(r."cognome", ''))) as Nome, --[varchar](255) NOT NULL,
		lTRIM(rtrim(COALESCE(r."nome", '') + ' ' + COALESCE(r."cognome", ''))) as Apelido, --[varchar](255) NULL,
		r."codice fiscale" as NumeroDocumentoNacional, --[varchar](150) NULL,
		CASE 
			WHEN r."codice fiscale" IS NOT NULL and r."codice fiscale" <> ''
			THEN 'CPF'
		END as TipoDocumentoNacional, --[varchar](4) NULL,
		r."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
		r."email" as Email, --[varchar](255) NULL,
		r."email" as EmailNFe, --[varchar](255) NULL,
		r."tipo" as Segmento, --[varchar](100) NULL, 
		CAST(r."note" as varchar(max)) as Observacao, --[varchar](max) NULL,
		CAST(r."datanascita" as datetime) as DataAbertura, --[datetime] NULL,
		'rubrica.' + CAST(r."codice" as varchar(12)) as CodigoAntigo --[varchar](255) NULL,
	from rubrica as r

--VETTORI
insert into Optisoul..Contato
	(Nome, Apelido, NumeroDocumentoNacional, TipoDocumentoNacional, NumeroDocumentoEstadual, Email, EmailNFe, Segmento, Observacao, CodigoAntigo, Ativo)

	select	
		v."ragione sociale" as Nome, --[varchar](255) NOT NULL,
		v."ragione sociale" as Apelido, --[varchar](255) NULL,
		v."codice fiscale" as NumeroDocumentoNacional, --[varchar](150) NULL,
		CASE 
			WHEN v."codice fiscale" IS NOT NULL and v."codice fiscale" <> ''
			THEN 'CNPJ'
		END as TipoDocumentoNacional, --[varchar](4) NULL,
		v."partita iva" as NumeroDocumentoEstadual, --[varchar](150) NULL,
		v."e-mail" as Email, --[varchar](255) NULL,
		v."e-mail" as EmailNFe, --[varchar](255) NULL,
		'Transportadora' as Segmento, --[varchar](100) NULL, 
		CAST(v."note" as varchar(max)) as Observacao, --[varchar](max) NULL,
		'vettori.' + CAST(v."codice filiale" as varchar(12)) as CodigoAntigo, --[varchar](255) NULL,
		v."attivo" as Ativo --[bit] NULL CONSTRAINT [DF_Contato_Ativo]  DEFAULT ((1)),
	from vettori as v
	

--AGENTE
insert into Optisoul..Contato
	(Nome, Apelido, Email, EmailNFe, Segmento, CodigoAntigo)

	select	
		isnull(ag."nome agente",'') as Nome, --[varchar](255) NOT NULL,
		ag."nome agente" as Apelido, --[varchar](255) NULL,
		ag."e-mail" as Email, --[varchar](255) NULL,
		ag."e-mail" as EmailNFe, --[varchar](255) NULL,
		'Representante' as Segmento, --[varchar](100) NULL, 
		'agente.' + CAST(ag."codice filiale" as varchar(12)) as CodigoAntigo --[varchar](255) NULL,
	from agente as ag
