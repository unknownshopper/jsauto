class Ticket < ApplicationRecord
  SERVICIOS_DISPONIBLES = [
    'Servicio mecánico',
    'Servicio eléctrico',
    'Carrocería y pintura',
    'Afinación',
    'Frenos',
    'Suspensión',
    'Diagnóstico general',
    'Cambio de aceite',
    'Alineación y balanceo'
  ].freeze

  validates :cliente, :vehiculo, :placas, :servicio, presence: true
  validates :fecha_entrega, presence: true
  validates :servicio, inclusion: { in: SERVICIOS_DISPONIBLES }

  before_validation :set_fecha_ingreso, on: :create

  private

  def set_fecha_ingreso
    self.fecha_ingreso ||= Time.current
  end
end
