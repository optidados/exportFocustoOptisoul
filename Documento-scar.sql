--Tabela Documento (carrello)
insert into Documento
(
	/*venda - STORICOCARRELLO*/
	select
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --int
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Venda' as Tipo, --varchar(255) --null
		CAST(NULL as varchar) as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		'Venda de Mercadoria' as Operacao, --varchar(255) --null
		'Aguardando Faturamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		COALESCE(matriz."Nome", filial."Nome") as DescricaoEmpresa, --varchar(255) --null
		COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
		COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
		COALESCE(matrizEnd."IbgeCod", filialEnd."IbgeCod") as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		cliente."CodigoAntigo" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		cliente."Nome" as DescricaoContato, --varchar(255) --null
		cliente."NumeroDocumentoNacional" as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		MAX(clienteTel."Telefone") as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		(COALESCE(clienteEnd."Logradouro", '') +(CASE WHEN(clienteEnd."Numero" <> '') THEN(', ') ELSE('') END)+ TRIM(COALESCE(clienteEnd."Numero", '')) +' '+ COALESCE(clienteEnd."Bairro", '') +' '+ COALESCE(clienteEnd."Municipio", '') +'-'+ COALESCE(clienteEnd."UF", '') +' '+ COALESCE(clienteEnd."CEP", '')) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		scar."data" as DataHoraEmissao, --datetime (date) --null
		scar2."data pagamento" as DataHoraFinalizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		1 as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		7 as CodigoContatoVendedor, --int --null
		1 as CodigoContatoDigitador, --int --null
		CAST(NULL as int) as CodigoContatoCobranca, --int --null
		CAST(NULL as int) as CodigoContatoEnderecoEntrega, --int --null
		CAST(NULL as varchar) as DescricaoContatoEnderecoEntrega, --varchar(8000) --null
		'CIF' as TipoFrete, --varchar(3) --null
		CAST(NULL as varchar) as TipoTransporte, --varchar(20) --null
		CAST(NULL as int) as CodigoContatoTransportadora, --int --null
		0 as NumeroVolumeTransporte, --int --null
		CAST(NULL as decimal(18,4)) as PesoTotalTransporte, --decimal(18,4) --null
		CAST(NULL as int) as CodigoMinuta, --int --null
		CAST(NULL as varchar) as CondicaoPagamento, --varchar(50) --null
		CAST(NULL as int) as PrazoMedio, --int --null
		CAST(NULL as varchar) as FormadePagamento, --varchar(100) --null
		CAST(NULL as int) as CodigoFatura, --int --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaFaturamento, --int --null
		CAST(scar."totale" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		CAST(scar."prezzo" as decimal(18,4)) as SubTotalProduto, --decimal(18,4) --null
		CAST(scar."sconto" as decimal(18,4)) as ValorDescontoProduto, --decimal(18,4) --null
		CAST(scar."sconto percentuale" as decimal(18,4)) as PercentualDescontoProduto, --decimal(18,4) --null
		CAST(scar."totale" as decimal(18,4)) as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		0.0000 as TotalDesconto, --decimal(18,4) --null
		0.0000 as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(NULL as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
		0.0000 as TotalTroco, --decimal(18,4) --null
		0.0000 as TotalCustoUltimo, --decimal(18,4) --null
		0.0000 as TotalCustoMedio, --decimal(18,4) --null
		0.0000 as TotalCustoTerceiro, --decimal(18,4) --null
		0.0000 as TotalCustoReposicao, --decimal(18,4) --null
		CAST(NULL as varchar) as NumeroOrdemCompra, --varchar(50) --null
		CAST(NULL as varchar) as NumeroPedidoVendaFornecedor, --varchar(50) --null
		CAST(NULL as varchar) as PalavraChave, --varchar(100) --null
		CAST(NULL as int) as ProvisaoCompra, --int --null
		'Sim' as CalcularAutomatico, --varchar(3) --null
		0.0000 as ValorBaseIcms, --decimal(18,4) --null
		0.0000 as ValorIcms, --decimal(18,4) --null
		0.0000 as ValorBaseIcmsSt, --decimal(18,4) --null
		0.0000 as ValorIcmsSt, --decimal(18,4) --null
		CAST(NULL as varchar) as DocumentoCodigo, --varchar(100) --null
		CAST(NULL as varchar) as DocumentoTipo, --varchar(100) --null
		CAST(NULL as varchar) as NaturezaOperacao, --varchar(255) --null
		CAST(NULL as date) as DataCompra, --date --null
		CAST(NULL as varchar) as MotivoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as ObservacaoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as CalculoAcabado, --varchar(8000) --null
		CAST(NULL as varchar) as CalculoEnvasado, --varchar(8000) --null
		0 as CodigoItemTabelaPreco, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(100) --null
		CAST(NULL as int) as CodigoDocumentoMobile, --bigint --null
		CAST(NULL as varchar) as CRMContatoStatus, --varchar(100) --null
		CAST(NULL as int) as idant, --int --null
		CAST(NULL as int) as pedidoANT, --int --null
		CAST(NULL as int) as DuplicataAnt, --int --null
		CAST(NULL as varchar) as OrdemAnt, --varchar(50) --null
		CAST(NULL as int) as clienteAnt, --int --null
		CAST(NULL as date) as emissaoANt, --date --null
		CAST(NULL as int) as empresaAnt, --int --null
		CAST(NULL as int) as CodigoContatoResponsavelMinuta, --int --null
		CAST(NULL as varchar) as DocumentoNotaPaulista, --varchar(50) --null
		CAST(NULL as varchar) as NomeNotaPaulista, --varchar(255) --null
		CAST(NULL as int) as CodigoCaixa, --int --null
		CAST(NULL as decimal(18,4)) as ValorAbertura, --decimal(18,4) --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaCaixa, --int --null
		0 as TransferenciaCaixa --int --null

	from storicocarrello as scar
		left join storicocarrello2 as scar2
		on (scar."codice filiale" = scar2."codice carrello")

		left join busta as b
		on (scar2."codice fornitura" = b."codice filiale")

		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join ContatoEndereco as matrizEnd
		on (matriz."CodigoAntigo" = matrizEnd."CodigoContato")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

		left join ContatoEndereco as filialEnd
		on (filial."CodigoAntigo" = filialEnd."CodigoContato")

		left join Contato as cliente
		on (('clienti.' + scar."codice cliente") = cliente."CodigoAntigo")

		left join ContatoEndereco as clienteEnd
		on (cliente."CodigoAntigo" = clienteEnd."CodigoContato") 

		left join ContatoTelefone as clienteTel
		on (cliente."CodigoAntigo" = clienteTel."CodigoContato")

	group by
		scar."codice filiale",
		matriz."CodigoAntigo",
		filial."CodigoAntigo",
		matriz."Nome",
		filial."Nome",
		matriz."NumeroDocumentoNacional",
		filial."NumeroDocumentoNacional",
		matriz."NumeroDocumentoMunicipal",
		filial."NumeroDocumentoMunicipal",
		matrizEnd."IbgeCod",
		filialEnd."IbgeCod",
		cliente."CodigoAntigo",
		cliente."Nome",
		cliente."NumeroDocumentoNacional",
		clienteEnd."Logradouro",
		clienteEnd."Numero",
		clienteEnd."Bairro",
		clienteEnd."Municipio",
		clienteEnd."UF",
		clienteEnd."CEP",
		scar."data",
		scar2."data pagamento",
		scar."totale",
		scar."prezzo",
		scar."sconto",
		scar."sconto percentuale"


	UNION


	/*Item venda - STORICOCARRELLO*/
	select
		'item.scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(20) (int->varchar(20))
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Item Venda' as Tipo, --varchar(255) --null
		scar."descrizione" as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		'Óculos de Grau' as Operacao, --varchar(255) --null
		'Orçamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		COALESCE(matriz."Nome", filial."Nome") as DescricaoEmpresa, --varchar(255) --null
		COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
		COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
		COALESCE(matrizEnd."IbgeCod", filialEnd."IbgeCod") as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		cliente."CodigoAntigo" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		cliente."Nome" as DescricaoContato, --varchar(255) --null
		cliente."NumeroDocumentoNacional" as NumeroDocumentoContato, --varchar(150) --null
		cliente."Email" as EmailContato, --varchar(100)-> varchar(255) --null
		MAX(clienteTel."Telefone") as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		1 as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		scar."data" as DataHoraEmissao, --datetime (date) --null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		CAST(NULL as int) as CodigoContatoVendedor, --int --null
		CAST(NULL as int) as CodigoContatoDigitador, --int --null
		CAST(NULL as int) as CodigoContatoCobranca, --int --null
		CAST(NULL as int) as CodigoContatoEnderecoEntrega, --int --null
		CAST(NULL as varchar) as DescricaoContatoEnderecoEntrega, --varchar(8000) --null
		CAST(NULL as varchar) as TipoFrete, --varchar(3) --null
		CAST(NULL as varchar) as TipoTransporte, --varchar(20) --null
		CAST(NULL as int) as CodigoContatoTransportadora, --int --null
		0 as NumeroVolumeTransporte, --int --null
		0.0000 as PesoTotalTransporte, --decimal(18,4) --null
		CAST(NULL as int) as CodigoMinuta, --int --null
		CAST(NULL as varchar) as CondicaoPagamento, --varchar(50) --null
		CAST(NULL as int) as PrazoMedio, --int --null
		CAST(NULL as varchar) as FormadePagamento, --varchar(100) --null
		CAST(NULL as int) as CodigoFatura, --int --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaFaturamento, --int --null
		CAST(scar."totale" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		0.0000 as TotalDesconto, --decimal(18,4) --null
		0.0000 as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(NULL as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
		0.0000 as TotalTroco, --decimal(18,4) --null
		0.0000 as TotalCustoUltimo, --decimal(18,4) --null
		0.0000 as TotalCustoMedio, --decimal(18,4) --null
		0.0000 as TotalCustoTerceiro, --decimal(18,4) --null
		0.0000 as TotalCustoReposicao, --decimal(18,4) --null
		CAST(NULL as varchar) as NumeroOrdemCompra, --varchar(50) --null
		CAST(NULL as varchar) as NumeroPedidoVendaFornecedor, --varchar(50) --null
		CAST(NULL as varchar) as PalavraChave, --varchar(100) --null
		CAST(NULL as int) as ProvisaoCompra, --int --null
		'Sim' as CalcularAutomatico, --varchar(3) --null
		0.0000 as ValorBaseIcms, --decimal(18,4) --null
		0.0000 as ValorIcms, --decimal(18,4) --null
		0.0000 as ValorBaseIcmsSt, --decimal(18,4) --null
		0.0000 as ValorIcmsSt, --decimal(18,4) --null
		CAST(NULL as varchar) as DocumentoCodigo, --varchar(100) --null
		CAST(NULL as varchar) as DocumentoTipo, --varchar(100) --null
		CAST(NULL as varchar) as NaturezaOperacao, --varchar(255) --null
		CAST(NULL as date) as DataCompra, --date --null
		CAST(NULL as varchar) as MotivoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as ObservacaoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as CalculoAcabado, --varchar(8000) --null
		CAST(NULL as varchar) as CalculoEnvasado, --varchar(8000) --null
		0 as CodigoItemTabelaPreco, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(100) --null
		CAST(NULL as int) as CodigoDocumentoMobile, --bigint --null
		CAST(NULL as varchar) as CRMContatoStatus, --varchar(100) --null
		CAST(NULL as int) as idant, --int --null
		CAST(NULL as int) as pedidoANT, --int --null
		CAST(NULL as int) as DuplicataAnt, --int --null
		CAST(NULL as varchar) as OrdemAnt, --varchar(50) --null
		CAST(NULL as int) as clienteAnt, --int --null
		CAST(NULL as date) as emissaoANt, --date --null
		CAST(NULL as int) as empresaAnt, --int --null
		CAST(NULL as int) as CodigoContatoResponsavelMinuta, --int --null
		CAST(NULL as varchar) as DocumentoNotaPaulista, --varchar(50) --null
		CAST(NULL as varchar) as NomeNotaPaulista, --varchar(255) --null
		CAST(NULL as int) as CodigoCaixa, --int --null
		CAST(NULL as decimal(18,4)) as ValorAbertura, --decimal(18,4) --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaCaixa, --int --null
		0 as TransferenciaCaixa --int --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")

		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

		left join ContatoEndereco as matrizEnd
		on (matriz."CodigoAntigo" = matrizEnd."CodigoContato")

		left join ContatoEndereco as filialEnd
		on (filial."CodigoAntigo" = filialEnd."CodigoContato")

		left join Contato as cliente
		on (('clienti.' + scar."codice cliente") = cliente."CodigoAntigo")

		left join ContatoTelefone as clienteTel
		on (cliente."CodigoAntigo" = clienteTel."CodigoContato")

	group by
		scar."codice filiale",
		scar."descrizione",
		matriz."CodigoAntigo",
		filial."CodigoAntigo",
		matriz."Nome",
		filial."Nome",
		matriz."NumeroDocumentoNacional",
		filial."NumeroDocumentoNacional",
		matriz."NumeroDocumentoMunicipal",
		filial."NumeroDocumentoMunicipal",
		matrizEnd."IbgeCod",
		filialEnd."IbgeCod",
		cliente."CodigoAntigo",
		cliente."Nome",
		cliente."NumeroDocumentoNacional",
		cliente."Email",
		scar."data",
		scar."totale"


	UNION


	/*Prescrição - STORICOCARRELLO*/
	select
		'presc.scar.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(20) (int->varchar(20))
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Prescrição' as Tipo, --varchar(255) --null
		CAST(NULL as varchar) as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		'Prescrição' as Operacao, --varchar(255) --null
		CAST(NULL as varchar) as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		COALESCE(matriz."Nome", filial."Nome") as DescricaoEmpresa, --varchar(255) --null
		COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
		COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
		COALESCE(matrizEnd."IbgeCod", filialEnd."IbgeCod") as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		cliente."CodigoAntigo" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		cliente."Nome" as DescricaoContato, --varchar(255) --null
		cliente."NumeroDocumentoNacional" as NumeroDocumentoContato, --varchar(150) --null
		cliente."Email" as EmailContato, --varchar(100)-> varchar(255) --null
		MAX(clienteTel."Telefone") as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		1 as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		oc."data" as DataHoraEmissao, --datetime (date) --null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		CAST(NULL as int) as CodigoContatoVendedor, --int --null
		CAST(NULL as int) as CodigoContatoDigitador, --int --null
		CAST(NULL as int) as CodigoContatoCobranca, --int --null
		CAST(NULL as int) as CodigoContatoEnderecoEntrega, --int --null
		CAST(NULL as varchar) as DescricaoContatoEnderecoEntrega, --varchar(8000) --null
		CAST(NULL as varchar) as TipoFrete, --varchar(3) --null
		CAST(NULL as varchar) as TipoTransporte, --varchar(20) --null
		CAST(NULL as int) as CodigoContatoTransportadora, --int --null
		0 as NumeroVolumeTransporte, --int --null
		0.0000 as PesoTotalTransporte, --decimal(18,4) --null
		CAST(NULL as int) as CodigoMinuta, --int --null
		CAST(NULL as varchar) as CondicaoPagamento, --varchar(50) --null
		CAST(NULL as int) as PrazoMedio, --int --null
		CAST(NULL as varchar) as FormadePagamento, --varchar(100) --null
		CAST(NULL as int) as CodigoFatura, --int --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaFaturamento, --int --null
		0.0000 as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		0.0000 as TotalDesconto, --decimal(18,4) --null
		0.0000 as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		0.0000 as TotalDocumento, --decimal(18,4) --null
		0.0000 as TotalTroco, --decimal(18,4) --null
		0.0000 as TotalCustoUltimo, --decimal(18,4) --null
		0.0000 as TotalCustoMedio, --decimal(18,4) --null
		0.0000 as TotalCustoTerceiro, --decimal(18,4) --null
		0.0000 as TotalCustoReposicao, --decimal(18,4) --null
		CAST(NULL as varchar) as NumeroOrdemCompra, --varchar(50) --null
		CAST(NULL as varchar) as NumeroPedidoVendaFornecedor, --varchar(50) --null
		CAST(NULL as varchar) as PalavraChave, --varchar(100) --null
		CAST(NULL as int) as ProvisaoCompra, --int --null
		'Sim' as CalcularAutomatico, --varchar(3) --null
		0.0000 as ValorBaseIcms, --decimal(18,4) --null
		0.0000 as ValorIcms, --decimal(18,4) --null
		0.0000 as ValorBaseIcmsSt, --decimal(18,4) --null
		0.0000 as ValorIcmsSt, --decimal(18,4) --null
		'7' as DocumentoCodigo, --varchar(100) --null
		'Venda' as DocumentoTipo, --varchar(100) --null
		CAST(NULL as varchar) as NaturezaOperacao, --varchar(255) --null
		CAST(NULL as date) as DataCompra, --date --null
		CAST(NULL as varchar) as MotivoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as ObservacaoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as CalculoAcabado, --varchar(8000) --null
		CAST(NULL as varchar) as CalculoEnvasado, --varchar(8000) --null
		0 as CodigoItemTabelaPreco, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(100) --null
		CAST(NULL as int) as CodigoDocumentoMobile, --bigint --null
		CAST(NULL as varchar) as CRMContatoStatus, --varchar(100) --null
		CAST(NULL as int) as idant, --int --null
		CAST(NULL as int) as pedidoANT, --int --null
		CAST(NULL as int) as DuplicataAnt, --int --null
		CAST(NULL as varchar) as OrdemAnt, --varchar(50) --null
		CAST(NULL as int) as clienteAnt, --int --null
		CAST(NULL as date) as emissaoANt, --date --null
		CAST(NULL as int) as empresaAnt, --int --null
		CAST(NULL as int) as CodigoContatoResponsavelMinuta, --int --null
		CAST(NULL as varchar) as DocumentoNotaPaulista, --varchar(50) --null
		CAST(NULL as varchar) as NomeNotaPaulista, --varchar(255) --null
		CAST(NULL as int) as CodigoCaixa, --int --null
		CAST(NULL as decimal(18,4)) as ValorAbertura, --decimal(18,4) --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaCaixa, --int --null
		0 as TransferenciaCaixa --int --null

	from carrello as car
		left join busta as b
		on (b."codice filiale" = car."codice fornitura")

		left join occhiali as oc
		on ( oc."codice cliente" = b."codice cliente" )

		left join Contato as matriz
		on (('sede.' + car."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

		left join ContatoEndereco as matrizEnd
		on (matriz."CodigoAntigo" = matrizEnd."CodigoContato")

		left join ContatoEndereco as filialEnd
		on (filial."CodigoAntigo" = filialEnd."CodigoContato")

		left join Contato as cliente
		on (('clienti.' + car."codice cliente") = cliente."CodigoAntigo")

		left join ContatoTelefone as clienteTel
		on (cliente."CodigoAntigo" = clienteTel."CodigoContato")

	where
		(CAST(b."data" as integer) - CAST(oc."data" as integer) >= 0)

	group by
		oc."codice filiale",
		matriz."CodigoAntigo",
		filial."CodigoAntigo",
		matriz."Nome",
		filial."Nome",
		matriz."NumeroDocumentoNacional",
		filial."NumeroDocumentoNacional",
		matriz."NumeroDocumentoMunicipal",
		filial."NumeroDocumentoMunicipal",
		matrizEnd."IbgeCod",
		filialEnd."IbgeCod",
		cliente."CodigoAntigo",
		cliente."Nome",
		cliente."NumeroDocumentoNacional",
		cliente."Email",
		oc."data"


	UNION


	/*venda - STORICOCARRELLO*/
	select
		'busta.scar.' + CAST(b."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
		'item.scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Envelope' as Tipo, --varchar(255) --null
		CAST(NULL as varchar) as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		'Normal' as Operacao, --varchar(255) --null
		'Aguardando Envio' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		COALESCE(matriz."Nome", filial."Nome") as DescricaoEmpresa, --varchar(255) --null
		COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
		COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
		COALESCE(matrizEnd."IbgeCod", filialEnd."IbgeCod") as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		CAST(NULL as varchar) as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		7 as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		b."data" as DataHoraEmissao, --datetime (date) --null
		b."data consegna" as DataHoraFinalizado, --datetime (date) --null
		b."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		CAST(NULL as int) as CodigoContatoVendedor, --int --null
		CAST(NULL as int) as CodigoContatoDigitador, --int --null
		CAST(NULL as int) as CodigoContatoCobranca, --int --null
		CAST(NULL as int) as CodigoContatoEnderecoEntrega, --int --null
		CAST(NULL as varchar) as DescricaoContatoEnderecoEntrega, --varchar(8000) --null
		CAST(NULL as varchar) as TipoFrete, --varchar(3) --null
		CAST(NULL as varchar) as TipoTransporte, --varchar(20) --null
		CAST(NULL as int) as CodigoContatoTransportadora, --int --null
		0 as NumeroVolumeTransporte, --int --null
		0.0000 as PesoTotalTransporte, --decimal(18,4) --null
		CAST(NULL as int) as CodigoMinuta, --int --null
		CAST(NULL as varchar) as CondicaoPagamento, --varchar(50) --null
		CAST(NULL as int) as PrazoMedio, --int --null
		CAST(NULL as varchar) as FormadePagamento, --varchar(100) --null
		CAST(NULL as int) as CodigoFatura, --int --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaFaturamento, --int --null
		0.0000 as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		0.0000 as TotalDesconto, --decimal(18,4) --null
		0.0000 as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		0.0000 as TotalDocumento, --decimal(18,4) --null
		0.0000 as TotalTroco, --decimal(18,4) --null
		0.0000 as TotalCustoUltimo, --decimal(18,4) --null
		0.0000 as TotalCustoMedio, --decimal(18,4) --null
		0.0000 as TotalCustoTerceiro, --decimal(18,4) --null
		0.0000 as TotalCustoReposicao, --decimal(18,4) --null
		CAST(NULL as varchar) as NumeroOrdemCompra, --varchar(50) --null
		CAST(NULL as varchar) as NumeroPedidoVendaFornecedor, --varchar(50) --null
		CAST(NULL as varchar) as PalavraChave, --varchar(100) --null
		CAST(NULL as int) as ProvisaoCompra, --int --null
		'Sim' as CalcularAutomatico, --varchar(3) --null
		0.0000 as ValorBaseIcms, --decimal(18,4) --null
		0.0000 as ValorIcms, --decimal(18,4) --null
		0.0000 as ValorBaseIcmsSt, --decimal(18,4) --null
		0.0000 as ValorIcmsSt, --decimal(18,4) --null
		CAST(NULL as varchar) as DocumentoCodigo, --varchar(100) --null
		CAST(NULL as varchar) as DocumentoTipo, --varchar(100) --null
		CAST(NULL as varchar) as NaturezaOperacao, --varchar(255) --null
		CAST(NULL as date) as DataCompra, --date --null
		CAST(NULL as varchar) as MotivoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as ObservacaoCancelamento, --varchar(255) --null
		CAST(NULL as varchar) as CalculoAcabado, --varchar(8000) --null
		CAST(NULL as varchar) as CalculoEnvasado, --varchar(8000) --null
		0 as CodigoItemTabelaPreco, --int --null
		CAST(NULL as varchar) as CodigoAntigo, --varchar(100) --null
		CAST(NULL as int) as CodigoDocumentoMobile, --bigint --null
		CAST(NULL as varchar) as CRMContatoStatus, --varchar(100) --null
		CAST(NULL as int) as idant, --int --null
		CAST(NULL as int) as pedidoANT, --int --null
		CAST(NULL as int) as DuplicataAnt, --int --null
		CAST(NULL as varchar) as OrdemAnt, --varchar(50) --null
		CAST(NULL as int) as clienteAnt, --int --null
		CAST(NULL as date) as emissaoANt, --date --null
		CAST(NULL as int) as empresaAnt, --int --null
		CAST(NULL as int) as CodigoContatoResponsavelMinuta, --int --null
		CAST(NULL as varchar) as DocumentoNotaPaulista, --varchar(50) --null
		CAST(NULL as varchar) as NomeNotaPaulista, --varchar(255) --null
		CAST(NULL as int) as CodigoCaixa, --int --null
		CAST(NULL as decimal(18,4)) as ValorAbertura, --decimal(18,4) --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaCaixa, --int --null
		0 as TransferenciaCaixa --int --null

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")

		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

		left join ContatoEndereco as matrizEnd
		on (matriz."CodigoAntigo" = matrizEnd."CodigoContato")

		left join ContatoEndereco as filialEnd
		on (filial."CodigoAntigo" = filialEnd."CodigoContato")

	group by
		b."codice filiale",
		scar."codice filiale",
		matriz."CodigoAntigo",
		filial."CodigoAntigo",
		matriz."Nome",
		filial."Nome",
		matriz."NumeroDocumentoNacional",
		filial."NumeroDocumentoNacional",
		matriz."NumeroDocumentoMunicipal",
		filial."NumeroDocumentoMunicipal",
		matrizEnd."IbgeCod",
		filialEnd."IbgeCod",
		b."data",
		b."data consegna",
		b."data prevista consegna"
);