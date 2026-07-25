import express from 'express';
import cors from 'cors';
import router from './routes/routes';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';

const app = express();
const port = process.env.PORT;

const httpServer = createServer(app);

const wss = new WebSocketServer({ server: httpServer });

app.set('wss', wss);

app.use(cors());
app.use(express.json());

app.use(router);

app.get('/ping', (req, res) => {
    res.json({ message: "API do TicketFlow rodando perfeitamente!" });
});

wss.on('connection', (ws) => {
    console.log(`🔌 Novo Painel de TV conectado via WS Nativo!`);

    ws.on('close', () => {
        console.log(`❌ Monitor de TV desconectado.`);
    });
});

httpServer.listen(port, () => {
    console.log(`Servidor HTTP e WebSockets rodando na porta ${port}`);
});