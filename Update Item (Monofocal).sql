update Item
set 
	Item."AdicaoInicial" = CAST(NULL as numeric(18,4)),
	Item."AdicaoFinal" = CAST(NULL as numeric(18,4))
where
	Item."Tipo" = 'Lente' and
	Item."LenteTipo" = 'Monofocal';