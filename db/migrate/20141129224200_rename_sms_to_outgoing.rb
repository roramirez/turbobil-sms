class RenameSmsToOutgoing < ActiveRecord::Migration
  def change
    rename_table :sms, :outgoing
  end
end
