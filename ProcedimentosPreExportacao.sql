delete from carrello as c
where
	(c."codice fornitura" <> '') and
	not exists
	(
		select *
		from busta as b
		where
			b."codice filiale" = c."codice fornitura"
	) and
	not exists
	(
		select *
		from lentibusta as lb
		where
			lb."codice filiale" = c."codice fornitura"
	);

delete from storicocarrello as sc
where
	(sc."codice fornitura" <> '') and
	not exists
	(
		select *
		from busta as b
		where
			b."codice filiale" = sc."codice fornitura"
	) and
	not exists
	(
		select *
		from lentibusta as lb
		where
			lb."codice filiale" = sc."codice fornitura"
	);

delete from carrello2 c2
where
	not exists
	(
		select *
		from carrello c
		where
			c."codice filiale" = c2."codice carrello"
	);

delete from carrello c
where
	not exists
	(
		select *
		from carrello2 c2
		where
			 c2."codice carrello" = c."codice filiale"
	);
	
delete from storicocarrello2 sc2
where
	not exists
	(
		select *			
		from storicocarrello sc
		where
			sc."codice filiale" = sc2."codice carrello"
	);

delete from storicocarrello sc
where
	not exists
	(
		select *			
		from storicocarrello2 sc2
		where
			sc2."codice carrello" = sc."codice filiale"
	);

update movimentoconti as m
set m."importo" = 0
where m."importo" between -0.004 and 0.004;

update carrello as c
set c."totale" = 0
where c."totale" between -0.004 and 0.004;

update carrello2 as c2
set c2."totale" = 0
where c2."totale" between -0.004 and 0.004;

update storicocarrello as sc
set sc."totale" = 0
where sc."totale" between -0.004 and 0.004;

update storicocarrello2 as sc2
set sc2."totale" = 0
where sc2."totale" between -0.004 and 0.004;

/*não sei que tipo de problema o código de barras em branco poderia ocasionar
foi o Alison que deu essa dica
---------------------------------------------
--Verificar Códigos de Barras em branco--
select * from carrello2 as c2
where c2."codice a barre" = '';
	
select * from storicocarrello2 as sc2
where sc2."codice a barre" = '';
*/
---------------------------------------------
--Verificar "codice filiale" duplicados--
select c."codice filiale"
from carrello as c
group by c."codice filiale"
having COUNT(c."codice filiale") > 1;

select sc."codice filiale"
from storicocarrello as sc
group by sc."codice filiale"
having COUNT(sc."codice filiale") > 1;