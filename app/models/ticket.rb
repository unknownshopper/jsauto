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

  # Enums para el estado de entrega
  enum entrega: {
    pendiente: 'pendiente',
    listo: 'listo',
    entregado: 'entregado'
  }, _default: 'pendiente'

  # Validaciones
  validates :cliente, :vehiculo, :placas, :servicio, presence: true
  validates :fecha_entrega, presence: true
  validates :servicio, inclusion: { in: SERVICIOS_DISPONIBLES }
  validates :entrega, inclusion: { in: entregas.keys }

  # Callbacks
  before_validation :set_fecha_ingreso, on: :create
  before_validation :set_default_status, on: :create

  # Métodos de estado
  def status_dots
    {
      proceso: true, # Siempre está en proceso hasta que se entrega
      pago: pago?,
      entrega: entrega
    }
  end

  private

  def set_fecha_ingreso
    self.fecha_ingreso ||= Time.current
  end

  def set_default_status
    self.proceso = true if proceso.nil?
    self.pago = false if pago.nil?
    self.entrega ||= 'pendiente'
  end
end
