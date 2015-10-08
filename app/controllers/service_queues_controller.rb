class ServiceQueuesController < ApplicationController
  def index
    @service_queues = ServiceQueue.all
  end

  def show
    @service_queue = ServiceQueue.find(params[:id])
  end

  def show_all
    @service_queues = ServiceQueue.all
  end

  def edit
    @service_queue = ServiceQueue.find(params[:id])
  end

  def manage
    @service_queue = ServiceQueue.find(params[:id])
    @filter_status = params[:filter_status] || "waiting"
    @tickets = @service_queue.tickets
  end


  def create
    @service_queue = ServiceQueue.create(params[:service_queue].permit(:name, :refresh_interval, :initial_waiting_time))
    redirect_to :back
  end

  def update
    @service_queue = ServiceQueue.find(params[:id])
    @service_queue.update(params[:service_queue].permit(:name, :refresh_interval, :initial_waiting_time, specialties_attributes: [:id, :name, :number_of_workers, :_destroy, subspecialties_attributes: [:id, :name, :number_of_workers, :_destroy]]))
    redirect_to :back
  end

  def destroy
    @service_queue = ServiceQueue.find(params[:id])
    @service_queue.destroy
    redirect_to :back
  end
end
