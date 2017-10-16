//NOSQLBDETOFF2 
DECLARE @id varchar(12);

DECLARE @diametro varchar(10);

DECLARE @input varchar(8000);

DECLARE @delimiter_position, @cil_position, @i integer;

DECLARE @delimiter varchar(255);

DECLARE @cur CURSOR FOR 
  SELECT 
    d."codice filiale",
    d."diametro",
    d."dati" 
  FROM diametri as d;

SET @delimiter = CHR(13) + CHR(10);

DROP TABLE IF EXISTS linhas_prontas;

CREATE TABLE linhas_prontas (
  "codice filiale" varchar(12),
  diametro varchar(10),
  n_linha integer,
  linha varchar(255)
);

OPEN @cur;

FETCH NEXT FROM @cur INTO @id, @diametro, @input;

WHILE @@FETCH_STATUS = 0 DO

  SET @i = 1;

  SET @delimiter_position = POSITION(@delimiter IN @input);

  WHILE @delimiter_position > 0 DO

    SET @cil_position = POSITION('-:' IN @input);

    IF @cil_position < @delimiter_position THEN

      INSERT INTO linhas_prontas ("codice filiale", diametro, n_linha, linha) VALUES (@id, @diametro, @i, SUBSTRING(@input FROM 0 FOR @delimiter_position - 1)); //NOMODIFICA

      SET @input = SUBSTRING(@input FROM (@delimiter_position + CHAR_LENGTH(@delimiter)) FOR (CHAR_LENGTH(@input) - CHAR_LENGTH(SUBSTRING(@input FROM 0 FOR @delimiter_position - 1))));

      SET @i = @i + 1;

    ELSE

      SET @input = SUBSTRING(@input FROM (@delimiter_position + CHAR_LENGTH(@delimiter)) FOR (CHAR_LENGTH(@input) - CHAR_LENGTH(SUBSTRING(@input FROM 0 FOR @delimiter_position - 1))));

    END IF;

    SET @delimiter_position = POSITION(@delimiter IN @input);

  END WHILE;

  FETCH NEXT FROM @cur INTO @id, @diametro, @input;

END WHILE;

CLOSE @cur;

DROP TABLE IF EXISTS diametri2;

CREATE TABLE diametri2
  (
    "codice filiale" varchar(12),
    "codice articolo" varchar(12),
    "diametro" varchar(10),
    "esf_de" numeric(18, 4),
    "esf_ate" numeric(18, 4),
    "cilindrico" numeric(18, 4)
  );

INSERT INTO diametri2
  SELECT 
    d."codice filiale",
    d."codice articolo",
    d."diametro",
    CAST
      (
        (
          CASE 
            WHEN (POSITION('.' in TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2))) <> 0)
              THEN TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2))
            WHEN (TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2)) = '')
              THEN CAST(NULL as varchar)
              ELSE 
                SUBSTRING
                (
                  TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2)) from 0 for 
                  (
                    CASE WHEN POSITION(',' in TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2))) = 0 THEN CHAR_LENGTH(TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2))) ELSE POSITION(',' in TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2)))-1 END
                  )
                ) +
                '.' + 
                (
                  CASE WHEN POSITION(',' in TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2))) = 0 
                    THEN '0' 
                    ELSE SUBSTRING(TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2)) from POSITION(',' in TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2)))+1 for CHAR_LENGTH(TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2))) - POSITION(',' in TOSTRING(SUBSTRING(esf_min."linha" FROM 0 FOR POSITION('+:' IN esf_min."linha")-2)))) 
                  END
                ) 
          END
        ) as numeric(18, 4)
      ) as esf_min,
    COALESCE(
      CAST
        (
          (
            CASE 
              WHEN (POSITION('.' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2)) <> 0)
                THEN SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2)
              WHEN (SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2) = '')
                THEN CAST(NULL as varchar)
                ELSE 
                  SUBSTRING
                  (
                    SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2) from 0 for 
                    (
                      CASE WHEN POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2)) = 0 THEN CHAR_LENGTH(SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2)) ELSE POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2))-1 END
                    )
                  ) +
                  '.' + 
                  (
                    CASE WHEN POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2)) = 0 
                      THEN '0' 
                      ELSE SUBSTRING(SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2) from POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2))+1 for CHAR_LENGTH(SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2)) - POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('+:' IN esf_max."linha")-2))) 
                    END
                  ) 
            END
          ) as numeric(18, 4)
        ),
      CAST
        (
          (
            CASE 
              WHEN (POSITION('.' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2)) <> 0)
                THEN SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2)
              WHEN (SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2) = '')
                THEN CAST(NULL as varchar)
                ELSE 
                  SUBSTRING
                  (
                    SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2) from 0 for 
                    (
                      CASE WHEN POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2)) = 0 THEN CHAR_LENGTH(SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2)) ELSE POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2))-1 END
                    )
                  ) +
                  '.' + 
                  (
                    CASE WHEN POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2)) = 0 
                      THEN '0' 
                      ELSE SUBSTRING(SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2) from POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2))+1 for CHAR_LENGTH(SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2)) - POSITION(',' in SUBSTRING(esf_max."linha" FROM 0 FOR POSITION('-:' IN esf_max."linha")-2))) 
                    END
                  ) 
            END
          ) as numeric(18, 4) 
        ) 
      ) as esf_max,
    cil."cilindrico"
  FROM diametri as d
    INNER JOIN linhas_prontas as esf_min
      ON (d."codice filiale" = esf_min."codice filiale") and (d."diametro" = esf_min."diametro")
    INNER JOIN linhas_prontas as esf_max
      ON (d."codice filiale" = esf_max."codice filiale") and (d."diametro" = esf_max."diametro")
    INNER JOIN 
    (
      SELECT
        lp."codice filiale",
        lp."diametro",
        MIN(
          CASE
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '1' THEN 0
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_1' THEN -0.25
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '__1' THEN -0.5
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '___1' THEN -0.75
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '____1' THEN -1
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_____1' THEN -1.25
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '______1' THEN -1.5
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_______1' THEN -1.75
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '________1' THEN -2
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_________1' THEN -2.25
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '__________1' THEN -2.5
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '___________1' THEN -2.75
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '____________1' THEN -3
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_____________1' THEN -3.25
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '______________1' THEN -3.5
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_______________1' THEN -3.75
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '________________1' THEN -4
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_________________1' THEN -4.25
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '__________________1' THEN -4.5
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '___________________1' THEN -4.75
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '____________________1' THEN -5
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_____________________1' THEN -5.25
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '______________________1' THEN -5.5
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '_______________________1' THEN -5.75
            WHEN SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha"))) LIKE '________________________1' THEN -6
          END
        ) as cilindrico
      FROM linhas_prontas as lp
      GROUP BY lp."codice filiale", lp."diametro"
    ) as cil
      ON (d."codice filiale" = cil."codice filiale") and (d."diametro" = cil."diametro")
  WHERE
    esf_max."codice filiale" + esf_max."diametro" + CAST(esf_max."n_linha" as varchar(10)) IN
    (
      SELECT t2."codice filiale" + t2."diametro" + CAST(t2."n_linha" as varchar(10))
      FROM
        (
          SELECT 
            t1."codice filiale",
            t1."diametro",
            MAX(t1."n_linha") as n_linha
          FROM linhas_prontas as t1
          GROUP BY t1."codice filiale", t1."diametro"  
        ) as t2
    ) and
    esf_min."n_linha" = 1;

DROP TABLE IF EXISTS prezzilenti2;

CREATE TABLE prezzilenti2
(
  "codice filiale" varchar(12),
  "codice articolo" varchar(12),
  "descrizione" varchar(60),
  "prezzo acquisto" numeric(18, 4),
  "prezzo di vendita" numeric(18, 4)
);

INSERT INTO prezzilenti2
  SELECT DISTINCT
    CAST(NULL as varchar),
    "codice articolo",
    CAST(NULL as varchar),
    "prezzo acquisto",
    "prezzo di vendita"
  FROM prezzilenti;

DELETE FROM prezzilenti2
WHERE
  EXISTS (
    SELECT COUNT(*), p2."codice articolo"
    FROM prezzilenti2 as p2
    WHERE prezzilenti2."codice articolo" = p2."codice articolo"
    GROUP BY p2."codice articolo"
    HAVING COUNT(*) > 1
  );

UPDATE prezzilenti2 as p2
SET p2."codice filiale" = (
  SELECT MAX(p."codice filiale")
  FROM prezzilenti as p
  WHERE p."codice articolo" = p2."codice articolo"
);

INSERT INTO prezzilenti2
  SELECT DISTINCT
    "codice filiale",
    "codice articolo",
    "descrizione",
    "prezzo acquisto",
    "prezzo di vendita"
  FROM prezzilenti as p
  WHERE 
    NOT EXISTS (
      SELECT * FROM prezzilenti2 p2
      WHERE p2."codice articolo" = p."codice articolo"
    );