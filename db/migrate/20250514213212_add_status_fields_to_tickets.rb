class AddStatusFieldsToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :proceso, :boolean
    add_column :tickets, :pago, :boolean
    add_column :tickets, :entrega, :string
  end
end
