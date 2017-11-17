/*
ATUALIZA OS CAMPOS DE CADASTRO DA TABELA DOCUMENTO
GEEKS, FAVOR REVISAR
*/
--DOCUMENTO TIPO = VENDA, DEVOLUÇÃO
update Documento
set
	CodigoMunicipioEmpresa = 
	(
		select ContatoEndereco."IbgeCod"
		from ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoEmpresa" and
			ContatoEndereco."Grupo" = 'Principal'
	),
	CodigoEmpresaEndereco =
	(
		select ContatoEndereco."CodigoContatoEndereco"
		from ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoEmpresa" and
			ContatoEndereco."Grupo" = 'Principal'
	),
	DescricaoContato =
	(
		select Contato."Nome"
		from Contato
		where
			Contato."CodigoAntigo" = Documento."CodigoContato"
	),
	NumeroDocumentoContato =
	(
		select Contato."NumeroDocumentoNacional"
		from Contato
		where
			Contato."CodigoAntigo" = Documento."CodigoContato"
	),
	EmailContato =
	(
		select Contato."EmailNFe"
		from Contato
		where
			Contato."CodigoAntigo" = Documento."CodigoContato"
	),
	TelefoneContato =
	(
		select ContatoTelefone."NumeroDocumentoNacional"
		from ContatoTelefone
		where
			ContatoTelefone."CodigoContato" = Documento."CodigoContato" and
			ContatoTelefone."TipoTelefone" = 'Principal'
	),
	CodigoContatoEndereco =
	(
		select ContatoEndereco."CodigoContatoEndereco"
		from ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoContato" and
			ContatoEndereco."Grupo" = 'Principal'
	),
	DescricaoContatoEndereco =
	(
		select COALESCE(ContatoEndereco."Logradouro" + ' - ', '')  + COALESCE(ContatoEndereco."Bairro" + ' - ', '') + COALESCE(ContatoEndereco."CEP" + ' - ', '') + COALESCE(ContatoEndereco."Cidade", '') + COALESCE('/' + ContatoEndereco."UF", '')
		from ContatoEndereco
		where
			ContatoEndereco."CodigoContatoEndereco" = Documento."CodigoContatoEndereco"
	)
where
	Tipo IN ('Venda', 'Devolução');

--DOCUMENTO TIPO = ITEM VENDA, PRESCRIÇÃO
update Documento
set
	CodigoEmpresaEndereco =
	(
		select ContatoEndereco."CodigoContatoEndereco"
		from ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoEmpresa" and
			ContatoEndereco."Grupo" = 'Principal'
	),
	DescricaoContato =
	(
		select Contato."Nome"
		from Contato
		where
			Contato."CodigoAntigo" = Documento."CodigoContato"
	),
	NumeroDocumentoContato =
	(
		select Contato."NumeroDocumentoNacional"
		from Contato
		where
			Contato."CodigoAntigo" = Documento."CodigoContato"
	),
	EmailContato =
	(
		select Contato."EmailNFe"
		from Contato
		where
			Contato."CodigoAntigo" = Documento."CodigoContato"
	),
	TelefoneContato =
	(
		select ContatoTelefone."NumeroDocumentoNacional"
		from ContatoTelefone
		where
			ContatoTelefone."CodigoContato" = Documento."CodigoContato" and
			ContatoTelefone."TipoTelefone" = 'Principal'
	)
where
	Tipo IN ('Item Venda', 'Prescrição');
/*
--DOCUMENTOENDERECO
update DocumentoEndereco as de
set 
	Descricao =
	(
		select COALESCE(ce."Logradouro" + ' - ', '')  + COALESCE(ce."Bairro" + ' - ', '') + COALESCE(ce."CEP" + ' - ', '') + COALESCE(ce."Cidade", '') + COALESCE('/' + ce."UF", '')
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	CodigoContatoEndereco =
	(
		select ce."CodigoContatoEndereco"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	Logradouro =
	(
		select ce."Logradouro"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	Bairro =
	(
		select ce."Bairro"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	CEP	=
	(
		select ce."CEP"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	IbgeCod	=
	(
		select ce."IbgeCod"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	Municipio =
	(
		select ce."Municipio"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	UF =
	(
		select ce."UF"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	Pais =
	(
		select ce."Pais"
		from ContatoEndereco as ce
		where 
			ce."CodigoContato" = de."CodigoContato" and
			ce."Grupo" = 'Principal'
	),
	Grupo = 'Principal'*/