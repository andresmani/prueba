class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_role
  belongs_to :resource, :polymorphic => true
end
