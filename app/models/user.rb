class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, usuario: 1, almacen: 2 }

  validates :role, presence: true

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :usuario
  end
end
