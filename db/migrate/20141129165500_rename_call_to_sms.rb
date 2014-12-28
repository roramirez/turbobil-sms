class RenameCallToSms < ActiveRecord::Migration
  def change
    rename_table :call, :sms
  end
end
