# exportFocustoOptisoul
Exportações do Focus para o Optisoul

# Exportação das tabelas Contato
01 Contato
02 ContatoEndereco
03 ContatoFilho
04 ContatoGrupo
05 ContatoTelefone

# Exportação das tabelas Item
06 AjustesLentes - Cria 2 novas tabelas acessórias que serão utiladas para exportar a grade de lentes do FOCUS
07 Item
08 ItemFornecedor
09 ItemComposicao

# Exportação das tabelas Documento
10 ProcedimentosPreExportacao - Este procedimento verifica a existência de chaves primária duplicadas que vai impactar diretamente na exportação das vendas
11 PrescricaoEnvelope - Cria uma tabela acessória para associar uma prescrição à um envelope, pois o FOCUS não faz isso
12 Documento
13 DocumentoEndereco
14 DocumentoItem
15 DocumentoStatus
16 UpdateDocumento - Associa uma venda à uma devolução, pois o FOCUS não faz isso. Atualiza a operação Óculos de Sol, pois o FOCUS não faz essa diferenciação nos Envelopes. Atualiza o titular de uma venda, pois no FOCUS é como se só houvesse o o paciente da venda. E arruma o Convênio, pois é diferente o como é feito no FOCUS e no Optisoul.

# Exportação do B.I.
17 Vendas - Exporta as vendas no formato que foi utilizado no B.I. para tentar pegar informações referentes ao faturamento (e financeiro?)

# Update no OptiSoul
18 ProcedimentosPosImportacao - Operações de Update que dependem da chave primária que é criada no OptiSoul, por isso tem que ser executado depois de importado.