export interface Ticket {
    id: number;
    numero: number;
    guiche?: number | null;
    status: 'pendente' | 'chamado';
    criado_em: Date;
    chamado_em?: Date | null;
}