class CreateColumnLists < ActiveRecord::Migration
  def change
    create_table :column_list do |t|
      t.string :name
      t.references :list, index: true

      t.timestamps
    end
  end
end
