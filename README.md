# 🎟️ Ticket Flow

**Ticket Flow** é um sistema de gestão e chamamento de senhas para atendimento, desenvolvido com foco em performance e reatividade. O projeto simula o ecossistema de uma agência bancária ou clínica médica, onde terminais de autoatendimento (Totens), mesas de funcionários (Atendentes) e painéis de exibição (Monitores/TVs) precisam conversar entre si de forma perfeitamente sincronizada.

O grande diferencial deste projeto é a integração **em tempo real** entre uma API Backend moderna construída em **Node.js** e aplicações Desktop nativas em **Delphi VCL**, utilizando a tecnologia de **WebSockets**.

---

## 🎯 O que o aplicativo faz?

O sistema consolida três grandes módulos em um único executável Desktop (conceito de "ERP/Menu"), consumindo a mesma API central:

1. **Totem (Gerador de Senha):** O cliente chega na agência e clica em um botão para retirar sua senha. O sistema se comunica com a API (via POST) e a nova senha é gravada no banco de dados.
2. **Atendente (Chamador):** O funcionário informa em qual guichê está trabalhando e clica em "Chamar Próxima Senha". O sistema busca a senha mais antiga da fila e atualiza o seu status.
3. **Monitor de TV (Tempo Real):** O painel visual que fica na parede. Ele não precisa ficar consultando a API repetidas vezes (Polling); em vez disso, ele mantém uma conexão **WebSocket** aberta permanentemente. Assim que o Atendente chama a senha, o Monitor reage **instantaneamente** exibindo o número da senha e do guichê.

---

## 🏗️ Arquitetura e Tecnologias

O projeto adota o padrão **Monorepo**, onde o código-fonte do Frontend (Delphi) e do Backend (Node.js) convivem harmonicamente, facilitando a manutenção e o controle de versão.

### 🟢 Backend (Node.js + TypeScript)
A API foi desenhada utilizando **TypeScript** para garantir segurança de tipagem e evitar erros em tempo de execução.

* **Express.js:** Escolhido pela sua simplicidade e padronização na construção de rotas RESTful (`/tickets/gerar` e `/tickets/chamar`).
* **ws (WebSockets Nativos):** Escolhido em substituição ao clássico `socket.io`. A biblioteca `ws` fala o protocolo WebSocket puro, o que torna a conexão com clientes de outras linguagens (como o Delphi) incrivelmente fácil e nativa, sem depender de dialetos proprietários.
* **mysql2 (com Promises):** Utilizado para a comunicação com o banco de dados MySQL. Implementamos um *Connection Pool* no padrão *Singleton* para garantir que a API suporte múltiplos totens e atendentes simultâneos sem gargalos de conexão.
* **dotenv:** Para segurança das credenciais do banco de dados, removendo senhas do código-fonte (Hardcode).

### 🔴 Frontend (Delphi VCL)
O cliente Desktop foi desenhado de forma "Code First" (orientado a código), abandonando componentes visuais antigos e abraçando o consumo moderno de serviços.

* **Boss:** O gerenciador de dependências nativo do Delphi, utilizado para gerenciar as bibliotecas de terceiros (semelhante ao NPM do Node).
* **RESTRequest4Delphi (RR4D):** Biblioteca fantástica do Vinicius Sanchez. Foi escolhida porque permite fazer requisições HTTP REST (GET, POST) de forma fluente 100% via código. Isso manteve os formulários VCL limpos (sem a poluição visual de componentes invisíveis como o `TRESTClient`).
* **Bird Socket Client:** Biblioteca leve criada pelo Mateus Vicente para atuar como Cliente WebSocket no Delphi. Ela roda em background e escuta o servidor Node.js.
* **TThread.Synchronize:** Utilizado junto com o Bird Socket para garantir que, quando a mensagem do WebSocket chegar de forma assíncrona, a atualização visual (ex: mudar o `Caption` de um Label) aconteça de forma segura na Main Thread do Windows, sem causar travamentos na UI.

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos
* Node.js (v18+)
* MySQL Server (v8+)
* Embarcadero Delphi (RAD Studio)
* Boss (Dependency Manager para Delphi)

### Subindo a API (Backend)
1. Crie um banco de dados no MySQL e execute a modelagem inicial.
2. Crie um arquivo `.env` na raiz do projeto contendo suas credenciais de banco.
3. No terminal, instale as dependências: `npm install`
4. Inicie o servidor: `npm run dev` (ou `npx tsx src/app.ts`)
5. O console exibirá: `🚀 Servidor HTTP e WebSockets Nativo rodando na porta 3000`

### Executando o Cliente (Frontend)
1. Pelo terminal, navegue até a pasta `frontend/` e restaure as bibliotecas: `boss install`
2. Abra o arquivo `.dproj` no RAD Studio.
3. Compile e rode o projeto (`F9`).
4. Pelo Menu Principal, você pode abrir as telas do Totem, Atendente e Monitor simultaneamente (elas são assíncronas/não-modais) para testar o fluxo completo em tempo real!
