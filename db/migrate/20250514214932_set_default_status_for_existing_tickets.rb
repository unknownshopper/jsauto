class SetDefaultStatusForExistingTickets < ActiveRecord::Migration[6.1]
  def up
    # Establecer valores por defecto para tickets existentes
    Ticket.update_all(
      proceso: true,
      pago: false,
      entrega: 'pendiente'
    )
  end

  def down
    # No es necesario revertir ya que solo estamos estableciendo valores por defecto
  end
end
