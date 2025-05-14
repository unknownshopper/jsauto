class AddDeliveryDateToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :fecha_entrega, :date
  end
end
