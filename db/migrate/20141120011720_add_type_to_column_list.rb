class AddTypeToColumnList < ActiveRecord::Migration
  def change
    add_column :column_list, :type, :text
  end
end
