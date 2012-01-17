class ProjectsUsers < ActiveRecord::Base
  validates_presence_of :project_id, :user_id
end
