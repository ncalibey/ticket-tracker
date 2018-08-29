class CommentsController < ApplicationController
  before_action :require_session
  before_action :set_ticket
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :require_creator, only: [:edit, :update, :destroy]

  def edit; end

  def create
    @comment = @ticket.comments.new(comment_params.merge(creator: current_user))

    if @comment.save
      if params[:ticket_status].present?
        @ticket.update_attribute(:status, params[:ticket_status])
      end
      redirect_to @ticket, notice: 'Comment was successfully created.'
    else
      render :edit
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @ticket, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @ticket, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_comment
    @comment = @ticket.comments.find(params[:id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def require_creator
    if current_user != @comment.creator
      redirect_to @ticket, alert: "You can only edit your own comments."
    end
  end
end
