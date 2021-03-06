ALTER procedure [dbo].[B3_sp_importa_ContatoFilho] as

--EMPRESA
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	 oc.CodigoContato,
	 fc.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'fornitor.' + an."codice azienda" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Empresa' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join 
	Optisoul..contato oc on oc.codigoantigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..contato fc on fc.codigoantigo= 'fornitor.' + an."codice azienda"	
where
	an."codice azienda" <> ''

--EMPRESA
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	 fc.CodigoContato,
	 oc.CodigoContato,
	--'fornitor.' + an."codice azienda" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Funcionário' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join 
	Optisoul..contato oc on oc.codigoantigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..contato fc on fc.codigoantigo= 'fornitor.' + an."codice azienda"	
where
	an."codice azienda" <> ''



--TITULAR
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	 ac.CodigoContato,
	 bc.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + an."codice titolare" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Titular' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join 
	Optisoul..contato Ac on ac.codigoantigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..contato Bc on bc.codigoantigo= 'clienti.' + an."codice titolare"	
where
	an."codice titolare" <> ''



--TITULAR
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	Bc.CodigoContato,
	Ac.CodigoContato,
	--'clienti.' + an."codice titolare" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Dependente' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join 
	Optisoul..contato Ac on ac.codigoantigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..contato Bc on bc.codigoantigo= 'clienti.' + an."codice titolare"	
where
	an."codice titolare" <> ''


--CONJUGE
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	Ac.CodigoContato,
	Bc.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + an."codice coniuge" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Cônjuge' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join
	Optisoul..Contato Ac on ac.CodigoAntigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..Contato Bc on bc.CodigoAntigo= 'clienti.' + an."Codice Coniuge"
where
	an."codice coniuge" <> ''

--CONJUGE
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	Bc.CodigoContato,
	Ac.CodigoContato,
	'Cônjuge' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join
	Optisoul..Contato Ac on ac.CodigoAntigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..Contato Bc on bc.CodigoAntigo= 'clienti.' + an."Codice Coniuge"
where
	an."codice coniuge" <> ''

--PAI
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	Ac.CodigoContato,
	Bc.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + an."codice padre" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Pai' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join
	Optisoul..Contato Ac on ac.CodigoAntigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..Contato Bc on bc.CodigoAntigo= 'clienti.' + an."Codice Padre"
where
	an."codice padre" <> ''


--PAI
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	Bc.CodigoContato,
	Ac.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + an."codice padre" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Filho' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join
	Optisoul..Contato Ac on ac.CodigoAntigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..Contato Bc on bc.CodigoAntigo= 'clienti.' + an."Codice Padre"
where
	an."codice padre" <> ''

--MAE
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	Ac.CodigoContato,
	Bc.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + an."codice madre" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Mãe' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join
	Optisoul..Contato Ac on ac.CodigoAntigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..Contato Bc on bc.CodigoAntigo= 'clienti.' + an."Codice Madre"
where
	an."codice madre" <> ''


--MAE
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	Bc.CodigoContato,
	Ac.CodigoContato,
	'Filho' as Observacao --[varchar](max) NULL,
from anag_ext5 as an inner join
	Optisoul..Contato Ac on ac.CodigoAntigo= 'clienti.' + an."Codice cliente" inner join
	Optisoul..Contato Bc on bc.CodigoAntigo= 'clienti.' + an."Codice Madre"
where
	an."codice madre" <> ''


--AGENTE
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	ag.CodigoContato,
	f.CodigoContato,
	--'agente.' + a."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'fornitor.' + a."codice fornitore" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Empresa' as Observacao --[varchar](max) NULL,
from agente as a inner join 
	Optisoul..Contato ag on ag.CodigoAntigo= 'agente.' + a."Codice filiale" inner join
	Optisoul..Contato f on f.CodigoAntigo= 'fornitor.' + a."Codice fornitore"

--AGENTE
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	f.CodigoContato,
	ag.CodigoContato,
	'Representante' as Observacao --[varchar](max) NULL,
from agente as a inner join 
	Optisoul..Contato ag on ag.CodigoAntigo= 'agente.' + a."Codice filiale" inner join
	Optisoul..Contato f on f.CodigoAntigo= 'fornitor.' + a."Codice fornitore"
