class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :require_session, execept: [:show, :index]

  def index
    @tags = Tag.with_counts.alphabetical
  end

  def new
    @tag = Tag.new
  end

  def edit; end

  def create
    @tag = Tag.new(tags_params)

    if @tag.save
      redirect_to tags_path, notice: 'Tag was succesfully created.'
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'Tag was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path, notice: 'Tag was successfully destroyed.'
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tags_params
    params.require(:tag).permit(:name)
  end
end
