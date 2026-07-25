import express from 'express';
import cors from 'cors';
import router from './routes/routes';

const app = express();
const port = process.env.PORT;

app.use(cors());
app.use(express.json());

app.use(router);

app.get('/ping', (req, res) => {
    res.json({ message: "API do TicketFlow rodando perfeitamente!" });
});

app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
    console.log(`Teste de conexão: http://localhost:${port}/ping`)
});