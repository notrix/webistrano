require File.dirname(__FILE__) + '/../test_helper'

class StageUsersControllerTest < ActionController::TestCase

  def setup
    @project = create_new_project
    @stage = create_new_stage(:project => @project)
    @user = admin_login
    @user_for_stage = create_new_user
  end

  def test_should_create_project_user
    pu = ProjectsUsers.new
    pu.project_id = @project.id
    pu.user_id = @user_for_stage.id
    pu.save!

    old_count = StagesUser.count
    post :create, :stage_id => @stage.id, :stage_user => { :id => @user_for_stage.id }
    assert_equal old_count+1, StagesUser.count

    assert_redirected_to project_stage_path(@stage.project.id, @stage)
  end

  def test_should_destroy_project_user
    pu = ProjectsUsers.new
    pu.project_id = @project.id
    pu.user_id = @user_for_stage.id
    pu.save!

    su = StagesUser.new
    su.stage_id = @stage.id
    su.user_id = @user_for_stage.id
    su.read_only = 0
    su.save!

    old_count = StagesUser.count

    delete :destroy, :stage_id => @stage.id, :id => @user_for_stage.id
    assert_equal old_count-1, StagesUser.count

    assert_redirected_to project_stage_path(@stage.project.id, @stage)
  end

end
