class CreateSmsQueues < ActiveRecord::Migration
  def change
    create_table :sms_queue do |t|
      t.references :contact, index: true
      t.references :campaign, index: true
      t.timestamp :process
      t.timestamp :discard

      t.timestamps
    end
  end
end
