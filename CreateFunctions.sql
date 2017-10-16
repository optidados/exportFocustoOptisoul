--GetMarchio - função que retorna a marca de um item
CREATE FUNCTION GetMarchio (codice_ VARCHAR(12)) 
 RETURNS VARCHAR(25) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(25);
   set ret = '';
   DECLARE acursor CURSOR FOR SELECT marchio."Marchio" from marchio where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   RETURN ret;
END;

--GetLinea - função que retorna a linha de um item
CREATE FUNCTION GetLinea (codice_ VARCHAR(12)) 
 RETURNS VARCHAR(25) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(25);
   set ret = '';
   IF (codice_<>'') THEN
   DECLARE acursor CURSOR FOR SELECT Linea."Linea" from Linea where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   END IF;
   RETURN ret;
END;

--GetTrattamento - função que retorna o tratamento de um item
CREATE FUNCTION GetTrattamento (codice_ VARCHAR(12))
 RETURNS VARCHAR(30) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(30);
   set ret = '';
   IF (codice_<>'') THEN
   DECLARE acursor CURSOR FOR SELECT "Trattamento" from TipoTrattamento where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   END IF;
   RETURN ret;
END;

--GetTipolenti - função que retorna o tipo de lente de um item
CREATE FUNCTION GetTipolenti (codice_ VARCHAR(12)) 
 RETURNS VARCHAR(25) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(25);
   set ret = '';
   IF (codice_<>'') THEN
   DECLARE acursor CURSOR FOR SELECT "Tipo lenti" from Tipolenti where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   END IF;
   RETURN ret;
END;

--GetTipoProdotto - função que retorna o tipo de produto de um item
CREATE FUNCTION GetTipoProdotto (codice_ VARCHAR(12)) 
 RETURNS VARCHAR(25) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(25);
   set ret = '';
   DECLARE acursor CURSOR FOR SELECT "Tipo prodotto" from tipoprodotto where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   RETURN ret;
END;

--GetUtente - função que retorna o gênero do produto
CREATE FUNCTION GetUtente (codice_ VARCHAR(12))
 RETURNS VARCHAR(25) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(25);
   set ret = '';
   IF (codice_<>'') THEN
   DECLARE acursor CURSOR FOR SELECT "Utente" from TipoUtente where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   END IF;
   RETURN ret;
END;

--GetMontaggio - função que retorna o tipo de montagem do item
CREATE FUNCTION GetMontaggio (codice_ VARCHAR(12)) 
 RETURNS VARCHAR(25) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(25);
   set ret = '';
   IF (codice_<>'') THEN
   DECLARE acursor CURSOR FOR SELECT "montaggio" from montaggio where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   END IF;
   RETURN ret; 
END;

--GetMateriale - função que retorna o material do item
CREATE FUNCTION GetMateriale (codice_ VARCHAR(12))
 RETURNS VARCHAR(25) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(25);
   set ret = '';
   IF (codice_<>'') THEN
   DECLARE acursor CURSOR FOR SELECT "Materiale" from Materiale where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   END IF;
   RETURN ret; 
END;

--GetFornitore - função que retorna o fornecedor de um item
CREATE FUNCTION GetFornitore (codice_ VARCHAR(12)) 
 RETURNS VARCHAR(60) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(60);
   set ret = '';
   DECLARE acursor CURSOR FOR SELECT "Ragione sociale" from fornitor where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   RETURN ret;
END;

--GetFamigliaLac - função que retorna o tipo da lente de contato
CREATE FUNCTION GetFamigliaLac (codice_ VARCHAR(12)) 
 RETURNS VARCHAR(20) 
 READS SQL DATA 
 BEGIN 
   DECLARE ret VARCHAR(20);
   set ret = '';
   IF (codice_<>'') THEN
   DECLARE acursor CURSOR FOR SELECT Famiglia from Lac_Famiglia where "codice filiale"=codice_;
   OPEN acursor;
   fetch NEXT from acursor INTO ret;
   CLOSE acursor;
   if (ret is null) THEN SET ret=''; END IF ;
   END IF;
   RETURN ret; 
END;