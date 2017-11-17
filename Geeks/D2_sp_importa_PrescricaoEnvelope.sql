alter procedure [dbo].[D2_sp_importa_PrescricaoEnvelope] as

drop table if exists PrescricaoEnvelope;

create table PrescricaoEnvelope
(
	Dias int,
	CodigoEnvelope varchar(12),
	CodigoReceita varchar(12)
);
/*
create index PrescEnvIdx on PrescricaoEnvelope("Dias", "CodigoEnvelope");
*/
insert into PrescricaoEnvelope
select
	MIN(t2."conta"),
	t2."CodigoEnvelope",
	t2."CodigoReceita"
from 
(
	select 
		DATEDIFF(day, b."data", oc."data") as conta,
		b."codice filiale" as CodigoEnvelope,
		oc."codice filiale" as CodigoReceita
	from busta b
	left join occhiali oc
		on ((b."codice cliente" = oc."codice cliente") and (DATEDIFF(day, b."data", oc."data") >= 0))

	UNION ALL

	select 
		DATEDIFF(day, lb."data", oc."data") as conta,
		lb."codice filiale",
		oc."codice filiale"
	from lentibusta lb
	left join occhiali oc
		on ((lb."codice cliente" = oc."codice cliente") and (DATEDIFF(day, lb."data", oc."data") >= 0))		
) as t2
group by t2."CodigoEnvelope", t2."CodigoReceita"


delete 
	from PrescricaoEnvelope
	where 
		PrescricaoEnvelope.[CodigoReceita] IN(
			select t."CodigoReceita"
				from PrescricaoEnvelope as t
				where
					t."CodigoReceita" NOT IN(
						select MAX(u."CodigoReceita")
							from (
								select b."CodigoReceita", b."CodigoEnvelope" 
									from PrescricaoEnvelope as b inner join (
										select d."CodigoEnvelope"
											from PrescricaoEnvelope as d
											group by d."CodigoEnvelope"
											having COUNT(*) > 1
									) as c on b."CodigoEnvelope" = c."CodigoEnvelope"
							) as u
							group by u."CodigoEnvelope"
					)
					and t."CodigoEnvelope" IN(
						select a."CodigoEnvelope"
							from PrescricaoEnvelope as a
							group by a."CodigoEnvelope"
							having COUNT(*) > 1
					)
		)
