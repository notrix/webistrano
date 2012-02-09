class StageUsersController < ApplicationController

  protect_from_forgery :except => [:create, :destroy]
  before_filter :ensure_admin, :only => [:destroy, :create]

  def create
    @stage = Stage.find params[:stage_id]
    @stage_user = User.find params[:stage_user][:id]
    @read_only = (params[:stage_user][:read_only].to_i != 0) ? true : false

    if @stage_user and @stage and !@stage.user_ids.include?(@stage_user.id) then
      StagesUser.new(:stage_id => @stage.id, :user_id => @stage_user.id, :read_only => @read_only).save
    end

    redirect_to project_stage_path(@stage.project.id, @stage)
  end

  def destroy
    @stage = Stage.find params[:stage_id]
    @stage_user = User.find params[:id]
    @stage.users.delete @stage_user if @stage.user_ids.include?(@stage_user.id)
    redirect_to project_stage_path(@stage.project.id, @stage)
  end
end
