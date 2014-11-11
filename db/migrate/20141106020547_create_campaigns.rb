class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaign do |t|
      t.string :name
      t.integer :status
      t.text :text
      t.timestamp :init
      t.references :customer, index: true
      t.references :list, index: true

      t.timestamps
    end
  end
end
