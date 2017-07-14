//NOSQLBDETOFF2
--Create table documento (tabela principal)
drop table if exists PrescricaoEnvelope;
create table PrescricaoEnvelope
(
	Dias int,
	CodigoEnvelope varchar(12)
);

insert into PrescricaoEnvelope
(
	select
		MIN(t2."conta"),
		t2."codice filiale"
	from 
	(
		select 
			CAST(b."data" as int) - CAST(oc."data" as int) as conta,
			b."codice filiale"
		from busta b
			left join occhiali oc
			on ((b."codice cliente" = oc."codice cliente") and ((CAST(b."data" as int) - CAST(oc."data" as int) >= 0)))
	) as t2
	group by t2."codice filiale"
);