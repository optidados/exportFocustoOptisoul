
ALTER procedure B2_sp_importa_ContatoFilho as

--EMPRESSA
insert into Optisoul..ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	 oc.CodigoContato,
	 fc.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'fornitor.' + an."codice azienda" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Empresa' as Observacao --[varchar](max) NULL,
from clienti as c
	join anag_ext5 as an
		on (an."codice cliente" = c."codice personale") inner join 
	Optisoul..contato oc on oc.codigoantigo= 'clienti.' + c."codice personale" inner join
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
from clienti as c
	join anag_ext5 as an
		on (an."codice cliente" = c."codice personale") inner join 
Optisoul..contato oc on oc.codigoantigo= 'clienti.' + c."codice personale" inner join
Optisoul..contato fc on fc.codigoantigo= 'fornitor.' + an."codice azienda"	
where
	an."codice azienda" <> ''



--TITULAR
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	 ac.CodigoContato,
	 bc.CodigoContato,
	--'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	--'clienti.' + an."codice titolare" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Titular' as Observacao --[varchar](max) NULL,
from clienti as c
	join anag_ext5 as an
		on (an."codice cliente" = c."codice personale") inner join 
Optisoul..contato Ac on ac.codigoantigo= 'clienti.' + c."codice personale" inner join
Optisoul..contato Bc on bc.codigoantigo= 'clienti.' + an."codice titolare"	


where
	an."codice titolare" <> ''



--TITULAR
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
(
	select
		'clienti.' + an."codice titolare" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Dependente' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice titolare" <> ''
);


--CONJUGE
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
(
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + an."codice coniuge" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Cônjuge' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice coniuge" <> ''
);


--CONJUGE
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
(
	select
		'clienti.' + an."codice coniuge" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Cônjuge' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice coniuge" <> ''
);


--PAI
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
(
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + an."codice padre" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Pai' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice padre" <> ''
);


--PAI
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
(
	select
		'clienti.' + an."codice padre" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Filho' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice padre" <> ''
);


--MAE
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
(
	select
		'clienti.' + c."codice personale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
		'clienti.' + an."codice madre" as CodigoContatoRelacionado, --[int] NOT NULL,
		'Mãe' as Observacao --[varchar](max) NULL,
	from clienti as c
		join anag_ext5 as an
			on (an."codice cliente" = c."codice personale")
	where
		an."codice madre" <> ''
);


--MAE
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	'clienti.' + an."codice madre" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	'clienti.' + c."codice personale" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Filho' as Observacao --[varchar](max) NULL,
from clienti as c
	join anag_ext5 as an
		on (an."codice cliente" = c."codice personale")
where
	an."codice madre" <> ''



--AGENTE
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	'agente.' + a."codice filiale" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	'fornitor.' + a."codice fornitore" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Empresa' as Observacao --[varchar](max) NULL,
from agente as a



--AGENTE
insert into ContatoFilho (CodigoContato ,CodigoContatoRelacionado,Observacao )
select
	'fornitor.' + a."codice fornitore" as CodigoContato, --[int] (int->varchar(255)) NOT NULL,
	'agente.' + a."codice filiale" as CodigoContatoRelacionado, --[int] NOT NULL,
	'Representante' as Observacao --[varchar](max) NULL,
from agente as a
