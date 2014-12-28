class AddIndexPrefixTelcoIdToRoute < ActiveRecord::Migration
  def change
    add_index :route, [:prefix, :telco_id], unique: true
  end
end
