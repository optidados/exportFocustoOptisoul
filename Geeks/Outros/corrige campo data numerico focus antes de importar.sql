

Select 'update "' + tabela + '" set "' + coluna + '" =cast(null as date) where "' + coluna  + '" < date''1900-01-01'';' from 
(
select t.name as tabela, 
       c.name as coluna,   
	   i.Data_Type   as Tipo
 from sys.tables t
 inner join sys.columns c on t.object_id = c.object_id and t.schema_id=5
 inner join INFORMATION_SCHEMA.COLUMNS i on i.TABLE_NAME = t.name and i.column_name = c.name and  i.CHARACTER_MAXIMUM_LENGTH is  null  and i.Numeric_Precision is null
 where i.Data_Type in ('date') 
 ) ss
 order by tabela,coluna

 
 update "cf-e_" as t
	set t."prezzo ivato" = 0
	where CAST("prezzo ivato" as varchar(50)) = 'NAN';
 
 Select 'update "' + tabela + '" set "' + coluna + '" =0 where cast("' + coluna  + '" as varchar(50)) = ''NAN'' ;' from 
(
 select t.name as tabela, 
       i.Ordinal_Position as Ordem, 
       c.name as coluna,
	   e.value as Descr,
	   i.Data_Type  + '(' +	Cast(i.Numeric_Precision as varchar(20)) + ',' +  Cast(i.NUMERIC_SCALE as varchar(10)) + ')' as Tipo,	
	   i.Collation_name as Collation,
	   Case When i.Is_Nullable = 'YES' then 'x' Else '' end as Nulo,
	   cc.definition as Computada
 from sys.tables t
 inner join sys.columns c on t.object_id = c.object_id and t.schema_id=5
 left join sys.computed_columns cc on cc.object_id = c.object_id and cc.column_id = c.column_id
 inner join INFORMATION_SCHEMA.COLUMNS i on i.TABLE_NAME = t.name and i.column_name = c.name and  i.Numeric_Precision is not null
 left join  sys.extended_properties e on e.major_id = c.object_id AND e.minor_id = c.column_id
 ) ss
  order by tabela,coluna
