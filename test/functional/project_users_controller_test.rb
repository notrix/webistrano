require File.dirname(__FILE__) + '/../test_helper'

class ProjectUsersControllerTest < ActionController::TestCase

  def setup
    @project = create_new_project
    @stage = create_new_stage(:project => @project)
    @user = admin_login
    @user_for_project = create_new_user
  end

  def test_should_create_project_user
    old_count = ProjectsUsers.count
    post :create, :project_id => @project.id, :project_user => { :id => @user_for_project.id }
    assert_equal old_count+1, ProjectsUsers.count

    assert_redirected_to project_url(@project)
  end

  def test_should_destroy_project_user
    pu = ProjectsUsers.new
    pu.project_id = @project.id
    pu.user_id = @user_for_project.id
    pu.save!
    old_count = ProjectsUsers.count

    delete :destroy, :project_id => @project.id, :id => @user_for_project.id
    assert_equal old_count-1, ProjectsUsers.count

    assert_redirected_to project_url(@project)
  end

end
