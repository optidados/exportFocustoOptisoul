alter procedure D2_sp_importa_PrescricaoEnvelope as

drop table if exists PrescricaoEnvelope;

create table PrescricaoEnvelope
(
	Dias int,
	CodigoEnvelope varchar(12)
);

create index PrescEnvIdx on PrescricaoEnvelope("Dias", "CodigoEnvelope");

insert into PrescricaoEnvelope
select
	MIN(t2."conta"),
	t2."codice filiale"
from 
(
	select 
		DATEDIFF(day, b."data", oc."data") as conta,
		b."codice filiale"
	from busta b
	left join occhiali oc
		on ((b."codice cliente" = oc."codice cliente") and (DATEDIFF(day, b."data", oc."data") >= 0))

	UNION

	select 
		DATEDIFF(day, lb."data", oc."data") as conta,
		lb."codice filiale"
	from lentibusta lb
	left join occhiali oc
		on ((lb."codice cliente" = oc."codice cliente") and (DATEDIFF(day, lb."data", oc."data") >= 0))		
) as t2
group by t2."codice filiale"
