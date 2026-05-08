# Portfólio QA Web com Robot Framework

[![Robot Framework Tests](https://github.com/JuniorSantosDev86/robot-framework-web-qa-portfolio/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/JuniorSantosDev86/robot-framework-web-qa-portfolio/actions/workflows/robot-tests.yml)
![Python](https://img.shields.io/badge/Python-3.12-blue)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.4.2-red)
![SeleniumLibrary](https://img.shields.io/badge/SeleniumLibrary-6.8.0-green)
![QA Automation](https://img.shields.io/badge/QA-Automation-purple)

Projeto de portfólio QA focado em automação de testes web usando Robot Framework e SeleniumLibrary.

Este projeto contém uma suíte de testes automatizados para a aplicação web SauceDemo, cobrindo cenários principais de login, página de produtos, ordenação de produtos, carrinho de compras e checkout com uma estrutura simples e de fácil manutenção.

## Tecnologias Utilizadas

- Python
- Robot Framework
- SeleniumLibrary
- Navegador Chrome
- Site de testes SauceDemo

## Escopo dos Testes

O escopo atual valida fluxos principais em:

https://www.saucedemo.com/

Os testes cobrem login com sucesso, credenciais inválidas, comportamento de usuário bloqueado, exibição da lista de produtos, ordenação de produtos, fluxos do carrinho de compras e checkout.

## Estrutura do Projeto

```text
.
├── .github/
│   └── workflows/
│       └── robot-tests.yml
├── README.md
├── requirements.txt
├── .gitignore
├── tests/
│   ├── login_tests.robot
│   ├── products_tests.robot
│   ├── cart_tests.robot
│   └── checkout_tests.robot
└── resources/
    ├── common.resource
    ├── login_keywords.resource
    ├── products_keywords.resource
    ├── cart_keywords.resource
    └── checkout_keywords.resource
```

## Instalação das Dependências

Crie o ambiente virtual:

```bash
python3 -m venv .venv
```

Ative o ambiente virtual no Linux/macOS:

```bash
source .venv/bin/activate
```

Atualize o pip:

```bash
python -m pip install --upgrade pip
```

Instale as dependências:

```bash
pip install -r requirements.txt
```

## Execução dos Testes

Execute toda a suíte de testes com:

```bash
robot -d results tests
```

## Visualização dos Relatórios

Após a execução, o Robot Framework gera os relatórios na pasta `results/`:

- `results/report.html`
- `results/log.html`
- `results/output.xml`

Abra `results/report.html` ou `results/log.html` em um navegador para revisar os resultados da execução.

## Integração Contínua

Os testes são executados automaticamente pelo GitHub Actions em eventos de push e pull request na branch `main`.

Também é possível iniciar uma execução manualmente pela opção `workflow_dispatch` na página do workflow.

O workflow instala as dependências do projeto, executa a suíte Robot Framework e salva os relatórios como artifact. Os relatórios ficam disponíveis no GitHub Actions com o nome `robot-framework-reports`.

## Relatórios no GitHub Actions

Após cada execução do workflow, os relatórios do Robot Framework são enviados como artifact.

O artifact contém:

- `report.html`
- `log.html`
- `output.xml`

Para visualizar os relatórios, abra a execução do workflow no GitHub Actions e baixe o artifact `robot-framework-reports`.

## Cenários Implementados

- Login válido redireciona o usuário para a página de produtos.
- Login inválido exibe uma mensagem de erro.
- Login com usuário bloqueado exibe uma mensagem de erro.
- Página de produtos exibe a lista de produtos.
- Página de produtos contém produtos padrão esperados.
- Usuário consegue ordenar produtos por nome de Z a A.
- Usuário consegue ordenar produtos por preço do menor para o maior.
- Produto adicionado atualiza o badge do carrinho.
- Produto adicionado aparece no carrinho.
- Produto pode ser removido do carrinho.
- Múltiplos produtos podem ser adicionados ao carrinho.
- Resumo do checkout exibe produto adicionado.
- Usuário consegue finalizar uma compra com sucesso.
- Checkout exige primeiro nome.
- Checkout exige sobrenome.
- Checkout exige CEP.

## Próximos Passos

- Melhorar evidências/documentação de execução.
- Adicionar screenshots ou GIFs demonstrando a execução dos testes.
- Expandir o projeto com cenários negativos adicionais e validações de regressão.
