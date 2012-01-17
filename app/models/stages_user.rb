class StagesUser < ActiveRecord::Base
  belongs_to :stage
  belongs_to :user

  validates_presence_of :stage_id, :user_id
end
