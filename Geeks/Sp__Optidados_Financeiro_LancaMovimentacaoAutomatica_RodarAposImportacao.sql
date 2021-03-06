
ALTER Procedure [dbo].[Sp__Optidados_Financeiro_LancaMovimentacaoAutomatica_RodarAposImportacao] 
 AS
    declare
    @CodigoFinanceiroTitulo int,
	@DataMovimentacao datetime,
	@DataPagamento datetime

BEGIN
SET NOCOUNT ON;
begin try
	exec ('Disable Trigger [dbo].[FinanceiroTitulo_Delete] ON [dbo].[FinanceiroTitulo]')
	exec ('Disable Trigger [dbo].[FinanceiroTitulo_Update] ON [dbo].[FinanceiroTitulo]')
	exec ('Disable TRIGGER [dbo].[LancaMovimentacaoAutomatica] ON  [dbo].[FinanceiroTitulo]')
	exec ('Disable Trigger [dbo].[FinanceiroMovimentacao_Consolidado] ON [dbo].[FinanceiroMovimentacao]')
	Set @DataMovimentacao = (Select convert(varchar(19), Valor + ' 00:00:00', 103) from Configuracoes where Nome = 'financeiro.movimentarcomo')
	if @DataMovimentacao is null 
		Set @DataMovimentacao = getDate();
	Begin Tran

	-- Cursor para percorrer os nomes dos objetos
	DECLARE cursor_obj CURSOR FAST_FORWARD FOR
		SELECT CodigoFinanceiroTitulo, DataPagamento FROM FinanceiroTitulo where FinanceiroMovimentacaoCodigoAgrupamentoAutomatico is null --and CodigoFinanceiroTitulo > 1000 and CodigoFinanceiroTitulo < 1100
	-- Abrindo Cursor para leitura
	OPEN cursor_obj
	-- Lendo a próxima linha
	FETCH NEXT FROM cursor_obj INTO @CodigoFinanceiroTitulo, @DataPagamento
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--if (@DataPagamento is null)
			EXEC Sp_FinanceiroTitulo_LancaMovimentacaoAutomatica @CodigoFinanceiroTitulo, @DataMovimentacao
		-- Lendo a próxima linha
		if @@trancount > 250
		Begin
			commit transaction;
			Begin Tran
		End

		FETCH NEXT FROM cursor_obj INTO @CodigoFinanceiroTitulo, @DataPagamento
	END
	-- Fechando Cursor para leitura
	CLOSE cursor_obj
	-- Desalocando o cursor
	DEALLOCATE cursor_obj 
	if @@trancount > 0	commit transaction;
	exec ('Enable Trigger [dbo].[FinanceiroTitulo_Delete] ON [dbo].[FinanceiroTitulo]')
	exec ('Enable Trigger [dbo].[FinanceiroTitulo_Update] ON [dbo].[FinanceiroTitulo]')
	exec ('Enable TRIGGER [dbo].[LancaMovimentacaoAutomatica] ON  [dbo].[FinanceiroTitulo]')
	exec ('Enable Trigger [dbo].[FinanceiroMovimentacao_Consolidado] ON [dbo].[FinanceiroMovimentacao]')

end try
begin catch
	exec ('Enable Trigger [dbo].[FinanceiroTitulo_Delete] ON [dbo].[FinanceiroTitulo]')
	exec ('Enable Trigger [dbo].[FinanceiroTitulo_Update] ON [dbo].[FinanceiroTitulo]')
	exec ('Enable TRIGGER [dbo].[LancaMovimentacaoAutomatica] ON  [dbo].[FinanceiroTitulo]')
	exec ('Enable Trigger [dbo].[FinanceiroMovimentacao_Consolidado] ON [dbo].[FinanceiroMovimentacao]')

	declare @errormessage varchar(8000)
	declare @errorseverity int 
	declare @errorstate int 
	declare @errorline int 
	declare @errornumber int
		
	select
		@errornumber = error_number() ,
		@errorseverity = error_severity() ,
		@errorstate = error_state() ,
		@errorline = error_line() ,
		@errormessage = error_message() ;

	if @@trancount > 0
		rollback transaction;
		
	set nocount off		
		
	raiserror(@errormessage, @errorseverity, @errorstate, @errornumber, @errorline) 
end catch
END
