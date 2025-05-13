class AddPlacasToTickets < ActiveRecord::Migration[6.1]
  def up
    add_column :tickets, :placas, :string
    Ticket.update_all(placas: 'Sin placa')
    change_column_null :tickets, :placas, false
  end

  def down
    remove_column :tickets, :placas
  end
end
