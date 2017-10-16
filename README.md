# exportFocustoOptisoul
Exportações do Focus para o Optisoul

## 1. Exportação das tabelas Contato
1.1 **Contato**
1.2 **ContatoEndereco**
1.3 **ContatoFilho**
1.4 **ContatoGrupo**
1.5 **ContatoTelefone**

## 2. Exportação das tabelas Item
2.1 **AjustesLentes** - Cria 2 novas tabelas acessórias que serão utiladas para exportar a grade de lentes do FOCUS
2.2 **Item**
2.3 **ItemFornecedor**
2.4 **ItemComposicao**

## 3. Exportação das tabelas Documento
3.1 **ProcedimentosPreExportacao** - Este procedimento verifica a existência de chaves primária duplicadas que vai impactar diretamente na exportação das vendas
3.2 **PrescricaoEnvelope** - Cria uma tabela acessória para associar uma prescrição à um envelope, pois o FOCUS não faz isso
3.3 **Documento**
3.4 **DocumentoEndereco**
3.5 **DocumentoItem**
3.6 **DocumentoStatus**
3.7 **UpdateDocumento** - Associa uma venda à uma devolução, pois o FOCUS não faz isso. Atualiza a operação Óculos de Sol, pois o FOCUS não faz essa diferenciação nos Envelopes. Atualiza o titular de uma venda, pois no FOCUS é como se só houvesse o o paciente da venda. E arruma o Convênio, pois é diferente o como é feito no FOCUS e no Optisoul.

## 4. Exportação do B.I.
4.1 **Vendas** - Exporta as vendas no formato que foi utilizado no B.I. para tentar pegar informações referentes ao faturamento (e financeiro?)

## 5. Update no OptiSoul
5.1 **ProcedimentosPosImportacao** - Operações de Update que dependem da chave primária que é criada no OptiSoul, por isso tem que ser executado depois de importado.