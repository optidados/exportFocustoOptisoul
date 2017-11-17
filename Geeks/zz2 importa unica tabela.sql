/*
	Importa uma unica tabela do .txt para .sql
	tem que colocar a tabela no schema.ini antes de executar
*/

Declare @sql varchar(max)
Declare @Tabela varchar(100), @db varchar(100)

set @Tabela = 'movimenti'
set @db = 'ElisPedreira'
	
set @sql='
drop table '+@tabela+'
Select * into Focus..'+@tabela + '
From Openrowset(''Microsoft.ACE.OLEDB.12.0'',''Text;Database=\\192.168.1.3\OptisoulFocus\'+@db+';HDR=Yes;Format=Delimited(,)'',
''Select * from ['+@tabela+'.txt]'') as A'

print @sql
exec(@sql)