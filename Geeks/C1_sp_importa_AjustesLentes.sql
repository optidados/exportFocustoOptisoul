ALTER procedure [dbo].[C1_sp_importa_AjustesLentes] as
DROP TABLE IF EXISTS linhas_prontas;

CREATE TABLE linhas_prontas (
  "codice filiale" varchar(12),
  linha varchar(255)
);

DECLARE @id varchar(12);
DECLARE @input varchar(max);

DECLARE cur CURSOR FOR 
	SELECT 
		d."codice filiale",
		d."dati" 
	FROM diametri as d;

OPEN cur;

FETCH NEXT FROM cur INTO @id, @input;

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO linhas_prontas
	select @id, ltrim(rtrim(replace(value,char(13),''))) i 
	from STRING_SPLIT(@input, char(10));

	FETCH NEXT FROM cur INTO @id, @input;
END

CLOSE cur;
DEALLOCATE cur;

update d
set 
	d.EsfDe = s1.Mi, 
	d.EsfAte = s1.Mx, 
	d.Cilindrico = s1.Cil
from diametri as d inner join (
	select
		s2.[codice filiale],
		min(a) Mi,
		max(a) Mx,
		(max(b) - 1)*(-0.25) Cil
	from (
		select
			s3."codice filiale",
			s3.a,
			len(substring(b,charindex('1',b),len(b))) b
		from (
			select
				lp."codice filiale",
				cast(replace(left(linha,(CASE WHEN CHARINDEX('-:',linha) <= 0 THEN 2 ELSE CASE WHEN CHARINDEX('+:',linha) > 0 THEN CHARINDEX('+:',linha) ELSE CHARINDEX('-:',linha) END END)-2),',','.') as float) a,
				REVERSE(substring(linha,(CASE WHEN CHARINDEX('-:',linha) > 0 THEN CHARINDEX('-:',linha)+2 ELSE len(linha)+1 END),len(linha))) b 
			from linhas_prontas lp
		) s3
		where charindex('1',b) > 0
	) s2
	group by s2."codice filiale"
) s1 on
	s1."codice filiale" = d."Codice filiale"

/*
	A prezzilenti2 é uma limpeza da prezzilenti que contém muita sujeira
	A tabela prezzilenti2 não conterá descrições de preços desnecessárias (por isso uso o distinct no insert)
	Esta descrição da prezzilenti2 está presente no Item, por isso é retirada a descrição de itens
	que não possuem mais do que 1 regra de preço
*/

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

UPDATE p2
SET p2."codice filiale" = p."codice filiale"
FROM prezzilenti2 as p2 inner join prezzilenti as p
	on p."codice articolo" = p2."codice articolo";

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