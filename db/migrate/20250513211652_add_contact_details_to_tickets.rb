class AddContactDetailsToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :telefono, :string, null: true
    add_column :tickets, :correo, :string, null: true
    add_column :tickets, :comentarios, :text, null: true
  end
end
