class Ticket < ApplicationRecord
  SERVICIOS = [
    'Servicio mecánico',
    'Servicio eléctrico',
    'Caja de velocidades',
    'Hojalatería y pintura'
  ].freeze

  validates :cliente, presence: true
  validates :vehiculo, presence: true
  validates :placas, presence: true
  validates :servicio, presence: true, inclusion: { in: SERVICIOS }
  validates :fecha_ingreso, presence: true

  before_validation :set_fecha_ingreso, on: :create

  private

  def set_fecha_ingreso
    self.fecha_ingreso ||= Time.current
  end
end
