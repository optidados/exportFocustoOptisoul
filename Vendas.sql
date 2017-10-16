//NOSQLBDETOFF2
/*Apaga a tabela vendas se ela já existir e cria novamente*/
DROP TABLE IF EXISTS Vendas;
create table Vendas
(
    "operador" varchar(6),
    "data pagamento" date,
    "nome" varchar(51),
    "codigo barras" varchar(14),
    "SKU e Cod Catalogo" varchar(30),
    "Fornecedor" varchar(70),
    "Estoque" varchar(30),
    "Tipos" varchar(40),
    "Familia" varchar(40),
    "Marca" varchar(40),
    "Linha" varchar(60),
    "TipoProduto" varchar(40),
    "Modelo" varchar(80),
    "Descricao" varchar(100),
    "Cor" varchar(40),
    "Tamanho" float,
    "tipo_pag" varchar(30),
    "filiale" varchar(2),
    "valor_trans" numeric(18, 2)
);

--DROP DA TEMPORARIA DE SESSAO
    DROP TABLE IF EXISTS ##car; //NOMODIFICA

--DATA
declare data_dal date;        
declare data_al date;
set data_dal = #DATA
;
set data_al = #DATA
;

--CUSTO --TAB PRECOS --ULT COMPRA --CUSTO MEDIO
declare custo varchar(15);
set custo = 'Custo Médio'; --fixando custo pelo custo médio mfc 25-02-2016

--DATA BASE --PAGAMENTO OU CARRINHO
declare info2 varchar(50);        
set info2 = 'Pagamento'; --FIXANDO DATA DO PAGAMENTO PARA A CRISLEN --FAZER PARA AS OUTRAS SITUAÇÕES

--DETALHAR POR OPERADOR
declare op integer;
set op = 1; --SERMPRE VAI DETALHAR POR OPERADOR

--ESTORNOS
create table #estorno //NOMODIFICA
(
    "codigo trans"  varchar(12),
    "totale" money
);

create index ctridx on #estorno("codigo trans"); //NOMODIFICA

insert into #estorno //NOMODIFICA
select
    t1."codice transazione" as "codigo trans",
    SUM(t1."totale")
from
    storicocarrello2 as t1
where
    (t1."tipo fornitura" = 101) --ADICIONAR FILTRO DE DATA????
group by t1."codice transazione";

create table #totalcar_ //NOMODIFICA
    (
        total money,
        "cod trans" varchar(12) 
    );

insert into #totalcar_ //NOMODIFICA
    (        
        select
            SUM(c."totale") as "totale",
            c."codice transazione"
        from carrello2 c
        where
            (c."pagato" IS TRUE) and
            (c."codice transazione" <> '') and
            (c."codice transazione" IS NOT NULL) and
            ((CASE WHEN c."tipo fornitura" = 100 THEN c."quantita" ELSE -1 END) < 0) and
            (c."tipo fornitura" <> 101)
        Group by
            c."codice transazione"
    );

insert into #totalcar_ //NOMODIFICA
    (
        select
            SUM(sc."totale"),
            sc."codice transazione"
        from storicocarrello2 sc
        where
            (sc."pagato" IS TRUE) and
            (sc."codice transazione" <> '') and
            (sc."codice transazione" IS NOT NULL) and
            ((CASE WHEN sc."tipo fornitura" = 100 THEN sc."quantita" ELSE -1 END) < 0) and
            (sc."tipo fornitura" <> 101)
        Group by
            sc."codice transazione"  
    );

--TABELA TEMPORÁRIO VALOR TOTAL DO CARRINHO
create table #totalcar //NOMODIFICA
    (
        total money,
        "cod trans" varchar(12)
    );

create index codtrans on #totalcar("cod trans"); //NOMODIFICA
    
insert into #totalcar //NOMODIFICA
    (   
        select
           SUM(t1."total"),
           t1."cod trans"
        from #totalcar_ as t1 //NOMODIFICA
        group by t1."cod trans"
    );
    
create table #totalcar2_ //NOMODIFICA
    (
        total money,
        "cod trans" varchar(12),
        "numero dav" varchar(13)
    );

insert into #totalcar2_ //NOMODIFICA
    (
        select
            SUM(c2."totale") as "totale",
            c2."codice transazione",
            c1."numero dav"
        from carrello c1, carrello2 c2
        where
            --(c2."pagato" IS TRUE) and-- FOI RETIRADO POR QUE DEVOLUÇÕES NO CARRINHO NÃO TEM PAGAMENTO
            --(c2."codice transazione" <> '') and-- FOI RETIRADO POR QUE DEVOLUÇÕES NO CARRINHO NÃO TEM PAGAMENTO
            --(c2."codice transazione" IS NOT NULL) and-- FOI RETIRADO POR QUE DEVOLUÇÕES NO CARRINHO NÃO TEM PAGAMENTO
            (c2."tipo fornitura" <> 100) and
            (c2."tipo fornitura" <> 101) and
            (c1."codice filiale" = c2."codice carrello")
        Group by
            c2."codice transazione", c1."numero dav"
    );

insert into #totalcar2_ //NOMODIFICA
    (
        select
            SUM(sc2."totale"),
            sc2."codice transazione",
            sc1."numero dav"
        from storicocarrello sc1, storicocarrello2 sc2
        where
            (sc2."pagato" IS TRUE) and
--            (sc2."codice transazione" <> '') and --mfc25-02-16 comentado para poder ter produtos devolvidos com vendas abaixo
--            (sc2."codice transazione" IS NOT NULL) and --mfc25-02-16 comentado para poder ter produtos devolvidos com vendas abaixo
            (sc2."tipo fornitura" <> 100) and
            (sc2."tipo fornitura" <> 101) and
            (sc1."codice filiale" = sc2."codice carrello")
        Group by
            sc2."codice transazione", sc1."numero dav" 
    );

--TABELA TEMPORÁRIO VALOR TOTAL DO CARRINHO SEM DEVOLUÇÕES TAMBÉM
create table #totalcar2 //NOMODIFICA
    (
        total money,
        "cod trans" varchar(12),
        "numero dav" varchar(13)
    );

create index codtrans on #totalcar2("cod trans"); //NOMODIFICA
create index coddav on #totalcar2("numero dav"); //NOMODIFICA
    
insert into #totalcar2 //NOMODIFICA
    (   select
            SUM(t1."total"),
            t1."cod trans",
            t1."numero dav"
        from #totalcar2_ as t1 //NOMODIFICA
        group by t1."cod trans", t1."numero dav"
    );

--BASE CRÉDITO
create table #bcredito //NOMODIFICA
(
    "codigo cli"  varchar(12),
    "codigo trans" varchar(12),
    "data" date,
    "operador" varchar(6),
    "total carrinho" money,
    "total estorno" money,
    "total trans" money,
    "total car" money,
    "trans proporcional" money,
    "filiale" varchar(2)
);

insert into #bcredito //NOMODIFICA
--CARRINHO PAGO, SEM ENTREGA
select
    carrello2."codice cliente",
    carrello2."codice transazione",
    transazioni."data",
    carrello2."operatore",
    SUM(carrello2."totale") as "Total Carrinho",
    (SUM(carrello2."totale") / CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END) * coalesce(estorno."totale", 0) as "Total Estorno",
    transazioni."totale",
    tc."total",
    ((SUM(carrello2."totale") / CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END) * transazioni."totale"),
    transazioni."filiale"
from
    carrello2
    left join #estorno as estorno //NOMODIFICA
        on (carrello2."codice transazione" = estorno."codigo trans")
    join transazioni
        on (carrello2."codice transazione" = transazioni."codice filiale")
    join #totalcar tc //NOMODIFICA
        on (carrello2."codice transazione" = tc."cod trans")
where
    (carrello2."pagato" IS TRUE) and
    (carrello2."codice transazione" <> '') and
    (carrello2."codice transazione" IS NOT NULL) and
    ((CASE WHEN carrello2."tipo fornitura" = 100 THEN carrello2."quantita" ELSE -1 END) < 0) and
    (carrello2."tipo fornitura" <> 101) and
    (transazioni."data" >= data_dal) and
    (transazioni."data" <= data_al)
group by
    carrello2."codice cliente", 
    carrello2."codice transazione", 
    transazioni."data", 
    carrello2."operatore", 
    estorno."totale",
    transazioni."totale",
    tc."total",
    transazioni."filiale"
    
UNION

--STORICOCARRELLO ESTORNO
select
    storicocarrello2."codice cliente",
    storicocarrello2."codice transazione",
    transazioni."data",
    storicocarrello2."operatore",
    SUM(storicocarrello2."totale"),
    (SUM(storicocarrello2."totale") / CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END) * coalesce(estorno."totale", 0),
    transazioni."totale",
    tc."total",
    ((SUM(storicocarrello2."totale") / CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END) * transazioni."totale"),
    transazioni."filiale"
from
    storicocarrello2
    left join #estorno as estorno //NOMODIFICA
        on (storicocarrello2."codice transazione" = estorno."codigo trans")
    join transazioni
        on (storicocarrello2."codice transazione" = transazioni."codice filiale")
    join #totalcar tc //NOMODIFICA
        on (storicocarrello2."codice transazione" = tc."cod trans")
where
    (storicocarrello2."pagato" IS TRUE) and
    (storicocarrello2."codice transazione" <> '') and
    (storicocarrello2."codice transazione" IS NOT NULL) and
    ((CASE WHEN storicocarrello2."tipo fornitura" = 100 THEN storicocarrello2."quantita" ELSE -1 END) < 0) and
    (storicocarrello2."tipo fornitura" <> 101) and
    (transazioni."data" >= data_dal) and
    (transazioni."data" <= data_al)
group by
    storicocarrello2."codice cliente", 
    storicocarrello2."codice transazione",
    transazioni."data", 
    storicocarrello2."operatore", 
    estorno."totale",
    transazioni."totale",
    tc."total",
    transazioni."filiale";
    
--TOTAL TRANSDET
create table #total_trans( //NOMODIFICA
    "codice filiale" varchar(12),
    total_trans money
);

create index codidx on #total_trans("codice filiale"); //NOMODIFICA

insert into #total_trans( //NOMODIFICA
    select
        transazioni."codice filiale",
        SUM(transdet."totale")
    from transazioni
    join transdet
        on (transazioni."codice filiale" = transdet."codice transazione")
    where
        transazioni."data" >= data_dal and
        transazioni."data" <= data_al and
        (transazioni."annullato" = FALSE or transazioni."annullato" IS NULL)
    group by transazioni."codice filiale"
);
    
--TEMP COM AS TRANSAÇÕES PARA A COMISSÃO
create table #temp_trans( //NOMODIFICA
    cod_trans varchar(12),
    cod_filiale varchar(12),
    tipo varchar(30),
    valor money,
    total_trans money
);

create index transidx on #temp_trans("cod_trans"); //NOMODIFICA

insert into #temp_trans( //NOMODIFICA
    select
        transdet."codice transazione",
        transdet."codice filiale",
        transdet."tipo",
        transdet."totale",
        t1."total_trans"
    from transdet
    join #total_trans as t1 //NOMODIFICA
        on (t1."codice filiale" = transdet."codice transazione")
);

--TEMP DEVOLUÇÃO
create table #temp_devolvido //NOMODIFICA
    (
        "codigo de barras" varchar(14),
        descricao varchar(100),
        preco real,
        quantidade integer,
        total real,
        "codice articolo" varchar(12),
        filial varchar(2),
        "codigo estoque" varchar(12),
        operador varchar(6),
        "codcli" varchar(12), --mfc 25/02/2016 para ligar com a car
        "data" date, --mfc 13-07-2016 para fazer a ligação com a car corretamente
        "numero dav" varchar(13)  --mfc 13-07-2016 para fazer a ligação com a car corretamente
    );
    
insert into #temp_devolvido //NOMODIFICA
    (
        select
            storicocarrello2."codice a barre",
            storicocarrello2."descrizione",
            storicocarrello2."prezzo",
            storicocarrello2."quantita",
            storicocarrello2."totale",
            storicocarrello2."codice articolo",
            storicocarrello2."filiale",
            storicocarrello2."codice magazzino",
            storicocarrello2."operatore",
            storicocarrello2."codice cliente",
            storicocarrello2."data", --mfc 13-07-2016 para fazer ligação com a car
            storicocarrello."numero dav" --mfc 13-07-2016 para fazer ligação com a car
        from storicocarrello --mfc 13-07-2016 para fazer ligação com a car
        join storicocarrello2 --mfc 13-07-2016 para fazer ligação com a car
            on (storicocarrello."codice filiale" = storicocarrello2."codice carrello") --mfc 13-07-2016 para fazer ligação com a car
        where
            storicocarrello2."reso" = TRUE
    );

--TABELA PRINCIPAL    
create table #Vendas1 //NOMODIFICA
    (                            
        "data" date,                 
        "ordem" varchar(12),
        "codtrans" varchar(24),   
        "codigo barras" varchar(14),    
        "SKU e Cod Catalogo" varchar(25),                               
        "Fornecedor" varchar(50),                  
        "estoque" varchar(30),              
        "Tipos" varchar(50),        
        "Familia" varchar(20),
        "Marca" varchar(25),
        "Linha" varchar(45),
        "TipoProduto" varchar(25),
        "Modelo" varchar(60),
        "Descricao" varchar(100),
        "Cor" varchar(25),
        "Tamanho" real,
        "quantia" integer,                                                     
        "custo" real,
        "valor" real,                               
        "desconto" real,
        "total" real,
        "operador" varchar(6),
        "filiale" varchar(2),
        "MagazzinoX" integer,
        "Forma" integer,
        "tipofor" integer,
        "codart" varchar(12),
        "tipo_pag" varchar(30),
        "valor_trans" money,
        "cod_cliente" varchar(12),
        "data pagamento" date,
        "non scontabile" boolean
    );
	
--TABELA COM AS VENDAS --CARRINHO E HISTORICO
create table ##car //NOMODIFICA
    (
        data date,
        "data pagamento" date,
        codfil varchar(12), 
        codtrans varchar(12),         
        codbar varchar(14),
        estoque integer,
        descricao varchar(100),
        qtd integer,
        valor real,
        desc real,
        totalcar real,
        op varchar(6),
        filiale varchar(2),
        codmag varchar(12),
        tipofordet integer,
        codfor varchar(12),
        codart varchar(12),  
        tipofor integer,
        tipoinfo varchar(20),
        "MagazzinoX" integer,
        "Forma" integer,
        "numero dav" varchar(13),
        "tipo_pag" varchar(30),
        valor_trans money,
        "cod_cliente" varchar(12),
        "cod_transdet" varchar(12),
        totaltodev real --25/02/2016 mfc para calcular proporcional do custo da devolução
    );

create index articoloidx on ##car("codart", "filiale", "codmag"); //NOMODIFICA
create index foridx on ##car("codfor"); //NOMODIFICA
create index filialeidx on ##car("codfil"); //NOMODIFICA
create index estoqueidx on ##car("estoque"); //NOMODIFICA
create index tipoforidx on ##car("tipofor"); //NOMODIFICA
create index tipofordetidx on ##car("tipofordet"); //NOMODIFICA
create index qtdidx on ##car("qtd"); //NOMODIFICA
create index codtransidx on ##car("codtrans"); //NOMODIFICA
create index cliidx on ##car("cod_cliente"); //NOMODIFICA

---CARRINHO---
insert into ##car //NOMODIFICA
    (       
        select
        carrello2."data",
        carrello2."data pagamento",
        carrello2."codice filiale", 
        carrello2."codice transazione",
        carrello2."codice a barre",
        CASE WHEN ((carrello2."codice articolo" = '') OR (carrello2."codice articolo" IS NULL)) THEN carrello2."magazzino" ELSE (articoli."magazzino") END as estoque,
        carrello2."descrizione",
        carrello2."quantita",
        CASE WHEN ((carrello2."codice transazione" = '' or carrello2."codice transazione" IS NULL) and (carrello2."pagato" = TRUE) and (carrello2."tipo fornitura" <> 100)) THEN 0 ELSE carrello2."prezzo" END, --mfc--25-02-2016 aparecer o valor sempre para devoluções, pois liga pelo valor a devoluçao com a temp_devolvido
        CASE WHEN ((carrello2."codice transazione" = '' or carrello2."codice transazione" IS NULL) and (carrello2."pagato" = TRUE)) THEN 0 ELSE carrello2."sconto" END,
        CASE WHEN ((carrello2."codice transazione" = '' or carrello2."codice transazione" IS NULL) and (carrello2."pagato" = TRUE) and (carrello2."tipo fornitura" <> 100)) THEN 0 ELSE carrello2."totale" END, --mfc--25-02-2016 aparecer o valor sempre para devoluções, pois liga pelo valor a devoluçao com a temp_devolvido
        carrello2."operatore",
        carrello2."filiale",
        carrello2."codice magazzino",
        carrello2."tipo fornitura dettaglio",
        carrello2."codice fornitura",
        carrello2."codice articolo",
        carrello2."tipo fornitura",
        CASE WHEN (carrello2."pagato" = FALSE) THEN 'Sem Pagto. Definido' ELSE (CASE WHEN (carrello2."pagato" = TRUE) THEN 'Com Pagto. Definido' ELSE '' END) END,
        (CASE WHEN (Not (carrello2."magazzino" is null)) THEN carrello2."Magazzino"
              WHEN ((carrello2."tipo Fornitura">=1) AND (carrello2."tipo Fornitura"<=5) AND (carrello2."tipo Fornitura dettaglio"=1)) THEN 0
              WHEN ((carrello2."tipo Fornitura">=1) AND (carrello2."tipo Fornitura"<=5) AND (carrello2."tipo Fornitura dettaglio"=2)) THEN 1
              WHEN ((carrello2."tipo Fornitura">=1) AND (carrello2."tipo Fornitura"<=5) AND (carrello2."tipo Fornitura dettaglio"=3)) THEN 1
              WHEN ((carrello2."tipo Fornitura">=9) AND (carrello2."tipo Fornitura"<=10)AND (carrello2."tipo Fornitura dettaglio"<9)) THEN 2
              WHEN ((carrello2."tipo Fornitura">=9) AND (carrello2."tipo Fornitura"<=10)AND (carrello2."tipo Fornitura dettaglio">=9)) THEN 3
              WHEN ((carrello2."tipo Fornitura"=100) AND ("quantita"<0)) THEN 99 //reso
              WHEN ((carrello2."tipo Fornitura"=103) AND ("quantita"<0)) THEN 99 //reso
              WHEN (carrello2."tipo Fornitura">=100) THEN carrello2."tipo Fornitura"
              ELSE 9
              END) as "MagazzinoX",
        (CASE WHEN ((carrello2."magazzino" is null) AND (carrello2."tipo Fornitura"=100 )AND("quantita">0)) THEN 100 //acconto
              WHEN ((carrello2."magazzino" is null) AND (carrello2."tipo Fornitura"=101 )) THEN 101 //storno
              WHEN ((carrello2."magazzino" is null) AND (carrello2."tipo Fornitura"=100 )AND("quantita"<0)) THEN 99 //reso
              WHEN ((carrello2."magazzino" is null) AND (carrello2."tipo Fornitura"=103 )AND("quantita"<0)) THEN 99//reso
              ELSE 0
              END) as "Forma",
        carrello."numero dav",
        trans."tipo",
        trans."valor"*(CASE WHEN ((carrello2."codice transazione" = '' or carrello2."codice transazione" IS NULL) and (carrello2."pagato" = TRUE)) THEN 0 ELSE carrello2."totale" END)/trans."total_trans",
        carrello2."codice cliente",
        trans."cod_filiale",
        carrello2."totale"

        from carrello, carrello2
        
        left join #temp_trans as trans //NOMODIFICA
            on (carrello2."codice transazione" = trans."cod_trans")
        
        left join articoli
            on carrello2."codice articolo" = articoli."codice filiale"

        where 
        (((carrello2."data" >= data_dal) and (carrello2."data" <= data_al)) or ((carrello2."data pagamento" >= data_dal) and (carrello2."data pagamento" <= data_al)))
        and (carrello."codice filiale" = carrello2."codice carrello")
        and ((CASE WHEN carrello2."tipo fornitura" = 100 THEN carrello2."quantita" ELSE -1 END) < 0)
    );

create table #soma_car  //NOMODIFICA
    (
        "codice cliente" varchar(12), 
        "codice filiale" varchar(12),
        "soma_prezzo" money, 
        "soma_totale" money
    );

create index codcliente on #soma_car("codice cliente"); //NOMODIFICA

insert into #soma_car //NOMODIFICA --SEPARAR PSEUDO PARA TEMPORARIA???
    (
        select 
            soma."codice cliente", 
            sinal_soma."codice filiale",
            SUM(soma."prezzo") soma_prezzo, 
            SUM(soma."totale") soma_totale
        from 
            (
                select
                    MAX(carrello."codice cliente") as "codice cliente",
                    MAX(carrello."prezzo") as "prezzo",
                    MAX(carrello."totale") as "totale",
                    MAX(carrello."tipo fornitura") as "tipo fornitura",
                    MAX(carrello."data") as "data"
                from carrello, carrello2
                where
                    carrello."codice filiale" = carrello2."codice carrello"
                    and carrello2."pagato" = FALSE
                Group by
                    carrello."codice filiale"
            ) soma, 
            carrello sinal_soma
        where 
            soma."tipo fornitura" <> 100
            and sinal_soma."tipo fornitura" = 100
            and ((CAST(sinal_soma."data" as integer) - (CAST(soma."data" as integer))) >= 0)
            and soma."codice cliente" = sinal_soma."codice cliente"
        group by soma."codice cliente", sinal_soma."codice filiale"
    );

---CARRINHO SINAL---
insert into ##car //NOMODIFICA
    (       
        select
        csinal."data",
        csinal."data",
        csinal."codice filiale", 
        csinal."codice transazione",
        csinal."codice a barre",
        CASE WHEN(csinal."codice articolo" = '') THEN csinal."magazzino" ELSE null END as estoque,
        csinal."descrizione",
        csinal."quantita",
        (csinal."prezzo" * -1)*(carrello2."prezzo")/soma_car."soma_prezzo",
        csinal."sconto",
        (csinal."totale" * -1)*(carrello2."totale")/soma_car."soma_totale",
        carrello2."operatore",
        csinal."filiale",
        csinal."codice magazzino",
        csinal."tipo fornitura dettaglio",
        csinal."codice fornitura",
        csinal."codice articolo",
        csinal."tipo fornitura",
        'Com Pagto. Definido',
        (CASE WHEN (Not (csinal."magazzino" is null)) THEN csinal."Magazzino"
              WHEN ((csinal."tipo Fornitura">=1) AND (csinal."tipo Fornitura"<=5) AND (csinal."tipo Fornitura dettaglio"=1)) THEN 0
              WHEN ((csinal."tipo Fornitura">=1) AND (csinal."tipo Fornitura"<=5) AND (csinal."tipo Fornitura dettaglio"=2)) THEN 1
              WHEN ((csinal."tipo Fornitura">=1) AND (csinal."tipo Fornitura"<=5) AND (csinal."tipo Fornitura dettaglio"=3)) THEN 1
              WHEN ((csinal."tipo Fornitura">=9) AND (csinal."tipo Fornitura"<=10)AND (csinal."tipo Fornitura dettaglio"<9)) THEN 2
              WHEN ((csinal."tipo Fornitura">=9) AND (csinal."tipo Fornitura"<=10)AND (csinal."tipo Fornitura dettaglio">=9)) THEN 3
              WHEN ((csinal."tipo Fornitura"=100) AND (csinal."quantita"<0)) THEN 99 //reso
              WHEN ((csinal."tipo Fornitura"=103) AND (csinal."quantita"<0)) THEN 99 //reso
              WHEN (csinal."tipo Fornitura">=100) THEN csinal."tipo Fornitura"
              ELSE 9
              END) as "MagazzinoX",
        (CASE WHEN ((csinal."magazzino" is null) AND (csinal."tipo Fornitura"=100 )AND(csinal."quantita">0)) THEN 100 //acconto
              WHEN ((csinal."magazzino" is null) AND (csinal."tipo Fornitura"=101 )) THEN 101 //storno
              WHEN ((csinal."magazzino" is null) AND (csinal."tipo Fornitura"=100 )AND(csinal."quantita"<0)) THEN 99 //reso
              WHEN ((csinal."magazzino" is null) AND (csinal."tipo Fornitura"=103 )AND(csinal."quantita"<0)) THEN 99//reso
              ELSE 0
              END) as "Forma",
        '',
        trans."tipo",
        trans."valor"*((csinal."totale" * -1)*(carrello2."totale")/soma_car."soma_totale")/trans."total_trans",
        csinal."codice cliente",
        trans."cod_filiale",
        0

        from 
            carrello

            inner join #soma_car as soma_car //NOMODIFICA
            on soma_car."codice cliente" = carrello."codice cliente", --LIGAÇÃO TEMP TAB E TAB PRINCIPAL--

            carrello2 as csinal
            join #temp_trans as trans //NOMODIFICA
                on (csinal."codice transazione" = trans."cod_trans"),

            carrello2

        where
        ((csinal."data" >= data_dal) and (csinal."data" <= data_al))
        and (carrello."codice filiale" = carrello2."codice carrello")
        and (carrello2."codice cliente" = csinal."codice cliente")
        and (csinal."tipo fornitura" = 100) --TAB RENOMEADA COM SINAL FIXO--
        and (carrello2."tipo fornitura" <> 100) --TAB PRINC. SEM SINAL--
        and ((CAST (csinal."data" as INTEGER) - (CAST (carrello2."data" as INTEGER))) >=0) --DIFERENCIAÇÃO DE VENDA POR DATA-- IMPLEMENTAR POR NÚMERO DAV????
        and (soma_car."codice filiale" = csinal."codice carrello") --LIGAÇÃO PSEUDO TAB COM TAB RENOMEADA--
    );

---HISTORICO CARRELLO---
insert into ##car //NOMODIFICA
    (                          
        select
        storicocarrello2."data",
        storicocarrello2."data pagamento",
        storicocarrello2."codice filiale",
        storicocarrello2."codice transazione",
        storicocarrello2."codice a barre",
        CASE WHEN ((storicocarrello2."codice articolo" = '') OR (storicocarrello2."codice articolo" IS NULL)) THEN storicocarrello2."magazzino" ELSE(articoli."magazzino")END as Estoque,
        storicocarrello2."descrizione",
        storicocarrello2."quantita",
        CASE WHEN ((storicocarrello2."codice transazione" = '' or storicocarrello2."codice transazione" IS NULL) and (storicocarrello2."pagato" = TRUE) and (storicocarrello2."tipo fornitura" <> 100)) THEN 0 ELSE storicocarrello2."prezzo" END, --mfc--25-02-2016 aparecer o valor sempre para devoluções, pois liga pelo valor a devoluçao com a temp_devolvido
        CASE WHEN ((storicocarrello2."codice transazione" = '' or storicocarrello2."codice transazione" IS NULL) and (storicocarrello2."pagato" = TRUE)) THEN 0 ELSE storicocarrello2."sconto" END,
        CASE WHEN ((storicocarrello2."codice transazione" = '' or storicocarrello2."codice transazione" IS NULL) and (storicocarrello2."pagato" = TRUE) and (storicocarrello2."tipo fornitura" <> 100)) THEN 0 ELSE storicocarrello2."totale" END, --mfc--25-02-2016 aparecer o valor sempre para devoluções, pois liga pelo valor a devoluçao com a temp_devolvido
        storicocarrello2."operatore",
        storicocarrello2."filiale",
        storicocarrello2."codice magazzino",
        storicocarrello2."tipo fornitura dettaglio",
        storicocarrello2."codice fornitura",
        storicocarrello2."codice articolo",
        storicocarrello2."tipo fornitura",
        'Com Pagto. Definido',
        (CASE WHEN (Not (storicocarrello2."magazzino" is null)) THEN storicocarrello2."Magazzino"
              WHEN ((storicocarrello2."tipo Fornitura">=1) AND (storicocarrello2."tipo Fornitura"<=5) AND (storicocarrello2."tipo Fornitura dettaglio"=1)) THEN 0
              WHEN ((storicocarrello2."tipo Fornitura">=1) AND (storicocarrello2."tipo Fornitura"<=5) AND (storicocarrello2."tipo Fornitura dettaglio"=2)) THEN 1
              WHEN ((storicocarrello2."tipo Fornitura">=1) AND (storicocarrello2."tipo Fornitura"<=5) AND (storicocarrello2."tipo Fornitura dettaglio"=3)) THEN 1
              WHEN ((storicocarrello2."tipo Fornitura">=9) AND (storicocarrello2."tipo Fornitura"<=10)AND (storicocarrello2."tipo Fornitura dettaglio"<9)) THEN 2
              WHEN ((storicocarrello2."tipo Fornitura">=9) AND (storicocarrello2."tipo Fornitura"<=10)AND (storicocarrello2."tipo Fornitura dettaglio">=9)) THEN 3
              WHEN ((storicocarrello2."tipo Fornitura"=100) AND ("quantita"<0)) THEN 99 //reso
              WHEN ((storicocarrello2."tipo Fornitura"=103) AND ("quantita"<0)) THEN 99 //reso
              WHEN (storicocarrello2."tipo Fornitura">=100) THEN storicocarrello2."tipo Fornitura"
              ELSE 9
              END) as "MagazzinoX",
        (CASE WHEN ((storicocarrello2."magazzino" is null) AND (storicocarrello2."tipo Fornitura"=100 )AND("quantita">0)) THEN 100 //acconto
              WHEN ((storicocarrello2."magazzino" is null) AND (storicocarrello2."tipo Fornitura"=101 )) THEN 101 //storno
              WHEN ((storicocarrello2."magazzino" is null) AND (storicocarrello2."tipo Fornitura"=100 )AND("quantita"<0)) THEN 99 //reso
              WHEN ((storicocarrello2."magazzino" is null) AND (storicocarrello2."tipo Fornitura"=103 )AND("quantita"<0)) THEN 99//reso
              ELSE 0
              END) as "Forma",
        storicocarrello."numero dav",
        trans."tipo",
        trans."valor"*(CASE WHEN ((storicocarrello2."codice transazione" = '' or storicocarrello2."codice transazione" IS NULL) and (storicocarrello2."pagato" = TRUE)) THEN 0 ELSE storicocarrello2."totale" END)/trans."total_trans",
        storicocarrello2."codice cliente",
        trans."cod_filiale",
        storicocarrello2."totale"
        
        from storicocarrello, storicocarrello2
        
        left join #temp_trans as trans //NOMODIFICA
            on (storicocarrello2."codice transazione" = trans."cod_trans")

        left join articoli
            on storicocarrello2."codice articolo" = articoli."codice filiale"

        where
        (((storicocarrello2."data" >= data_dal) and (storicocarrello2."data" <= data_al)) or ((storicocarrello2."data pagamento" >= data_dal) and (storicocarrello2."data pagamento" <= data_al))) and
		(storicocarrello."codice filiale" = storicocarrello2."codice carrello")
        and ((CASE WHEN storicocarrello2."tipo fornitura" = 100 THEN storicocarrello2."quantita" ELSE -1 END) < 0)
        and (storicocarrello2."tipo fornitura" <> 101)
    );

create table #soma_scar  //NOMODIFICA
    (
        "codice cliente" varchar(12), 
        "codice filiale" varchar(12),
        "soma_prezzo" money, 
        "soma_totale" money
    );

create index codcliente on #soma_scar("codice cliente"); //NOMODIFICA

insert into #soma_scar //NOMODIFICA
    (
        select
            soma."codice cliente",
            sinal_soma."codice filiale",
            SUM(soma."prezzo") soma_prezzo,
            SUM(soma."totale") soma_totale
        from
            storicocarrello2 soma,
            storicocarrello2 sinal_soma
        where
                soma."tipo fornitura" <> 101
            and soma."tipo fornitura" <> 100
            and sinal_soma."tipo fornitura" = 100
            and soma."codice cliente" = sinal_soma."codice cliente"
            and soma."codice transazione" = sinal_soma."codice fornitura"
        group by
            soma."codice cliente", sinal_soma."codice filiale"
    );

--HISTORICO CARRELLO SINAL--
insert into ##car //NOMODIFICA
    (                          
        select
        scsinal."data",
        scsinal."data",
        scsinal."codice filiale",
        scsinal."codice transazione",
        scsinal."codice a barre",
        CASE WHEN(scsinal."codice articolo" = '') THEN scsinal."magazzino" ELSE null END as Estoque,
        scsinal."descrizione",
        scsinal."quantita",
        (scsinal."prezzo")*(storicocarrello2."prezzo")/soma_scar."soma_prezzo",
        scsinal."sconto",
        (scsinal."totale")*(storicocarrello2."totale")/soma_scar."soma_totale",
        storicocarrello2."operatore",
        scsinal."filiale",
        scsinal."codice magazzino",
        scsinal."tipo fornitura dettaglio",
        scsinal."codice fornitura",
        scsinal."codice articolo",
        scsinal."tipo fornitura",
        'Com Pagto. Definido',
        (CASE WHEN (Not (scsinal."magazzino" is null)) THEN scsinal."Magazzino"
              WHEN ((scsinal."tipo Fornitura">=1) AND (scsinal."tipo Fornitura"<=5) AND (scsinal."tipo Fornitura dettaglio"=1)) THEN 0
              WHEN ((scsinal."tipo Fornitura">=1) AND (scsinal."tipo Fornitura"<=5) AND (scsinal."tipo Fornitura dettaglio"=2)) THEN 1
              WHEN ((scsinal."tipo Fornitura">=1) AND (scsinal."tipo Fornitura"<=5) AND (scsinal."tipo Fornitura dettaglio"=3)) THEN 1
              WHEN ((scsinal."tipo Fornitura">=9) AND (scsinal."tipo Fornitura"<=10)AND (scsinal."tipo Fornitura dettaglio"<9)) THEN 2
              WHEN ((scsinal."tipo Fornitura">=9) AND (scsinal."tipo Fornitura"<=10)AND (scsinal."tipo Fornitura dettaglio">=9)) THEN 3
              WHEN ((scsinal."tipo Fornitura"=100) AND (scsinal."quantita"<0)) THEN 99 //reso
              WHEN ((scsinal."tipo Fornitura"=103) AND (scsinal."quantita"<0)) THEN 99 //reso
              WHEN (scsinal."tipo Fornitura">=100) THEN scsinal."tipo Fornitura"
              ELSE 9
              END) as "MagazzinoX",
        (CASE WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=100 )AND(scsinal."quantita">0)) THEN 100 //acconto
              WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=101 )) THEN 101 //storno
              WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=100 )AND(scsinal."quantita"<0)) THEN 99 //reso
              WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=103 )AND(scsinal."quantita"<0)) THEN 99//reso
              ELSE 0
              END) as "Forma",
        '',
        trans."tipo",
        trans."valor"*((scsinal."totale")*(storicocarrello2."totale")/soma_scar."soma_totale")/trans."total_trans",
        scsinal."codice cliente",
        trans."cod_filiale",
        0

        from storicocarrello

        inner join #soma_scar as soma_scar //NOMODIFICA
        on soma_scar."codice cliente" = storicocarrello."codice cliente", --LIGAÇÃO TEMP TAB E TAB PRINCIPAL--

        storicocarrello2 as scsinal
        join #temp_trans as trans //NOMODIFICA
            on (scsinal."codice transazione" = trans."cod_trans"),            
            
        storicocarrello2
        
        where
        ((scsinal."data" >= data_dal) and (scsinal."data" <= data_al))
        and (storicocarrello."codice filiale" = storicocarrello2."codice carrello")
        and (storicocarrello2."codice cliente" = scsinal."codice cliente")
        and (scsinal."tipo fornitura" = 100)--TAB RENOMEADA COM SINAL FIXO--
        and (storicocarrello2."tipo fornitura" <> 100) --TAB PRINCIPAL SEM SINAL--
        and (storicocarrello2."tipo fornitura" <> 101) --TAB PRINCIPAL SEM ESTORNO--
        and (soma_scar."codice filiale" = scsinal."codice filiale") --LIGAÇÃO PSEUDO TAB COM TAB RENOMEADA--
        and (scsinal."codice fornitura" = storicocarrello2."codice transazione") --LIGAÇÃO DO SINAL COM PRODUTOS E ESTORNO--
    );

create table #soma_scestorno  //NOMODIFICA
    (
        "codice cliente" varchar(12), 
        "codice filiale" varchar(12),
        "soma_prezzo" money, 
        "soma_totale" money
    );

create index codcliente on #soma_scestorno("codice cliente"); //NOMODIFICA

insert into #soma_scestorno //NOMODIFICA
    (
        select
            soma."codice cliente",
            sinal_soma."codice filiale",
            SUM(soma."prezzo") soma_prezzo,
            SUM(soma."totale") soma_totale
        from
            storicocarrello2 soma,
            storicocarrello2 sinal_soma
        where
                soma."tipo fornitura" <> 101
            and soma."tipo fornitura" <> 100
            and sinal_soma."tipo fornitura" = 101
            and soma."codice cliente" = sinal_soma."codice cliente"
            and soma."codice transazione" = sinal_soma."codice transazione"
        group by
            soma."codice cliente", sinal_soma."codice filiale"
    );

---HISTORICO CARRELLO ESTORNO---
insert into ##car //NOMODIFICA
    (                          
        select
        scestorn."data",
        scestorn."data",
        scestorn."codice filiale",
        scestorn."codice transazione",
        scestorn."codice a barre",
        CASE WHEN(scestorn."codice articolo" = '') THEN scestorn."magazzino" ELSE null END as Estoque,
        scestorn."descrizione",
        scestorn."quantita",
        (scestorn."prezzo")*(storicocarrello2."prezzo")/soma_scestorno."soma_prezzo",
        scestorn."sconto",
        (scestorn."totale")*(storicocarrello2."totale")/soma_scestorno."soma_totale",
        storicocarrello2."operatore",
        scestorn."filiale",
        scestorn."codice magazzino",
        scestorn."tipo fornitura dettaglio",
        scestorn."codice fornitura",
        scestorn."codice articolo",
        scestorn."tipo fornitura",
        'Com Pagto. Definido',
        (CASE WHEN (Not (scestorn."magazzino" is null)) THEN scestorn."Magazzino"
              WHEN ((scestorn."tipo Fornitura">=1) AND (scestorn."tipo Fornitura"<=5) AND (scestorn."tipo Fornitura dettaglio"=1)) THEN 0
              WHEN ((scestorn."tipo Fornitura">=1) AND (scestorn."tipo Fornitura"<=5) AND (scestorn."tipo Fornitura dettaglio"=2)) THEN 1
              WHEN ((scestorn."tipo Fornitura">=1) AND (scestorn."tipo Fornitura"<=5) AND (scestorn."tipo Fornitura dettaglio"=3)) THEN 1
              WHEN ((scestorn."tipo Fornitura">=9) AND (scestorn."tipo Fornitura"<=10)AND (scestorn."tipo Fornitura dettaglio"<9)) THEN 2
              WHEN ((scestorn."tipo Fornitura">=9) AND (scestorn."tipo Fornitura"<=10)AND (scestorn."tipo Fornitura dettaglio">=9)) THEN 3
              WHEN ((scestorn."tipo Fornitura"=100) AND (scestorn."quantita"<0)) THEN 99 //reso
              WHEN ((scestorn."tipo Fornitura"=103) AND (scestorn."quantita"<0)) THEN 99 //reso
              WHEN (scestorn."tipo Fornitura">=100) THEN scestorn."tipo Fornitura"
              ELSE 9
              END) as "MagazzinoX",
        (CASE WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=100 )AND(scestorn."quantita">0)) THEN 100 //acconto
              WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=101 )) THEN 101 //storno
              WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=100 )AND(scestorn."quantita"<0)) THEN 99 //reso
              WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=103 )AND(scestorn."quantita"<0)) THEN 99//reso
              ELSE 0
              END) as "Forma",
        '',
        trans."tipo",
        trans."valor"*((scestorn."totale")*(storicocarrello2."totale")/soma_scestorno."soma_totale")/trans."total_trans",
        scestorn."codice cliente",
        trans."cod_filiale",
        0

        from storicocarrello

        inner join #soma_scestorno as soma_scestorno //NOMODIFICA
        on soma_scestorno."codice cliente" = storicocarrello."codice cliente", --LIGAÇÃO TEMP TAB E TAB PRINCIPAL--

        storicocarrello2 as scestorn
        join #temp_trans as trans //NOMODIFICA
            on (scestorn."codice transazione" = trans."cod_trans"),
            
        storicocarrello2

        where
        ((scestorn."data" >= data_dal) and (scestorn."data" <= data_al))
        and (storicocarrello."codice filiale" = storicocarrello2."codice carrello")
        and (storicocarrello2."codice cliente" = scestorn."codice cliente")
        and (scestorn."tipo fornitura" = 101) --TAB RENOMEADA COM ESTORNO FIXO--
        and (storicocarrello2."tipo fornitura" <> 100) --TAB PRINCIPAL SEM SINAL--
        and (storicocarrello2."tipo fornitura" <> 101) --TAB PRINCIPAL SEM ESTORNO--
        and (soma_scestorno."codice filiale" = scestorn."codice filiale") --LIG PSEUDO TAB COM TAB RENOMEADA--
        and (scestorn."codice transazione" = storicocarrello2."codice transazione") --LIG TAB RENOMEADA COM TAB PRINCIPAL--
        and (scestorn."codice transazione" <> '' and scestorn."codice transazione" IS NOT NULL)
    );

create table #soma_scestorno2  //NOMODIFICA
    (
        "codice cliente" varchar(12), 
        "codice filiale" varchar(12),
        "soma_prezzo" money, 
        "soma_totale" money
    );

create index codcliente on #soma_scestorno2("codice cliente"); //NOMODIFICA

insert into #soma_scestorno2 //NOMODIFICA
    (
        select
            soma."codice cliente",
            sinal_soma."codice filiale",
            SUM(soma."prezzo") soma_prezzo,
            SUM(soma."totale") soma_totale
        from
            carrello2 soma,
            storicocarrello2 sinal_soma
        where
                soma."tipo fornitura" <> 101
            and soma."tipo fornitura" <> 100
            and sinal_soma."tipo fornitura" = 100
            and soma."codice cliente" = sinal_soma."codice cliente"
            and soma."codice transazione" = sinal_soma."codice fornitura"
            and sinal_soma."codice fornitura" <> '' --mfc--25-02-2016 --codice fornitura em branco (devoluções) estavam entrando
        group by
            soma."codice cliente", sinal_soma."codice filiale"
    );

---HISTORICO CARRELLO SINAL---SEM ENTREGA---
insert into ##car //NOMODIFICA
    (                          
        select
        scsinal."data",
        scsinal."data",
        scsinal."codice filiale",
        scsinal."codice transazione",
        scsinal."codice a barre",
        CASE WHEN(scsinal."codice articolo" = '') THEN scsinal."magazzino" ELSE null END as Estoque,
        scsinal."descrizione",
        scsinal."quantita",
        (scsinal."prezzo")*(carrello2."prezzo")/soma_scar."soma_prezzo",
        scsinal."sconto",
        (scsinal."totale")*(carrello2."totale")/soma_scar."soma_totale",
        carrello2."operatore",
        scsinal."filiale",
        scsinal."codice magazzino",
        scsinal."tipo fornitura dettaglio",
        scsinal."codice fornitura",
        scsinal."codice articolo",
        scsinal."tipo fornitura",
        'Com Pagto. Definido',
        (CASE WHEN (Not (scsinal."magazzino" is null)) THEN scsinal."Magazzino"
              WHEN ((scsinal."tipo Fornitura">=1) AND (scsinal."tipo Fornitura"<=5) AND (scsinal."tipo Fornitura dettaglio"=1)) THEN 0
              WHEN ((scsinal."tipo Fornitura">=1) AND (scsinal."tipo Fornitura"<=5) AND (scsinal."tipo Fornitura dettaglio"=2)) THEN 1
              WHEN ((scsinal."tipo Fornitura">=1) AND (scsinal."tipo Fornitura"<=5) AND (scsinal."tipo Fornitura dettaglio"=3)) THEN 1
              WHEN ((scsinal."tipo Fornitura">=9) AND (scsinal."tipo Fornitura"<=10)AND (scsinal."tipo Fornitura dettaglio"<9)) THEN 2
              WHEN ((scsinal."tipo Fornitura">=9) AND (scsinal."tipo Fornitura"<=10)AND (scsinal."tipo Fornitura dettaglio">=9)) THEN 3
              WHEN ((scsinal."tipo Fornitura"=100) AND (scsinal."quantita"<0)) THEN 99 //reso
              WHEN ((scsinal."tipo Fornitura"=103) AND (scsinal."quantita"<0)) THEN 99 //reso
              WHEN (scsinal."tipo Fornitura">=100) THEN scsinal."tipo Fornitura"
              ELSE 9
              END) as "MagazzinoX",
        (CASE WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=100 )AND(scsinal."quantita">0)) THEN 100 //acconto
              WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=101 )) THEN 101 //storno
              WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=100 )AND(scsinal."quantita"<0)) THEN 99 //reso
              WHEN ((scsinal."magazzino" is null) AND (scsinal."tipo Fornitura"=103 )AND(scsinal."quantita"<0)) THEN 99//reso
              ELSE 0
              END) as "Forma",
        '',
        trans."tipo",
        trans."valor"*((scsinal."totale")*(carrello2."totale")/soma_scar."soma_totale")/trans."total_trans",
        scsinal."codice cliente",
        trans."cod_filiale",
        0

        from carrello

        inner join #soma_scestorno2 as soma_scar //NOMODIFICA
        on soma_scar."codice cliente" = carrello."codice cliente", --LIGAÇÃO TEMP TAB E TAB PRINCIPAL--

        storicocarrello2 as scsinal
        join #temp_trans as trans //NOMODIFICA
            on (scsinal."codice transazione" = trans."cod_trans"),
            
        carrello2

        where
        ((scsinal."data" >= data_dal) and (scsinal."data" <= data_al))
        and (carrello."codice filiale" = carrello2."codice carrello")
        and (carrello2."codice cliente" = scsinal."codice cliente")
        and (scsinal."tipo fornitura" = 100) --FIXADO SINAL NA TAB RENOMEADA--
        and (carrello2."tipo fornitura" <> 100) --RETIRADO SINAL TAB PRINCIPAL--
        and (carrello2."tipo fornitura" <> 101) --RETIRADO ESTORNO TAB PRINCIPAL--
        and (soma_scar."codice filiale" = scsinal."codice filiale") --LIG PSEUDO TAB COM TAB RENOMEADA--
        and (scsinal."codice fornitura" = carrello2."codice transazione") --LIG TAB RENOMEADA COM TAB PRINCIPAL--
        and (scsinal."codice fornitura" <> '') --mfc--25-02-2016 --codice fornitura em branco (devoluções) estavam entrando
    );

create table #soma_scestorno3  //NOMODIFICA
    (
        "codice cliente" varchar(12), 
        "codice filiale" varchar(12),
        "soma_prezzo" money, 
        "soma_totale" money
    );

create index codcliente on #soma_scestorno3("codice cliente"); //NOMODIFICA

insert into #soma_scestorno3 //NOMODIFICA
    (
        select
            soma."codice cliente",
            sinal_soma."codice filiale",
            SUM(soma."prezzo") soma_prezzo,
            SUM(soma."totale") soma_totale
        from
            carrello2 soma,
            storicocarrello2 sinal_soma
        where
                soma."tipo fornitura" <> 101
            and soma."tipo fornitura" <> 100
            and sinal_soma."tipo fornitura" = 101
            and soma."codice cliente" = sinal_soma."codice cliente"
            and soma."codice transazione" = sinal_soma."codice transazione"
        group by
            soma."codice cliente", sinal_soma."codice filiale"
    );

---HISTORICO CARRELLO ESTORNO---SEM ENTREGA---
insert into ##car //NOMODIFICA
    (                          
        select
        scestorn."data",
        scestorn."data",
        scestorn."codice filiale",
        scestorn."codice transazione",
        scestorn."codice a barre",
        CASE WHEN(scestorn."codice articolo" = '') THEN scestorn."magazzino" ELSE null END as Estoque,
        scestorn."descrizione",
        scestorn."quantita",
        (scestorn."prezzo")*(carrello2."prezzo")/soma_scestorno."soma_prezzo",
        scestorn."sconto",
        (scestorn."totale")*(carrello2."totale")/soma_scestorno."soma_totale",
        carrello2."operatore",
        scestorn."filiale",
        scestorn."codice magazzino",
        scestorn."tipo fornitura dettaglio",
        scestorn."codice fornitura",
        scestorn."codice articolo",
        scestorn."tipo fornitura",
        'Com Pagto. Definido',
        (CASE WHEN (Not (scestorn."magazzino" is null)) THEN scestorn."Magazzino"
              WHEN ((scestorn."tipo Fornitura">=1) AND (scestorn."tipo Fornitura"<=5) AND (scestorn."tipo Fornitura dettaglio"=1)) THEN 0
              WHEN ((scestorn."tipo Fornitura">=1) AND (scestorn."tipo Fornitura"<=5) AND (scestorn."tipo Fornitura dettaglio"=2)) THEN 1
              WHEN ((scestorn."tipo Fornitura">=1) AND (scestorn."tipo Fornitura"<=5) AND (scestorn."tipo Fornitura dettaglio"=3)) THEN 1
              WHEN ((scestorn."tipo Fornitura">=9) AND (scestorn."tipo Fornitura"<=10)AND (scestorn."tipo Fornitura dettaglio"<9)) THEN 2
              WHEN ((scestorn."tipo Fornitura">=9) AND (scestorn."tipo Fornitura"<=10)AND (scestorn."tipo Fornitura dettaglio">=9)) THEN 3
              WHEN ((scestorn."tipo Fornitura"=100) AND (scestorn."quantita"<0)) THEN 99 //reso
              WHEN ((scestorn."tipo Fornitura"=103) AND (scestorn."quantita"<0)) THEN 99 //reso
              WHEN (scestorn."tipo Fornitura">=100) THEN scestorn."tipo Fornitura"
              ELSE 9
              END) as "MagazzinoX",
        (CASE WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=100 )AND(scestorn."quantita">0)) THEN 100 //acconto
              WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=101 )) THEN 101 //storno
              WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=100 )AND(scestorn."quantita"<0)) THEN 99 //reso
              WHEN ((scestorn."magazzino" is null) AND (scestorn."tipo Fornitura"=103 )AND(scestorn."quantita"<0)) THEN 99//reso
              ELSE 0
              END) as "Forma",
        '',
        trans."tipo",
        trans."valor"*((scestorn."totale")*(carrello2."totale")/soma_scestorno."soma_totale")/trans."total_trans",
        scestorn."codice cliente",
        trans."cod_filiale",
        0

        from carrello

        inner join #soma_scestorno3 as soma_scestorno //NOMODIFICA
        on soma_scestorno."codice cliente" = carrello."codice cliente", --LIGAÇÃO PSEUDO TAB E TAB PRINCIPAL--

        storicocarrello2 as scestorn
        join #temp_trans as trans //NOMODIFICA
            on (scestorn."codice transazione" = trans."cod_trans"),
            
        carrello2

        where
        ((scestorn."data" >= data_dal) and (scestorn."data" <= data_al))
        and (carrello."codice filiale" = carrello2."codice carrello")
        and (carrello2."codice cliente" = scestorn."codice cliente")
        and (scestorn."tipo fornitura" = 101) --FIXADO ESTORNO NA TAB RENOMEADA--
        and (carrello2."tipo fornitura" <> 100) --RETIRADO SINAL TAB PRINCIPAL--
        and (carrello2."tipo fornitura" <> 101) --RETIRADO ESTORNO TAB PRINCIPAL--
        and (soma_scestorno."codice filiale" = scestorn."codice filiale") --LIG PSEUDO COM TAB RENOMEADA--
        and (scestorn."codice transazione" = carrello2."codice transazione") --LIG TAB RENOMEADA E  TAB PRINCIPAL--
        and (scestorn."codice transazione" <> '' and scestorn."codice transazione" IS NOT NULL)
    );
    


--SINAL
    insert into #Vendas1 //NOMODIFICA
        (
            select 
                c."data",
                c."codfil",
                c."codtrans",
                c."codbar",
                '',
                '',
                '100',
                'Sinal',
                '',
                'Sinal',
                '',
                'Sinal',
                c."descricao",
                '',
                '',
                0,
                0,
                0,
                c."valor",
                c."desc",
                c."totalcar",
                c."op",
                c."filiale",
                c."MagazzinoX",
                c."Forma",
                c."tipofor",
                c."codart",
                c."tipo_pag",
                c."valor_trans",
                c."cod_cliente",
                c."data pagamento",
                False

            from ##car c //NOMODIFICA

            where
                (((c."estoque" <> 0) and (c."estoque" <> 1) and (c."estoque" <> 2) and (c."estoque" <> 3)) or
                (c."estoque" IS NULL)) and
                ((c."tipofor" = 100) or (c."tipofor" = 101)) and
                (c."qtd" > 0)
        );

--RETIRAR SINAL E ESTORNO DE SINAL DO CODIGO-- 
if info2 = 'Carrinho' --OTIMIZAR, POIS SE FOR CARRINHO NÃO TEM SINAL NEM ESTORNO E NAO PRECISA DE MUITOS CODIGOS DAQUI
    then
    delete from #Vendas1 t //NOMODIFICA
    where t."TipoProduto" = 'Sinal';
end if;

--DATA BASE --PAGAMENTO --CARRINHO
if info2 = 'Pagamento'
then
    delete from ##car c //NOMODIFICA
    where 
        c."data pagamento" < data_dal or
        c."data pagamento" > data_al or
        c."data pagamento" IS NULL;
else
    delete from ##car c //NOMODIFICA
    where 
        c."data" < data_dal or
        c."data" > data_al;
end if;


--CATALOGO
    create table #temp_catalogo //NOMODIFICA
        (
            modello varchar(60),
            marca varchar(20),
            "codice a barre" varchar(14),
            fornitore varchar(40),
            linea varchar(20),
            "prezzo acquisto" real
        );
        
    create index modelloidx on #temp_catalogo("modello", "marca"); //NOMODIFICA
        
    insert into #temp_catalogo //NOMODIFICA
        (
            select 
                max(catalogo."modello") modello, 
                max(catalogo."marca") marca, 
                catalogo."codice a barre", 
                catalogo."fornitore", 
                catalogo."linea", 
                catalogo."prezzo acquisto"
            from catalogo
            group by catalogo."codice a barre", catalogo."fornitore", catalogo."linea", catalogo."prezzo acquisto"
        );

--ENVELOPE --LENTE DIREITA
    create table #busta_catalogo_direita //NOMODIFICA
        (
            "codice filiale" varchar(12),
            "codice lente dx" varchar(14), 
            "tipo lente dx" varchar(25), 
            "sfera l dx" real, 
            "cilindro l dx" real, 
            "sfera v dx" real, 
            "cilindro v dx" real, 
            "sfera m dx" real, 
            "cilindro m dx" real, 
            "occhiale da lontano" boolean, 
            "occhiale da vicino" boolean, 
            "occhiale da medio" boolean, 
            "ADD V DX" real,
            "codice a barre" varchar(14), 
            "fornitore" varchar(40), 
            "linea" varchar(20), 
            "marca" varchar(20), 
            "modello" varchar(60), 
            "prezzo acquisto" real
        );
        
    create index codfilidx on #busta_catalogo_direita("codice filiale"); //NOMODIFICA

    insert into #busta_catalogo_direita //NOMODIFICA
        (
            select 
                busta."codice filiale", 
                COALESCE(busta."codice lente dx", ''), 
                CASE busta."tipo lente dx" 
                    WHEN 1 THEN 'LM'     
                    WHEN 2 THEN 'LB'
                    WHEN 3 THEN 'LP'                  
                    WHEN 4 THEN 'LD' 
                    ELSE ''
                END, 
                busta."sfera l dx", 
                busta."cilindro l dx", 
                busta."sfera v dx", 
                busta."cilindro v dx", 
                busta."sfera m dx", 
                busta."cilindro m dx", 
                busta."occhiale da lontano", 
                busta."occhiale da vicino", 
                busta."occhiale da medio", 
                busta."ADD V DX",
                COALESCE(cat."codice a barre", busta."codice lente dx", ''), 
                COALESCE(cat."fornitore", busta."fornitore dx"), 
                COALESCE(
                    cat."linea", 
                    CASE busta."tipo lente dx" 
                        WHEN 1 THEN 'Monofoc.'     
                        WHEN 2 THEN 'Bifocal'
                        WHEN 3 THEN 'Multifocal'                  
                        WHEN 4 THEN 'Intermed.' 
                        ELSE ''
                    END
                ), 
                COALESCE(cat."marca", busta."marca lente dx"), 
                COALESCE(cat."modello", busta."prodotto lente dx"), 
                COALESCE(cat."prezzo acquisto", 0)
            from busta
                left join 
                    #temp_catalogo cat //NOMODIFICA
                on (busta."prodotto lente dx" = cat."modello") and (busta."marca lente dx" = cat."marca")
            where
                ((busta."codice lente dx" = '') or (busta."codice lente dx" IS NULL))
        );
     
--ENVELOPE --LENTE ESQUERDA
    create table #busta_catalogo_esquerda //NOMODIFICA
        (
            "codice filiale" varchar(12),
            "codice lente sx" varchar(14), 
            "tipo lente sx" varchar(25), 
            "sfera l sx" real, 
            "cilindro l sx" real, 
            "sfera v sx" real, 
            "cilindro v sx" real, 
            "sfera m sx" real, 
            "cilindro m sx" real, 
            "occhiale da lontano" boolean, 
            "occhiale da vicino" boolean, 
            "occhiale da medio" boolean, 
            "ADD V SX" real, 
            "codice a barre" varchar(14), 
            "fornitore" varchar(40), 
            "linea" varchar(20), 
            "marca" varchar(20), 
            "modello" varchar(60), 
            "prezzo acquisto" real
        );
        
    create index codfilidx on #busta_catalogo_esquerda("codice filiale"); //NOMODIFICA
        
    insert into #busta_catalogo_esquerda //NOMODIFICA
        (
            select 
                busta."codice filiale", 
                COALESCE(busta."codice lente sx", ''), 
                CASE busta."tipo lente sx" 
                    WHEN 1 THEN 'LM'     
                    WHEN 2 THEN 'LB'
                    WHEN 3 THEN 'LP'
                    WHEN 4 THEN 'LD' 
                    ELSE ''
                END, 
                busta."sfera l sx", 
                busta."cilindro l sx", 
                busta."sfera v sx", 
                busta."cilindro v sx", 
                busta."sfera m sx", 
                busta."cilindro m sx", 
                busta."occhiale da lontano", 
                busta."occhiale da vicino", 
                busta."occhiale da medio", 
                busta."ADD V SX", 
                COALESCE(cat."codice a barre", busta."codice lente sx", ''), 
                COALESCE(cat."fornitore", busta."fornitore sx"), 
                COALESCE(
                    cat."linea", 
                    CASE busta."tipo lente sx" 
                        WHEN 1 THEN 'Monofoc.'     
                        WHEN 2 THEN 'Bifocal'
                        WHEN 3 THEN 'Multifocal'                  
                        WHEN 4 THEN 'Intermed.' 
                        ELSE ''
                    END
                ), 
                COALESCE(cat."marca", busta."marca lente sx"), 
                COALESCE(cat."modello", busta."prodotto lente sx"), 
                COALESCE(cat."prezzo acquisto", 0)
            from busta
                left join 
                    #temp_catalogo cat //NOMODIFICA
                on (busta."prodotto lente sx" = cat."modello") and (busta."marca lente sx" = cat."marca")
            where
                ((busta."codice lente sx" = '') or (busta."codice lente sx" IS NULL))
        );

--ARTICOLI
create table #temp_articoli //NOMODIFICA
    (
        "SKU" varchar(25),
        "codice filiale" varchar(12),
        "codice magazzino" varchar(12),
        "filiale" varchar(2),
        "fornecedor" varchar(12),
        "tipo_lente" varchar(12),
        "marca" varchar(12),
        "linha" varchar(12),
        "familia_oft" varchar(12),
        "tipo_produto" varchar(12),
        "familia_ldc" varchar(12),
        "modello" varchar(60),
        "colore" varchar(25),
        "calibro" real,
        "sfera" real,
        "cilindro" real,
        "addizione" real,
        "descrizione" varchar(60),
        "prezzo listino acquisto" real,
        "prezzo acquisto" real,
        "costo medio" real,
        "non scontabile" boolean
    );

create index cfmidx on #temp_articoli("codice filiale", "codice magazzino", "filiale"); //NOMODIFICA

insert into #temp_articoli //NOMODIFICA
    select 
        articoli."SKU",
        articoli."codice filiale",
        articoli_mag."codice magazzino",
        articoli_mag."filiale",
        articoli."codice fornitore",
        articoli."codice tipo lenti",
        articoli."codice marchio",
        articoli."codice linea",
        articoli."codice famiglia",
        articoli."codice tipo prodotto",
        articoli."codice famiglia",
        articoli."modello",
        articoli."colore",
        articoli."calibro",
        articoli."sfera",
        articoli."cilindro",
        articoli."addizione",
        articoli."descrizione",
        articoli."prezzo listino acquisto",
        articoli_mag."prezzo acquisto",
        articoli_mag."costo medio",
        articoli."non scontabile"
    from articoli, articoli_mag

    where 
        articoli."codice filiale" = articoli_mag."codice articolo";

--ARMACAO
    insert into #Vendas1 //NOMODIFICA          
        (
            select  
            c."data",
            c."codfil", 
            c."codtrans",
            c."codbar",   
            ta."SKU",
            GetFornitore(ta."fornecedor"),
            '0' as estoque,                         
            GetTipoLenti(ta."tipo_lente"),
            '',
            GetMarchio(ta."marca"),
            GetLinea(ta."linha"),
            GetTipoProdotto(ta."tipo_produto"),
            ta."modello",
            '',
            ta."colore",
            ta."calibro",
            c."qtd",
            CASE custo
              WHEN 'Tab. Preços' THEN ta."prezzo listino acquisto"
              WHEN 'Últ. Compra' THEN ta."prezzo acquisto"
              WHEN 'Custo Médio' THEN ta."costo medio"
            END * c."qtd", --mfc 25-02-16
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            ta."non scontabile"

            from ##car c //NOMODIFICA

            left join #temp_articoli ta //NOMODIFICA
            on (ta."codice filiale" = c."codart") and (ta."filiale" = c."filiale") and (ta."codice magazzino" = c."codmag")
                                     
            where                             
            (c."estoque" = 0) and
            (MagazzinoX <> 99)
        );

--LDC
    insert into #Vendas1 //NOMODIFICA  
        (
            select 
            c."data",
            c."codfil",
            c."codtrans",
            c."codbar",
            ta."SKU",
            GetFornitore(ta."fornecedor"),
            '2',
            GetTipoLenti(ta."tipo_lente"),
            GetFamigliaLac(ta."familia_ldc"),
            GetMarchio(ta."marca"),
            ta."modello",
            GetTipoProdotto(ta."tipo_produto"),
            '',
            'Esf.: ' + CAST(ta."sfera" AS varchar(6)) + '/Cil.: ' + CAST(ta."cilindro" AS varchar(6)),
            ta."colore",
            0,
            c."qtd",
            CASE custo
              WHEN 'Tab. Preços' THEN ta."prezzo listino acquisto"
              WHEN 'Últ. Compra' THEN ta."prezzo acquisto"
              WHEN 'Custo Médio' THEN ta."costo medio"
            END * c."qtd", --mfc 25-02-16
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            ta."non scontabile"

            from ##car c //NOMODIFICA

            left join #temp_articoli ta //NOMODIFICA
            on (ta."codice filiale" = c."codart") and (ta."filiale" = c."filiale") and (ta."codice magazzino" = c."codmag")

            where 
            (c."estoque" = 2) and
            (MagazzinoX <> 99)
        );

--LENTE OFTALMICA --DIREITA --SEM CADASTRO NO ESTOQUE
    insert into #Vendas1 //NOMODIFICA     
        (
            select 
            c."data",
            c."codfil",
            c."codtrans",
            c."codbar",
            busta_dir."codice a barre" as "codice catalogo",
            busta_dir."fornitore",
            '1' as estoque,
            '',
            busta_dir."linea",
            busta_dir."marca",   
            '',
            GetTipoProdotto(busta_dir."tipo lente dx"),
            busta_dir."modello" as modelo,
            CASE                            
            WHEN (busta_dir."occhiale da lontano" IS TRUE) and (busta_dir."occhiale da vicino" IS FALSE) and (busta_dir."occhiale da medio" IS FALSE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_dir."sfera l dx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_dir."cilindro l dx", 0) AS varchar(6))
            WHEN (busta_dir."occhiale da lontano" IS FALSE) and (busta_dir."occhiale da vicino" IS TRUE) and (busta_dir."occhiale da medio" IS FALSE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_dir."sfera v dx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_dir."cilindro v dx", 0) AS varchar(6))
            WHEN (busta_dir."occhiale da lontano" IS FALSE) and (busta_dir."occhiale da vicino" IS FALSE) and (busta_dir."occhiale da medio" IS TRUE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_dir."sfera m dx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_dir."cilindro m dx", 0) AS varchar(6))
            WHEN (busta_dir."occhiale da lontano" IS TRUE) and (busta_dir."occhiale da vicino" IS TRUE) and (busta_dir."occhiale da medio" IS FALSE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_dir."sfera l dx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_dir."cilindro l dx", 0) AS varchar(6)) + '/Adic.: ' + CAST(COALESCE(busta_dir."Add V Dx", 0) AS varchar(6))          
            WHEN (busta_dir."occhiale da lontano" IS TRUE) and (busta_dir."occhiale da vicino" IS TRUE) and (busta_dir."occhiale da medio" IS TRUE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_dir."sfera l dx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_dir."cilindro l dx", 0) AS varchar(6)) + '/Adic.: ' + CAST(COALESCE(busta_dir."Add V Dx", 0) AS varchar(6))
            WHEN (busta_dir."occhiale da lontano" IS FALSE) and (busta_dir."occhiale da vicino" IS TRUE) and (busta_dir."occhiale da medio" IS TRUE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_dir."sfera m dx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_dir."cilindro m dx", 0) AS varchar(6))
            ELSE ''
            END "esf_cil",
            '',
            0,
            c."qtd",
            busta_dir."prezzo acquisto" * c."qtd",
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            False

            from #busta_catalogo_direita busta_dir, ##car c //NOMODIFICA

            where
            (c."estoque" = 1)
            and
            (c."tipofordet" = 2)
            and
            (c."codfor" = busta_dir."codice filiale") and
            (MagazzinoX <> 99)
        );

--LENTE OFTALMICA --ESQUERDA --SEM CADASTRO NO ESTOQUE
    insert into #Vendas1 //NOMODIFICA
        (
            select 
            c."data",
            c."codfil",
            c."codtrans",
            c."codbar",
            busta_esq."codice a barre",
            busta_esq."fornitore",
            '1',
            '',
            busta_esq."linea",
            busta_esq."marca",
            '',
            GetTipoProdotto(busta_esq."tipo lente sx"),
            busta_esq."modello",
            CASE 
            WHEN (busta_esq."occhiale da lontano" IS TRUE) and (busta_esq."occhiale da vicino" IS FALSE) and (busta_esq."occhiale da medio" IS FALSE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_esq."sfera l sx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_esq."cilindro l sx", 0) AS varchar(6))
            WHEN (busta_esq."occhiale da lontano" IS FALSE) and (busta_esq."occhiale da vicino" IS TRUE) and (busta_esq."occhiale da medio" IS FALSE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_esq."sfera v sx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_esq."cilindro v sx", 0) AS varchar(6))
            WHEN (busta_esq."occhiale da lontano" IS FALSE) and (busta_esq."occhiale da vicino" IS FALSE) and (busta_esq."occhiale da medio" IS TRUE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_esq."sfera m sx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_esq."cilindro m sx", 0) AS varchar(6))
            WHEN (busta_esq."occhiale da lontano" IS TRUE) and (busta_esq."occhiale da vicino" IS TRUE) and (busta_esq."occhiale da medio" IS FALSE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_esq."sfera l sx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_esq."cilindro l sx", 0) AS varchar(6)) + '/Adic.: ' + CAST(COALESCE(busta_esq."Add V Sx", 0) AS varchar(6))   
            WHEN (busta_esq."occhiale da lontano" IS TRUE) and (busta_esq."occhiale da vicino" IS TRUE) and (busta_esq."occhiale da medio" IS TRUE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_esq."sfera l sx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_esq."cilindro l sx", 0) AS varchar(6)) + '/Adic.: ' + CAST(COALESCE(busta_esq."Add V Sx", 0) AS varchar(6))   
            WHEN (busta_esq."occhiale da lontano" IS FALSE) and (busta_esq."occhiale da vicino" IS TRUE) and (busta_esq."occhiale da medio" IS TRUE)
              THEN 'Esf.: ' + CAST(COALESCE(busta_esq."sfera m sx", 0) AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(busta_esq."cilindro m sx", 0) AS varchar(6))   
            ELSE ''
            END,
            '',
            0,
            c."qtd",
            busta_esq."prezzo acquisto" * c."qtd",
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            False

            from #busta_catalogo_esquerda busta_esq, ##car c //NOMODIFICA 

            where
            (c."estoque" = 1)
            and
            (c."tipofordet" = 3)
            and
            (c."codfor" = busta_esq."codice filiale") and
            (MagazzinoX <> 99)
        );

--LENTE OFTALMICA --COM CADASTRO EM ESTOQUE
    insert into #Vendas1 //NOMODIFICA
        (
            select 
            c."data",
            c."codfil",
            c."codtrans",
            c."codbar",
            ta."SKU",
            GetFornitore(ta."fornecedor"),
            '1',
            '',
            GetFamiglia(ta."familia_oft"),
            GetMarchio(ta."marca"),
            '',
            GetTipoProdotto(ta."tipo_produto"),
            ta."modello",
            'Esf.: ' + CAST(COALESCE(ta."sfera", '') AS varchar(6)) + '/Cil.: ' + CAST(COALESCE(ta."cilindro", '') AS varchar(6)) + '/Adic.: ' + CAST(COALESCE(ta."Addizione", '') AS varchar(6)),
            '',
            0,
            c."qtd",
            CASE custo
              WHEN 'Tab. Preços' THEN ta."prezzo listino acquisto"
              WHEN 'Últ. Compra' THEN ta."prezzo acquisto"
              WHEN 'Custo Médio' THEN ta."costo medio"
            END * c."qtd", --mfc 25-02-16
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            ta."non scontabile"

            from ##car c //NOMODIFICA
            
            join #temp_articoli ta //NOMODIFICA
            on (ta."codice filiale" = c."codart") and (ta."filiale" = c."filiale") and (ta."codice magazzino" = c."codmag")

            where
            (c."estoque" = 1) and
            (MagazzinoX <> 99)
        );
        
--LENTE OFTALMICA --NÃO EXISTENTE NA TEMP
    insert into #Vendas1 //NOMODIFICA
        (
            select 
            c."data",
            c."codfil",
            c."codtrans",
            c."codbar",
            '',
            '',
            '1',
            '',
            '',
            '',
            '',
            '',
            '',
            c."descricao",
            '',
            0,
            c."qtd",
            0,
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            False

            from ##car c //NOMODIFICA

            where
            (c."estoque" = 1) and
            (MagazzinoX <> 99) and
            (c."codfil" NOT IN (select tt."ordem" from #Vendas1 tt)) //NOMODIFICA
        );
                       
--LIQ E ACESSORIOS
    insert into #Vendas1 //NOMODIFICA
        (
            select 
            c."data",
            c."codfil",
            c."codtrans",
            c."codbar",
            ta."SKU",
            GetFornitore(ta."fornecedor"),
            '3',
            '',
            '',
            GetMarchio(ta."marca"),
            '',
            GetTipoProdotto(ta."tipo_produto"),
            ta."modello",
            ta."descrizione",
            '',
            0,
            c."qtd",
            CASE custo
              WHEN 'Tab. Preços' THEN ta."prezzo listino acquisto"
              WHEN 'Últ. Compra' THEN ta."prezzo acquisto"
              WHEN 'Custo Médio' THEN ta."costo medio"
            END * c."qtd", --mfc 25-02-16
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            ta."non scontabile"

            from ##car c //NOMODIFICA

            left join #temp_articoli ta //NOMODIFICA
            on (ta."codice filiale" = c."codart") and (ta."filiale" = c."filiale") and (ta."codice magazzino" = c."codmag")

            where
            (c."estoque" = 3) and
            (MagazzinoX <> 99)
        );

--SERVICOS E OUTROS
    insert into #Vendas1 //NOMODIFICA
        (
            select 
            c."data",
            c."codfil",
            c."codtrans",
            c."codbar",
            ta."SKU",
            GetFornitore(ta."fornecedor"),
            '4',
            '',
            '',
            GetMarchio(ta."marca"),
            '',
            GetTipoProdotto(ta."tipo_produto"),
            ta."modello",
            COALESCE(ta."descrizione", 'Serviços e outros'),
            '',
            0,
            c."qtd",
            ta."prezzo acquisto" * c."qtd", --mfc 25-02-16
            c."valor",
            c."desc",
            c."totalcar",
            c."op",
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            c."valor_trans",
            c."cod_cliente",
            c."data pagamento",
            ta."non scontabile"

            from ##car c //NOMODIFICA

            left join #temp_articoli ta //NOMODIFICA
            on (ta."codice filiale" = c."codart") and (ta."filiale" = c."filiale") and (ta."codice magazzino" = c."codmag")

            where
            (((c."estoque" <> 0) and (c."estoque" <> 1) and (c."estoque" <> 2) and (c."estoque" <> 3)) or
            (c."estoque" IS NULL)) and
            (c."tipofor" <> 100) and
            (c."tipofor" <> 101) and
            (MagazzinoX <> 99)
        );

create table #c2 //NOMODIFICA
    (
        "op" varchar(6),
        "codtrans" varchar(12),
        "numero dav" varchar(13),
        "totalcar" money,
        "totaltodev" money
    );

create index codtransidx on #c2("codtrans"); //NOMODIFICA
create index coddavidx on #c2("numero dav"); //NOMODIFICA

insert into #c2 //NOMODIFICA
    (
        select
            c3."op",
            c3."cod_transdet",
            c3."numero dav",
            SUM(c3."totalcar"),
            SUM(c3."totaltodev")
        from ##car c3 //NOMODIFICA
        where
            c3."tipofor" <> 100 and
            c3."tipofor" <> 101
        Group by
            c3."op",
            c3."cod_transdet",
            c3."numero dav"
    );

--DEVOLUCAO
    insert into #Vendas1 //NOMODIFICA
        (
            select distinct --DISTINCT PQ ELE RESOLVE O CASO DA DEVOLUÇÃO DE DOIS PRODUTOS IGUAIS EM UM MESMO CLIENTE (POR EXEMPLO, DUAS LENTES)     
            c."data",
            c."codfil",
            c."codtrans" + c."cod_transdet",
            c."codbar",
            ta."SKU",
            GetFornitore(ta."fornecedor"),
            '99',
            GetTipoLenti(ta."tipo_lente"),
            '',
            GetMarchio(ta."marca"),
            GetLinea(ta."linha"),
            GetTipoProdotto(ta."tipo_produto"),
            ta."modello",
            COALESCE(ta."descrizione", c."descricao"), --mfc 25-02-2016 descricao da devoluçao otimizada
            ta."colore",
            ta."calibro",
            0,--MFC--25/02/2016 -- criado para acertar as quantidades de devoluções
            (c2."totaltodev"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* ta."prezzo acquisto" *(-1), --mfc 25-02-16 proporcional do custo
            CASE WHEN ((c."codtrans" = '' or c."codtrans" IS NULL) and (c."tipoinfo" = 'Com Pagto. Definido')) THEN 0 ELSE (c2."totalcar"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* c."valor" *(-1) END, --mfc 25-02-2016 case simplificado
            0,
            CASE WHEN ((c."codtrans" = '' or c."codtrans" IS NULL) and (c."tipoinfo" = 'Com Pagto. Definido')) THEN 0 ELSE (c2."totalcar"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* c."totalcar" END, --mfc 25-02-2016 case simplificado
            c2."op",                  
            c."filiale",
            c."MagazzinoX",
            c."Forma",
            c."tipofor",
            c."codart",
            c."tipo_pag",
            CASE WHEN ((CASE WHEN ((c."codtrans" = '' or c."codtrans" IS NULL) and (c."tipoinfo" = 'Com Pagto. Definido')) THEN 0 ELSE (c2."totalcar"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* c."valor_trans" *(-1) END) > (c2."totalcar"))
                THEN(c2."totalcar" * (-1))
                ELSE(CASE WHEN ((c."codtrans" = '' or c."codtrans" IS NULL) and (c."tipoinfo" = 'Com Pagto. Definido')) THEN 0 ELSE (c2."totalcar"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* c."valor_trans" END) END,
            c."cod_cliente",
            c."data pagamento",
            ta."non scontabile"
    
            from ##car c //NOMODIFICA
            join #totalcar2 tc //NOMODIFICA
                on (c."codtrans" = tc."cod trans")
            join #c2 as c2 //NOMODIFICA
                on (c2."codtrans" = c."cod_transdet"),

            #temp_devolvido d //NOMODIFICA    
            left join #temp_articoli ta //NOMODIFICA
                on (ta."codice filiale" = d."codice articolo") and (ta."filiale" = d."filial") and (ta."codice magazzino" = d."codigo estoque")
                               
            where
                c."cod_cliente" = d."codcli" and --mfc 25-02-2016 adicionado para não ocasionar problemas de conciliação das devoluções entre outros clientes
                c."codbar" = d."codigo de barras"  and
                c."descricao" = d."descricao" and
                c."valor" = d."total" and
                c."qtd"*(-1) = d."quantidade" and
                c."totalcar"*(-1) = d."total" and
                c."codtrans" <> '' --mfc 25-02-2016 estava sendo considerado varios codtrans em branco
        );

--DEVOLUÇÕES SEM PAGAMENTO --COMO OTIMIZAR????
insert into #Vendas1 //NOMODIFICA
    (
        select distinct --DISTINCT PQ ELE RESOLVE O CASO DA DEVOLUÇÃO DE DOIS PRODUTOS IGUAIS EM UM MESMO CLIENTE (POR EXEMPLO, DUAS LENTES)
        c."data",
        c."codfil",
        c."codtrans" + c."cod_transdet",
        c."codbar",
        ta."SKU",
        GetFornitore(ta."fornecedor"),
        '99',
        GetTipoLenti(ta."tipo_lente"),
        '',
        GetMarchio(ta."marca"),
        GetLinea(ta."linha"),
        GetTipoProdotto(ta."tipo_produto"),
        ta."modello",
        COALESCE(ta."descrizione", c."descricao"), --mfc 25-02-2016 descricao da devoluçao otimizada
        ta."colore",
        ta."calibro",
        0,--MFC--25/02/2016 -- criado para acertar as quantidades de devoluções
        (c2."totaltodev"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* ta."prezzo acquisto" *(-1), --mfc 25-02-16 proporcional do custo
        CASE WHEN ((c."codtrans" = '' or c."codtrans" IS NULL) and (c."tipoinfo" = 'Com Pagto. Definido')) THEN 0 ELSE (c2."totalcar"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* c."valor" *(-1) END, --mfc 25-02-2016 case simplificado
        0,
        CASE WHEN ((c."codtrans" = '' or c."codtrans" IS NULL) and (c."tipoinfo" = 'Com Pagto. Definido')) THEN 0 ELSE (c2."totalcar"/(CASE tc."total" WHEN 0 THEN 1 ELSE tc."total" END))* c."totalcar" END, --mfc 25-02-2016 case simplificado
        c2."op",                  
        c."filiale",
        c."MagazzinoX",
        c."Forma",
        c."tipofor",
        c."codart",
        c."tipo_pag",
        c."valor_trans",
        c."cod_cliente",
        c."data pagamento",
        ta."non scontabile"

        from ##car c //NOMODIFICA
        join #totalcar2 tc //NOMODIFICA
            on (c."numero dav" = tc."numero dav")
        join #c2 as c2 //NOMODIFICA
            on (c."numero dav" = c2."numero dav"),

        #temp_devolvido d //NOMODIFICA    
        left join #temp_articoli ta //NOMODIFICA
            on (ta."codice filiale" = d."codice articolo") and (ta."filiale" = d."filial") and (ta."codice magazzino" = d."codigo estoque")
                           
        where
            c."cod_cliente" = d."codcli" and --mfc 25-02-2016 adicionado para não ocasionar problemas de conciliação das devoluções entre outros clientes
            c."codbar" = d."codigo de barras"  and
            c."descricao" = d."descricao" and
            c."valor" = d."total" and
            c."qtd"*(-1) = d."quantidade" and
            c."totalcar"*(-1) = d."total" and
            c."numero dav" <> '' and --mfc 25-02-16 para nao considerar numero dav em branco
            ((c."codtrans" is null) or (c."codtrans" = ''))    --mfc 25-02-2016 aplicada conforme comparação com o demo vendas            
    );
        
--DEVOLUÇÕES QUANTIDADES--MFC--25/02/2016 -- criado para acertar as quantidades de devoluções        
insert into #Vendas1 //NOMODIFICA
    (
        select distinct --DISTINCT PQ ELE RESOLVE O CASO DA DEVOLUÇÃO DE DOIS PRODUTOS IGUAIS EM UM MESMO CLIENTE (POR EXEMPLO, DUAS LENTES)
        c."data",
        c."codfil",
        c."codtrans" + c."cod_transdet",
        c."codbar",
        ta."SKU",
        GetFornitore(ta."fornecedor"),
        '99',
        GetTipoLenti(ta."tipo_lente"),
        '',
        GetMarchio(ta."marca"),
        GetLinea(ta."linha"),
        GetTipoProdotto(ta."tipo_produto"),
        ta."modello",
        COALESCE(ta."descrizione", c."descricao"), --mfc 25-02-2016 descricao da devoluçao otimizada
        ta."colore",
        ta."calibro",
        c."qtd",
        0,
        0,
        0,
        0,
        d."operador",                  
        d."filial",
        c."MagazzinoX",
        c."Forma",
        c."tipofor",
        c."codart",
        c."tipo_pag",
        0,
        c."cod_cliente",
        c."data pagamento",
        ta."non scontabile"

        from ##car c, #temp_devolvido d //NOMODIFICA,
        left join #temp_articoli ta //NOMODIFICA
            on (ta."codice filiale" = d."codice articolo") and (ta."filiale" = d."filial") and (ta."codice magazzino" = d."codigo estoque"),
        (--mfc 13-07-2016 select criado para resolver problemas de duplicidade de devolucoes (2 devolucoes do mesmo produto no mesmo historico)
            select MIN(t2."conta") as dias, t2."codcli", t2."codfil" 
            from
                (
                    select CAST(c2."data" as integer) - CAST(d2."data" as integer) conta, d2."codcli", c2."codfil"
                    from ##car c2, #temp_devolvido d2 //NOMODIFICA
                    where
                        c2."numero dav" <> d2."numero dav" and
                        c2."cod_cliente" = d2."codcli" and 
                        c2."codbar" = d2."codigo de barras"  and
                        c2."descricao" = d2."descricao" and
                        c2."valor" = d2."total" and
                        c2."qtd"*(-1) = d2."quantidade" and
                        c2."totalcar"*(-1) = d2."total" and
                        (CAST(c2."data" as integer) - CAST(d2."data" as integer) >= 0)
                ) as t2
            group by t2."codcli", t2."codfil"
            order by 1
        ) as t1
                           
        where
            (t1."dias" = (CAST(c."data" as integer) - CAST(d."data" as integer))) and --mfc 13-07-2016 select (t1) e condicoes criadas para resolver duplicidade de devolucao
            (t1."codcli" = d."codcli") and --mfc 13-07-2016 select (t1) e condicoes criadas para resolver duplicidade de devolucao
            (t1."codfil" = c."codfil") and --mfc 13-07-2016 select (t1) e condicoes criadas para resolver duplicidade de devolucao
            (CAST(c."data" as integer) - CAST(d."data" as integer) >= 0) and --mfc 13-07-2016 para ligar estas duas tabelas a data da devolucao sempre sera maior do que da venda
            c."numero dav" <> d."numero dav" and --mfc 13-07-2016 a devolucao e a venda sempre estarao em davs diferentes
            c."cod_cliente" = d."codcli" and --mfc 25-02-2016 adicionado para não ocasionar problemas de conciliação das devoluções entre outros clientes
            c."codbar" = d."codigo de barras"  and
            c."descricao" = d."descricao" and
            c."valor" = d."total" and
            c."qtd"*(-1) = d."quantidade" and
            c."totalcar"*(-1) = d."total"
    );

--CREDITO
if (info2 = 'Pagamento') then
    insert into #Vendas1 //NOMODIFICA
        (
            select 
                bc."data",
                '',
                bc."codigo trans",
                '',
                '',
                '',
                '150',
                'Crédito',
                '',
                'Crédito',
                '',
                'Crédito',
                'Crédito',
                '',
                '',
                0,
                0,
                0,
                (bc."total carrinho" + bc."total estorno" - bc."trans proporcional")*-1,
                0,
                (bc."total carrinho" + bc."total estorno" - bc."trans proporcional")*-1,
                bc."operador",
                bc."filiale",
                150,
                150,
                150,
                '',
                trans."tipo",
                trans."valor"*((bc."total carrinho" + bc."total estorno" - bc."trans proporcional")*-1)/trans."total_trans",
                bc."codigo cli",
                bc."data",
                False

            from #bcredito bc //NOMODIFICA
            
            left join #temp_trans as trans //NOMODIFICA
                on (bc."codigo trans" = trans."cod_trans")
            
            where
                (bc."total carrinho" + bc."total estorno" - bc."trans proporcional") > 0.001
        );
end if;

--DROP DA TEMPORARIA DE SESSAO
    DROP TABLE IF EXISTS ##car; //NOMODIFICA

--PERCENTUAIS DE COMISSÃO --IMPLEMENTAR TAMBÉM QUANDO FOR ÚNICA, SÓ ESTÁ FUNCIONANDO PARA O COMBINADA
create table #comissao( //NOMODIFICA
    tipo_pag varchar(30),
    percent real
);

create index pagidx on #comissao("tipo_pag"); //NOMODIFICA

insert into #comissao( //NOMODIFICA
    select
        CASE foecfg."entry"
            WHEN 'Boleto' THEN 'Boleto bancario'
            WHEN 'Carne' THEN 'Crediário'
            WHEN 'Cartao' THEN 'Cartão'
            WHEN 'CartaoParc' THEN 'Cartão parcelada'
            WHEN 'ChequePre' THEN 'Cheque Pré'
            WHEN 'Convenio' THEN 'Convênio'
            WHEN 'Debito' THEN 'Cartão débito'
            WHEN 'Vista' THEN 'Dinheiro'
            ELSE foecfg."entry"
        END,
        CAST((CASE WHEN foecfg."value" = '' THEN '0' ELSE SUBSTRING(foecfg."value" from 0 for (CASE WHEN POSITION(',' in foecfg."value") = 0 THEN CHAR_LENGTH(foecfg."value") ELSE POSITION(',' in foecfg."value")-1 END)) + '.' + (CASE WHEN POSITION(',' in foecfg."value") = 0 THEN '0' ELSE SUBSTRING(foecfg."value" from POSITION(',' in foecfg."value")+1 for CHAR_LENGTH(foecfg."value") - POSITION(',' in foecfg."value")) END) END) as real)
    from foecfg
    where
        (foecfg."section" = 'Comissao') and
        (foecfg."filiale" = GetFiliale) 
);                         

insert into Vendas
(         
	select
		"operador",
		"data pagamento", --PENSAR PARA OUTRAS DATA BASES
		CASE WHEN (clienti."Nome" IS NULL) OR (clienti."Nome" = '') THEN '' ELSE (clienti."Nome" + ' ') END + CASE WHEN (clienti."cogNome" IS NULL) THEN '' ELSE (SUBSTRING (clienti."cogNome" FROM 1 FOR 29)) END as nome,
		"codigo barras",
		"SKU e Cod Catalogo",
		"Fornecedor",
		CASE "Estoque"
			WHEN '0' THEN 'Armações'
			WHEN '1' THEN 'Lentes Oftálmicas'
			WHEN '2' THEN 'Lentes de Contato'
			WHEN '3' THEN 'Líquidos e Acessórios'
			WHEN '4' THEN 'Serviços e Outros'
			WHEN '99' THEN 'Devolução'
			WHEN '100' THEN 'Sinal'
			WHEN '150' THEN 'Crédito'
		END as "Estoque",
		"Tipos",
		"Familia",
		"Marca",
		"Linha",
		"TipoProduto",
		"Modelo",
		"Descricao",
		"Cor",
		"Tamanho",
		t1."tipo_pag",
		t1."filiale",
		SUM("valor_trans") as "valor_trans"
		
	from #Vendas1 t1 //NOMODIFICA
	join clienti
		on (t1."cod_cliente" = clienti."codice personale")

	group by "operador", "data pagamento", clienti."Nome", clienti."cogNome", "codigo barras", "SKU e Cod Catalogo", "Fornecedor", "Estoque", "Tipos", "Familia", "Marca", "Linha", "TipoProduto", "Modelo", "Descricao", "Cor", "Tamanho", t1."tipo_pag", t1."filiale"    
	order by 1, 2, 3, 4
);

DROP TABLE IF EXISTS Estoque;

DECLARE c1i DATE;                                        
SET c1i = DATE '1899-12-30';
DECLARE c1f DATE;
SET c1f = data_al; 

DECLARE c1i_gg INTEGER;
SET c1i_gg = cast(c1i as integer);

DECLARE Totale_delta_gg INTEGER;
SET Totale_delta_gg = cast(c1f as integer) - c1i_gg;

//-----------------------------------------
IF GetDescClusterPrezzo('V',1000) = '' THEN
Insert Into FasceDiPrezzo ("Codice Filiale","Tipo","Sigla","Descrizione","LimiteInferiore")
values
('VA','V','A','0 - 149'  ,  0),
('VB','V','B','150 - 249',150),
('VC','V','C','250 - 349',250),
('VD','V','D','350 - 449',350),
('VE','V','E','450 - 549',450),
('VF','V','F','550 - 649',550),
('VG','V','G','> 650'    ,650);
END IF;

IF GetDescClusterPrezzo('A',1000) = '' THEN
Insert Into FasceDiPrezzo ("Codice Filiale","Tipo","Sigla","Descrizione","LimiteInferiore")
values
('AA','A','A','0 - 49'   ,  0),
('AB','A','B','50 - 99'  , 50),
('AC','A','C','100 - 149',100),
('AD','A','D','150 - 199',150),
('AE','A','E','200 - 249',200),
('AF','A','F','250 - 299',250),
('AG','A','G','> 300'    ,300);
END IF;

create table #temp_vendas //NOMODIFICA
    (
        "codice articolo" varchar(12),
        "qtd vendita 2" integer,
        "filiale2" varchar(2),
        "data" date
    );

insert into #temp_vendas //NOMODIFICA
    (
        select
            carrello2."codice articolo",
            carrello2."quantita",
            carrello2."filiale",
            carrello2."data"
        from carrello2
        where
            carrello2."data" > c1i and
            carrello2."data" < c1f
    );

insert into #temp_vendas //NOMODIFICA
    (
        select
            storicocarrello2."codice articolo",
            storicocarrello2."quantita",
            storicocarrello2."filiale",
            storicocarrello2."data"
        from storicocarrello2
        where
            storicocarrello2."data" > c1i and
            storicocarrello2."data" < c1f
    );

    
create table #temp_vendas3 //NOMODIFICA
    (
        codice varchar(12),
        qtd integer,
        filiale3 varchar(2),
        ult varchar(10)
    );

insert into #temp_vendas3 //NOMODIFICA
    (
        select
            tv."codice articolo",
            SUM(tv."qtd vendita 2"),
            tv."filiale2",
            MAX(substring(cast(tv."data" as varchar(20)) from 6 for 10))
        from #temp_vendas tv //NOMODIFICA
        where
            tv."data" > c1i and
            tv."data" < c1f
        
        group by
        tv."codice articolo",
        tv."filiale2"
        
        having
        (sum(tv."qtd vendita 2") > 0)
    );
    
create table #temp_vendas2 //NOMODIFICA
    (
        "codice articolo" varchar(12),
        "qtd vendita 3" integer,
        "filiale2" varchar(2),
        "ultima ven 3" varchar(10)
    );

    
insert into #temp_vendas2 //NOMODIFICA
    (
        select
            carrello2."codice articolo",
            COALESCE(SUM(carrello2."quantita"),0.0),
            carrello2."filiale",
            MAX(substring(cast(carrello2."data pagamento" as varchar(20)) from 6 for 10))
        from carrello2
        where
            carrello2."data pagamento" >= c1i and
            carrello2."data pagamento" <= c1f
        
        group by
        carrello2."codice articolo",
        carrello2."filiale"
        
        having
        (sum(carrello2."quantita") > 0)
    );
    
insert into #temp_vendas2 //NOMODIFICA
    (
        select
            storicocarrello2."codice articolo",
            COALESCE(SUM(storicocarrello2."quantita"),0.0),
            storicocarrello2."filiale",
            MAX(substring(cast(storicocarrello2."data pagamento" as varchar(20)) from 6 for 10))
        from storicocarrello2
        where
            storicocarrello2."data pagamento" >= c1i and
            storicocarrello2."data pagamento" <= c1f

        group by
        storicocarrello2."codice articolo",
        storicocarrello2."filiale"
        
        having
        (sum(storicocarrello2."quantita") > 0)
    );


create table #mov //NOMODIFICA       
 (
  "Codice articolo" varchar(12), 
  "filiale" varchar(2),              
  "Codice magazzino" varchar(12), 
  "data" date,                          
  "gg_delta" integer,
  "Tipo operazione" varchar(4),                           
  "Operatore" varchar(6),              
  "qtamov" float,
  "qta_acq" float,
  "qta_res_for" float,
  "qta_ven" float,
  "qta_res_cli" float,              
--  "qta_ing" float, não serve Brasil
--  "qta_res_ing" float, não serve Brasil
  "qta_tr_in" float,
  "qta_tr_out" float,
  "qta_tr" float,
  "qta_altri" float,
  "Acquisto" float,
  "Reso fornitore" float,
  "Reso cliente" float,
--  "Reso cliente netto" float, não serve Brasil
--  "Reso ingrosso" float, não serve Brasil
--  "Listino lordo" float, não serve Brasil
--  "Listino netto" float, não serve Brasil
--  "Fatturato lordo" float, não serve Brasil
--  "Fatturato netto" float, não serve Brasil
--  "Ingrosso" float, não serve Brasil
--  "Costo_ven" float, não serve Brasil
  "Costo_res" float,
--  "Costo_ing" float, não serve Brasil
--  "Costo_res_ing" float, não serve Brasil
  "valore_tr_in" float ,
  "valore_tr_out" float ,
  "qta_ir_IN" float,
  "qta_ir_OUT" float,
  "giacenza" float,
  "costo giacenza" float
 );                 
create index caidx on #mov("Codice articolo");      //NOMODIFICA


insert into #mov // //NOMODIFICA
select
movimenti."Codice articolo",
movimenti."filiale",
movimenti."Codice magazzino",
movimenti."data",                                 
cast(movimenti."data" as integer) - c1i_gg,
movimenti."tipo operazione",       
movimenti.Operatore,
 (case when (movimenti."Tipo operazione"='VEN')OR
            (movimenti."Tipo operazione"='ING')OR
            (movimenti."Tipo operazione"='FURT')OR
            (movimenti."Tipo operazione"='ERR')OR
            (movimenti."Tipo operazione"='DIST')OR
            (movimenti."Tipo operazione"='ROTT')OR
            (movimenti."Tipo operazione"='SCA')  then -1*coalesce(movimenti.Quantita,0) else coalesce(movimenti.Quantita,0) end) as "qtamov",

 (case when movimenti."Tipo operazione"='ACQ' then coalesce(movimenti.Quantita,0) else 0 end) as "qta_acq",
 (case when ((movimenti."Tipo operazione"='RES')or(movimenti."Tipo operazione"='RESF')) AND
             (movimenti.Quantita<0) then -coalesce(movimenti.Quantita,0) else 0 end)          as "qta_res_for",

 (case when movimenti."Tipo operazione"='VEN' then coalesce(movimenti.Quantita,0) else 0 end) as "qta_ven",
 (case when ((movimenti."Tipo operazione"='RES')or(movimenti."Tipo operazione"='RESC')) AND
             (movimenti.Quantita>0) then coalesce(movimenti.Quantita,0) else 0 end)           as "qta_res_cli",

/* (case when movimenti."Tipo operazione"='ING' then coalesce(movimenti.Quantita,0) else 0 end)   as "qta_ing",*/ --não serve Brasil
/* (case when movimenti."Tipo operazione"='RESI' then coalesce( movimenti.Quantita,0) else 0 end) as "qta_res_ing",*/ --não serve Brasil

 (case when (substring(movimenti."Tipo operazione" from 1 for 2) ='TR') AND (coalesce(movimenti.Quantita,0)>0) then movimenti.Quantita else 0 end) as "qta_tr_in",
 (case when (substring(movimenti."Tipo operazione" from 1 for 2) ='TR') AND (coalesce(movimenti.Quantita,0)<0) then movimenti.Quantita else 0 end) as "qta_tr_out",
 (case when substring(movimenti."Tipo operazione" from 1 for 2) ='TR' then coalesce(movimenti.Quantita,0) else 0 end) as "qta_tr",

 (case when (movimenti."Tipo operazione"='FURT')OR
            (movimenti."Tipo operazione"='ERR')OR
            (movimenti."Tipo operazione"='DIST')OR
            (movimenti."Tipo operazione"='ROTT')OR
            (movimenti."Tipo operazione"='SCA')  then -1*coalesce(movimenti.Quantita,0)
       when (movimenti."Tipo operazione"='GAR')OR
            (movimenti."Tipo operazione"='SOST')OR
            (movimenti."Tipo operazione"='DINV')OR
            (movimenti."Tipo operazione"='CAR')  then  coalesce(movimenti.Quantita,0) 
       else 0.0 
       end) as "qta_Altri",

 (case when movimenti."Tipo operazione"='ACQ' then  (coalesce(movimenti."Prezzo acquisto",0) * coalesce(movimenti.Quantita,0)) else 0 end) as "Acquisto",

 (case when ((movimenti."Tipo operazione"='RES')or(movimenti."Tipo operazione"='RESF')) and  (coalesce(movimenti.Quantita,0)<0)  then 
 -(coalesce(movimenti."Prezzo acquisto",0) * coalesce(movimenti.Quantita,0))
 else 0 end) as "Reso fornitore",

 (case when ((movimenti."Tipo operazione"='RES')or(movimenti."Tipo operazione"='RESC')) and  (coalesce(movimenti.Quantita,0)>0) then 
 (coalesce(movimenti."Prezzo vendita",0) * coalesce(movimenti.Quantita,0))
 else 0 end) as "Reso cliente",

/* (case when ((movimenti."Tipo operazione"='RES')or(movimenti."Tipo operazione"='RESC')) and  (coalesce(movimenti.Quantita,0)>0) then 
 ((coalesce(movimenti."Prezzo vendita",0) * coalesce(movimenti.Quantita,0))/(1+coalesce(movimenti.Iva,0)/100))
 else 0 end) as "Reso cliente netto",*/ --não serve Brasil

/* (case when movimenti."Tipo operazione"='RESI' then 
 (coalesce(movimenti."Prezzo vendita",0) * coalesce(movimenti.Quantita,0))
 else 0 end) as "Reso ingrosso",*/ -- não serve Brasil

/* (case when movimenti."Tipo operazione"='VEN' then 
      (coalesce(movimenti."Prezzo listino vendita",0) * coalesce(movimenti.Quantita,0)) else 0 end) as "Listino lordo",*/ --não serve Brasil
/* (case when movimenti."Tipo operazione"='VEN' then 
     ((coalesce(movimenti."Prezzo listino vendita",0) * coalesce(movimenti.Quantita,0))/(1+coalesce(movimenti.Iva,0)/100)) 
      else 0 end) as "Listino netto",*/ --não serve Brasil

/* (case when movimenti."Tipo operazione"='VEN' then 
 (coalesce(movimenti."Prezzo vendita",0) * coalesce(movimenti.Quantita,0))
 else 0 end) as "Fatturato lordo",*/ --não serve Brasil

/* (case when movimenti."Tipo operazione"='VEN' then 
 ((coalesce(movimenti."Prezzo vendita",0) * coalesce(movimenti.Quantita,0))/(1+coalesce(movimenti.Iva,0)/100))
 else 0 end) as "Fatturato netto",*/ --não serve Brasil

/* (case when movimenti."Tipo operazione"='ING' then 
            (coalesce(movimenti."Prezzo vendita",0) * coalesce(movimenti.Quantita,0))
       else 0 end) as "Ingrosso",*/ --não serve Brasil

/* (case when (movimenti."Tipo operazione"='VEN') then 
            (coalesce(movimenti."Costo Medio",0) * coalesce(movimenti.Quantita,0))
         else 0 end) as "Costo_ven",*/ --não serve Brasil

 (case when ((movimenti."Tipo operazione"='RES')or(movimenti."Tipo operazione"='RESC')) and  (coalesce(movimenti.Quantita,0)>0) 
            then (coalesce(movimenti."Costo Medio",0) * coalesce(movimenti.Quantita,0)) 
       else 0 end) as "Costo_res",

/* (case when (movimenti."Tipo operazione"='ING') 
            then (coalesce(movimenti."Costo Medio",0) * coalesce(movimenti.Quantita,0))
       else 0 end) as "Costo_ing",*/ --não serve Brasil

/* (case when (movimenti."Tipo operazione"='RESI') and  (coalesce(movimenti.Quantita,0)>0) 
            then (coalesce(movimenti."Costo Medio",0) * coalesce(movimenti.Quantita,0)) 
       else 0 end) as "Costo_res_ing",*/ --não serve Brasil

 (case when (substring(movimenti."Tipo operazione" from 1 for 2) ='TR') AND (coalesce(movimenti.Quantita,0)>0) 
       then (coalesce(movimenti."Prezzo acquisto",0) * coalesce(movimenti.Quantita,0))
       else 0 end) as "valore_tr_in",

 (case when (substring(movimenti."Tipo operazione" from 1 for 2) ='TR') AND (coalesce(movimenti.Quantita,0)<0) 
       then (coalesce(movimenti."Prezzo vendita",0) * coalesce(-1*movimenti.Quantita,0))
       else 0 end) as "valore_tr_out",

 (case when (movimenti."Tipo operazione"='ACQ')OR(movimenti."Tipo operazione"='RESF')
            then coalesce(movimenti."Quantita",0.0) else 0.0 end) as "qta_ir_IN",

 (case when (movimenti."Tipo operazione"='VEN')
            then coalesce(movimenti."Quantita",0.0) 
       when (movimenti."Tipo operazione"='RESC')
            then -1*coalesce(movimenti."Quantita",0.0)
       else 0.0 end) as "qta_ir_OUT",

 0, //giacenza            
 0 //costo giacenza
from 
movimenti              
 where      
 ("filiale" <> '00') AND                           
 ("data">=c1i);

//-----------------------------------------
create table #artfil //NOMODIFICA          
 (                                   
   "codice articolo" varchar(12),
   "codice filiale" varchar(12), 
--   "codice IVA" varchar(12) , não serve Brasil
--   "IVA" real , não serve Brasil
   "filiale" varchar(3),
   "quantita iniziale" real,
   "quantita finale" real,
   "quantita magazzino" real,
   "quantita prenotata" real,
   "quantita in arrivo" real,
   "costo medio" real,
   "prezzo vendita" real,
   "valore magazzino costo medio" real,
   "valore magazzino vendita" real,
   "ultimo acq" varchar(10),
   "ultima ven" varchar(10),
   "ultimo acq2" date,
   "ultima ven2" date
 );                 
create index cfidx on #artfil("Codice articolo"); //NOMODIFICA        
insert into #artfil //NOMODIFICA
select 
a."codice articolo",
a."codice filiale", 
--a."codice IVA", não serve Brasil
--a."IVA", não serve Brasil
a."filiale",
(a."quantita magazzino" - coalesce(mi."qta",0)), // quantita iniziale
(a."quantita magazzino" - coalesce(mf."qta",0)), // quantita finale
a."quantita magazzino",
a."quantita prenotata",
a."quantita in arrivo",
a."costo medio",
a."prezzo vendita",
(a."quantita magazzino" * a."costo medio") as "valore magazzino costo medio",
(a."quantita magazzino" * a."prezzo vendita") as "valore magazzino vendita",
substring(cast(a."data ult. acquisto" as varchar(20)) from 6 for 10),
substring(cast(a."data ult. vendita" as varchar(20))  from 6 for 10),
a."data ult. acquisto",
a."data ult. vendita"
from 
(articoli_fil a 
 left join 
   (SELECT
     max(m2."Filiale") as "Filiale",
     max(m2."codice articolo") as "Codice articolo",
     sum(m2."qtamov") as "qta"
    FROM #mov m2 //NOMODIFICA       
    where
     (m2."filiale" <> '00') AND                           
     (m2."data">=c1i) 
    group by 
     m2."Filiale",
     m2."codice articolo") mi
  ON (a."filiale" = mi."Filiale" AND a."codice articolo" = mi."Codice articolo"))
 left join 
   (SELECT
     max(m1."Filiale") as "Filiale",
     max(m1."codice articolo") as "Codice articolo",
     sum(m1."qtamov") as "qta"
    FROM #mov m1 //NOMODIFICA       
    where
     (m1."filiale" <> '00') AND                           
     (m1."data">c1f)
    group by 
     m1."Filiale",
     m1."codice articolo") mf
  ON (a."filiale" = mf."Filiale" AND a."codice articolo" = mf."Codice articolo")
where
 (a."filiale" <> '00');
 
//-----------------------------------------
create table #prezziVEN   //NOMODIFICA
 (
  "prezzo" real,
  "Cluster" varchar(12)
  );
create index pridx on #prezziVEN("prezzo");       //NOMODIFICA
insert into #prezziVEN // select //NOMODIFICA
   SELECT distinct "prezzo vendita" , '' FROM #artfil; //NOMODIFICA
insert into #prezziVEN ("prezzo","cluster") // select //NOMODIFICA
   values(null, 'VA');
update #prezziVEN set "cluster" = GetCFCluster('V',coalesce("Prezzo", 0));    //NOMODIFICA

//-----------------------------------------
create table #prezziACQ   //NOMODIFICA
 (
  "prezzo" real,
  "Cluster" varchar(12)
  );
create index pridx on #prezziACQ("prezzo");       //NOMODIFICA
insert into #prezziACQ // select //NOMODIFICA
   SELECT distinct "prezzo acquisto", '' FROM "articoli_mag";
insert into #prezziACQ ("prezzo", "cluster")      //NOMODIFICA
   values(null, 'AA');
update #prezziACQ set "cluster" = GetCFCluster('A', coalesce("Prezzo", 0));    //NOMODIFICA

//-----------------------------------------
create table #temp_final //NOMODIFICA
    (
        "Filiale" varchar(3),
        "Codice Articolo" varchar(12),
        "Q.ta Iniziale" real,
        "Q.ta Finale" real,
        "Q.ta magazzino" real,
        "Q.ta prenotata" real,
        "Q.ta in arrivo" real,
        "Valore magazzino costo medio" real, 
        "Valore magazzino ult costo" real,
        "Valore magazzino vendita" real,
        "Magazzino" varchar(30),
        "GetTipoProdotto" varchar(12),
        "Codice a barre" varchar(14),
        "Categoria filtro" varchar(2),
        "GetFornitore" varchar(12),
        "GetMarchio" varchar(12),
        "GetUtente" varchar(12),
        "GetMontaggio" varchar(12),
        "Modello" varchar(60),
        "Colore" varchar(25),
        "Colore 2" varchar(25),
        "GetLinea" varchar(12),
        "GetTipoLenti" varchar(12),
        "GetMateriale" varchar(12),
        "Codice stato" varchar(12),
        "Codice attributo1" varchar(12),
        "Codice attributo2" varchar(12),
        "Ponte" float,
        "Asta" float,
        "Calibro" float,
        "Sfera" float,
        "Cilindro" float,
        "Asse" float,
        "Addizione" float,
        "Diametro" varchar(5),
        "Scorta minima" float,
        "Qtd. para pedir" float,
        "IndiceRotazione" float,
        "Q.ta Acquistata" float,
        "Q.ta Reso Fornitore" float,
        "Q.ta Venduta" float,
        "Q.ta Reso Cliente" float,
        "Q.ta TR Ingresso" float,
        "Q.ta TR Uscita" float,
        "Q.ta Trasferimenti" float,
        "Q.ta Altri Movimenti" float,
        "Acquisto" float,
        "Reso fornitore" float,
        "Reso cliente" float,
        "Costo reso" float,
        "valore_tr_out" float,
        "valore_tr_in" float,
        "Cluster" varchar(12),
        "Cluster acq" varchar(12),
        "ultimo acq" varchar(10),
        "ultima ven" varchar(10),
        "ultimo acq2" date,
        "ultima ven2" date
    );

insert into #temp_final //NOMODIFICA
(
    select        
        max(f."Filiale") as "Filiale",      
        max(f."Codice Articolo") as "Codice Articolo",      
        max(f."quantita iniziale") as "Q.ta Iniziale",
        max(f."quantita finale") as "Q.ta Finale",
        max(f."quantita magazzino") as "Q.ta magazzino",
        max(f."quantita prenotata") as "Q.ta prenotata",
        max(f."quantita in arrivo") as "Q.ta in arrivo",
        /*
        max(f."costo medio") as "Costo medio",
        max(coalesce(g."prezzo acquisto", 0)) as "Ult. costo",
        max(f."prezzo vendita") as "Prezzo vendita",
        max(coalesce(g."ricarico", 0)) as "Ricarico",
        */ --Average não funciona para o Cubo
        max(f."Valore magazzino costo medio") as "Valore magazzino costo medio",
        (max(f."quantita magazzino") * max(coalesce(g."prezzo acquisto", 0))) as "Valore magazzino ult costo",
        max(f."Valore magazzino vendita") as "Valore magazzino vendita",
        max(case 
            when articoli."Magazzino"=0 then '(0) Armações'
            when articoli."Magazzino"=1 then '(1) Lentes Oftálmicas'
            when articoli."Magazzino"=2 then '(2) Lentes de contato'
            when articoli."Magazzino"=3 then '(3) Líquidos e acessórios'
            when articoli."Magazzino"=4 then '(4) Serviços' 
            else '(9) Outros' end) as "Magazzino",
        max(articoli."Codice Tipo Prodotto") as "Codice Tipo Prodotto",
        max(articoli."Codice a barre") as "Codice a barre",
        max(articoli."Categoria filtro")as "Categoria filtro",
        max(articoli."Codice Fornitore") as "Codice Fornitore",
        max(articoli."Codice Marchio") as "Codice Marchio",
        max(articoli."Codice Utente") as "Codice Utente",
        max(articoli."Codice Montaggio") as "Codice Montaggcio",
        max(articoli."Modello") as "Modello",                                     
        max(articoli."Colore") as "Colore",
        max(articoli."Colore 2") as "Colore 2",
        max(articoli."Codice linea") as "Codice linea",
        max(articoli."Codice tipo lenti") as "Codice tipo lenti",
        max(articoli."Codice materiale") as "Codice materiale",
        max(articoli."Codice stato") as "Codice stato",
        max(articoli."Codice attributo1") as "Codice attributo1",
        max(articoli."Codice attributo2") as "Codice attributo2",
        max(articoli."Ponte") as "Ponte",
        max(articoli."Asta") as "Asta",
        max(articoli."Calibro") as "Calibro",
        max(articoli."Sfera") as "Sfera",
        max(articoli."Cilindro") as "Cilindro",
        max(articoli."Asse") as "Asse",
        max(articoli."Addizione") as "Addizione",
        max(articoli."Diametro") as "Diametro",

        max(coalesce(g."Scorta minima", 0)) as "Scorta minima",
        CASE WHEN max(coalesce(g."Scorta minima", 0)) <= max(f."quantita magazzino") THEN 0 ELSE max(coalesce(g."Scorta minima", 0)) - max(f."quantita magazzino") END as "Qtd. para pedir",

        Cast((CASE 
        WHEN Totale_delta_gg=0 THEN 0.0
        WHEN (max(coalesce(f."quantita finale",0.0))+
        (sum(coalesce("qta_ir_OUT",0.0)) - sum(coalesce("qta_ir_IN",0.0)))/Totale_delta_gg)=0 THEN 0.0
        ELSE
        round(sum(coalesce("qta_ir_OUT",0.0))/(max(coalesce(f."quantita finale",0.0))+
        (sum(coalesce("qta_ir_OUT",0.0)) - sum(coalesce("qta_ir_IN",0.0)))/Totale_delta_gg)*100)/100
        END) as float) as "IndiceRotazione",

        coalesce(sum(m."qta_acq"),0.0) as "Q.ta Acquistata",
        coalesce(sum(m."qta_res_for"),0.0) as "Q.ta Reso Fornitore",

        coalesce(sum(m."qta_ven"),0.0) as "Q.ta Venduta",                         
        coalesce(sum(m."qta_res_cli"),0.0) as "Q.ta Reso Cliente",

        /*coalesce(sum(m."qta_ing"),0.0) as "Q.ta Ingrosso",
        coalesce(sum(m."qta_res_ing"),0.0) as "Q.ta Reso Ingrosso",*/ --não serve Brasil

        coalesce(sum(m."qta_tr_in"),0.0) as "Q.ta TR Ingresso",
        coalesce(sum(m."qta_tr_out"),0.0) as "Q.ta TR Uscita",
        coalesce(sum(m."qta_tr"),0.0) as "Q.ta Trasferimenti",
        coalesce(sum(m."qta_altri"),0.0) as "Q.ta Altri Movimenti",

        coalesce(sum(m."Acquisto"),0.0) as "Acquisto",
        coalesce(sum(m."Reso fornitore"),0.0) as "Reso fornitore",

        /*coalesce(sum(m."Fatturato lordo" ),0.0) as "Fatturato lordo",
        coalesce(sum(m."Fatturato netto"),0.0) as "Fatturato netto",*/ --não serve Brasil
        coalesce(sum(m."Reso cliente"),0.0) as "Reso cliente",
        /*coalesce(sum(m."Reso cliente netto"),0.0) as "Reso cliente netto",
        coalesce(sum(m."Costo_ven"),0.0) as "Costo venduto",*/ --não serve Brasil
        coalesce(sum(m."Costo_res"),0.0) as "Costo reso",

        /*coalesce(sum(m."Costo_ing"),0.0) as "Costo ingrosso",
        coalesce(sum(m."Costo_res_ing"),0.0) as "Costo resi ing",*/ --não serve Brasil

        coalesce(sum(m."valore_tr_out"),0.0) as "valore_tr_out",
        coalesce(sum(m."valore_tr_in"),0.0) as "valore_tr_in",

        /*coalesce(sum(m."Costo_ven" - m."Costo_res"),0.0) as "Costo reale ven",
        coalesce(sum(m."Fatturato netto" - m."Reso cliente netto"),0.0) as "Fatturato reale ven",
        coalesce(sum(m."Fatturato netto" - m."Reso cliente netto"- m."Costo_ven" + m."Costo_res"),0.0) as "Margine reale ven",
        coalesce(sum(m."Fatturato netto" - m."Costo_ven"),0.0) as "Margine ven",

        (CASE WHEN sum(m."Fatturato netto") <> 0.0 THEN ((sum(m."Fatturato netto")-sum(m."Costo_ven"))/sum(m."Fatturato netto"))*100
              ELSE 0.0
        END) as "Margine ven perc",

        (CASE WHEN sum(m."Fatturato netto" - m."Reso cliente netto") <> 0.0 THEN ((sum(m."Fatturato netto" - m."Reso cliente netto")-sum(m."Costo_ven" - m."Costo_res"))/sum(m."Fatturato netto" - m."Reso cliente netto"))*100
              ELSE 0.0
        END) as "Margine reale ven perc",*/ --não serve Brasil

        //GetCFCluster('V',Max(coalesce(f."Prezzo vendita", 0))) as "Cluster",
        //GetCFCluster('A',Max(coalesce(g."Prezzo acquisto",0))) as "Cluster Acq",
        max(pV."Cluster") as "Cluster",
        max(pA."Cluster") as "Cluster Acq",


        Max(CASE WHEN f."ultimo acq" is null then '' else f."ultimo acq" end) as "ultimo acq",
        Max(CASE WHEN f."ultima ven" is null THEN '' ELSE f."ultima ven" END) as "ultima ven",
        MAX(f."ultimo acq2") as "ultimo acq2",
        MAX(f."ultima ven2") as "ultima ven2"

        FROM
         (
         (articoli left join #artfil f //NOMODIFICA
                  on (articoli."codice filiale" = f."codice articolo"))   
         left join #mov m //NOMODIFICA
                  on (f."codice articolo" = m."codice articolo" AND f."filiale" = m."Filiale")
         left join articoli_mag g //NOMODIFICA 
                  on (f."codice articolo" = g."codice articolo" AND f."filiale" = g."Filiale" AND m."codice magazzino" = g."codice magazzino")
           )
           left join #PrezziVEN pV //NOMODIFICA
                on (f."Prezzo vendita" = pV."Prezzo")
           left join #PrezziACQ pA //NOMODIFICA
                on (g."Prezzo acquisto" = pA."Prezzo")
        where
          (f."Codice articolo" <> '')
        group by
        f."filiale",
        f."Codice articolo"
        having
        (max(f."quantita iniziale") > 0) OR
        (max(f."quantita finale") > 0) OR
        (max(f."quantita magazzino") > 0) OR
        (max(f."quantita prenotata") > 0) OR
        (max(f."quantita in arrivo") > 0) OR
        (sum(m."qta_acq") > 0) OR
        (sum(m."qta_res_for") > 0) OR
        (sum(m."qta_ven") > 0) OR
        (sum(m."qta_res_cli") > 0) OR
        /*(sum(m."qta_ing") > 0) OR
        (sum(m."qta_res_ing") > 0) OR*/ --não serve Brasil
        (sum(m."qta_tr_in") > 0) OR
        (sum(m."qta_tr_out") > 0) OR
        (sum(m."qta_altri") > 0)
    );

create table #temp_parada //NOMODIFICA
    (
        "codice articolo" varchar(12),
        filiale varchar(2),
        "qtd parada" integer
    );
    
insert into #temp_parada //NOMODIFICA
    (
        select
            tf."codice articolo",
            tf."filiale",
            CASE WHEN ((tf."ultima ven" = '') or (tf."ultima ven" is NULL) or (CAST("ultima ven2" as integer) < CAST("ultimo acq2" as integer))) THEN (CAST(c1f as integer) - CAST(tf."ultimo acq2" as integer)) ELSE CAST(tf."ultima ven2" as integer) - CAST(tf."ultimo acq2" as integer) END
        from #temp_final tf //NOMODIFICA
    );

--TABELA ESTOQUE
create table Estoque
    (
        "Filiale" varchar(3),
        "Codice Articolo" varchar(12),
        "Q.ta Iniziale" real,
        "Q.ta Finale" real,
        "Q.ta magazzino" real,
        "Q.ta prenotata" real,
        "Q.ta in arrivo" real,
        "Valore magazzino costo medio" real, 
        "Valore magazzino ult costo" real,
        "Valore magazzino vendita" real,
        "Magazzino" varchar(30),
        "GetTipoProdotto" varchar(40),
        "Codice a barre" varchar(14),
        "Categoria filtro" varchar(2),
        "GetFornitore" varchar(60),
        "GetMarchio" varchar(40),
        "GetUtente" varchar(40),
        "GetMontaggio" varchar(40),
        "Modello" varchar(80),
        "Colore" varchar(25),
        "Colore 2" varchar(25),
        "GetLinea" varchar(40),
        "GetTipoLenti" varchar(40),
        "GetMateriale" varchar(40),
        "Codice stato" varchar(40),
        "Codice attributo1" varchar(12),
        "Codice attributo2" varchar(12),
        "Ponte" float,
        "Asta" float,
        "Calibro" float,
        "Sfera" float,
        "Cilindro" float,
        "Asse" float,
        "Addizione" float,
        "Diametro" varchar(5),
        "Scorta minima" float,
        "Qtd. para pedir" float,
        "IndiceRotazione" float,
        "Q.ta Acquistata" float,
        "Q.ta Reso Fornitore" float,
        "Q.ta Venduta" float,
        "Q.ta Reso Cliente" float,
        "Q.ta TR Ingresso" float,
        "Q.ta TR Uscita" float,
        "Q.ta Trasferimenti" float,
        "Q.ta Altri Movimenti" float,
        "Acquisto" float,
        "Reso fornitore" float,
        "Reso cliente" float,
        "Costo reso" float,
        "valore_tr_out" float,
        "valore_tr_in" float,
        "Cluster" varchar(12),
        "Cluster acq" varchar(12),
        "ultimo acq" varchar(10),
        "ultima ven" varchar(10),
        "qtd vendita 2" integer,
        ult varchar(12),
        "qtd vendita 3" integer,
        "ultima ven 3" varchar(12),
        "qtd parada" integer
    );

insert into Estoque
(
    select
        tf."Filiale",
        tf."Codice Articolo",
        tf."Q.ta Iniziale",
        tf."Q.ta Finale",
        tf."Q.ta magazzino",
        tf."Q.ta prenotata",
        tf."Q.ta in arrivo",
        tf."Valore magazzino costo medio", 
        tf."Valore magazzino ult costo",
        tf."Valore magazzino vendita",
        tf."Magazzino",
        GetTipoProdotto(tf."GetTipoProdotto"),
        tf."Codice a barre",
        tf."Categoria filtro",
        GetFornitore(tf."GetFornitore"),
        GetMarchio(tf."GetMarchio"),
        GetUtente(tf."GetUtente"),
        GetMontaggio(tf."GetMontaggio"),
        tf."Modello",
        tf."Colore",
        tf."Colore 2",
        GetLinea(tf."GetLinea"),
        GetTipoLenti(tf."GetTipoLenti"),
        GetMateriale(tf."GetMateriale"),
        tf."Codice stato",
        tf."Codice attributo1",
        tf."Codice attributo2",
        tf."Ponte",
        tf."Asta",
        tf."Calibro",
        tf."Sfera",
        tf."Cilindro",
        tf."Asse",
        tf."Addizione",
        tf."Diametro",
        tf."Scorta minima",
        tf."Qtd. para pedir",
        tf."IndiceRotazione",
        tf."Q.ta Acquistata",
        tf."Q.ta Reso Fornitore",
        tf."Q.ta Venduta",
        tf."Q.ta Reso Cliente",
        tf."Q.ta TR Ingresso",
        tf."Q.ta TR Uscita",
        tf."Q.ta Trasferimenti",
        tf."Q.ta Altri Movimenti",
        tf."Acquisto",
        tf."Reso fornitore",
        tf."Reso cliente",
        tf."Costo reso",
        tf."valore_tr_out",
        tf."valore_tr_in",
        tf."Cluster",
        tf."Cluster acq",
        tf."ultimo acq",
        tf."ultima ven",
        COALESCE(tv3."qtd",0) as "qtd vendita 2",
        (CASE WHEN tv3."ult" is null then '' else tv3."ult" end) as ult,
        COALESCE(tv2."qtd vendita 3",0) as "qtd vendita 3",
        (CASE WHEN tv2."ultima ven 3" is null then '' else tv2."ultima ven 3" end) as "ultima ven 3",
        CASE WHEN (tp."qtd parada" is NULL) THEN 0 ELSE tp."qtd parada" END as "qtd parada"
        
    from #temp_final tf //NOMODIFICA
    left join #temp_vendas3 tv3 //NOMODIFICA
        on (tv3."codice" = tf."codice articolo" and tv3."filiale3" = tf."filiale")
    left join #temp_vendas2 tv2 //NOMODIFICA
        on (tv2."codice articolo" = tf."codice articolo" and tv2."filiale2" = tf."filiale")
    left join #temp_parada tp //NOMODIFICA
        on (tp."codice articolo" = tf."codice articolo" and tp."filiale" = tf."filiale")
);

select * from Vendas;