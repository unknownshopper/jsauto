class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @services = Service.all
    @services_by_status = Service.group(:status).count
    @services_by_delivery = Service.group_by_day(:delivery_date).count
  end

  def show
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to @service, notice: 'Servicio creado exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: 'Servicio actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to services_url, notice: 'Servicio eliminado exitosamente.'
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:client, :vehicle, :description, :status, :delivery_date)
  end
end
