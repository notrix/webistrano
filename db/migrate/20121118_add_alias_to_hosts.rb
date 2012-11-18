class AddAliasToHosts < ActiveRecord::Migration
  def self.up
    add_column :hosts, :alias, :string, :default => ''
  end

  def self.down
    remove_column :hosts, :alias
  end
end
