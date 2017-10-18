USE [Focus]
GO
/****** Object:  StoredProcedure [dbo].[sp_importa]    Script Date: 16/10/2017 14:17:50 ******/
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

Declare @sql varchar(max)
Declare @Tabela varchar(100), @db varchar(100)
DECLARE xcursor CURSOR FOR SELECT Tabela,db FROM #Arquivos where db='ElisPedreira' ORDER BY db,Tabela
OPEN xcursor
FETCH NEXT FROM xcursor INTO @Tabela,@db
WHILE @@FETCH_STATUS = 0
BEGIN

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



	