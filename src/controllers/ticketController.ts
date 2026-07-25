import { Request, Response } from "express";
import { TicketService } from "../services/ticketServices";

const ticketService = new TicketService();

export class TicketController {

    async chamarSenha(req: Request, res: Response) {
        try {
            const guiche = req.body.guiche;
            if (!guiche) {
                return res.status(400).json({ error: "O número do guichê é obrigatório!" });
            }

            const resultado = await ticketService.chamarProximaSenha(guiche);
            if (!resultado) {
                return res.status(404).json({ error: "A fila está vazia. Nenhuma senha pendente." });
            }

            const wss = req.app.get('wss');

            wss.clients.forEach((client: any) => {
                if (client.readyState === 1) {
                    client.send(JSON.stringify(resultado));
                }
            });

            return res.status(200).json(resultado)

        } catch (error) {
            console.error("Erro ao chamar senha: ", error);
            return res.status(500).json({ error: "Erro interno do servidor ao chamar senha" })
        }
    }

    async gerarSenha(req: Request, res: Response) {
        try {
            const novaSenha = await ticketService.gerarSenha();
            return res.status(201).json({ senha: novaSenha, mensagem: "Senha gerada com sucesso!" });
        } catch (error) {
            console.error("Erro ao gerar senha: ", error);
            return res.status(500).json({ error: "Erro interno do servidor ao gerar senha" })
        }
    }
}