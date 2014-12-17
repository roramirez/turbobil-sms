class AddTextToOutgoing < ActiveRecord::Migration
  def change
    add_column :outgoing, :text, :text
  end
end
