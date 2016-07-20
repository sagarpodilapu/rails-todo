class Task < ActiveRecord::Base
  belongs_to:user
  validates :task,
  presence:true
  validates :user_id,
  presence:true
end
