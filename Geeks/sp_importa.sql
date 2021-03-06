USE [Focus]
GO
/****** Object:  StoredProcedure [dbo].[sp_importa]    Script Date: 25/10/2017 17:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[sp_importa] as

drop database Optisoul
RESTORE DATABASE Optisoul FROM  DISK = N'C:\Geeks\SqlData\BaseLimpa.bkpsql.bak' WITH  FILE = 1,  MOVE N'Optisoul' TO N'C:\Geeks\SqlData\Optisoul.mdf',  MOVE N'Optisoul_log' TO N'C:\Geeks\SqlData\Optisoul_log.ldf',  NOUNLOAD,  REPLACE,  STATS = 5

drop table #Arquivos
Create table #Arquivos (
Arq varchar(2000), 
Tabela varchar(2000),
Path  varchar(2000),
db varchar(2000)
)
Select * from #Arquivos

Truncate table #Arquivos
insert into #Arquivos (Arq)
exec xp_cmdshell 'dir \\192.168.1.3\OptisoulFocus\*.txt /b /s'

Update #Arquivos set Path= replace(replace(arq,'\\192.168.1.3\OptisoulFocus\',''),'.txt','')
Update #Arquivos set Tabela = substring([Path],CHARINDEX( '\', [Path], 1)+1 ,999)
Update #Arquivos set db = substring([Path],1,CHARINDEX( '\', [Path], 1)-1 )

Delete #Arquivos where tabela in ('Item','ItemComposicao','ItemFornecedor','','Contato','ContatoEndereco','ContatoFilho','ContatoGrupo','ContatoTelefone','')
Delete #Arquivos where tabela in ('Documento','DocumentoContato','DocumentoItem','DocumentoEndereco','DocumentoStatus')

Declare @sql varchar(max)
Declare @Tabela varchar(100), @db varchar(100)
DECLARE xcursor CURSOR FOR SELECT Tabela,db FROM #Arquivos where db='ElisPedreira' and Tabela='Articoli' ORDER BY db,Tabela
OPEN xcursor
FETCH NEXT FROM xcursor INTO @Tabela,@db
WHILE @@FETCH_STATUS = 0
BEGIN

	/*
	declare @tabela varchar(max)  ='tipoprodotto'
	declare @db varchar(max) ='ElisPedreira'
	Declare @sql varchar(max)
	*/

	set @sql='
	drop table '+@tabela+'
	Select * into Focus..'+@tabela + '
	From Openrowset(''Microsoft.ACE.OLEDB.12.0'',''Text;Database=\\192.168.1.3\OptisoulFocus\'+@db+';HDR=Yes;Format=Delimited(,)'',
	''Select * from ['+@tabela+'.txt]'') as A'

	print @sql
	exec(@sql)
	FETCH NEXT FROM xcursor INTO @Tabela,@db
END
CLOSE xcursor
DEALLOCATE xcursor

exec('use Optisoul;Drop index documento.missing_index_1910')
alter table optisoul..documento ALTER COLUMN PedidoAnt varchar(50)
alter table optisoul..documento ALTER COLUMN IdAnt varchar(50)
alter table optisoul..documento ALTER COLUMN EmpresaAnt varchar(50)
alter table optisoul..documento ALTER COLUMN ClienteAnt varchar(50)
alter table optisoul..documento ALTER COLUMN OrdemAnt varchar(50)

alter table optisoul..item Add CurvaBase numeric(18,4)
alter table optisoul..item Add CurvaBase2 numeric(18,4)
alter table optisoul..item Add CurvaTipo varchar(30)

--Acerta os formatos dos campos
begin
	ALTER TABLE Carrello ALTER COLUMN Data Date
	update Carrello set Totale = replace(left(Totale,10),',','.')
	ALTER TABLE Carrello ALTER COLUMN Totale money
	
	ALTER TABLE Carrello2 ALTER COLUMN Data Date
	ALTER TABLE Carrello2 ALTER COLUMN [Data pagamento] Date
	update Carrello2 set Totale = replace(left(Totale,10),',','.')
	ALTER TABLE Carrello2 ALTER COLUMN Totale money
	


	update transazioni set totale = replace(left(Totale,10),',','.')
	update storicocarrello2 set totale = replace(left(Totale,10),',','.')
	update storicocarrello set totale = replace(left(Totale,10),',','.')
	update MovimentoConti set Importo = replace(left(Importo,10),',','.')

	ALTER TABLE MovimentoConti ALTER COLUMN Importo money
	alter table movimentoconti ALTER COLUMN Data Date
	
	ALTER TABLE transdet ALTER COLUMN Totale money
	ALTER TABLE transazioni ALTER COLUMN Totale money
	ALTER TABLE storicocarrello2 ALTER COLUMN Totale money
	ALTER TABLE storicocarrello ALTER COLUMN Totale money

	ALTER TABLE fattura ALTER COLUMN Codice int
	ALTER TABLE fattura ALTER COLUMN Data Date
	update fattura set Importo = replace(left(Importo,10),',','.')
	ALTER TABLE fattura ALTER COLUMN Importo numeric(18,2)
	ALTER TABLE fattura ALTER COLUMN [Numero rate] int

	ALTER TABLE fatturaclienti ALTER COLUMN Codice int
	ALTER TABLE fatturaclienti ALTER COLUMN Data Date
	update fatturaclienti set Importo = replace(left(Importo,10),',','.')
	ALTER TABLE fatturaclienti ALTER COLUMN Importo numeric(18,2)
	ALTER TABLE fatturaclienti ALTER COLUMN [Numero rate] int
	
	ALTER TABLE rata ALTER COLUMN Codice int
	ALTER TABLE rata ALTER COLUMN Data Date
	ALTER TABLE rata ALTER COLUMN [Numero rata] int
	update rata set Importo = replace(left(Importo,10),',','.')
	ALTER TABLE rata ALTER COLUMN Importo money
	update rata set [Importo Rata] = replace(left([Importo Rata],10),',','.')
	ALTER TABLE rata ALTER COLUMN [Importo Rata] float
	Alter Table rata Add ValorPago float

	ALTER TABLE rataclienti ALTER COLUMN Codice int
	ALTER TABLE rataclienti ALTER COLUMN Data Date
	ALTER TABLE rataclienti ALTER COLUMN [Numero rata] int
	update rataclienti set Importo = replace(left(Importo,10),',','.')
	ALTER TABLE rataclienti ALTER COLUMN Importo money
	update rataclienti set [Importo Rata] = replace(left([Importo Rata],10),',','.')
	ALTER TABLE rataclienti ALTER COLUMN [Importo Rata] float
	Alter Table rataclienti Add ValorPago float

	ALTER TABLE primanot ALTER COLUMN Data Date

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

	Update articoli Set Diametro = 
	replace((select max(cast(value as float)) from STRING_SPLIT(replace(replace(replace(cast(isnull(diametro,'0') as varchar(100)),'/','#'),'-','#'),',','.') , cast('#' as char)) ss),',','.')
	
	ALTER TABLE articoli ALTER COLUMN Diametro float

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

end

--Importa as tabelas para o optisoul
begin 
	exec B1_sp_importa_Contato
 
    exec B2_sp_importa_ContatoEndereco
 
    exec B3_sp_importa_ContatoFilho
 
    exec B4_sp_importa_ContatoGrupo

end	
	

if (1=0) begin
	
	Select * 
	From Openrowset('Microsoft.ACE.OLEDB.12.0','Text;Database=\\192.168.1.3\OptisoulFocus\ElisPedreira;HDR=Yes;Format=Delimited(,)',
	'Select * from [anag_ext5.txt]') as A

	declare @Schema varchar(max)
	
	--Gera Schema.ini
	--Declare @Tabela varchar(100), @db varchar(100)
	DECLARE xcursor CURSOR FOR SELECT Tabela,db FROM #Arquivos where db='ElisPedreira' ORDER BY db,Tabela
	OPEN xcursor
	FETCH NEXT FROM xcursor INTO @Tabela,@db
	WHILE @@FETCH_STATUS = 0
	BEGIN

		set @Schema='
		['+@Tabela+'.txt]
		ColNameHeader=True
		Format=Delimited(;)'

		print @Schema
		FETCH NEXT FROM xcursor INTO @Tabela,@db
	END
	CLOSE xcursor
	DEALLOCATE xcursor

end



	