class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contact do |t|
      t.string :number
      t.json :data
      t.references :list, index: true

      t.timestamps
    end
  end
end
