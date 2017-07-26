//NOSQLBDETOFF2
/*Precisa ser rodado para encontrar a venda original que gerou a devolução*/
--TEMP DEVOLUÇÃO
create table #temp_devolvido //NOMODIFICA
    (
        "CodigoTransacao" varchar(12),
        "CodigoCarrinho" varchar(12),
        "CodigoCarrinhoItem" varchar(12),
        "Data" date,
        "CodigoItem" varchar(12),
        "Descricao" varchar(100),
        "Usado" boolean
    );

insert into #temp_devolvido //NOMODIFICA
    (
        select
            storicocarrello2."codice transazione",
            storicocarrello2."codice carrello",
            storicocarrello2."codice filiale",
            storicocarrello2."data",
            storicocarrello2."codice articolo",
            storicocarrello2."descrizione",
            False
        from storicocarrello2
        where
            storicocarrello2."reso" = TRUE
    );

DECLARE vData date;
DECLARE vCodigoTransacaoDevolucao, vCodigoItem, vCodigoCarrinhoItem varchar(12);
DECLARE vCodigoAntigo varchar(150);
DECLARE vDescricao varchar(100);

DECLARE DevolucaoCursor CURSOR FOR
    select *
    from
        ( 
            select 
                'car2.' + CAST(car2."codice filiale" as varchar(12)),
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
        );

OPEN DevolucaoCursor;

FETCH NEXT FROM DevolucaoCursor INTO vCodigoAntigo, vCodigoItem, vCodigoTransacaoDevolucao, vData, vDescricao;
WHILE @@FETCH_STATUS = 0 DO
    SET vCodigoCarrinhoItem =
        (
            select MIN(td."CodigoCarrinhoItem")
            from #temp_devolvido as td //NOMODIFICA
            where
                (td."CodigoTransacao" = vCodigoTransacaoDevolucao) and
                (td."CodigoItem" = vCodigoItem) and
                (td."Data" <= vData) and
                (td."Usado" = False)
        );

    IF vCodigoCarrinhoItem IS NULL 
        THEN
            SET vCodigoCarrinhoItem =
                (
                    select MIN(td."CodigoCarrinhoItem")
                    from #temp_devolvido as td //NOMODIFICA
                    where
                        (td."CodigoTransacao" = vCodigoTransacaoDevolucao) and
                        (td."Descricao" = vDescricao) and
                        (td."Data" <= vData) and
                        (td."Usado" = False)
                );
    END IF;

    IF vCodigoCarrinhoItem IS NOT NULL
        THEN
            update #temp_devolvido as td //NOMODIFICA
            set td."Usado" = True
            where td."CodigoCarrinhoItem" = vCodigoCarrinhoItem;

            update DocumentoItem as di
            set 
                di."CodigoDocumentoVenda" = 
                    (
                        select MAX(di2."CodigoDocumento")
                        from DocumentoItem as di2
                        where
                            (di2."CodigoAntigo" = 'scar2.' + vCodigoCarrinhoItem)
                    ), 
                di."CodigoDocumentoItemVenda" = 'scar2.' + vCodigoCarrinhoItem
            where
                (di."CodigoAntigo" = vCodigoAntigo);
    END IF;

    FETCH NEXT FROM DevolucaoCursor INTO vCodigoAntigo, vCodigoItem, vCodigoTransacaoDevolucao, vData, vDescricao;
END WHILE;

CLOSE DevolucaoCursor;
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
update Documento
set Documento."Operacao" = 'Óculos de Sol'
where
    EXISTS
    (
        SELECT DocumentoItem."CodigoDocumento", COUNT(*) 
        FROM DocumentoItem
        JOIN Item
        ON (Item."CodigoAntigo" = DocumentoItem."CodigoItem")
        WHERE
            Documento."CodigoDocumento" = DocumentoItem."CodigoDocumento"
            and DocumentoItem."TipoItem" = 'Armação'
            and Item."Tipo" = 'Óculos Sol'
        GROUP BY DocumentoItem."CodigoDocumento"
        HAVING COUNT(*) = 1
    );