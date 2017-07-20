//NOSQLBDETOFF2
drop table if exists Documento;
create table Documento
(
	CodigoDocumento	varchar(30), --varchar(30) not null
	CodigoDocumentoAdicional varchar(30), --varchar(30) null (int->varchar(30))
	CodigoNFe int, --null
	Numero int, --null
	NotaNumero int, --null
	NotaSerie varchar, --null
	Revisao	int, --null
	Tipo varchar(255), --not null
	Descricao varchar(100), --null
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
	RegimeContato varchar, --null
	CodigoContatoEndereco int, --null
	DescricaoContatoEndereco varchar(8000), --null [varchar(max)]--> varchar(8000)
	CodigoContatoResponsavel int, --null
	ContatoResponsavelEmail varchar, --null
	DataHoraEmissao	date, --datetime->date --null
	DataHoraFinalizado date, --datetime->date --null
	DataHoraPrevisto date, --datetime->date --null
	DataHoraRealizado date, --datetime->date --null
	DataHoraAvisado	date, --datetime->date --null
	CodigoContatoFinalizado	int, --null
	Observacao varchar(8000), --null [varchar(max)]--> varchar(8000)
	ObservacaoInterna varchar, --null [varchar(max)]--> varchar(8000)
	ObservacaoEntrega varchar, --null
	ObservacaoFaturamento varchar, --null
	CodigoContatoComprador int, --null
	CodigoContatoVendedor varchar(13), --null
	CodigoContatoDigitador varchar(13), --null
	CodigoContatoCobranca int, --null
	CodigoContatoEnderecoEntrega int, --null
	DescricaoContatoEnderecoEntrega	varchar, --null [varchar(max)]--> varchar(8000)
	TipoFrete varchar(3), --null
	TipoTransporte varchar, --null
	CodigoContatoTransportadora	int, --null
	NumeroVolumeTransporte int, --null
	PesoTotalTransporte	decimal(18,4), --null
	CodigoMinuta int, --null
	CondicaoPagamento varchar, --null
	PrazoMedio int, --null
	FormadePagamento varchar, --null
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
	NumeroOrdemCompra varchar, --null
	NumeroPedidoVendaFornecedor	varchar, --null
	PalavraChave varchar, --null
	ProvisaoCompra int, --null [bit]--> int
	CalcularAutomatico varchar(3), --null
	ValorBaseIcms decimal(18,4), --null
	ValorIcms decimal(18,4), --null
	ValorBaseIcmsSt	decimal(18,4), --null
	ValorIcmsSt	decimal(18,4), --null
	DocumentoCodigo	varchar(20), --null
	DocumentoTipo varchar(5), --null
	NaturezaOperacao varchar(20), --null
	DataCompra date, --null
	MotivoCancelamento varchar, --null
	ObservacaoCancelamento varchar, --null
	CalculoAcabado varchar, --null [varchar(max)]--> varchar(8000)
	CalculoEnvasado	varchar, --null [varchar(max)]--> varchar(8000)
	CodigoItemTabelaPreco int, --null
	CodigoAntigo varchar, --null
	CodigoDocumentoMobile int, --null
	CRMContatoStatus varchar, --null
	idant int, --null
	pedidoANT int, --null
	DuplicataAnt int, --null
	OrdemAnt varchar, --null
	clienteAnt int, --null
	emissaoANt date, --null
	empresaAnt int, --null
	CodigoContatoResponsavelMinuta int, --null
	DocumentoNotaPaulista varchar, --null
	NomeNotaPaulista varchar, --null
	CodigoCaixa int, --null
	ValorAbertura decimal(18,4), --null
	CodigoFinanceiroPlanoContaCaixa	int, --null
	TransferenciaCaixa int --null [bit]--> int
);

create index CodDocIdx on Documento("CodigoDocumento");
create index CodDocAdcIdx on Documento("CodigoDocumentoAdicional");

/*venda - CARRELLO (quem vai pagar pela Venda, se tiver titular, puxar o titular)*/
insert into Documento
(
	select
		'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
		CAST(NULL as varchar) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30)) 
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
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + car."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		car."data" as DataHoraEmissao, --datetime (date) --null
		car."data" as DataHoraFinalizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		'utente.' + car."operatore" as CodigoContatoVendedor, --int --null
		'utente.' + car."operatore" as CodigoContatoDigitador, --int --null
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
		CAST(car."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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

	from carrello as car
		left join Contato as matriz
		on (('sede.' + car."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

	where
		(car."tipo fornitura" <> 100)
);

/*Item venda - CARRELLO*/
insert into Documento
(
	select
		'item.car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
		'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Item Venda' as Tipo, --varchar(255) --null
		car."descrizione" as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		CASE car."tipo fornitura"
			WHEN 0 THEN 'Outro Produto/Serviço'
			WHEN 1 THEN 'Óculos de Grau'
			WHEN 2 THEN 'Óculos de Sol'
			WHEN 3 THEN 'Óculos de Grau'
			WHEN 4 THEN 'Armação'
			WHEN 5 THEN 'Outro Produto/Serviço'
			ELSE 'Outro Produto/Serviço'
		END as Operacao, --varchar(255) --null
		'Orçamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + car."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		car."data" as DataHoraEmissao, --datetime (date) --null
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
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		CAST(car."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		CAST(car."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
		CAST(car."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(car."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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

	from carrello as car
		left join Contato as matriz
		on (('sede.' + car."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

	where
		(car."tipo fornitura" <> 100)
		and(car."tipo fornitura" <> 5) --Outro Produto/Serviço não possui registro na Documento com Tipo = Item Venda
		and(car."tipo fornitura" <> 0)
);


/*Item venda - CARRELLO2 - para itens jogados direto no carrinho*/
insert into Documento
(
	select
		'item.car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
		'car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Item Venda' as Tipo, --varchar(255) --null
		car2."descrizione" as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		CASE
			WHEN(car2."magazzino" = 0) THEN('Armação')
			WHEN(car2."magazzino" = 2) THEN('Lente de Contato Pronta')
		END as Operacao, --varchar(255) --null
		'Orçamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + car2."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		car2."data" as DataHoraEmissao, --datetime (date) --null
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
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		CAST(car2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		CAST(car2."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
		CAST(car2."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(car2."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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

	from carrello2 as car2
		left join Contato as matriz
		on (('sede.' + car2."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car2."filiale") = filial."CodigoAntigo")

	where
		(car2."tipo fornitura" = 0)
		and((car2."magazzino" = 0) or (car2."magazzino" = 2))
);

/*Devolução - CARRELLO - Item Venda*/
insert into Documento
(
	select
		'item.car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
		'car.' + CAST(dev."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Item Venda' as Tipo, --varchar(255) --null
		car."descrizione" as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		CASE car."tipo fornitura"
			WHEN 0 THEN 'Outro Produto/Serviço'
			WHEN 1 THEN 'Óculos de Grau'
			WHEN 2 THEN 'Óculos de Sol'
			WHEN 3 THEN 'Óculos de Grau'
			WHEN 4 THEN 'Armação'
			WHEN 5 THEN 'Outro Produto/Serviço'
			ELSE 'Outro Produto/Serviço'
		END as Operacao, --varchar(255) --null
		'Orçamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + car."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		car."data" as DataHoraEmissao, --datetime (date) --null
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
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		CAST(car."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		CAST(car."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
		CAST(car."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(car."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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
		'Devolução' as NaturezaOperacao, --varchar(255) --null
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
		left join Contato as matriz
		on (('sede.' + car."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

		join carrello as dev
		on (car."numero dav" = dev."numero dav")

	where
		(car."tipo fornitura" = 100) and
		(dev."tipo fornitura" <> 100) and
		(car."descrizione" = 'Devolução cliente')
);

/*Prescrição - CARRELLO*/
insert into Documento
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
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
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + car."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		oc."data" as DataHoraEmissao, --datetime (date) --null
		oc."data" as DataHoraFinalizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		MIN('item.car.' + CAST(car."codice filiale" as varchar(12))) as DocumentoCodigo, --varchar(100) --null
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

		left join occhiali as oc --ser left join aqui tem algum problema? acho que não, pois faz join com a PrescricaoEnvelope
		on (oc."codice cliente" = b."codice cliente")

		left join Contato as matriz
		on (('sede.' + car."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

		left join Contato as cliente
		on (('clienti.' + car."codice cliente") = cliente."CodigoAntigo")

		join PrescricaoEnvelope as pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."Dias" = (CAST(b."data" as integer) - CAST(oc."data" as integer))))

	where
		(car."tipo fornitura" <> 100)

	group by
		oc."codice filiale",
		matriz."CodigoAntigo",
		filial."CodigoAntigo",
		car."codice cliente",
		oc."data"
);

/*Envelope - CARRELLO*/
insert into Documento
(
	select
		'busta.' + CAST(b."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
		'item.car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
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
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		CASE b."tipo laboratorio"
			WHEN 0 THEN lab."CodigoAntigo"
			WHEN 1 THEN '' --Este caso é do lab. próprio, interno, mas não tenho como saber quem é o lab.
		END as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		b."data" as DataHoraEmissao, --datetime (date) --null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (date) --null
		b."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(b."note" as varchar(8000)) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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

	from carrello as car
		join busta as b
		on (b."codice filiale" = car."codice fornitura")

		left join Contato as matriz
		on (('sede.' + car."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

		left join Contato as lab
		on (b."laboratorio esterno" = lab."Nome")

	where
		(car."tipo fornitura" <> 100)
);

/*venda - STORICOCARRELLO*/
insert into Documento
(
	select
		'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
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
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + scar."codice cliente" as CodigoContato, --varchar(255) (int->varhscar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		scar."data" as DataHoraEmissao, --datetime (date) --null
		scar."data" as DataHoraFinalizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		'utente.' + scar."operatore" as CodigoContatoVendedor, --int --null
		'utente.' + scar."operatore" as CodigoContatoDigitador, --int --null
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
		CAST(scar."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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
		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)
);


/*Item venda - STORICOCARRELLO*/
insert into documento
(
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
		CASE scar."tipo fornitura"
			WHEN 0 THEN 'Outro Produto/Serviço'
			WHEN 1 THEN 'Óculos de Grau'
			WHEN 2 THEN 'Óculos de Sol'
			WHEN 3 THEN 'Óculos de Grau'
			WHEN 4 THEN 'Armação'
			WHEN 5 THEN 'Outro Produto/Serviço'
			ELSE 'Outro Produto/Serviço'
		END as Operacao, --varchar(255) --null
		'Orçamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + scar."codice cliente" as CodigoContato, --varchar(255) (int->varhscar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
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
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		CAST(scar."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		CAST(scar."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
		CAST(scar."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(scar."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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
		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101) and
		(scar."tipo fornitura" <> 5) and --Outro Produto/Serviço não possui registro na Documento com Tipo = Item Venda
		(scar."tipo fornitura" <> 0)
);


/*Item venda - STORICOCARRELLO2 - para Vendas direto no carrinho*/
insert into Documento
(
	select
		'item.scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
		'scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Item Venda' as Tipo, --varchar(255) --null
		scar2."descrizione" as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		CASE
			WHEN(scar2."magazzino" = 0) THEN('Armação')
			WHEN(scar2."magazzino" = 2) THEN('Lente de Contato Pronta')
		END as Operacao, --varchar(255) --null
		'Orçamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + scar2."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		scar2."data" as DataHoraEmissao, --datetime (date) --null
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
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		CAST(scar2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		CAST(scar2."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
		CAST(scar2."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(scar2."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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

	from storicocarrello2 as scar2
		left join Contato as matriz
		on (('sede.' + scar2."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar2."filiale") = filial."CodigoAntigo")

	where
		(scar2."tipo fornitura" = 0)
		and((scar2."magazzino" = 0) or (scar2."magazzino" = 2))
);

/*Devolução - Item Venda*/
insert into Documento
(
	select
		'item.scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
		'scar.' + CAST(dev."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
		CAST(NULL as int) as CodigoNFe, --int --null
		CAST(NULL as int) as Numero, --int --null
		CAST(NULL as int) as NotaNumero, --int --null
		CAST(NULL as varchar) as NotaSerie, --varchar(10) --null
		CAST(NULL as int) as Revisao, --int --null
		'Item Venda' as Tipo, --varchar(255) --null
		scar."descrizione" as Descricao, --varchar(255) --null 
		CAST(NULL as int) as CodigoDocumentoOperacao, --int --null
		CASE scar."tipo fornitura"
			WHEN 0 THEN 'Outro Produto/Serviço'
			WHEN 1 THEN 'Óculos de Grau'
			WHEN 2 THEN 'Óculos de Sol'
			WHEN 3 THEN 'Óculos de Grau'
			WHEN 4 THEN 'Armação'
			WHEN 5 THEN 'Outro Produto/Serviço'
			ELSE 'Outro Produto/Serviço'
		END as Operacao, --varchar(255) --null
		'Orçamento' as Status, --varchar(255) --null
		COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + scar."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
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
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		CAST(scar."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
		0.0000 as SubTotalProduto, --decimal(18,4) --null
		0.0000 as ValorDescontoProduto, --decimal(18,4) --null
		0.0000 as PercentualDescontoProduto, --decimal(18,4) --null
		0.0000 as TotalProduto, --decimal(18,4) --null
		0.0000 as SubTotalServico, --decimal(18,4) --null
		0.0000 as ValorDescontoServico, --decimal(18,4) --null
		0.0000 as PercentualDescontoServico, --decimal(18,4) --null
		0.0000 as TotalServico, --decimal(18,4) --null
		CAST(scar."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
		CAST(scar."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
		0.0000 as TotalOutroAbatimento, --decimal(18,4) --null
		0.0000 as TotalPercentualOutroAbatimento, --decimal(18,4) --null
		0.0000 as ValorFrete, --decimal(18,4) --null
		1 as FreteSeparado, --int --null
		0.0000 as ValorSeguro, --decimal(18,4) --null
		0.0000 as ValorOutrasDespesas, --decimal(18,4) --null
		0.0000 as ValorIPI, --decimal(18,4) --null
		CAST(scar."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
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
		'Devolução' as NaturezaOperacao, --varchar(255) --null
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
		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

		join storicocarrello as dev
		on (scar."numero dav" = dev."numero dav")

	where
		(scar."tipo fornitura" = 100) and
		(dev."tipo fornitura" <> 100) and
		(scar."descrizione" = 'Devolução cliente')
);


/*Prescrição - STORICOCARRELLO*/
insert into documento
(
	select
		'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
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
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		'cliente.' + scar."codice cliente" as CodigoContato, --varchar(255) (int->varhscar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		oc."data" as DataHoraEmissao, --datetime (date) --null
		oc."data" as DataHoraFinalizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		MIN('item.scar.' + CAST(scar."codice filiale" as varchar(12))) as DocumentoCodigo, --varchar(100) --null
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

	from storicocarrello as scar
		left join busta as b
		on (b."codice filiale" = scar."codice fornitura")

		left join occhiali as oc --ser left join aqui tem algum problema? acho que não, pois faz join com a PrescricaoEnvelope
		on (oc."codice cliente" = b."codice cliente")

		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

		join PrescricaoEnvelope as pe
		on ((b."codice filiale" = pe."CodigoEnvelope") and (pe."Dias" = (CAST(b."data" as integer) - CAST(oc."data" as integer))))

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)

	group by
		oc."codice filiale",
		matriz."CodigoAntigo",
		filial."CodigoAntigo",
		scar."codice cliente",
		oc."data"
);


/*venda - STORICOCARRELLO*/
insert into documento
(
	select
		'busta.' + CAST(b."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
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
		CAST(NULL as varchar) as DescricaoEmpresa, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as InscricaoMunicipalEmpresa, --varchar(150) --null
		CAST(NULL as varchar) as CodigoMunicipioEmpresa, --int->varchar(40) --null
		CAST(NULL as int) as OptanteSimplesNacional, --int --not null
		CAST(NULL as int) as CodigoEmpresaEndereco, --int --null
		CASE b."tipo laboratorio"
			WHEN 0 THEN lab."CodigoAntigo"
			WHEN 1 THEN '' --Este caso é do lab. próprio, interno, mas não tenho como saber quem é o lab.
		END as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
		CAST(NULL as varchar) as DescricaoContato, --varchar(255) --null
		CAST(NULL as varchar) as NumeroDocumentoContato, --varchar(150) --null
		CAST(NULL as varchar) as EmailContato, --varchar(100)-> varchar(255) --null
		CAST(NULL as varchar) as TelefoneContato, --varchar(30)-> varchar(50) --null
		CAST(NULL as varchar) as RegimeContato, --varchar(100) --null
		CAST(NULL as int) as CodigoContatoEndereco, --int --null
		CAST(NULL as varchar) as DescricaoContatoEndereco, --varchar(170) --null
		CAST(NULL as int) as CodigoContatoResponsavel, --int --null
		CAST(NULL as varchar) as ContatoResponsavelEmail, --varchar(255) --null
		b."data" as DataHoraEmissao, --datetime (date) --null
		CAST(NULL as date) as DataHoraFinalizado, --datetime (date) --null
		b."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
		CAST(NULL as date) as DataHoraRealizado, --datetime (date) --null
		CAST(NULL as date) as DataHoraAvisado, --datetime (date) --null
		CAST(NULL as int) as CodigoContatoFinalizado, --int --null
		CAST(NULL as varchar) as Observacao, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoInterna, --varchar(8000) --null
		CAST(NULL as varchar) as ObservacaoEntrega, --varchar(150) --null
		CAST(NULL as varchar) as ObservacaoFaturamento, --varchar(150) --null
		CAST(NULL as int) as CodigoContatoComprador, --int --null
		CAST(NULL as varchar) as CodigoContatoVendedor, --int --null
		CAST(NULL as varchar) as CodigoContatoDigitador, --int --null
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
		join busta as b
		on (b."codice filiale" = scar."codice fornitura")

		left join Contato as matriz
		on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

		left join Contato as filial
		on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

		left join Contato as lab
		on (b."laboratorio esterno" = lab."Nome")

	where
		(scar."tipo fornitura" <> 100) and
		(scar."tipo fornitura" <> 101)
);


--UPDATE OBSERVAÇÃO (PRESCRIÇÃO)
update Documento
set Documento."Observacao" = 
(
	select
		CAST(oc."note" as varchar(8000))
	from occhiali as oc
	where (Documento."CodigoDocumento" = 'occhiali.'+ oc."codice filiale")
);