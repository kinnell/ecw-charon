class ServiceQueuesController < ApplicationController
  def index
    @service_queues = ServiceQueue.all
  end
  
  def show
    @service_queue = ServiceQueue.find(params[:id])
  end
  
  def manage
    @service_queue = ServiceQueue.find(params[:id])
  end

  def create
    @service_queue = ServiceQueue.create(params[:service_queue].permit(:name, :specialties, :refresh_interval))
    redirect_to :back
  end

  def update
    @service_queue = ServiceQueue.find(params[:id])
    @service_queue.update(params[:service_queue].permit(:name, :specialties, :refresh_interval))
    redirect_to :back
  end

  def destroy
    @service_queue = ServiceQueue.find(params[:id])
    @service_queue.destroy
    redirect_to :back
  end
end
