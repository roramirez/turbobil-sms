class AddTelcoIdToRoute < ActiveRecord::Migration
  def change
    add_column :route, :telco_id, :integer
  end
end
