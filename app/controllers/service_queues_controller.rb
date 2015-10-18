class ServiceQueuesController < ApplicationController
  respond_to :html, :js

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

  def edit_workforce
    @service_queue = ServiceQueue.find(params[:id])
  end

  def manage
    @service_queue = ServiceQueue.find(params[:id])
    @filter_status = params[:filter_status] || "waiting"
    @tickets = @service_queue.tickets
  end

  def admin_waiting
    @service_queue = ServiceQueue.find(params[:id])
  end

  def create
    @service_queue = ServiceQueue.create(service_queue_params)
    redirect_to :back
  end

  def update
    @service_queue = ServiceQueue.find(params[:id])
    @service_queue.update(service_queue_params)
    redirect_to :back
  end

  def update_workforce
    @service_queue = ServiceQueue.find(params[:id])
    @service_queue.update(service_queue_params)
    @test = service_queue_params["specialties_attributes"].to_a
  end

  def destroy
    @service_queue = ServiceQueue.find(params[:id])
    @service_queue.destroy
    redirect_to :back
  end

  private

  def service_queue_params
    params[:service_queue].permit(:name, :refresh_interval, :initial_waiting_time,
                                  specialties_attributes: [:id, :name, :number_of_workers, :_destroy, :badge_color,
                                                           subspecialties_attributes: [:id, :name, :number_of_workers, :_destroy]])
  end

end
