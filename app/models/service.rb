class Service < ApplicationRecord
  validates :client, :vehicle, :description, :status, presence: true
  validates :delivery_date, presence: true

  enum status: {
    pendiente: 'pendiente',
    en_proceso: 'en_proceso',
    completado: 'completado',
    entregado: 'entregado'
  }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= 'pendiente'
  end
end
