# Portfólio QA Web com Robot Framework

Projeto de portfólio QA focado em automação de testes web usando Robot Framework e SeleniumLibrary.

Este projeto contém uma suíte inicial de testes automatizados para a aplicação web SauceDemo, cobrindo cenários principais de login com uma estrutura simples e de fácil manutenção.

## Tecnologias Utilizadas

- Python
- Robot Framework
- SeleniumLibrary
- Navegador Chrome
- Site de testes SauceDemo

## Escopo dos Testes

O escopo atual valida o fluxo de login em:

https://www.saucedemo.com/

Os testes cobrem login com sucesso, credenciais inválidas e comportamento de usuário bloqueado.

## Estrutura do Projeto

```text
.
├── README.md
├── requirements.txt
├── .gitignore
├── tests/
│   └── login_tests.robot
└── resources/
    ├── common.resource
    └── login_keywords.resource
```

## Instalação das Dependências

Crie e ative um ambiente virtual, depois instale as dependências:

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

## Cenários Implementados

- Login válido redireciona o usuário para a página de produtos.
- Login inválido exibe uma mensagem de erro.
- Login com usuário bloqueado exibe uma mensagem de erro.

## Próximos Passos

- Adicionar validações da listagem de produtos.
- Adicionar testes do fluxo de carrinho.
- Adicionar testes do fluxo de checkout.
- Configurar execução em CI para verificações automatizadas de regressão.
