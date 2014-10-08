class TicketsController < ApplicationController
  def create
    @ticket = Ticket.create(params[:ticket].permit(:service_queue_id, :name))
    redirect_to :back
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update(params[:ticket].permit(:started_service_at, :finished_service_at, :name))
    redirect_to :back
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to :back
  end
end

