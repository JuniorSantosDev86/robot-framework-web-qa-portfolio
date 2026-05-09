# Estratégia de Testes — Robot Framework Web QA Portfolio

## Objetivo

Este projeto tem como objetivo demonstrar uma suíte de automação web end-to-end usando Robot Framework e SeleniumLibrary, aplicada sobre a plataforma de testes SauceDemo.

A estratégia foi construída para validar fluxos funcionais críticos de uma aplicação web simulando uma jornada de compra, com foco em clareza, organização, reutilização de keywords, estabilidade em execução local e execução automatizada via GitHub Actions.

## Aplicação Testada

Aplicação: SauceDemo  
URL: https://www.saucedemo.com/

O SauceDemo foi escolhido por possuir fluxos adequados para demonstração de automação web, incluindo autenticação, listagem de produtos, ordenação, carrinho e checkout.

## Escopo dos Testes

A suíte cobre os seguintes módulos funcionais:

### Login

Valida os principais comportamentos da autenticação:

- Login com usuário válido.
- Tentativa de login com credenciais inválidas.
- Tentativa de login com usuário bloqueado.

### Produtos

Valida a página de produtos após autenticação:

- Exibição da lista de produtos.
- Presença de produtos esperados.
- Ordenação por nome de Z a A.
- Ordenação por preço do menor para o maior.

### Carrinho

Valida ações essenciais do carrinho de compras:

- Adicionar produto ao carrinho.
- Verificar atualização do badge do carrinho.
- Validar produto exibido no carrinho.
- Remover produto do carrinho.
- Adicionar múltiplos produtos ao carrinho.

### Checkout

Valida o fluxo de finalização de compra:

- Exibição do resumo do checkout com produto adicionado.
- Finalização de compra com sucesso.
- Validação de obrigatoriedade do primeiro nome.
- Validação de obrigatoriedade do sobrenome.
- Validação de obrigatoriedade do CEP.

## Fora do Escopo

Este projeto não cobre, nesta versão:

- Testes de performance.
- Testes de segurança.
- Testes de acessibilidade.
- Testes de API.
- Testes mobile.
- Testes cross-browser.
- Testes visuais por comparação de imagem.
- Validações reais de pagamento.

Esses pontos podem ser evoluções futuras do portfólio, mas não fazem parte do objetivo principal desta suíte.

## Abordagem de Automação

A automação foi estruturada com separação entre arquivos de teste e arquivos de recursos reutilizáveis.

Os arquivos em tests/ concentram os cenários de teste em linguagem clara e orientada ao comportamento esperado.

Os arquivos em resources/ concentram variáveis, seletores e keywords reutilizáveis, reduzindo duplicação e facilitando manutenção.

A estrutura atual é organizada por domínio funcional:

- tests/login_tests.robot
- tests/products_tests.robot
- tests/cart_tests.robot
- tests/checkout_tests.robot
- resources/common.resource
- resources/ui_actions.resource
- resources/login_keywords.resource
- resources/products_keywords.resource
- resources/cart_keywords.resource
- resources/checkout_keywords.resource

## Critérios de Validação

Os testes utilizam validações baseadas em comportamento observável da interface, como:

- Mudança de URL esperada.
- Elementos visíveis na tela.
- Mensagens de erro exibidas.
- Conteúdo textual esperado.
- Quantidade de itens no carrinho.
- Presença ou ausência de produtos.
- Confirmação de finalização de compra.

## Estabilidade e Manutenção

O projeto usa waits explícitos e keywords reutilizáveis para reduzir instabilidade em ambiente local e em CI.

Algumas ações de interface usam helpers de clique com fallback controlado, especialmente em fluxos que podem apresentar comportamento instável em execução headless. Esses fallbacks não pulam o fluxo real do usuário e não manipulam o estado interno da aplicação.

O objetivo é manter a suíte estável sem mascarar falhas funcionais reais.

## Execução Local

Para executar a suíte completa localmente:

    robot -d results tests

Para executar suítes específicas:

    robot -d results tests/login_tests.robot
    robot -d results tests/products_tests.robot
    robot -d results tests/cart_tests.robot
    robot -d results tests/checkout_tests.robot

## Relatórios

Após a execução local, o Robot Framework gera automaticamente:

- results/report.html
- results/log.html
- results/output.xml

Esses relatórios permitem analisar status geral, tempo de execução, suítes, testes, falhas e detalhes de cada keyword executada.

## Integração Contínua

O projeto possui workflow configurado no GitHub Actions.

A suíte é executada automaticamente em:

- push na branch main.
- pull_request para a branch main.
- Execução manual pela aba Actions.

O workflow instala as dependências, executa os testes e publica os relatórios como artifact com o nome robot-framework-reports.

## Status Atual

Status da suíte:

- 16 testes automatizados.
- 16 testes passando localmente.
- 16 testes passando no GitHub Actions.
- Relatórios HTML gerados pelo Robot Framework.
- Artifact de execução publicado no GitHub Actions.

## Possíveis Evoluções

Evoluções futuras possíveis:

- Adicionar screenshots ou GIFs demonstrando a execução.
- Criar cenários negativos adicionais.
- Adicionar documentação de bugs simulados.
- Adicionar testes de API em projeto separado com Postman/Newman.
- Adicionar matriz de rastreabilidade simples entre cenário e funcionalidade.
- Adicionar versão resumida em inglês da documentação.
