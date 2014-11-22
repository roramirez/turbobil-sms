class AddKeyToColumnList < ActiveRecord::Migration
  def change
    add_column :column_list, :key, :boolean, :default => false
  end
end
