class AddFechaIngresoToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :fecha_ingreso, :datetime
    change_column_default :tickets, :fecha_ingreso, from: nil, to: -> { "CURRENT_TIMESTAMP" }
    change_column_null :tickets, :fecha_ingreso, false, Time.current
  end
end
