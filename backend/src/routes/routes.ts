import { Router } from "express";
import { TicketController } from "../controllers/ticketController";

const router = Router();
const ticketController = new TicketController();

router.post("/tickets/chamar", ticketController.chamarSenha);
router.post("/tickets/gerar", ticketController.gerarSenha);

export default router;