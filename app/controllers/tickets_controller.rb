class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all

    # Filtros
    @tickets = @tickets.where(servicio: params[:servicio]) if params[:servicio].present?
    @tickets = @tickets.where(pago: params[:pago]) if params[:pago].present?
    @tickets = @tickets.where(entrega: params[:entrega]) if params[:entrega].present?

    # Filtrar por rango de fechas de entrega
    if params[:fecha_desde].present?
      fecha_desde = Date.strptime(params[:fecha_desde], '%d/%m/%y') rescue nil
      @tickets = @tickets.where('fecha_entrega >= ?', fecha_desde) if fecha_desde
    end
    if params[:fecha_hasta].present?
      fecha_hasta = Date.strptime(params[:fecha_hasta], '%d/%m/%y') rescue nil
      @tickets = @tickets.where('fecha_entrega <= ?', fecha_hasta) if fecha_hasta
    end

    # Búsqueda por cliente o vehículo
    if params[:buscar].present?
      search_term = "%#{params[:buscar]}%"
      @tickets = @tickets.where('cliente LIKE ? OR vehiculo LIKE ? OR placas LIKE ?',
                              search_term, search_term, search_term)
    end

    # Estadísticas para las gráficas
    @tickets_by_service = Ticket.group(:servicio).count
    
    # Preparar datos para el timeline de entregas
    @delivery_timeline = @tickets.order(:created_at).map do |ticket|
      {
        id: ticket.id,
        content: "#{ticket.cliente} - #{ticket.placas}",
        start: ticket.created_at,
        end: ticket.fecha_entrega || ticket.updated_at, # Usar fecha_entrega o updated_at si no está definida
        className: timeline_class_for(ticket),
        group: timeline_group_for(ticket),
        title: "Cliente: #{ticket.cliente}\nVehículo: #{ticket.vehiculo} (#{ticket.placas})\nServicio: #{ticket.servicio}"
      }
    end
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

  def timeline_class_for(ticket)
    classes = []
    classes << 'timeline-proceso' if ticket.proceso
    classes << (ticket.pago ? 'timeline-pagado' : 'timeline-pago-pendiente')
    
    case ticket.entrega
    when 'pendiente'
      classes << 'timeline-pendiente'
    when 'listo'
      classes << 'timeline-listo'
    when 'entregado'
      classes << 'timeline-entregado'
    end
    
    classes.join(' ')
  end

  def timeline_group_for(ticket)
    if ticket.entrega == 'entregado'
      3 # Entregados
    elsif ticket.pago
      2 # Pagados
    else
      1 # En proceso
    end
  end

  def ticket_params
    params.require(:ticket).permit(:cliente, :vehiculo, :placas, :servicio, 
                                   :fecha_ingreso, :fecha_entrega,
                                   :proceso, :pago, :entrega)
  end
end
