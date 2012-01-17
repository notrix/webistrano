require 'test_helper'

class ProjectsUsersTest < ActiveSupport::TestCase

  fixtures :projects
  fixtures :users

  def setup
    @project = projects(:project_1)
    @user = users(:quentin)
  end

  def test_creation
    assert_equal 0, ProjectsUsers.count

    assert_nothing_raised{
      pu = ProjectsUsers.create!(:project_id => @project.id, :user_id => @user.id)
    }

    assert_equal 1, ProjectsUsers.count
  end

  def test_validation
    # try to create project user without project id
    pu = ProjectsUsers.new(:user_id => @user.id)
    assert !pu.valid?
    assert_not_nil pu.errors.on("project_id")

    # try to create two entries with same project_id and user_id
    pu = ProjectsUsers.create!(:project_id => @project.id, :user_id => @user.id)

    assert_raise(ActiveRecord::StatementInvalid) {
      pu = ProjectsUsers.create!(:project_id => @project.id, :user_id => @user.id)
    }
  end
end
