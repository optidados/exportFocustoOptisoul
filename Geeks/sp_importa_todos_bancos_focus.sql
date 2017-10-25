
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

Declare @db2 varchar(100)
DECLARE xcursor CURSOR FOR SELECT db FROM (Select distinct db from #Arquivos where not db is null) ss ORDER BY db
OPEN xcursor
FETCH NEXT FROM xcursor INTO @db2
WHILE @@FETCH_STATUS = 0
BEGIN

	exec('drop DATABASE '+@db2)
	exec('CREATE DATABASE '+@db2)
	FETCH NEXT FROM xcursor INTO @db2
END
CLOSE xcursor
DEALLOCATE xcursor

Declare @sql varchar(max)
Declare @Tabela varchar(100), @db varchar(100)
DECLARE xcursor CURSOR FOR SELECT Tabela,db FROM #Arquivos ORDER BY db,Tabela
OPEN xcursor
FETCH NEXT FROM xcursor INTO @Tabela,@db
WHILE @@FETCH_STATUS = 0
BEGIN

	set @sql='
	use '+@db+'
	drop table '+@db+'..['+@tabela+']
	Select * into '+@db+'..['+@tabela + ']
	From Openrowset(''Microsoft.ACE.OLEDB.12.0'',''Text;Database=\\192.168.1.3\OptisoulFocus\'+@db+';HDR=Yes;Format=Delimited(,)'',
	''Select * from ['+@tabela+'.txt]'') as A
	go'

	print @sql
	--exec(@sql)
	FETCH NEXT FROM xcursor INTO @Tabela,@db
END
CLOSE xcursor
DEALLOCATE xcursor