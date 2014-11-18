class AddMapToLists < ActiveRecord::Migration
  def change
    add_column :list, :map, :boolean, :default => true
  end
end
