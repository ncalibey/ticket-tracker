class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_session, except: [:show, :index]

  def index
    @tickets = if params[:project].present?
                 Project.find(params[:project]).tickets
               else
                 Ticket.all
               end

    if params[:status].present?
      @tickets = @tickets.where(status: params[:status])
    end

    if params[:tag].present?
      @tickets = @tickets.join(:tags).where("tags.id": params[:tag])
    end
  end

  def show; end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params.merge(creator: current_user))

    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :body, :status, :project_id, :assignee_id, tags_ids: [])
  end
end
