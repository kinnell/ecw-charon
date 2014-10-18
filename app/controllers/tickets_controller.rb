class TicketsController < ApplicationController
  def create
    @ticket = Ticket.create(params[:ticket].permit(:service_queue_id, :name, :note, :specialty))
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
    @ticket.update(params[:ticket].permit(:started_service_at, :finished_service_at, :name, :starred, :note, :specialty, :active, :removal_reason))
    redirect_to :back
  end

end
