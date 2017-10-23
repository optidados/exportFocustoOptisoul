USE [Focus]
GO
/****** Object:  StoredProcedure [dbo].[sp_importa]    Script Date: 20/10/2017 09:46:22 ******/
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

Delete #Arquivos where tabela in ('Documento','DocumentoContato','DocumentoItem','Item','ItemComposicao','ItemFornecedor','','Contato','ContatoEndereco','ContatoFilho','ContatoGrupo','ContatoTelefone','')

Declare @sql varchar(max)
Declare @Tabela varchar(100), @db varchar(100)
DECLARE xcursor CURSOR FOR SELECT Tabela,db FROM #Arquivos where db='ElisPedreira' ORDER BY db,Tabela
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

	alter table optisoul..documento ALTER COLUMN PedidoAnt varchar(50)

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



	
