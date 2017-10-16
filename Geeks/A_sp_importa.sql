USE [Focus]
GO
/****** Object:  StoredProcedure [dbo].[sp_importaOld]    Script Date: 16/10/2017 11:44:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[sp_importa] as

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

declare @sql varchar(max)

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


	