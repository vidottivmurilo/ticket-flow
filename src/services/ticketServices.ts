import { Ticket } from "../types";
import pool from "../config/database";

export class TicketService {
    async gerarSenha() {
        const [rows] = await pool.query("SELECT MAX(numero) as ultimaSenha FROM tickets");
        const ultimaSenha = (rows as { ultimaSenha: number | null }[])[0].ultimaSenha || 0;
        const novaSenha = ultimaSenha + 1;

        const [result] = await pool.execute(
            "INSERT INTO tickets (numero, status) VALUES (?, 'pendente')",
            [novaSenha]
        );

        return novaSenha;
    }

    async chamarProximaSenha(guiche: number) {
        const [rows] = await pool.query("SELECT MIN(numero) as min_numero FROM tickets WHERE status = 'pendente'");
        const senhaPendente = (rows as { min_numero: number | null }[])[0].min_numero || 0;

        if (senhaPendente === 0) {
            return null;
        }

        const [result] = await pool.execute(
            "UPDATE tickets SET status = 'chamado', chamado_em = NOW(), guiche = ? WHERE numero = ?",
            [guiche, senhaPendente]
        );

        return {
            guiche: guiche,
            senha: senhaPendente
        };
    }
}