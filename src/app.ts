import express from 'express';
import cors from 'cors';
import router from './routes/routes';
import { createServer } from 'http';
import { Server } from 'socket.io';

const app = express();
const port = process.env.PORT;

const httpServer = createServer(app);

const io = new Server(httpServer, {
    cors: {
        origin: '*'
    }
})

app.set('io', io);

app.use(cors());
app.use(express.json());

app.use(router);

app.get('/ping', (req, res) => {
    res.json({ message: "API do TicketFlow rodando perfeitamente!" });
});

io.on('connection', (socket) => {
    console.log(`Novo painel conectado! ID: ${socket.id}`);
})

httpServer.listen(port, () => {
    console.log(`Servidor HTTP e WebSockets rodando na porta ${port}`);
});