ALTER procedure [dbo].[B4_sp_importa_ContatoGrupo] as

--CLIENTES
insert into Optisoul..ContatoGrupo (CodigoContato, Descricao)
select
	co.CodigoContato, --[int] (int->varchar(30)) NOT NULL,
	'Cliente' as Descricao --[varchar](255) NOT NULL,
from clienti as c inner join
Optisoul..contato co on co.codigoantigo = 'clienti.' + CAST(c."codice personale" as varchar(12)) 


--VENDEDOR
insert into Optisoul..ContatoGrupo (CodigoContato,Descricao)
select
	 co.CodigoContato, --[int] (int->varchar(30)) NOT NULL,
	'Vendedor' as Descricao --[varchar](255) NOT NULL,
from utente ut inner join
Optisoul..contato co on co.codigoantigo = 'utente.' + CAST(ut."sigla" as varchar(6)) 



--CLIENTE
insert into Optisoul..ContatoGrupo (CodigoContato,Descricao)
select
	co.CodigoContato, --[int] (int->varchar(30)) NOT NULL,
	'Cliente' as Descricao --[varchar](255) NOT NULL,
from [Clienti Ingrosso] as ci inner join
Optisoul..contato co on co.codigoantigo = 'clienti ingrosso.' + CAST(ci."codice filiale" as varchar(12))  



--FORNECEDORES
insert into Optisoul..ContatoGrupo (CodigoContato,Descricao)
select
	co.CodigoContato,
	--'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
	'Fornecedor' as Descricao --[varchar](255) NOT NULL,
from fornitor as f inner join
Optisoul..contato co on co.codigoantigo = 'fornitor.' + CAST(f."codice filiale" as varchar(12))  


--CONVÊNIO
insert into Optisoul..ContatoGrupo (CodigoContato,Descricao)
select
	co.CodigoContato,
	--'fornitor.' + CAST(f."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
	'Convênio' as Descricao --[varchar](255) NOT NULL,
from fornitor as f inner join
	Optisoul..contato co on co.codigoantigo = 'fornitor.' + CAST(f."codice filiale" as varchar(12))  
where f."campo3_f" is not null


--MÉDICO
insert into Optisoul..ContatoGrupo (CodigoContato,Descricao)
select
	co.CodigoContato,
	--'oculisti.' + CAST(o."codice filiale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
	'Médico' as Descricao --[varchar](255) NOT NULL,
from oculisti as o inner join
	Optisoul..contato co on co.codigoantigo = 'oculisti.' + CAST(o."codice filiale" as varchar(12))  


--PROBLEMA VISUAL
insert into Optisoul..ContatoGrupo (CodigoContato,Descricao)
select
	co.CodigoContato,
	--'clienti.' + CAST(c."codice personale" as varchar(12)) as CodigoContato, --[int] (int->varchar(30)) NOT NULL,
	c."problema visivo" as Descricao --varchar(20) (varchar(255)->varchar(20)) NOT NULL,
from clienti as c inner join
	Optisoul..contato co on co.codigoantigo = 'clienti.' + CAST(c."codice personale" as varchar(12))  
where
	c."problema visivo" <> ''