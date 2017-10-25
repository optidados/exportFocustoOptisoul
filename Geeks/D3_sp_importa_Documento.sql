
alter procedure [dbo].D3_sp_importa_Documento as

drop table  DocumentoTmp

create table DocumentoTmp
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
	CodigoContato varchar(30), --not null
	DescricaoContato varchar(255), --null
	NumeroDocumentoContato varchar(150), --null
	EmailContato varchar(255), --varchar(100)-> varchar(255) --null
	TelefoneContato	varchar(50), --varchar(30)-> varchar(50) --null
	RegimeContato varchar, --null
	CodigoContatoEndereco int, --null
	DescricaoContatoEndereco varchar(8000), --null [varchar(max)]--> varchar(8000)
	CodigoContatoResponsavel varchar(30), --null
	ContatoResponsavelEmail varchar(50), --null
	DataHoraEmissao	date, --datetime->date --null
	DataHoraFinalizado date, --datetime->date --null
	DataHoraPrevisto date, --datetime->date --null
	DataHoraRealizado date, --datetime->date --null
	DataHoraAvisado	date, --datetime->date --null
	DataHoraRetorno	date, --datetime->date --null
	CodigoContatoFinalizado	varchar(30), --null
	Observacao varchar(8000), --null [varchar(max)]--> varchar(8000)
	ObservacaoInterna varchar, --null [varchar(max)]--> varchar(8000)
	ObservacaoEntrega varchar, --null
	ObservacaoFaturamento varchar, --null
	CodigoContatoComprador int, --null
	CodigoContatoVendedor varchar(30), --null
	CodigoContatoDigitador varchar(30), --null
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
	TransferenciaCaixa int, --null [bit]--> int
	ChaveAcesso varchar, --varchar NULL
	NumeroFabricacaoECF int, --int NULL
	CPF_CNPJ_CCF int, --int NULL
	CodigoAlternativo1 int, --int NULL
	NomeCCF varchar, --varchar NULL
	EnderecoCCF varchar --varchar NULL
);

/*venda - CARRELLO*/
insert into DocumentoTmp (CodigoDocumento, Tipo, Operacao, CodigoEmpresa, DescricaoEmpresa, NumeroDocumentoEmpresa, InscricaoMunicipalEmpresa, CodigoContato, DataHoraEmissao, DataHoraFinalizado, CodigoContatoFinalizado, CodigoContatoVendedor, CodigoContatoDigitador, TipoFrete, SubTotal, SubTotalProduto, ValorDescontoProduto, PercentualDescontoProduto, TotalProduto, FreteSeparado, TotalDocumento, CalcularAutomatico)

select
	'car.' + CAST(car.[codice filiale] as varchar(12)) as CodigoDocumento,
	'Venda' as Tipo, --varchar(255) --null
	'Venda de Mercadoria' as Operacao, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'clienti.' + car."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	car."data" as DataHoraEmissao, --datetime (date) --null
	car."data" as DataHoraFinalizado, --datetime (date) --null
	'utente.' + car."operatore" as CodigoContatoFinalizado, --int --null
	'utente.' + car."operatore" as CodigoContatoVendedor, --int --null
	'utente.' + car."operatore" as CodigoContatoDigitador, --int --null
	'CIF' as TipoFrete, --varchar(3) --null
	CAST(car."totale" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
	CAST(car."prezzo" as decimal(18,4)) as SubTotalProduto, --decimal(18,4) --null
	CAST(car."sconto" as decimal(18,4)) as ValorDescontoProduto, --decimal(18,4) --null
	CAST((car."sconto"/(CASE WHEN car."totale" = 0 THEN 1 ELSE car."totale" END))*100 as decimal(18,4)) as PercentualDescontoProduto, --decimal(18,4) --null
	CAST(car."totale" as decimal(18,4)) as TotalProduto, --decimal(18,4) --null
	1 as FreteSeparado, --int --null
	CAST(car."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
	'Sim' as CalcularAutomatico --varchar(3) --null

from carrello as car
	left join optisoul..contato  matriz
	on ('sede.' + car."filiale") = matriz."CodigoAntigo"

	left join optisoul..contato  filial
	on ('puntovendita.' + car."filiale") = filial."CodigoAntigo"
where
	(car."tipo fornitura" <> 100) or
	(car."tipo fornitura" = 100 and car."descrizione" = 'Devolução cliente')


/*Item Venda e Devolução - CARRELLO*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Descricao,	Operacao,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	DataHoraEmissao,	DataHoraFinalizado,	SubTotal,	TotalDesconto,	TotalPercentualDesconto,	FreteSeparado,	TotalDocumento,	CalcularAutomatico)

select
	'item.car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
	'car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
	CASE car."tipo fornitura"
		WHEN 100 THEN 'Devolução'
		ELSE 'Item Venda'
	END as Tipo, --varchar(255) --null
	car."descrizione" as Descricao, --varchar(255) --null 
	CASE car."tipo fornitura"
		WHEN 1 THEN 'Óculos de Grau'
		WHEN 2 THEN 'Óculos de Sol'
		WHEN 3 THEN 'Óculos de Grau'
		WHEN 4 THEN 'Armação'
		WHEN 10 THEN 'Lente de Contato Surfaçada'
		WHEN 100 THEN 'Item de Devolução'
	END as Operacao, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'clienti.' + car."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	car."data" as DataHoraEmissao, --datetime (date) --null
	car."data" as DataHoraFinalizado, --datetime (date) --null
	CAST(car."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
	CAST(car."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
	CAST(car."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
	1 as FreteSeparado, --int --null
	CAST(car."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
	'Sim' as CalcularAutomatico --varchar(3) --null
	
from carrello as car
	left join Optisoul..Contato as matriz
	on (('sede.' + car."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

where
	((car."tipo fornitura" <> 100) or (car."tipo fornitura" = 100 and car."descrizione" = 'Devolução cliente')) --by Jennifer
	and(car."tipo fornitura" <> 5) --Outro Produto/Serviço não possui registro na Documento com Tipo = Item Venda
	and(car."tipo fornitura" <> 0)

/*Item venda - CARRELLO2 - PARA ITEMS JOGADOS DIRETO NO CARRINHO*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Descricao,	Operacao,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	DataHoraEmissao,	DataHoraFinalizado,	SubTotal,	TotalDesconto,	TotalPercentualDesconto,	FreteSeparado,	TotalDocumento,	CalcularAutomatico)

select
	'item.car2.' + CAST(car2."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
	'car.' + CAST(car2."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
	'Item Venda' as Tipo, --varchar(255) --null
	car2."descrizione" as Descricao, --varchar(255) --null 
	CASE 
		WHEN Item."Tipo" = 'Armação' THEN 'Armação'
		WHEN Item."Tipo" = 'Óculos Sol' THEN 'Óculos de Sol'
		WHEN Item."Tipo" = 'Óculos Pronto' THEN 'Óculos Pronto'
		WHEN car2."magazzino" = 2 THEN 'Lente de Contato Pronta'
		WHEN car2."magazzino" = 0 THEN 'Armação'
	END as Operacao, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'clienti.' + car2."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	car2."data" as DataHoraEmissao, --datetime (date) --null
	car2."data" as DataHoraFinalizado, --datetime (date) --null
	CAST(car2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
	CAST(car2."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
	CAST(car2."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
	1 as FreteSeparado, --int --null
	CAST(car2."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
	'Sim' as CalcularAutomatico --varchar(3) --null
		
from carrello2 as car2
	left join Optisoul..Contato as matriz
	on (('sede.' + car2."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + car2."filiale") = filial."CodigoAntigo")

	left join Optisoul..Item as Item
	on (('articoli.' + car2."codice articolo") = Item."CodigoAntigo")

where
	(car2."tipo fornitura" = 0)
	and((car2."magazzino" = 0) or (car2."magazzino" = 2))

/*Prescrição - CARRELLO*/
insert into DocumentoTmp (CodigoDocumento,	Tipo,	Operacao,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	DataHoraEmissao,	DataHoraFinalizado,	FreteSeparado,	CalcularAutomatico,	DocumentoCodigo,	DocumentoTipo)

select
	'occhiali.' + CAST(oc."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
	'Prescrição' as Tipo, --varchar(255) --null
	'Prescrição' as Operacao, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'clienti.' + oc."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	oc."data" as DataHoraEmissao, --datetime (date) --null
	oc."data" as DataHoraFinalizado, --datetime (date) --null
	1 as FreteSeparado, --int --null
	'Sim' as CalcularAutomatico, --varchar(3) --null
	MIN(t."codice filiale") as DocumentoCodigo, --varchar(100) --null
	'Venda' as DocumentoTipo --varchar(100) --null
		
from
	(
		select
			car."codice cliente",
			'item.car.' + car."codice filiale" as "codice filiale",
			car."codice fornitura"
		from carrello as car
		where car."tipo fornitura" <> 100

		UNION

		select
			scar."codice cliente",
			'item.scar.' + scar."codice filiale",
			scar."codice fornitura"
		from storicocarrello as scar
		where 
			(scar."tipo fornitura" <> 100) and
			(scar."tipo fornitura" <> 101)
	) as t
	left join busta as b
	on (b."codice filiale" = t."codice fornitura")

	left join lentibusta as lb
	on (lb."codice filiale" = t."codice fornitura")

	left join occhiali as oc --ser left join aqui tem algum problema? acho que não, pois faz join com a PrescricaoEnvelope
	on (oc."codice cliente" = COALESCE(b."codice cliente", lb."codice cliente"))

	left join Optisoul..Contato as matriz
	on (('sede.' + oc."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + oc."filiale") = filial."CodigoAntigo")

	left join Optisoul..Contato as cliente
	on (('clienti.' + oc."codice cliente") = cliente."CodigoAntigo")

	join PrescricaoEnvelope as pe
	on ((COALESCE(b."codice filiale", lb."codice filiale") = pe."CodigoEnvelope") and (pe."Dias" = DATEDIFF(day, COALESCE(b."data", lb."data"), oc."data")))

group by
	oc."codice filiale",
	matriz."CodigoAntigo",
	filial."CodigoAntigo",
	matriz."Apelido",
	filial."Apelido",
	matriz."NumeroDocumentoNacional", 
	filial."NumeroDocumentoNacional",
	matriz."NumeroDocumentoMunicipal",
	filial."NumeroDocumentoMunicipal",
	oc."codice cliente",
	oc."data"

/*Envelope - CARRELLO*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Operacao,	Status,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	CodigoContatoResponsavel,	DataHoraEmissao,	DataHoraPrevisto,	DataHoraRealizado,	Observacao,	FreteSeparado,	CalcularAutomatico,	DocumentoCodigo,	DocumentoTipo)

select
	'busta.' + CAST(b."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
	'item.car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(12)
	'Envelope' as Tipo, --varchar(255) --null
	'Normal' as Operacao, --varchar(255) --null
	CASE b."stato montaggio"
		WHEN 0 THEN 'Aguardando Envio'
		WHEN 1 THEN 'Aguardando Retorno'
		WHEN 2 THEN 'Processando'
		WHEN 3 THEN 'Pronto para Entrega'
		WHEN 4 THEN 'Entregue'
	END as Status, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'0' as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	'utente.' + b."operatore" as CodigoContatoResponsavel, --int --null
	b."data" as DataHoraEmissao, --datetime (date) --null
	b."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
	b."data consegna" as DataHoraRealizado, --datetime (date) --null
	CAST(b."note" as varchar(max)) as Observacao, --varchar(8000) --null
	1 as FreteSeparado, --int --null
	'Sim' as CalcularAutomatico, --varchar(3) --null
	'car.' + CAST(car."codice filiale" as varchar(12)) as DocumentoCodigo, --varchar(100) --null
	'Venda' as DocumentoTipo --varchar(100) --null
		
from carrello as car
	join busta as b
	on (b."codice filiale" = car."codice fornitura")

	left join Optisoul..Contato as matriz
	on (('sede.' + car."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

where
	(car."tipo fornitura" NOT IN (2, 5, 6, 100)) /*and
	(b."stato montaggio" <> 5) --status cancelado*/

/*Envelope - CARRELLO (LENTES DE CONTATO SURFAÇADA)*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Operacao,	Status,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	CodigoContatoResponsavel,	DataHoraEmissao,	DataHoraPrevisto,	DataHoraRealizado,	Observacao,	FreteSeparado,	CalcularAutomatico,	DocumentoCodigo,	DocumentoTipo)

select
	'lentibusta.' + CAST(lb."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
	'item.car.' + CAST(car."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(12)
	'Envelope' as Tipo, --varchar(255) --null
	'Normal' as Operacao, --varchar(255) --null
	CASE 
	    WHEN lb."stato lente dx" >= lb."stato lente sx" THEN
	    CASE lb."stato lente dx"
	        WHEN 1 THEN 'Aguardando Envio'
	        WHEN 2 THEN 'Aguardando Retorno'
	        WHEN 3 THEN 'Pronto para Entrega'
	        WHEN 4 THEN 'Entregue'
	    END
	    WHEN lb."stato lente dx" < lb."stato lente sx" THEN
	    CASE lb."stato lente sx"
	        WHEN 1 THEN 'Aguardando Envio'
	        WHEN 2 THEN 'Aguardando Retorno'
	        WHEN 3 THEN 'Pronto para Entrega'
	        WHEN 4 THEN 'Entregue'
	    END
	END as Status, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'0' as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	'utente.' + lb."operatore" as CodigoContatoResponsavel, --int --null
	lb."data" as DataHoraEmissao, --datetime (date) --null
	lb."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
	lb."data consegna" as DataHoraRealizado, --datetime (date) --null
	CAST(lb."note" as varchar(max)) as Observacao, --varchar(8000) --null
	1 as FreteSeparado, --int --null
	'Sim' as CalcularAutomatico, --varchar(3) --null
	'car.' + CAST(car."codice filiale" as varchar(12)) as DocumentoCodigo, --varchar(100) --null
	'Venda' as DocumentoTipo --varchar(100) --null

from carrello as car
	join lentibusta as lb
	on (lb."codice filiale" = car."codice fornitura")

	left join Optisoul..Contato as matriz
	on (('sede.' + car."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + car."filiale") = filial."CodigoAntigo")

where
	(car."tipo fornitura" <> 100)


/*venda - STORICOCARRELLO*/
insert into DocumentoTmp (CodigoDocumento, Tipo, Operacao, CodigoEmpresa, DescricaoEmpresa, NumeroDocumentoEmpresa, InscricaoMunicipalEmpresa, CodigoContato, DataHoraEmissao, DataHoraFinalizado, CodigoContatoFinalizado, CodigoContatoVendedor, CodigoContatoDigitador, TipoFrete, SubTotal, SubTotalProduto, ValorDescontoProduto, PercentualDescontoProduto, TotalProduto, TotalDocumento, CalcularAutomatico)

select
	'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
	'Venda' as Tipo, --varchar(255) --null
	'Venda de Mercadoria' as Operacao, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'clienti.' + scar."codice cliente" as CodigoContato, --varchar(255) (int->varhscar(255)) --not null
	scar."data" as DataHoraEmissao, --datetime (date) --null
	scar."data" as DataHoraFinalizado, --datetime (date) --null
	'utente.' + scar."operatore" as CodigoContatoFinalizado, --int --null
	'utente.' + scar."operatore" as CodigoContatoVendedor, --int --null
	'utente.' + scar."operatore" as CodigoContatoDigitador, --int --null
	'CIF' as TipoFrete, --varchar(3) --null
	CAST(scar."totale" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
	CAST(scar."prezzo" as decimal(18,4)) as SubTotalProduto, --decimal(18,4) --null
	CAST(scar."sconto" as decimal(18,4)) as ValorDescontoProduto, --decimal(18,4) --null
	CAST((scar."sconto"/(CASE WHEN scar."totale" = 0 THEN 1 ELSE scar."totale" END))*100 as decimal(18,4)) as PercentualDescontoProduto, --decimal(18,4) --null
	CAST(scar."totale" as decimal(18,4)) as TotalProduto, --decimal(18,4) --null
	CAST(scar."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
	'Sim' as CalcularAutomatico --varchar(3) --null
		
from storicocarrello as scar
	left join Optisoul..Contato as matriz
	on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

where
	((scar."tipo fornitura" <> 100) or (scar."tipo fornitura" = 100 and scar."descrizione" = 'Devolução cliente'))
	and(scar."tipo fornitura" <> 101)


/*Item Venda e Devolução - STORICOCARRELLO*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Descricao,	Operacao,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	DataHoraEmissao,	DataHoraFinalizado,	SubTotal,	TotalDesconto,	TotalPercentualDesconto,	FreteSeparado,	TotalDocumento,	CalcularAutomatico)

select
	'item.scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
	'scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(20) (int->varchar(20))
	CASE scar."tipo fornitura"
		WHEN 100 THEN 'Devolução'
		ELSE 'Item Venda'
	END as Tipo, --varchar(255) --null
	scar."descrizione" as Descricao, --varchar(255) --null 
	CASE scar."tipo fornitura"
		WHEN 1 THEN 'Óculos de Grau'
		WHEN 2 THEN 'Óculos de Sol'
		WHEN 3 THEN 'Óculos de Grau'
		WHEN 4 THEN 'Armação'
		WHEN 10 THEN 'Lente de Contato Surfaçada'
		WHEN 100 THEN 'Item de Devolução'
	END as Operacao, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'clienti.' + scar."codice cliente" as CodigoContato, --varchar(255) (int->varhscar(255)) --not null
	scar."data" as DataHoraEmissao, --datetime (date) --null
	scar."data" as DataHoraFinalizado, --datetime (date) --null
	CAST(scar."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
	CAST(scar."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
	CAST(scar."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
	1 as FreteSeparado, --int --null
	CAST(scar."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
	'Sim' as CalcularAutomatico --varchar(3) --null
		
from storicocarrello as scar
	left join Optisoul..Contato as matriz
	on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

where
	((scar."tipo fornitura" <> 100) or (scar."tipo fornitura" = 100 and scar."descrizione" = 'Devolução cliente')) and
	(scar."tipo fornitura" <> 101) and
	(scar."tipo fornitura" <> 5) and --Outro Produto/Serviço não possui registro na Documento com Tipo = Item Venda
	(scar."tipo fornitura" <> 0)

/*Item venda - STORICOCARRELLO2 - para Vendas direto no carrinho*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Descricao,	Operacao,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	DataHoraEmissao,	DataHoraFinalizado,	SubTotal,	TotalDesconto,	TotalPercentualDesconto,	FreteSeparado,	TotalDocumento,	CalcularAutomatico)

select
	'item.scar2.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(30)
	'scar.' + CAST(scar2."codice filiale" as varchar(12)) as CodigoDocumentoAdicional, --varchar(30) (int->varchar(30))
	'Item Venda' as Tipo, --varchar(255) --null
	scar2."descrizione" as Descricao, --varchar(255) --null 
	CASE
		WHEN Item."Tipo" = 'Armação' THEN 'Armação'
		WHEN Item."Tipo" = 'Óculos Sol' THEN 'Óculos de Sol'
		WHEN Item."Tipo" = 'Óculos Pronto' THEN 'Óculos Pronto'
		WHEN scar2."magazzino" = 2 THEN 'Lente de Contato Pronta'
		WHEN scar2."magazzino" = 0 THEN 'Armação'
	END as Operacao, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'clienti.' + scar2."codice cliente" as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	scar2."data" as DataHoraEmissao, --datetime (date) --null
	scar2."data" as DataHoraFinalizado, --datetime (date) --null
	CAST(scar2."prezzo" as decimal(18,4)) as SubTotal, --decimal(18,4) --null
	CAST(scar2."sconto" as decimal(18,4)) as TotalDesconto, --decimal(18,4) --null
	CAST(scar2."sconto percentuale" as decimal(18,4)) as TotalPercentualDesconto, --decimal(18,4) --null
	1 as FreteSeparado, --int --null
	CAST(scar2."totale" as decimal(18,4)) as TotalDocumento, --decimal(18,4) --null
	'Sim' as CalcularAutomatico --varchar(3) --null
		
from storicocarrello2 as scar2
	left join Optisoul..Contato as matriz
	on (('sede.' + scar2."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + scar2."filiale") = filial."CodigoAntigo")

	left join Optisoul..Item
	on (('articoli.' + scar2."codice articolo") = Item."CodigoAntigo")

where
	(scar2."tipo fornitura" = 0)
	and((scar2."magazzino" = 0) or (scar2."magazzino" = 2))


/*Envelope - STORICOCARRELLO*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Operacao,	Status,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	CodigoContatoResponsavel,	DataHoraEmissao,	DataHoraPrevisto,	DataHoraRealizado,	Observacao,	FreteSeparado,	CalcularAutomatico,	DocumentoCodigo,	DocumentoTipo)

select
	'busta.' + CAST(b."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
	'item.scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
	'Envelope' as Tipo, --varchar(255) --null
	'Normal' as Operacao, --varchar(255) --null
	CASE b."stato montaggio"
		WHEN 0 THEN 'Aguardando Envio'
		WHEN 1 THEN 'Aguardando Retorno'
		WHEN 2 THEN 'Processando'
		WHEN 3 THEN 'Pronto para Entrega'
		WHEN 4 THEN 'Entregue'
	END as Status, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'0' as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	'utente.' + b."operatore" as CodigoContatoResponsavel, --int --null
	b."data" as DataHoraEmissao, --datetime (date) --null
	b."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
	b."data consegna" as DataHoraRealizado, --datetime (date) --null
	CAST(b."note" as varchar(max)) as Observacao, --varchar(8000) --null
	1 as FreteSeparado, --int --null
	'Sim' as CalcularAutomatico, --varchar(3) --null
	'scar.' + CAST(scar."codice filiale" as varchar(12)) as DocumentoCodigo, --varchar(100) --null
	'Venda' as DocumentoTipo --varchar(100) --null
		
from storicocarrello as scar
	join busta as b
	on (b."codice filiale" = scar."codice fornitura")

	left join Optisoul..Contato as matriz
	on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")

where
	(scar."tipo fornitura" NOT IN (2, 5, 6, 100, 101)) /*and
	(b."stato montaggio" <> 5) --status cancelado*/


/*Envelope - STORICOCARRELLO (LENTES DE CONTATO SURFAÇADA)*/
insert into DocumentoTmp (CodigoDocumento,	CodigoDocumentoAdicional,	Tipo,	Operacao,	Status,	CodigoEmpresa,	DescricaoEmpresa,	NumeroDocumentoEmpresa,	InscricaoMunicipalEmpresa,	CodigoContato,	CodigoContatoResponsavel,	DataHoraEmissao,	DataHoraPrevisto,	DataHoraRealizado,	Observacao,	FreteSeparado,	CalcularAutomatico,	DocumentoCodigo,	DocumentoTipo)

select
	'lentibusta.' + CAST(lb."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(20)
	'item.scar.' + CAST(scar."codice filiale" as varchar(12)) as CodigoDocumento, --varchar(12)
	'Envelope' as Tipo, --varchar(255) --null
	'Normal' as Operacao, --varchar(255) --null
	CASE 
	    WHEN lb."stato lente dx" >= lb."stato lente sx" THEN
	    CASE lb."stato lente dx"
	        WHEN 1 THEN 'Aguardando Envio'
	        WHEN 2 THEN 'Aguardando Retorno'
	        WHEN 3 THEN 'Pronto para Entrega'
	        WHEN 4 THEN 'Entregue'
        END
	    WHEN lb."stato lente dx" < lb."stato lente sx" THEN
	    CASE lb."stato lente sx"
	        WHEN 1 THEN 'Aguardando Envio'
	        WHEN 2 THEN 'Aguardando Retorno'
	        WHEN 3 THEN 'Pronto para Entrega'
	        WHEN 4 THEN 'Entregue'
	    END
	END as Status, --varchar(255) --null
	COALESCE(matriz."CodigoAntigo", filial."CodigoAntigo") as CodigoEmpresa, --varchar(255) (int -> varchar(255)) --not null
	COALESCE(matriz."Apelido", filial."Apelido") as DescricaoEmpresa, --varchar(255) --null
	COALESCE(matriz."NumeroDocumentoNacional", filial."NumeroDocumentoNacional") as NumeroDocumentoEmpresa, --varchar(150) --null
	COALESCE(matriz."NumeroDocumentoMunicipal", filial."NumeroDocumentoMunicipal") as InscricaoMunicipalEmpresa, --varchar(150) --null
	'0' as CodigoContato, --varchar(255) (int->varhcar(255)) --not null
	'utente.' + lb."operatore" as CodigoContatoResponsavel, --int --null
	lb."data" as DataHoraEmissao, --datetime (date) --null
	lb."data prevista consegna" as DataHoraPrevisto, --datetime (date) --null
	lb."data consegna" as DataHoraRealizado, --datetime (date) --null
	CAST(lb."note" as varchar(max)) as Observacao, --varchar(8000) --null
	1 as FreteSeparado, --int --null
	'Sim' as CalcularAutomatico, --varchar(3) --null
	'scar.' + CAST(scar."codice filiale" as varchar(12)) as DocumentoCodigo, --varchar(100) --null
	'Venda' as DocumentoTipo --varchar(100) --null
from storicocarrello as scar
	join lentibusta as lb
	on (lb."codice filiale" = scar."codice fornitura")

	left join Optisoul..Contato as matriz
	on (('sede.' + scar."filiale") = matriz."CodigoAntigo")

	left join Optisoul..Contato as filial
	on (('puntovendita.' + scar."filiale") = filial."CodigoAntigo")
		
where
	(scar."tipo fornitura" <> 100) and
	(scar."tipo fornitura" <> 101)


--UPDATE OBSERVAÇÃO (PRESCRIÇÃO)
/*
	A observacao da prescricao nao foi incluida pelo seu insert pois la foi necessario fazer um group by
	A observacao eh um campo do tipo MEMO que agrupa em um group by
*/
update d
set d."Observacao" = 
(
	select
		CAST( ((oc."controllato da")+' - '+ (oc."note")) as varchar(max))
	from occhiali as oc
	where (d."CodigoDocumento" = 'occhiali.'+ oc."codice filiale")
)
from DocumentoTmp d
where d.Tipo = 'Prescrição'




