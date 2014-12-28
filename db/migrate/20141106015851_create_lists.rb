class CreateLists < ActiveRecord::Migration
  def change
    create_table :list do |t|
      t.string :name
      t.references :customer, index: true

      t.timestamps
    end
  end
end
