class TicketsController < ApplicationController
  def create
    @ticket = Ticket.create(params[:ticket].permit(:service_queue_id, :name, :note, :subspecialty_id))
    redirect_to :back
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def deactivate
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update(params[:ticket].permit(:started_service_at, :finished_service_at, :name, :starred, :note, :active, :removal_reason, :subspecialty_id))
    redirect_to :back
  end

end
