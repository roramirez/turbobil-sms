class CreateTmpContactLists < ActiveRecord::Migration
  def change
    create_table :tmp_contact_list do |t|
      t.text :key
      t.json :content
      t.references :list, index: true

      t.timestamps
    end
  end
end
