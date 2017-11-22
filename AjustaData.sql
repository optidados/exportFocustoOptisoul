update Agenda as a
	set a."Data" = CAST(NULL as date)
	where a."Data" < DATE'1000-01-01';

update Busta as b
	set b."Data prevista consegna" = CAST(NULL as date)
	where b."Data prevista consegna" < DATE'1000-01-01';

update Clienti as c
	set c."Data nascita" = CAST(NULL as date)
	where c."Data nascita" < DATE'1000-01-01';

update FatturaClienti as fc
	set fc."Data" = CAST(NULL as date)
	where fc."Data" < DATE'1000-01-01';

update Movimenti as m
	set m."Data ddt" = CAST(NULL as date)
	where m."Data ddt" < DATE'1000-01-01';

update Occhiali as o
	set o."Data prescrizione" = CAST(NULL as date)
	where o."Data prescrizione" < DATE'1000-01-01';

update Occhiali as o
	set o."Richiamo data1" = CAST(NULL as date)
	where o."Richiamo data1" < DATE'1000-01-01';

update Occhiali as o
	set o."Richiamo data2" = CAST(NULL as date)
	where o."Richiamo data2" < DATE'1000-01-01';

update Rataclienti as rc
	set rc."Data" = CAST(NULL as date)
	where rc."Data" < DATE'1000-01-01';

update "cf-e_" as t
	set t."prezzo ivato" = 0
	where CAST("prezzo ivato" as varchar(50)) = 'NAN';