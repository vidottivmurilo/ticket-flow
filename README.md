# Ticket Flow

**Ticket Flow** é um sistema de senhas e atendimento, projetado para simular um cenário onde o controle local precisa se comunicar com painéis em tempo real.

## Arquitetura do Sistema

O projeto é dividido em três aplicações principais:

### 1. Backend: API Node.js + MySQL
Uma API RESTful (usando Express e TypeScript) que gerencia a fila de senhas. Ela recebe os comandos, atualiza o banco de dados (MySQL) e emite eventos em tempo real via WebSockets (Socket.io) para os painéis conectados.

### 2. Frontend: Atendente & Totem (Delphi)
- **Atendente:** Tela Windows onde o funcionário clica em "Chamar Próxima Senha", disparando um POST para a API.
- **Totem:** Tela para o cliente clicar em "Retirar Senha", também consumindo a API.
- Ambos utilizam a biblioteca `RESTRequest4Delphi` para consumo HTTP limpo e via código.

### 3. Frontend: Monitor de Senhas (Delphi)
Um painel de exibição para a TV da agência que fica conectado via WebSockets. Quando uma nova senha é chamada, a API avisa o painel e ele atualiza imediatamente a tela emitindo um aviso sonoro.

## Tecnologias Utilizadas

* **Node.js + TypeScript**: Motor e linguagem do servidor.
* **Express.js**: Framework para criação de rotas REST.
* **MySQL 8+**: Banco de dados relacional.
* **Socket.io**: Comunicação bidirecional em tempo real (WebSockets).
* **Delphi VCL**: Criação das interfaces Desktop para Windows.
* **RESTRequest4Delphi**: Biblioteca de consumo de API moderna para Delphi (via Boss).

## O que este projeto aborda (Objetivos de Aprendizado)

* **Node.js:** Criação de rotas, conexão com banco de dados usando Pool, e emissão de eventos em tempo real com WebSockets.
* **Delphi:** Integração com APIs externas de forma programática (sem componentes visuais) usando o padrão Monorepo.
