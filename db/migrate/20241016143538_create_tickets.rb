class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :cliente
      t.string :vehiculo
      t.string :servicio

      t.timestamps
    end
  end
end
