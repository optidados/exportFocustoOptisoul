ALTER procedure [dbo].[A1_sp_Altera_Optisoul_Focus] as

exec('use Optisoul;Drop index documento.missing_index_1910')
alter table optisoul..documento ALTER COLUMN PedidoAnt varchar(50)
alter table optisoul..documento ALTER COLUMN IdAnt varchar(50)
alter table optisoul..documento ALTER COLUMN EmpresaAnt varchar(50)
alter table optisoul..documento ALTER COLUMN ClienteAnt varchar(50)
alter table optisoul..documento ALTER COLUMN OrdemAnt varchar(50)

alter table optisoul..item Add CurvaBase numeric(18,4)
alter table optisoul..item Add CurvaBase2 numeric(18,4)
alter table optisoul..item Add CurvaTipo varchar(30)

begin
	Alter Table rata Add ValorPago float
	Alter Table rataclienti Add ValorPago float
	ALTER TABLE diametri ADD EsfDe float
	ALTER TABLE diametri ADD EsfAte float
	ALTER TABLE diametri ADD Cilindrico float

	ALTER TABLE articoli ADD DiametroNum numeric(18,4)
	ALTER TABLE articoli_fornitore ADD DiametroNum numeric(18,4)
	ALTER TABLE diametri ADD DiametroNum numeric(18,4)
	ALTER TABLE diametrirx ADD DiametroNum numeric(18,4)

	/*tenta colocar em diametronum o maior diametro encontrado*/
	update articoli set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')
	update articoli_fornitore set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')
	update diametri set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')
	update diametrirx set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')

	update articoli set [Rb] = replace([Rb],',','.')
	update articoli_fornitore set [Rb] = replace([Rb],',','.')

	update storicocarrello set [Data] = (
			select MAX([Data])
				from storicocarrello2
				where storicocarrello.[Codice filiale] = storicocarrello2.[Codice carrello]
		)
		where [Data] is null

	update carrello set [Data] = (
			select MAX([Data])
				from carrello2
				where carrello.[Codice filiale] = carrello2.[Codice carrello]
		)
		where [Data] is null

	update clienti set campo6_c = replace(campo6_c, '.', '')
end

/*EXCLUI REGISTROS DUPLICADOS NA ANAG_EXT5*/
delete 
	from anag_ext5
	where 
		anag_ext5.[Codice filiale] IN(
			select t."codice filiale"
				from anag_ext5 as t
				where
					t."codice filiale" NOT IN(
						select MAX(u."codice filiale")
						from (
							select b."codice filiale", b."codice cliente" 
								from anag_ext5 as b inner join (
									select d."codice cliente"
										from anag_ext5 as d
										group by d."codice cliente"
										having COUNT(*) > 1
								) as c on b."codice cliente" = c."codice cliente"
						) as u
						group by u."codice cliente"
					)
					and t."codice cliente" IN(
						select a."codice cliente"
							from anag_ext5 as a
							group by a."codice cliente"
							having COUNT(*) > 1
					)
		)

/*EXCLUI DUPLICADOS DE BUSTA E LENTIBUSTA*/
delete
	from carrello
	where
		carrello.[Codice fornitura] IN(
			select storicocarrello.[Codice fornitura]
				from storicocarrello
				where storicocarrello.[Codice fornitura] <> ''
		)
		
/*EXCLUI DUPLICADOS DE BUSTA E LENTIBUSTA*/
delete 
	from carrello
	where 
		carrello.[Codice filiale] IN(
			select t."codice filiale"
				from carrello as t
				where
					t."codice filiale" NOT IN(
						select MAX(u."codice filiale")
						from (
							select b."codice filiale", b."codice fornitura" 
								from carrello as b inner join (
									select d."codice fornitura"
										from carrello as d
										where d."codice fornitura" <> ''
										group by d."codice fornitura"
										having COUNT(*) > 1
								) as c on b."codice fornitura" = c."codice fornitura"
						) as u
						group by u."codice fornitura"
					)
					and t."codice fornitura" IN(
						select a."codice fornitura"
							from carrello as a
							where a."codice fornitura" <> ''
							group by a."codice fornitura"
							having COUNT(*) > 1
					)
		)

/*EXCLUI DUPLICADOS DE BUSTA E LENTIBUSTA*/
delete 
	from storicocarrello
	where 
		storicocarrello.[Codice filiale] IN(
			select t."codice filiale"
				from storicocarrello as t
				where
					t."codice filiale" NOT IN(
						select MAX(u."codice filiale")
						from (
							select b."codice filiale", b."codice fornitura" 
								from storicocarrello as b inner join (
									select d."codice fornitura"
										from storicocarrello as d
										where d."codice fornitura" <> ''
										group by d."codice fornitura"
										having COUNT(*) > 1
								) as c on b."codice fornitura" = c."codice fornitura"
						) as u
						group by u."codice fornitura"
					)
					and t."codice fornitura" IN(
						select a."codice fornitura"
							from storicocarrello as a
							where a."codice fornitura" <> ''
							group by a."codice fornitura"
							having COUNT(*) > 1
					)
		)