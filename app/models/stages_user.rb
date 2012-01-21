class StagesUser < ActiveRecord::Base
  belongs_to :stage
  belongs_to :user

  validates_presence_of :stage_id, :user_id
  validate :user_must_be_associated_to_project

  def user_must_be_associated_to_project
    if (!self.stage.nil?)
      errors.add(:stage_id, "user must be associated to the project") unless
        self.stage.project.user_ids.include?(self.user_id)
    end
  end
end
