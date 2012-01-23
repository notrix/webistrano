class ChangeDeploymentLogColumn < ActiveRecord::Migration
  def self.up
    change_column :deployments, :log, :text, :limit => 4294967295
  end

  def self.down
    change_column :deployments, :log, :text, :limit => 65535
  end
end
