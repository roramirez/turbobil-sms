class ChangeColumnOutgoing < ActiveRecord::Migration
  def change
    rename_column :outgoing, :dialstatus, :status
    add_column :outgoing, :code, :text
    add_column :outgoing, :response, :text
    add_reference :outgoing, :list, index: true
    add_reference :outgoing, :campaign, index: true
    add_reference :outgoing, :contact, index: true
  end
end
