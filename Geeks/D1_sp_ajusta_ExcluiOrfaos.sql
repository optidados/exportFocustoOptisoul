ALTER PROCEDURE [dbo].[D1_sp_ajusta_ExcluiOrfaos] as

delete 
	from Carrello
	where
		not exists
		(
			select *
			from (
				select s."codice filiale"
				from sede s

				UNION

				select pv."codice filiale"
				from puntovendita pv
			) as t
			where
				t."codice filiale" = Carrello.[Filiale]
		)

delete 
	from Carrello
	where
		not exists
		(
			select *
			from clienti as c
			where
				c."codice personale" = Carrello.[Codice cliente]
		)

delete 
	from Carrello
	where
		(Carrello.[Codice fornitura] <> '') and
		not exists
		(
			select *
			from busta as b
			where
				b."codice filiale" = Carrello.[Codice fornitura]
		) and
		not exists
		(
			select *
			from lentibusta as lb
			where
				lb."codice filiale" = Carrello.[Codice fornitura]
		)

delete 
	from Storicocarrello
	where
		not exists
		(
			select *
			from (
				select s."codice filiale"
				from sede s

				UNION

				select pv."codice filiale"
				from puntovendita pv
			) as t
			where
				t."codice filiale" = Storicocarrello.[Filiale]
		)

delete 
	from Storicocarrello
	where
		not exists
		(
			select *
			from clienti as c
			where
				c."codice personale" = Storicocarrello.[Codice cliente]
		)

delete 
	from Storicocarrello
	where
		(Storicocarrello.[Codice fornitura] <> '') and
		not exists
		(
			select *
			from busta as b
			where
				b."codice filiale" = Storicocarrello.[Codice fornitura]
		) and
		not exists
		(
			select *
			from lentibusta as lb
			where
				lb."codice filiale" = Storicocarrello.[Codice fornitura]
		)

delete 
	from Carrello2
	where
		not exists
		(
			select *
			from carrello c
			where
				c."codice filiale" = Carrello2.[Codice carrello]
		)

delete
	from Carrello
	where
		not exists
		(
			select *
			from carrello2 c2
			where
					c2."codice carrello" = Carrello.[Codice filiale]
		)
	
delete
	from Storicocarrello2
	where
		not exists
		(
			select *			
			from storicocarrello sc
			where
				sc."codice filiale" = Storicocarrello2.[Codice carrello]
		)

delete 
	from Storicocarrello
	where
		not exists
		(
			select *			
			from storicocarrello2 sc2
			where
				sc2."codice carrello" = Storicocarrello.[Codice filiale]
		)