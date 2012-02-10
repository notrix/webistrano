require 'test_helper'

class StagesUsersTest < ActiveSupport::TestCase

  fixtures :users

  def setup
    @user = users(:quentin)
  end

  def test_creation
    assert_equal 0, StagesUser.count

    project = create_new_project
    pu = ProjectsUsers.create!(:project_id => project.id, :user_id => @user.id)
    stage = create_new_stage(:project => project)

    assert_nothing_raised{
      su = StagesUser.create!(:stage_id => stage.id, :user_id => @user.id)
    }

    assert_equal 1, StagesUser.count

    assert_equal "#{stage.id},#{@user.id}", StagesUser.find(:first).to_param
  end

  def test_validation
    # try to create stage user without stage_id
    su = StagesUser.new(:user_id => @user.id)
    assert !su.valid?
    assert_not_nil su.errors.on("stage_id")

    # try to create stage user for user not include in stage projet user
    project = create_new_project
    stage = create_new_stage(:project => project)

    su = StagesUser.new(:stage_id => stage.id, :user_id => @user.id)
    assert !su.valid?
    assert_equal "user must be associated to the project", su.errors.on("stage_id")

    # try to create two entries with same project_id and user_id
    project = create_new_project
    pu = ProjectsUsers.create!(:project_id => project.id, :user_id => @user.id)
    stage = create_new_stage(:project => project)
    pu = StagesUser.create!(:stage_id => stage.id, :user_id => @user.id)

    assert_raise(ActiveRecord::StatementInvalid) {
      pu = StagesUser.create!(:stage_id => stage.id, :user_id => @user.id)
    }
  end
end
