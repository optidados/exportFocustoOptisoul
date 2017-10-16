# exportFocustoOptisoul
Exportações do Focus para o Optisoul

## Exportação das tabelas Contato
* **Contato**
* **ContatoEndereco**
* **ContatoFilho**
* **ContatoGrupo**
* **ContatoTelefone**

## Exportação das tabelas Item
* **AjustesLentes** - Cria 2 novas tabelas acessórias que serão utiladas para exportar a grade de lentes do FOCUS
* **Item**
* **ItemFornecedor**
* **ItemComposicao**

## Exportação das tabelas Documento
* **ProcedimentosPreExportacao** - Este procedimento verifica a existência de chaves primária duplicadas que vai impactar diretamente na exportação das vendas
* **PrescricaoEnvelope** - Cria uma tabela acessória para associar uma prescrição à um envelope, pois o FOCUS não faz isso
* **Documento**
* **DocumentoEndereco**
* **DocumentoItem**
* **DocumentoStatus**
* **UpdateDocumento** - Associa uma venda à uma devolução, pois o FOCUS não faz isso. Atualiza a operação Óculos de Sol, pois o FOCUS não faz essa diferenciação nos Envelopes. Atualiza o titular de uma venda, pois no FOCUS é como se só houvesse o o paciente da venda. E arruma o Convênio, pois é diferente o como é feito no FOCUS e no Optisoul.

## Exportação do B.I.
* **Vendas** - Exporta as vendas no formato que foi utilizado no B.I. para tentar pegar informações referentes ao faturamento (e financeiro?)

## Update no OptiSoul
* **ProcedimentosPosImportacao** - Operações de Update que dependem da chave primária que é criada no OptiSoul, por isso tem que ser executado depois de importado.