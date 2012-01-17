class AddUniqueIndexes < ActiveRecord::Migration
  def self.up
    add_index :recipes_stages, [:recipe_id, :stage_id], :unique => true
    add_index :deployments_roles, [:deployment_id, :role_id], :unique => true
  end

  def self.down
     remove_index :recipes_stages, :recipe_id
     remove_index :recipes_stages, :stage_id
     remove_index :deployments_roles, :recipe_id
     remove_index :deployments_roles, :stage_id
  end
end
