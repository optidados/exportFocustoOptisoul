ALTER procedure [dbo].[D8_sp_ajusta_Documento] as

/*
	Atualiza os Status da Documento
*/
update doc
set doc."Status" = (
		select MAX(docit."Status")
		from Optisoul..DocumentoItem as docit
		where
			docit."CodigoDocumento" = doc."CodigoDocumento" and
			docit."Operacao" = 'Venda de Mercadoria'
		group by docit."CodigoDocumento"
	)
from Optisoul..Documento as doc
where
	doc."Tipo" IN ('Item Venda', 'Devolução')

update doc
set doc."Status" = (
		select
			MAX(docit."Status")
		from Optisoul..DocumentoItem as docit
		join Optisoul..Documento as doc2
			on docit."CodigoDocumento" = doc2."CodigoDocumento"
		where
			doc2."CodigoDocumentoAdicional" = doc."CodigoDocumento" and
			doc2."Tipo" = 'Item Venda' and
			docit."Operacao" = 'Venda de Mercadoria'
		group by docit."CodigoDocumento"
	)
from Optisoul..Documento as doc
where
	doc."Tipo" = 'Venda'

--ATUALIZA ENDERECO, TELEFONE E EMAIL DO DOCUMENTO
update Optisoul..Documento
set
	CodigoMunicipioEmpresa = 
	(
		select ContatoEndereco."IbgeCod"
		from Optisoul..ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoEmpresa" and
			ContatoEndereco."Grupo" = 'Principal'
	)

,
	CodigoEmpresaEndereco =
	(
		select ContatoEndereco."CodigoContatoEndereco"
		from Optisoul..ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoEmpresa" and
			ContatoEndereco."Grupo" = 'Principal'
	)

,
	DescricaoContato =
	(
		select Contato."Nome"
		from Optisoul..Contato
		where
			Contato."CodigoContato" = Documento."CodigoContato"


	)	,

	NumeroDocumentoContato =
	(
		select Contato."NumeroDocumentoNacional"
		from Optisoul..Contato
		where
			Contato."CodigoContato" = Documento."CodigoContato"
	)  ,
	EmailContato =
	(
		select Contato."EmailNFe"
		from Optisoul..Contato
		where
			Contato."CodigoContato" = Documento."CodigoContato"
	),
	TelefoneContato =
	(
		select ContatoTelefone."telefone"
		 from Optisoul..ContatoTelefone
		where
			ContatoTelefone."CodigoContato" = Documento."CodigoContato" and
			ContatoTelefone."TipoTelefone" = 'Principal'
	) ,
	CodigoContatoEndereco =
	(
		select ContatoEndereco."CodigoContatoEndereco"
		from Optisoul..ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoContato" and
			ContatoEndereco."Grupo" = 'Principal'
	),
	DescricaoContatoEndereco =
	(
		select COALESCE(ContatoEndereco."Logradouro" + ' - ', '')  +
		       COALESCE(ContatoEndereco."Bairro" + ' - ', '') + 
			   COALESCE(ContatoEndereco."CEP" + ' - ', '') + 
			   COALESCE(ContatoEndereco."Municipio", '') + 
			   COALESCE('/' + ContatoEndereco."UF", '')
		
		from Optisoul..ContatoEndereco
		where
			ContatoEndereco."CodigoContatoEndereco" = Documento."CodigoContatoEndereco"
	)

where
	Tipo IN ('Venda', 'Devolução')

update Optisoul..Documento
set
	CodigoEmpresaEndereco =
	(
		select ContatoEndereco."CodigoContatoEndereco"
		from Optisoul..ContatoEndereco
		where
			ContatoEndereco."CodigoContato" = Documento."CodigoEmpresa" and
			ContatoEndereco."Grupo" = 'Principal'
	),
	DescricaoContato =
	(
		select Contato."Nome"
		from Optisoul..Contato
		where
			Contato."CodigoContato" = Documento."CodigoContato"
	),
	NumeroDocumentoContato =
	(
		select Contato."NumeroDocumentoNacional"
		from Optisoul..Contato
		where
			Contato."CodigoContato" = Documento."CodigoContato"
	),
	EmailContato =
	(
		select Contato."EmailNFe"
		from Optisoul..Contato
		where
			Contato."CodigoContato" = Documento."CodigoContato"
	),
	TelefoneContato =
	(
		select ContatoTelefone."telefone"
		from Optisoul..ContatoTelefone
		where
			ContatoTelefone."CodigoContato" = Documento."CodigoContato" and
			ContatoTelefone."TipoTelefone" = 'Principal'
	)
where
	Tipo IN ('Item Venda', 'Prescrição')


--TEMP DEVOLUÇÃO
drop table if exists temp_devolvido

create table temp_devolvido
    (
        "CodigoTransacao" varchar(12),
        "CodigoCarrinho" varchar(12),
        "CodigoCarrinhoItem" varchar(12),
        "Data" date,
        "CodigoItem" varchar(12),
        "Descricao" varchar(100),
        "Usado" bit
    )

insert into temp_devolvido
select
    storicocarrello2."codice transazione",
    storicocarrello2."codice carrello",
    storicocarrello2."codice filiale",
    storicocarrello2."data",
    storicocarrello2."codice articolo",
    storicocarrello2."descrizione",
    0
from storicocarrello2
where
    storicocarrello2."reso" = 1

DECLARE @vData date;
DECLARE @vCodigoTransacaoDevolucao varchar(12), @vCodigoItem varchar(12), @vCodigoCarrinhoItem varchar(12);
DECLARE @vCodigoAntigo varchar(150);
DECLARE @vDescricao varchar(100);

DECLARE DevolucaoCursor CURSOR FOR
    select *
    from ( 
            select 
                'car2.' + CAST(car2."codice filiale" as varchar(12)) CodigoAntigo,
                car2."codice articolo",
                car2."codice transazione reso",
                car2."data",
                car2."descrizione"
            from carrello2 as car2
            where
                (car2."tipo fornitura" = 100) and
                (car2."quantita" < 1) and
                (car2."codice transazione reso" IS NOT NULL)

            UNION

            select 
                'scar2.' + CAST(scar2."codice filiale" as varchar(12)),
                scar2."codice articolo",
                scar2."codice transazione reso",
                scar2."data",
                scar2."descrizione"
            from storicocarrello2 as scar2
            where
                (scar2."tipo fornitura" = 100) and
                (scar2."quantita" < 1) and
                (scar2."codice transazione reso" IS NOT NULL)
	) as t;

OPEN DevolucaoCursor;

FETCH NEXT FROM DevolucaoCursor INTO @vCodigoAntigo, @vCodigoItem, @vCodigoTransacaoDevolucao, @vData, @vDescricao;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @vCodigoCarrinhoItem =
        (
            select MIN(td."CodigoCarrinhoItem") --pego o menor que ainda nao tenha sido usado
            from temp_devolvido as td
            where
                (td."CodigoTransacao" = @vCodigoTransacaoDevolucao) and
                (td."CodigoItem" = @vCodigoItem) and
                (td."Data" <= @vData) and
                (td."Usado" = 0)
        );

    IF @vCodigoCarrinhoItem IS NULL 
	BEGIN
        SET @vCodigoCarrinhoItem =
            (
                select MIN(td."CodigoCarrinhoItem") --pego o menor que ainda nao tenha sido usado
                from temp_devolvido as td
                where
                    (td."CodigoTransacao" = @vCodigoTransacaoDevolucao) and
                    (td."Descricao" = @vDescricao) and
                    (td."Data" <= @vData) and
                    (td."Usado" = 0)
            );
    END;

    IF @vCodigoCarrinhoItem IS NOT NULL
	BEGIN
        update td
        set td."Usado" = 1
		from temp_devolvido as td
        where td."CodigoCarrinhoItem" = @vCodigoCarrinhoItem;

        update di
        set 
            di."CodigoDocumentoVenda" = 
                (
                    select di2."CodigoDocumento"
                    from Optisoul..DocumentoItem as di2
                    where
                        (di2."CodigoAntigo" = 'scar2.' + @vCodigoCarrinhoItem)
                ), 
            di."CodigoDocumentoItemVenda" = 
                (
                    select di2."CodigoDocumentoItem"
                    from Optisoul..DocumentoItem as di2
                    where
                        (di2."CodigoAntigo" = 'scar2.' + @vCodigoCarrinhoItem)
                )
		from Optisoul..DocumentoItem as di
        where
            (di."CodigoAntigo" = @vCodigoAntigo);
    END;

    FETCH NEXT FROM DevolucaoCursor INTO @vCodigoAntigo, @vCodigoItem, @vCodigoTransacaoDevolucao, @vData, @vDescricao;
END;

CLOSE DevolucaoCursor;
DEALLOCATE DevolucaoCursor;

drop table temp_devolvido


/*
--UPDATE TOTAIS --da pra otimizar?
update Documento as doc
set 
    doc."SubTotalProduto" =
        (
            select SUM(doc2."SubTotal")
            from Documento as doc2
            where doc2."CodigoDocumentoAdicional" = doc."CodigoDocumento"
        ),
    doc."ValorDescontoProduto" =
        (
            select SUM(doc2."TotalDesconto")
            from Documento as doc2
            where doc2."CodigoDocumentoAdicional" = doc."CodigoDocumento"
        ),
    doc."TotalDocumento" =
        (
            select SUM(doc2."TotalDocumento")
            from Documento as doc2
            where doc2."CodigoDocumentoAdicional" = doc."CodigoDocumento"
        )
where
    EXISTS
    (
        select *
        from Documento as doc2
        where
            doc."CodigoDocumento" = doc2."CodigoDocumentoAdicional" and
            doc2."NaturezaOperacao" = 'Devolução'
    );

update Documento as doc
set 
    doc."SubTotal" = doc."TotalDocumento",
    doc."PercentualDescontoProduto" = (doc."ValorDescontoProduto"/(CASE WHEN doc."SubTotal" = 0 THEN 1 ELSE doc."SubTotal" END))*100,
    doc."TotalProduto" = doc."TotalDocumento"
where
    EXISTS
    (
        select *
        from Documento as doc2
        where
            doc."CodigoDocumento" = doc2."CodigoDocumentoAdicional" and
            doc2."NaturezaOperacao" = 'Devolução'
    );
*/
-----------------------------------aqui já é outra coisa---------------------------------------------
--UPDATE COLUNA OPERAÇÃO = ÓCULOS DE SOL
update Optisoul..Documento
set Documento."Operacao" = 'Óculos de Sol'
where
    EXISTS
    (
        SELECT DocumentoItem."CodigoDocumento", COUNT(*) 
        FROM Optisoul..DocumentoItem
        JOIN Optisoul..Item
        ON (Item."CodigoItem" = DocumentoItem."CodigoItem")
        WHERE
            Documento."CodigoDocumento" = DocumentoItem."CodigoDocumento"
            and DocumentoItem."TipoItem" = 'Armação'
            and Item."Tipo" = 'Óculos Sol'
        GROUP BY DocumentoItem."CodigoDocumento"
        HAVING COUNT(*) = 1
    );

-----------------------------------------------------------------------------------------------------
--UPDATE DO TITULAR
drop table if exists temp_fatturac

create table temp_fatturac
(
    "codice fornitore" varchar(30),
    "codice transdet" varchar(12),
    "codice azienda" varchar(30)
)
/*
create index codforidx on #temp_fatturac("codice fornitore"); //NOMODIFICA
create index codtdidx on #temp_fatturac("codice transdet"); //NOMODIFICA    
*/
insert into temp_fatturac
select
    'clienti.' + fc."codice fornitore",
    fc."codice transdet",
    'fornitor.' + fc."codice azienda"
from fatturaclienti as fc
where fc."codice transdet" <> ''

drop table if exists temp_v
create table temp_v
(
    "codice carrello" varchar(20),
    "codice cliente" varchar(25),
    "codice transazione" varchar(12)
);
/*
create index codcaridx on #temp_v("codice carrello"); //NOMODIFICA
create index codcliidx on #temp_v("codice cliente"); //NOMODIFICA
create index codtidx on #temp_v("codice transazione"); //NOMODIFICA    
*/
insert into temp_v
select distinct
    'car.' + car2."codice carrello" as "codice carrello",
    'clienti.' + car2."codice cliente",
    car2."codice transazione"
from carrello2 as car2    

insert into temp_v
select distinct
    'scar.' + scar2."codice carrello" as "codice carrello",
    'clienti.' + scar2."codice cliente",
    scar2."codice transazione"
from storicocarrello2 as scar2    


update Optisoul..Documento
set Documento."CodigoContato" = 
isnull((
    select distinct -- a transdet pode produzir mais do que um resultado para o mesmo registro de venda, por isso o MAX
        Contato.[CodigoContato] 
    from temp_v as v
    join transdet as td
        on (td."codice transazione" = v."codice transazione")
    join temp_fatturac as fc
        on (fc."codice transdet" = td."codice filiale")
    join Optisoul..Contato
        on (Contato.[CodigoAntigo] = fc."codice fornitore")
    where
        (v."codice cliente" <> fc."codice fornitore") and
        (v."codice carrello" = Documento.[idant])
), Documento.[CodigoContato])
where
    Documento."Tipo" = 'Venda';

--CONVÊNIO
update Optisoul..Documento
set Documento."CodigoContatoResponsavel" = 
(
    select distinct
        Contato.[CodigoContato]
    from temp_v as v
    join transdet as td
        on (td."codice transazione" = v."codice transazione")
    join temp_fatturac as fc
        on (fc."codice transdet" = td."codice filiale")
    join Optisoul..Contato
        on (Contato.[CodigoAntigo] = fc."codice azienda")
    where
        (fc."codice azienda" <> '') and
        (v."codice carrello" = Documento.[idant])
)
where
    Documento."Tipo" = 'Venda';

update Optisoul..Documento
set Documento."ContatoResponsavelEmail" = 
(
    select
        c."EmailNFe"
    from Optisoul..Contato as c
    where
        (c."CodigoContato" = Documento."CodigoContatoResponsavel")
)
where
    Documento."CodigoContatoResponsavel" is not null;

drop table temp_fatturac
drop table temp_v