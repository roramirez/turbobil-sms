class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaign do |t|
      t.integer :status
      t.string :text
      t.timestamp :init
      t.references :customer, index: true
      t.references :list, index: true

      t.timestamps
    end
  end
end
