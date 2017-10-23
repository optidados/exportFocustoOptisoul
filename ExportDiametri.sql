/*
	tem que criar uma diametri_ para exportar o memo como texto
*/

drop routine if exists StringReplace;

create function StringReplace(aStr varchar(15000), findstr varchar(5000), replacestr varchar(5000)) RETURNS varchar(15000)
begin
	declare apos int;
	declare alen int;
	set apos = position(findstr in aStr);
	set alen = char_length(findstr);
	while apos > 0 do
		set aStr = Substring(aStr from 1 for apos - 1) + replacestr + Substring(aStr from apos+alen for char_length(aStr)-alen-apos+1);
		set apos = position(findstr in aStr);
	end while;
	return aStr;
end;

/*
update mytable set myfield=StringReplace(myfield, 'searchstring',
'replacestring') where myfield like '%searchstring%';
  */

create table diametri_ (
	"codice diametro" int,
	"codice articolo" varchar(12),
	"codice filiale" varchar(12),
	"diametro" varchar(10),
	"dati" varchar(15000)
);
/*
insert into diametri_
SELECT
	"codice diametro", 
	"codice articolo", 
	"codice filiale", 
	"diametro", 
	StringReplace(CAST("dati" as varchar(15000)), CHR(13)+CHR(10), '#') as Dati //NOMODIFICA
FROM diametri;
*/
insert into diametri_
SELECT
	"codice diametro", 
	"codice articolo", 
	"codice filiale", 
	"diametro", 
	CAST("dati" as varchar(15000))
FROM diametri;