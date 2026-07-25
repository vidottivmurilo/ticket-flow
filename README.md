# 🚀 Ticket Flow (Integração Delphi & Node.js)

Este projeto nasceu como um laboratório prático para explorar a integração de ponta a ponta entre uma linguagem compilada clássica para Desktop e um ecossistema backend moderno e assíncrono. O objetivo central aqui não é a regra de negócio em si (um sistema de senhas), mas sim **a arquitetura, as tecnologias combinadas e os desafios de sincronização em tempo real.**

---

## 🛠️ Stack Tecnológica Utilizada

A arquitetura escolhida foi um **Monorepo**, mantendo os ecossistemas separados, porém versionados em conjunto para facilitar o estudo da comunicação entre eles.

### 🟢 Backend (Node.js)
* **TypeScript:** Utilizado para trazer tipagem estática e segurança na hora do build, facilitando a modelagem dos retornos do banco.
* **Express.js:** Framework minimalista para construção da API RESTful.
* **ws (WebSockets Nativos):** A biblioteca escolhida para suportar comunicação em tempo real via TCP/IP.
* **MySQL2 (Promises):** Driver Node.js para conectar ao banco de dados relacional (MySQL), configurado no padrão de *Connection Pool (Singleton)* para garantir resiliência e concorrência no uso das conexões.
* **Dotenv:** Gerenciamento seguro das variáveis de ambiente.

### 🔴 Frontend (Delphi VCL)
* **Boss:** Gerenciador de dependências moderno para Delphi, trazendo a cultura do NPM para o ecossistema Object Pascal.
* **RESTRequest4Delphi (RR4D):** Biblioteca de consumo de APIs REST de forma puramente programática ("Code-First"), eliminando a necessidade de poluir os formulários com dezenas de componentes visuais antigos de conexão.
* **Bird Socket Client:** Cliente WebSocket leve, desenvolvido pela comunidade brasileira, essencial para capturar as transmissões assíncronas vindas do Node.js.
* **System.JSON:** Manipulação nativa de objetos JSON no Delphi.

---

## 🧠 O Que Aprendemos com a Construção deste Projeto?

O desenvolvimento deste laboratório gerou *insights* profundos, principalmente na área de interoperabilidade e gerenciamento de concorrência. Destacam-se os seguintes aprendizados:

### 1. Dialetos vs. Protocolos Universais (O Desafio do Tempo Real)
Inicialmente, tentamos utilizar a famosa biblioteca `socket.io` no Node.js. O grande aprendizado foi perceber que o `socket.io` fala um "dialeto" próprio por cima do protocolo WebSocket. Isso dificultou a vida do lado do cliente Delphi. 
**A solução arquitetural:** Substituir o `socket.io` pelo pacote `ws` no Node.js. Ao descer para o protocolo WebSocket "puro", o cliente Delphi (`Bird Socket Client`) conseguiu se conectar e conversar instantaneamente, provando que **simplificar para protocolos abertos universais** é quase sempre o melhor caminho para integrações entre ecossistemas muito distintos.

### 2. A Cultura "Code-First" no Delphi
Aplicações tradicionais em Delphi sofrem com formulários pesados (DFMs) entupidos de componentes não-visuais. O aprendizado aqui foi modernizar a escrita: usando `RESTRequest4Delphi`, fizemos todas as requisições HTTP via código de forma fluente (Fluent Interface). O código ficou legível, de fácil manutenção, fácil de "commitar" no Git e as telas VCL permaneceram limpas e puramente visuais.

### 3. Sincronização de Threads (Assincronismo Seguro)
Ao trabalhar com o `Bird Socket Client`, ele cria uma *Thread* paralela rodando em background para ficar ouvindo o servidor (impedindo que a janela do Windows congele). 
O aprendizado prático foi o uso obrigatório da chamada `TThread.Synchronize`. Sem ela, qualquer tentativa de atualizar um elemento visual (`Label.Caption`) através de uma thread secundária causaria falhas catastróficas na memória gráfica do Windows. Com a sincronização, o fluxo UI tornou-se "Thread-safe".

### 4. Gerenciamento de Memória Modeless no VCL
Para que o sistema ficasse interativo, os formulários deixaram de usar `ShowModal` e passaram a ser assíncronos (`Show`). Isso trouxe o aprendizado de gerenciar a memória ativamente: a necessidade de garantir que o Delphi não auto-criasse os formulários de forma invisível, e o uso da diretiva `Action := caFree` no evento `OnClose` para limpar a memória RAM adequadamente quando a tela secundária for fechada pelo usuário.

---

*Este é um projeto acadêmico focado em design de software, conectividade inter-plataforma e boas práticas modernas de codificação.*
