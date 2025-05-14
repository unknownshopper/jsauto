class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all

    # Filtrar por servicio si se especifica
    @tickets = @tickets.where(servicio: params[:servicio]) if params[:servicio].present?

    # Filtrar por rango de fechas de entrega
    if params[:fecha_desde].present?
      @tickets = @tickets.where('fecha_entrega >= ?', params[:fecha_desde])
    end
    if params[:fecha_hasta].present?
      @tickets = @tickets.where('fecha_entrega <= ?', params[:fecha_hasta])
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
    @delivery_timeline = Ticket.order(:created_at)
                              .select(:id, :vehiculo, :cliente, :servicio, :created_at, :fecha_entrega, :placas)
                              .map do |ticket|
      # Calcular el progreso y color
      total_days = (ticket.fecha_entrega.to_date - ticket.created_at.to_date).to_i
      days_left = (ticket.fecha_entrega.to_date - Date.today).to_i
      progress = total_days > 0 ? ((total_days - days_left).to_f / total_days * 100).round : 100
      
      # Determinar el color basado en el progreso usando gradientes
      color = if progress <= 33
                'linear-gradient(135deg, #34d399 0%, #059669 100%)' # Verde
              elsif progress <= 66
                'linear-gradient(135deg, #fbbf24 0%, #d97706 100%)' # Naranja
              else
                'linear-gradient(135deg, #f87171 0%, #dc2626 100%)' # Rojo
              end

      # Formatear fechas
      fecha_recepcion = ticket.created_at.strftime("%d/%m/%Y")
      fecha_entrega = ticket.fecha_entrega.strftime("%d/%m/%Y")

      # Preparar el tooltip
      tooltip = <<~HTML
        <div class="timeline-tooltip">
          <strong>#{ticket.vehiculo}</strong> - #{ticket.placas}<br>
          <strong>Cliente:</strong> #{ticket.cliente}<br>
          <strong>Servicio:</strong> #{ticket.servicio}<br>
          <strong>Recepción:</strong> #{fecha_recepcion}<br>
          <strong>Entrega:</strong> #{fecha_entrega}<br>
          <strong>Progreso:</strong> #{progress}%
        </div>
      HTML

      {
        id: ticket.id,
        content: ticket.vehiculo,
        start: ticket.created_at,
        end: ticket.fecha_entrega,
        type: 'range',
        style: "background: #{color};",
        className: 'timeline-bar',
        title: tooltip.gsub("\n", "") # El tooltip no acepta saltos de línea
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

  def ticket_params
    params.require(:ticket).permit(:cliente, :vehiculo, :placas, :servicio, :telefono, :correo, :comentarios, :fecha_entrega)
  end
end
