//NOSQLBDETOFF2 
DECLARE @id varchar(12);

DECLARE @input varchar(8000);

DECLARE @delimiter_position INTEGER;

DECLARE @delimiter varchar(255);

DECLARE @i INTEGER;

DECLARE @cur CURSOR FOR 
  SELECT 
    d."codice filiale",
    d."dati" 
  FROM diametri as d;

SET @delimiter = CHR(13) + CHR(10);

DROP TABLE IF EXISTS linhas_prontas;

CREATE TABLE linhas_prontas (
  "codice filiale" varchar(12),
  n_linha integer,
  linha varchar(255)
);

OPEN @cur;

FETCH NEXT FROM @cur INTO @id, @input;

WHILE @@FETCH_STATUS = 0 DO

  SET @i = 1;

  SET @delimiter_position = POSITION(@delimiter IN @input);

  WHILE @delimiter_position > 0 DO

    INSERT INTO linhas_prontas ("codice filiale", n_linha, linha) VALUES (@id, @i, SUBSTRING(@input FROM 0 FOR @delimiter_position - 1)); //NOMODIFICA

    SET @input = SUBSTRING(@input FROM (@delimiter_position + CHAR_LENGTH(@delimiter)) FOR (CHAR_LENGTH(@input) - CHAR_LENGTH(SUBSTRING(@input FROM 0 FOR @delimiter_position - 1))));

    SET @delimiter_position = POSITION(@delimiter IN @input);

    SET @i = @i + 1;

  END WHILE;

  FETCH NEXT FROM @cur INTO @id, @input;

END WHILE;

CLOSE @cur;

DROP TABLE IF EXISTS diametri2;

CREATE TABLE diametri2
  (
    "codice articolo" varchar(12),
    "diametro" varchar(10),
    "esf_de" numeric(18, 4),
    "esf_ate" numeric(18, 4),
    "cilindrico" numeric(18, 4)
  );

INSERT INTO diametri2
  SELECT 
    d."codice articolo",
    d."diametro",
    CAST
      (
        (
          CASE 
            WHEN (POSITION('.' in TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2))) <> 0)
              THEN TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2))
            WHEN (TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2)) = '')
              THEN CAST(NULL as varchar)
              ELSE 
                SUBSTRING
                (
                  TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2)) from 0 for 
                  (
                    CASE WHEN POSITION(',' in TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2))) = 0 THEN CHAR_LENGTH(TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2))) ELSE POSITION(',' in TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2)))-1 END
                  )
                ) +
                '.' + 
                (
                  CASE WHEN POSITION(',' in TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2))) = 0 
                    THEN '0' 
                    ELSE SUBSTRING(TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2)) from POSITION(',' in TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2)))+1 for CHAR_LENGTH(TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2))) - POSITION(',' in TOSTRING(SUBSTRING(d."dati" FROM 0 FOR POSITION('+:' IN d."dati")-2)))) 
                  END
                ) 
          END
        ) as numeric(18, 4)
      ) as esf_min,
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
      ) as esf_max,
    cil."cilindrico"
  FROM diametri as d
    INNER JOIN linhas_prontas as esf_max
      ON (d."codice filiale" = esf_max."codice filiale")
    INNER JOIN 
    (
      SELECT
        lp."codice filiale",
        MIN(
          CASE SUBSTRING(lp."linha" FROM (POSITION('-:' IN lp."linha") + 2) FOR (CHAR_LENGTH(lp."linha") - POSITION('-:' IN lp."linha")))
            WHEN '1' THEN 0
            WHEN '11' THEN -0.25
            WHEN '111' THEN -0.5
            WHEN '1111' THEN -0.75
            WHEN '11111' THEN -1
            WHEN '111111' THEN -1.25
            WHEN '1111111' THEN -1.5
            WHEN '11111111' THEN -1.75
            WHEN '111111111' THEN -2
            WHEN '1111111111' THEN -2.25
            WHEN '11111111111' THEN -2.5
            WHEN '111111111111' THEN -2.75
            WHEN '1111111111111' THEN -3
            WHEN '11111111111111' THEN -3.25
            WHEN '111111111111111' THEN -3.5
            WHEN '1111111111111111' THEN -3.75
            WHEN '11111111111111111' THEN -4
            WHEN '111111111111111111' THEN -4.25
            WHEN '1111111111111111111' THEN -4.5
            WHEN '11111111111111111111' THEN -4.75
            WHEN '111111111111111111111' THEN -5
            WHEN '1111111111111111111111' THEN -5.25
            WHEN '11111111111111111111111' THEN -5.5
            WHEN '111111111111111111111111' THEN -5.75
            WHEN '1111111111111111111111111' THEN -6
          END
        ) as cilindrico
      FROM linhas_prontas as lp
      GROUP BY lp."codice filiale"
    ) as cil
      ON (d."codice filiale" = cil."codice filiale")
  WHERE
    esf_max."codice filiale" + CAST(esf_max."n_linha" as varchar(10)) IN
    (
      SELECT t2."codice filiale" + CAST(t2."n_linha" as varchar(10))
      FROM
        (
          SELECT 
            t1."codice filiale", 
            MAX(t1."n_linha") as n_linha
          FROM linhas_prontas as t1
          GROUP BY t1."codice filiale"  
        ) as t2
    );