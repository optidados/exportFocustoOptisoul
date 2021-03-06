USE [Focus]
GO
/****** Object:  StoredProcedure [dbo].[sp_importa2]    Script Date: 30/10/2017 12:00:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[sp_importa2] as
/* ja inseridos no sp_importa
update articoli_mag set [Prezzo listino acquisto] = replace(left([Prezzo listino acquisto],10),',','.')
ALTER TABLE articoli_mag ALTER COLUMN [Prezzo listino acquisto] float
update articoli_mag set [Prezzo acquisto] = replace(left([Prezzo acquisto],10),',','.')
ALTER TABLE articoli_mag ALTER COLUMN [Prezzo acquisto] float
update articoli_mag set [Costo medio] = replace(left([Costo medio],10),',','.')
ALTER TABLE articoli_mag ALTER COLUMN [Costo medio] float
update articoli_mag set [Scorta minima] = replace(left([Scorta minima],10),',','.')
ALTER TABLE articoli_mag ALTER COLUMN [Scorta minima] float

update articoli_fil set [Prezzo vendita] = replace(left([Prezzo vendita],10),',','.')
ALTER TABLE articoli_fil ALTER COLUMN [Prezzo vendita] float

update articoli_fornitore set [Prezzo listino acquisto] = replace(left([Prezzo listino acquisto],10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN [Prezzo listino acquisto] float
update articoli_fornitore set [Prezzo consigliato] = replace(left([Prezzo consigliato],10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN [Prezzo consigliato] float

update articoli set Asse = replace(left(Asse,10),',','.')
ALTER TABLE articoli ALTER COLUMN Asse float
update articoli set Addizione = replace(left(Addizione,10),',','.')
ALTER TABLE articoli ALTER COLUMN Addizione float
update articoli set Sfera = replace(left(Sfera,10),',','.')
ALTER TABLE articoli ALTER COLUMN Sfera float
update articoli set Cilindro = replace(left(Cilindro,10),',','.')
ALTER TABLE articoli ALTER COLUMN Cilindro float
update articoli set Rb2 = replace(left(Rb2,10),',','.')
ALTER TABLE articoli ALTER COLUMN Rb2 float
update articoli set Campo_1 = replace(left(Campo_1,10),',','.')
ALTER TABLE articoli ALTER COLUMN Campo_1 float
/*diametro no FOCUS é do tipo varchar(10) e com certeza dará problema de conversão
--na base da Elis Pedreira já apresenta erro na articoli
update articoli set Diametro = replace(left(Diametro,10),',','.')
ALTER TABLE articoli ALTER COLUMN Diametro float*/
/*rb1 no FOCUS é do tipo varchar(5) e com certeza dará problema de conversão
--na base da Elis Pedreira já apresenta erro na articoli
update articoli set Rb = replace(left(Rb,10),',','.')
ALTER TABLE articoli ALTER COLUMN Rb float*/

update articoli_fornitore set Asse = replace(left(Asse,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Asse float
update articoli_fornitore set Addizione = replace(left(Addizione,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Addizione float
update articoli_fornitore set Sfera = replace(left(Sfera,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Sfera float
update articoli_fornitore set Cilindro = replace(left(Cilindro,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Cilindro float
update articoli_fornitore set Rb2 = replace(left(Rb2,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Rb2 float
update articoli_fornitore set Campo_1 = replace(left(Campo_1,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Campo_1 float
/*diametro no FOCUS é do tipo varchar(10) e com certeza dará problema de conversão
update articoli_fornitore set Diametro = replace(left(Diametro,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Diametro float*/
/*rb1 no FOCUS é do tipo varchar(5) e com certeza dará problema de conversão
update articoli_fornitore set Rb = replace(left(Rb,10),',','.')
ALTER TABLE articoli_fornitore ALTER COLUMN Rb float*/

update catalogo set [Prezzo acquisto] = replace(left([Prezzo acquisto],10),',','.')
ALTER TABLE catalogo ALTER COLUMN [Prezzo acquisto] float
update catalogo set [Prezzo di vendita] = replace(left([Prezzo di vendita],10),',','.')
ALTER TABLE catalogo ALTER COLUMN [Prezzo di vendita] float
update catalogo set [Prezzo di vendita] = replace(left([Prezzo di vendita],10),',','.')
ALTER TABLE catalogo ALTER COLUMN [Prezzo di vendita] float

ALTER TABLE diametri ADD EsfDe float
ALTER TABLE diametri ADD EsfAte float
ALTER TABLE diametri ADD Cilindrico float

/*diametro no FOCUS é do tipo varchar(10) e com certeza dará problema de conversão
update diametri set [Diametro] = replace(left([Diametro],10),',','.')
ALTER TABLE diametri ALTER COLUMN [Diametro] float*/

update prezzilenti set [Prezzo acquisto] = replace(left([Prezzo acquisto],10),',','.')
ALTER TABLE prezzilenti ALTER COLUMN [Prezzo acquisto] float
update prezzilenti set [Prezzo di vendita] = replace(left([Prezzo di vendita],10),',','.')
ALTER TABLE prezzilenti ALTER COLUMN [Prezzo di vendita] float

/*diametro no FOCUS é do tipo varchar(10) e com certeza dará problema de conversão
--na base da Elis Pedreira já apresenta erro na diametrirx
update diametrirx set [Diametro] = replace(left([Diametro],10),',','.')
ALTER TABLE diametrirx ALTER COLUMN [Diametro] float*/
update diametrirx set [Da sfero] = replace(left([Da sfero],10),',','.')
ALTER TABLE diametrirx ALTER COLUMN [Da sfero] float
update diametrirx set [A sfero] = replace(left([A sfero],10),',','.')
ALTER TABLE diametrirx ALTER COLUMN [A sfero] float
update diametrirx set [Cilindro massimo] = replace(left([Cilindro massimo],10),',','.')
ALTER TABLE diametrirx ALTER COLUMN [Cilindro massimo] float
update diametrirx set [da addizione] = replace(left([da addizione],10),',','.')
ALTER TABLE diametrirx ALTER COLUMN [da addizione] float
update diametrirx set [a addizione] = replace(left([a addizione],10),',','.')
ALTER TABLE diametrirx ALTER COLUMN [a addizione] float

update trattamenti set [Prezzo acquisto] = replace(left([Prezzo acquisto],10),',','.')
ALTER TABLE trattamenti ALTER COLUMN [Prezzo acquisto] float
update trattamenti set [Prezzo di vendita] = replace(left([Prezzo di vendita],10),',','.')
ALTER TABLE trattamenti ALTER COLUMN [Prezzo di vendita] float

update supplementi set [Prezzo acquisto] = replace(left([Prezzo acquisto],10),',','.')
ALTER TABLE supplementi ALTER COLUMN [Prezzo acquisto] float
update supplementi set [Prezzo di vendita] = replace(left([Prezzo di vendita],10),',','.')
ALTER TABLE supplementi ALTER COLUMN [Prezzo di vendita] float
ja inseridos no sp_importa */
-------------------------------25/10/2017----------------------------------------------------------
/*Alteracao do campo diametro de texto para numeric*/
ALTER TABLE articoli ADD DiametroNum numeric(18,4)
ALTER TABLE articoli_fornitore ADD DiametroNum numeric(18,4)
ALTER TABLE diametri ADD DiametroNum numeric(18,4)
ALTER TABLE diametrirx ADD DiametroNum numeric(18,4)
/*tenta colocar em diametronum o maior diametro encontrado*/
update articoli set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')
update articoli_fornitore set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')
update diametri set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')
update diametrirx set DiametroNum = replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')

update articoli set [Rb] = replace(left([Rb],10),',','.')
update articoli_fornitore set [Rb] = replace(left([Rb],10),',','.')

-- ja existe o campo CurvaBase na Item (utilizado tambem para as lentes normais)
-- por isso so eh necessario criar CurvaBase2 e CurvaTipo
alter table optisoul..item Add CurvaBase2 numeric(18,4)
alter table optisoul..item Add CurvaTipo varchar(30)

update carrello set [Sconto] = replace(left([Sconto],10),',','.')
ALTER TABLE carrello ALTER COLUMN sconto float
update carrello set [Prezzo] = replace(left([Prezzo],10),',','.')
ALTER TABLE carrello ALTER COLUMN prezzo float
update carrello set [Totale] = replace(left([Totale],10),',','.')
ALTER TABLE carrello ALTER COLUMN totale float

update storicocarrello set [Sconto] = replace(left([Sconto],10),',','.')
ALTER TABLE storicocarrello ALTER COLUMN sconto float
update storicocarrello set [Prezzo] = replace(left([Prezzo],10),',','.')
ALTER TABLE storicocarrello ALTER COLUMN prezzo float
update storicocarrello set [Totale] = replace(left([Totale],10),',','.')
ALTER TABLE storicocarrello ALTER COLUMN totale float

update carrello2 set [Sconto] = replace(left([Sconto],10),',','.')
ALTER TABLE carrello2 ALTER COLUMN sconto float
update carrello2 set [Sconto percentuale] = replace(left([Sconto percentuale],10),',','.')
ALTER TABLE carrello2 ALTER COLUMN [Sconto percentuale] float
update carrello2 set [Prezzo] = replace(left([Prezzo],10),',','.')
ALTER TABLE carrello2 ALTER COLUMN prezzo float
update carrello2 set [Totale] = replace(left([Totale],10),',','.')
ALTER TABLE carrello2 ALTER COLUMN totale float

update storicocarrello2 set [Sconto] = replace(left([Sconto],10),',','.')
ALTER TABLE storicocarrello2 ALTER COLUMN sconto float
update storicocarrello2 set [Sconto percentuale] = replace(left([Sconto percentuale],10),',','.')
ALTER TABLE storicocarrello2 ALTER COLUMN [Sconto percentuale] float
update storicocarrello2 set [Prezzo] = replace(left([Prezzo],10),',','.')
ALTER TABLE storicocarrello2 ALTER COLUMN prezzo float
update storicocarrello2 set [Totale] = replace(left([Totale],10),',','.')
ALTER TABLE storicocarrello2 ALTER COLUMN totale float

ALTER TABLE busta ALTER COLUMN data date
ALTER TABLE occhiali ALTER COLUMN data date

update carrello2 set [Pagato] = replace([Pagato], 'Sim', '1')
update carrello2 set [Pagato] = replace([Pagato], 'Não', '0')
ALTER TABLE carrello2 ALTER COLUMN [Pagato] bit

update busta set [Occhiale da lontano] = replace([Occhiale da lontano], 'Sim', '1')
update busta set [Occhiale da lontano] = replace([Occhiale da lontano], 'Não', '0')
ALTER TABLE busta ALTER COLUMN [Occhiale da lontano] bit
update busta set [Occhiale da medio] = replace([Occhiale da medio], 'Sim', '1')
update busta set [Occhiale da medio] = replace([Occhiale da medio], 'Não', '0')
ALTER TABLE busta ALTER COLUMN [Occhiale da medio] bit
update busta set [Occhiale da vicino] = replace([Occhiale da vicino], 'Sim', '1')
update busta set [Occhiale da vicino] = replace([Occhiale da vicino], 'Não', '0')
ALTER TABLE busta ALTER COLUMN [Occhiale da vicino] bit
update busta set [Lente propria Dx] = replace([Lente propria Dx], 'Sim', '1')
update busta set [Lente propria Dx] = replace([Lente propria Dx], 'Não', '0')
ALTER TABLE busta ALTER COLUMN [Lente propria Dx] bit
update busta set [Lente propria Sx] = replace([Lente propria Sx], 'Sim', '1')
update busta set [Lente propria Sx] = replace([Lente propria Sx], 'Não', '0')
ALTER TABLE busta ALTER COLUMN [Lente propria Sx] bit
update busta set [Occhiale da sole] = replace([Occhiale da sole], 'Sim', '1')
update busta set [Occhiale da sole] = replace([Occhiale da sole], 'Não', '0')
ALTER TABLE busta ALTER COLUMN [Occhiale da sole] bit

update movimenti set [Prezzo listino vendita] = replace(left([Prezzo listino vendita],10),',','.')
ALTER TABLE movimenti ALTER COLUMN [Prezzo listino vendita] float
update movimenti set [Prezzo listino acquisto] = replace(left([Prezzo listino acquisto],10),',','.')
ALTER TABLE movimenti ALTER COLUMN [Prezzo listino acquisto] float
update movimenti set [Costo medio] = replace(left([Costo medio],10),',','.')
ALTER TABLE movimenti ALTER COLUMN [Costo medio] float

