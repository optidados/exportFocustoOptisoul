--Create table documento (tabela principal)
drop table if exists documento;
create table documento
(
	CodigoDocumento	varchar(200), --not null
	CodigoDocumentoAdicional int, --null
	CodigoNFe int, --null
	Numero int, --null
	NotaNumero int, --null
	NotaSerie varchar(10), --null
	Revisao	int, --null
	Tipo varchar(255), --not null
	Descricao varchar(255), --null
	CodigoDocumentoOperacao	int, --null
	Operacao varchar(255), --null
	Status varchar(255), --null
	CodigoEmpresa varchar(200), --not null (int -> varchar(200))
	DescricaoEmpresa varchar(255), --null
	NumeroDocumentoEmpresa varchar(150), --null
	InscricaoMunicipalEmpresa varchar(150), --null
	CodigoMunicipioEmpresa varchar(40), --null
	OptanteSimplesNacional int, --not null [bit] --> int
	CodigoEmpresaEndereco int, --null
	CodigoContato varchar(255), --not null
	DescricaoContato varchar(255), --null
	NumeroDocumentoContato varchar(150), --null
	EmailContato varchar(255), --varchar(100)-> varchar(255) --null
	TelefoneContato	varchar(50), --varchar(30)-> varchar(50) --null
	RegimeContato varchar(100), --null
	CodigoContatoEndereco int, --null
	DescricaoContatoEndereco varchar(8000), --null [varchar(max)]--> varchar(8000)
	CodigoContatoResponsavel int, --null
	ContatoResponsavelEmail varchar(255), --null
	DataHoraEmissao	date, --datetime->date --null
	DataHoraFinalizado date, --datetime->date --null
	DataHoraPrevisto date, --datetime->date --null
	DataHoraRealizado date, --datetime->date --null
	DataHoraAvisado	date, --datetime->date --null
	CodigoContatoFinalizado	int, --null
	Observacao varchar(8000), --null [varchar(max)]--> varchar(8000)
	ObservacaoInterna varchar(8000), --null [varchar(max)]--> varchar(8000)
	ObservacaoEntrega varchar(150), --null
	ObservacaoFaturamento varchar(150), --null
	CodigoContatoComprador int, --null
	CodigoContatoVendedor int, --null
	CodigoContatoDigitador int, --null
	CodigoContatoCobranca int, --null
	CodigoContatoEnderecoEntrega int, --null
	DescricaoContatoEnderecoEntrega	varchar(170), --null [varchar(max)]--> varchar(8000)
	TipoFrete varchar(3), --null
	TipoTransporte varchar(20), --null
	CodigoContatoTransportadora	int, --null
	NumeroVolumeTransporte int, --null
	PesoTotalTransporte	decimal(18,4), --null
	CodigoMinuta int, --null
	CondicaoPagamento varchar(50), --null
	PrazoMedio int, --null
	FormadePagamento varchar(100), --null
	CodigoFatura int, --null
	CodigoFinanceiroPlanoContaFaturamento int, --null
	SubTotal decimal(18,4), --null
	SubTotalProduto	decimal(18,4), --null
	ValorDescontoProduto decimal(18,4), --null
	PercentualDescontoProduto decimal(18,4), --null
	TotalProduto decimal(18,4), --null
	SubTotalServico	decimal(18,4), --null
	ValorDescontoServico decimal(18,4), --null
	PercentualDescontoServico decimal(18,4), --null
	TotalServico decimal(18,4), --null
	TotalDesconto decimal(18,4), --null
	TotalPercentualDesconto	decimal(18,4), --null
	TotalOutroAbatimento decimal(18,4), --null
	TotalPercentualOutroAbatimento decimal(18,4), --null
	ValorFrete decimal(18,4), --null
	FreteSeparado int, --null [bit]--> int
	ValorSeguro decimal(18,4), --null
	ValorOutrasDespesas	decimal(18,4), --null
	ValorIPI decimal(18,4), --null
	TotalDocumento decimal(18,4), --null
	TotalTroco decimal(18,4), --null
	TotalCustoUltimo decimal(18,4), --null
	TotalCustoMedio	decimal(18,4), --null
	TotalCustoTerceiro decimal(18,4), --null
	TotalCustoReposicao decimal(18,4), --null
	NumeroOrdemCompra varchar(50), --null
	NumeroPedidoVendaFornecedor	varchar(50), --null
	PalavraChave varchar(100), --null
	ProvisaoCompra int, --null [bit]--> int
	CalcularAutomatico varchar(3), --null
	ValorBaseIcms decimal(18,4), --null
	ValorIcms decimal(18,4), --null
	ValorBaseIcmsSt	decimal(18,4), --null
	ValorIcmsSt	decimal(18,4), --null
	DocumentoCodigo	varchar(100), --null
	DocumentoTipo varchar(100), --null
	NaturezaOperacao varchar(255), --null
	DataCompra date, --null
	MotivoCancelamento varchar(255), --null
	ObservacaoCancelamento varchar(255), --null
	CalculoAcabado varchar(8000), --null [varchar(max)]--> varchar(8000)
	CalculoEnvasado	varchar(8000), --null [varchar(max)]--> varchar(8000)
	CodigoItemTabelaPreco int, --null
	CodigoAntigo varchar(255), --null
	CodigoDocumentoMobile int, --null
	CRMContatoStatus varchar(100), --null
	idant int, --null
	pedidoANT int, --null
	DuplicataAnt int, --null
	OrdemAnt varchar(50), --null
	clienteAnt int, --null
	emissaoANt date, --null
	empresaAnt int, --null
	CodigoContatoResponsavelMinuta int, --null
	DocumentoNotaPaulista varchar(50), --null
	NomeNotaPaulista varchar(255), --null
	CodigoCaixa int, --null
	ValorAbertura decimal(18,4), --null
	CodigoFinanceiroPlanoContaCaixa	int, --null
	TransferenciaCaixa int --null [bit]--> int
);



--Tipo Venda (carrello) quem vai pagar pela Venda, se tiver titular, puxar o titular?
insert into Documento
(
	select
		'car.' + car."codice filiale" as CodigoDocumento, --varchar(12)
		CAST(NULL as int) as CodigoDocumentoAdicional, --int
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar(10)) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Venda' as Tipo, --varchar(255) --null
		CAST(NULL as varchar(255)) as Descricao, --varchar(255) --null 
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
		cliente."Email" as EmailContato, --varchar(100)-> varchar(255) --null
		MAX(clienteTel."Telefone") as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar(100)) as RegimeContato, --varchar(100) --null
CAST(NULL as int) as CodigoContatoEndereco, --int --null
		(COALESCE(clienteEnd."Logradouro", '') +(CASE WHEN(clienteEnd."Numero" <> '') THEN(', ') ELSE('') END)+ TRIM(COALESCE(clienteEnd."Numero", '')) +' '+ COALESCE(clienteEnd."Bairro", '') +' '+ COALESCE(clienteEnd."Municipio", '') +'-'+ COALESCE(clienteEnd."UF", '') +' '+ COALESCE(clienteEnd."CEP", '')) as DescricaoContatoEndereco, --varchar(170) --null
CAST(NULL as int) as CodigoContatoResponsavel, --int --null
CAST(NULL as varchar(255)) as ContatoResponsavelEmail, --varchar(255) --null
		car."data" as DataHoraEmissao, --datetime (date) --null
		car2."data pagamento" as DataHoraFinalizado, --datetime (date) --null
		b."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		cliente."Observacao" as Observacao, --varchar(8000) --null
		cliente."ObservacaoConsulta" as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar(150)) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar(150)) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
CAST(NULL as int) as CodigoContatoVendedor, --int --null
CAST(NULL as int) as CodigoContatoDigitador, --int --null
		CAST(NULL as int) as CodigoContatoCobranca, --int --null
		CAST(NULL as int) as CodigoContatoEnderecoEntrega, --int --null
		CAST(NULL as varchar(8000)) as DescricaoContatoEnderecoEntrega, --varchar(8000) --null
		'CIF' as TipoFrete, --varchar(3) --null
		CAST(NULL as varchar(20)) as TipoTransporte, --varchar(20) --null
		CAST(NULL as int) as CodigoContatoTransportadora, --int --null
		0 as NumeroVolumeTransporte, --int --null
		CAST(NULL as decimal(18,4)) as PesoTotalTransporte, --decimal(18,4) --null
		CAST(NULL as int) as CodigoMinuta, --int --null
		CAST(NULL as varchar(50)) as CondicaoPagamento, --varchar(50) --null
		CAST(NULL as int) as PrazoMedio, --int --null
		CAST(NULL as varchar(100)) as FormadePagamento, --varchar(100) --null
		CAST(NULL as int) as CodigoFatura, --int --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaFaturamento, --int --null
		CAST(car."totale" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		CAST(car."prezzo" as decimal(18,4)) as SubTotalProduto, --decimal(18,4) --null
		CAST(car."sconto" as decimal(18,4)) as ValorDescontoProduto, --decimal(18,4) --null
		CAST(car."sconto percentuale" as decimal(18,4)) as PercentualDescontoProduto, --decimal(18,4) --null
		CAST(car."totale" as decimal(18,4)) as TotalProduto, --decimal(18,4) --null
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
		CAST(NULL as varchar(50)) as NumeroOrdemCompra, --varchar(50) --null
		CAST(NULL as varchar(50)) as NumeroPedidoVendaFornecedor, --varchar(50) --null
		CAST(NULL as varchar(100)) as PalavraChave, --varchar(100) --null
		CAST(NULL as int) as ProvisaoCompra, --int --null
		'Sim' as CalcularAutomatico, --varchar(3) --null
		0.0000 as ValorBaseIcms, --decimal(18,4) --null
		0.0000 as ValorIcms, --decimal(18,4) --null
		0.0000 as ValorBaseIcmsSt, --decimal(18,4) --null
		0.0000 as ValorIcmsSt, --decimal(18,4) --null
		CAST(NULL as varchar(100)) as DocumentoCodigo, --varchar(100) --null
		CAST(NULL as varchar(100)) as DocumentoTipo, --varchar(100) --null
		CAST(NULL as varchar(255)) as NaturezaOperacao, --varchar(255) --null
		CAST(NULL as date) as DataCompra, --date --null
		CAST(NULL as varchar(255)) as MotivoCancelamento, --varchar(255) --null
		CAST(NULL as varchar(255)) as ObservacaoCancelamento, --varchar(255) --null
		CAST(NULL as varchar(8000)) as CalculoAcabado, --varchar(8000) --null
		CAST(NULL as varchar(8000)) as CalculoEnvasado, --varchar(8000) --null
		0 as CodigoItemTabelaPreco, --int --null
		CAST(NULL as varchar(255)) as CodigoAntigo, --varchar(100) --null
		CAST(NULL as int) as CodigoDocumentoMobile, --bigint --null
		CAST(NULL as varchar(100)) as CRMContatoStatus, --varchar(100) --null
		CAST(NULL as int) as idant, --int --null
		CAST(NULL as int) as pedidoANT, --int --null
		CAST(NULL as int) as DuplicataAnt, --int --null
		CAST(NULL as varchar(50)) as OrdemAnt, --varchar(50) --null
		CAST(NULL as int) as clienteAnt, --int --null
		CAST(NULL as date) as emissaoANt, --date --null
		CAST(NULL as int) as empresaAnt, --int --null
		CAST(NULL as int) as CodigoContatoResponsavelMinuta, --int --null
		CAST(NULL as varchar(50)) as DocumentoNotaPaulista, --varchar(50) --null
		CAST(NULL as varchar(255)) as NomeNotaPaulista, --varchar(255) --null
		CAST(NULL as int) as CodigoCaixa, --int --null
		CAST(NULL as decimal(18,4)) as ValorAbertura, --decimal(18,4) --null
		CAST(NULL as int) as CodigoFinanceiroPlanoContaCaixa, --int --null
		0 as TransferenciaCaixa --int --null

	from carrello as car
		left join carrello2 as car2
		on (car."codice filiale" = car2."codice carrello")

		left join busta as b
		on (b."codice filiale" = car2."codice fornitura")

		left join Contato as matriz
		on (('sede.' + car."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

		left join ContatoEndereco as matrizEnd
		on (('sede.' + car."filiale") = matrizEnd."CodigoContato")

		left join ContatoEndereco as filialEnd
		on (('puntovendita.' + car."filiale") = filialEnd."CodigoContato")

		left join Contato as cliente
		on (('clienti.' + car."codice cliente") = cliente."CodigoAntigo")

		left join ContatoEndereco as clienteEnd
		on (('clienti.' + car."codice cliente") = clienteEnd."CodigoContato")

		left join ContatoTelefone as clienteTel
		on (('clienti.' + car."codice cliente") = clienteTel."CodigoContato")
);
