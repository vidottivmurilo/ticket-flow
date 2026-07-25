# Ticket Flow

**Ticket Flow** é um sistema de senhas e atendimento, projetado para simular um cenário onde o controle local precisa se comunicar com painéis em tempo real.

## Arquitetura do Sistema

O projeto é dividido em duas partes principais:

### 1. Delphi (Desktop)
O aplicativo do atendente. Uma tela Windows onde o funcionário clica em "Chamar Próxima Senha". O Delphi faz uma requisição HTTP POST para a API Node.js informando o guichê e chamando a senha.

### 2. Node.js + TypeScript (Backend)
Uma API REST (usando Express) que gerencia a fila de senhas. Ela recebe o comando do Delphi e atualiza o banco de dados (MySQL).

## O que este projeto aborda (Objetivos de Aprendizado)

* **Node.js:** Criação de rotas básicas (GET/POST), tipagem de rotas com TypeScript.
* **Delphi:** Como usar o `TRESTClient` para fazer um POST consumindo uma API REST externa e enviar JSON.
