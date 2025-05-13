class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.fecha_ingreso = Time.current
    if @ticket.save
      redirect_to tickets_path, notice: 'Ticket creado con éxito.'
    else
      render :new
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to tickets_path, notice: 'Ticket actualizado con éxito.'
    else
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: 'Ticket eliminado con éxito.'
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:cliente, :vehiculo, :placas, :servicio, :telefono, :correo, :comentarios)
  end
end
