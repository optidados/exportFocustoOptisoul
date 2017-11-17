ALTER procedure [dbo].[D6_sp_importa_DocumentoEndereco] as

--Cliente Endereço (carrello)
insert into Optisoul..DocumentoEndereco
	(Descricao, CodigoDocumento, CodigoContatoEndereco, CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais)
select
	COALESCE(ce.Logradouro + ' - ', '')  + COALESCE(ce.Bairro + ' - ', '') + COALESCE(ce.CEP + ' - ', '') + COALESCE(ce.Municipio, '') + COALESCE('/' + ce.UF, '') as Descricao, --varchar(255) --null
	d.CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
	ce.CodigoContatoEndereco, --int --not null
	c.CodigoContato, --varchar(30) (int->varchar(30)) not null
	ce.Logradouro, --varchar(255) --null
	ce.Bairro, --varchar(255) --null
	ce.CEP, --varchar(50) --null
	ce.IbgeCod, --int --null
	ce.Municipio, --varchar(150) --null
	ce.UF, --varchar(50) --null
	ce.Pais --varchar(150) --null
	
from carrello as car
	inner join Optisoul..Contato as c
		on (c.CodigoAntigo = 'clienti.' + CAST(car."codice cliente" as varchar(12)))

	inner join Optisoul..ContatoEndereco as ce
		on (c.CodigoContato = ce.CodigoContato)

	inner join Optisoul..Documento as d
		on (d.idant = 'car.' + CAST(car."codice filiale" as varchar(12)))

where
	ce.Grupo = 'Principal'

--Loja Endereço (carrello)
insert into Optisoul..DocumentoEndereco
	(Descricao, CodigoDocumento, CodigoContatoEndereco, CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais)
select
	COALESCE(ce.Logradouro + ' - ', '')  + COALESCE(ce.Bairro + ' - ', '') + COALESCE(ce.CEP + ' - ', '') + COALESCE(ce.Municipio, '') + COALESCE('/' + ce.UF, '') as Descricao, --varchar(255) --null
	d.CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
	ce.CodigoContatoEndereco, --int --not null
	c.CodigoContato, --varchar(30) (int->varchar(30)) not null
	ce.Logradouro, --varchar(255) --null
	ce.Bairro, --varchar(255) --null
	ce.CEP, --varchar(50) --null
	ce.IbgeCod, --int --null
	ce.Municipio, --varchar(150) --null
	ce.UF, --varchar(50) --null
	ce.Pais --varchar(150) --null
	
from carrello as car
	inner join Optisoul..Contato as c
		on (c.CodigoAntigo = 'sede.' + CAST(car."filiale" as varchar(12)))

	inner join Optisoul..ContatoEndereco as ce
		on (c.CodigoContato = ce.CodigoContato)

	inner join Optisoul..Documento as d
		on (d.idant = 'car.' + CAST(car."codice filiale" as varchar(12)))

where
	ce.Grupo = 'Principal'

insert into Optisoul..DocumentoEndereco
	(Descricao, CodigoDocumento, CodigoContatoEndereco, CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais)
select
	COALESCE(ce.Logradouro + ' - ', '')  + COALESCE(ce.Bairro + ' - ', '') + COALESCE(ce.CEP + ' - ', '') + COALESCE(ce.Municipio, '') + COALESCE('/' + ce.UF, '') as Descricao, --varchar(255) --null
	d.CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
	ce.CodigoContatoEndereco, --int --not null
	c.CodigoContato, --varchar(30) (int->varchar(30)) not null
	ce.Logradouro, --varchar(255) --null
	ce.Bairro, --varchar(255) --null
	ce.CEP, --varchar(50) --null
	ce.IbgeCod, --int --null
	ce.Municipio, --varchar(150) --null
	ce.UF, --varchar(50) --null
	ce.Pais --varchar(150) --null
	
from carrello as car
	inner join Optisoul..Contato as c
		on (c.CodigoAntigo = 'puntovendita.' + CAST(car."filiale" as varchar(12)))

	inner join Optisoul..ContatoEndereco as ce
		on (c.CodigoContato = ce.CodigoContato)

	inner join Optisoul..Documento as d
		on (d.idant = 'car.' + CAST(car."codice filiale" as varchar(12)))

where
	ce.Grupo = 'Principal'


--Cliente Endereço (storicocarrello)
insert into Optisoul..DocumentoEndereco
	(Descricao, CodigoDocumento, CodigoContatoEndereco, CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais)
select
	COALESCE(ce.Logradouro + ' - ', '')  + COALESCE(ce.Bairro + ' - ', '') + COALESCE(ce.CEP + ' - ', '') + COALESCE(ce.Municipio, '') + COALESCE('/' + ce.UF, '') as Descricao, --varchar(255) --null
	d.CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
	ce.CodigoContatoEndereco, --int --not null
	c.CodigoContato, --varchar(30) (int->varchar(30)) not null
	ce.Logradouro, --varchar(255) --null
	ce.Bairro, --varchar(255) --null
	ce.CEP, --varchar(50) --null
	ce.IbgeCod, --int --null
	ce.Municipio, --varchar(150) --null
	ce.UF, --varchar(50) --null
	ce.Pais --varchar(150) --null
	
from storicocarrello as scar
	inner join Optisoul..Contato as c
		on (c.CodigoAntigo = 'clienti.' + CAST(scar."codice cliente" as varchar(12)))

	inner join Optisoul..ContatoEndereco as ce
		on (c.CodigoContato = ce.CodigoContato)

	inner join Optisoul..Documento as d
		on (d.idant = 'scar.' + CAST(scar."codice filiale" as varchar(12)))

where
	ce.Grupo = 'Principal'

--Loja Endereço (storicocarrello)
insert into Optisoul..DocumentoEndereco
	(Descricao, CodigoDocumento, CodigoContatoEndereco, CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais)
select
	COALESCE(ce.Logradouro + ' - ', '')  + COALESCE(ce.Bairro + ' - ', '') + COALESCE(ce.CEP + ' - ', '') + COALESCE(ce.Municipio, '') + COALESCE('/' + ce.UF, '') as Descricao, --varchar(255) --null
	d.CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
	ce.CodigoContatoEndereco, --int --not null
	c.CodigoContato, --varchar(30) (int->varchar(30)) not null
	ce.Logradouro, --varchar(255) --null
	ce.Bairro, --varchar(255) --null
	ce.CEP, --varchar(50) --null
	ce.IbgeCod, --int --null
	ce.Municipio, --varchar(150) --null
	ce.UF, --varchar(50) --null
	ce.Pais --varchar(150) --null
	
from storicocarrello as scar
	inner join Optisoul..Contato as c
		on (c.CodigoAntigo = 'sede.' + CAST(scar."filiale" as varchar(12)))

	inner join Optisoul..ContatoEndereco as ce
		on (c.CodigoContato = ce.CodigoContato)

	inner join Optisoul..Documento as d
		on (d.idant = 'scar.' + CAST(scar."codice filiale" as varchar(12)))

where
	ce.Grupo = 'Principal'

insert into Optisoul..DocumentoEndereco
	(Descricao, CodigoDocumento, CodigoContatoEndereco, CodigoContato, Logradouro, Bairro, CEP, IbgeCod, Municipio, UF, Pais)
select
	COALESCE(ce.Logradouro + ' - ', '')  + COALESCE(ce.Bairro + ' - ', '') + COALESCE(ce.CEP + ' - ', '') + COALESCE(ce.Municipio, '') + COALESCE('/' + ce.UF, '') as Descricao, --varchar(255) --null
	d.CodigoDocumento, --varchar(30) (int->varchar(30)) --not null
	ce.CodigoContatoEndereco, --int --not null
	c.CodigoContato, --varchar(30) (int->varchar(30)) not null
	ce.Logradouro, --varchar(255) --null
	ce.Bairro, --varchar(255) --null
	ce.CEP, --varchar(50) --null
	ce.IbgeCod, --int --null
	ce.Municipio, --varchar(150) --null
	ce.UF, --varchar(50) --null
	ce.Pais --varchar(150) --null
	
from storicocarrello as scar
	inner join Optisoul..Contato as c
		on (c.CodigoAntigo = 'puntovendita.' + CAST(scar."filiale" as varchar(12)))

	inner join Optisoul..ContatoEndereco as ce
		on (c.CodigoContato = ce.CodigoContato)

	inner join Optisoul..Documento as d
		on (d.idant = 'scar.' + CAST(scar."codice filiale" as varchar(12)))

where
	ce.Grupo = 'Principal'
