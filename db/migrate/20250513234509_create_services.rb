class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :client
      t.string :vehicle
      t.text :description
      t.string :status
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
