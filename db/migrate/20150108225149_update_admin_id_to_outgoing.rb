class UpdateAdminIdToOutgoing < ActiveRecord::Migration
  def change
    Outgoing.where(admin: nil).update_all(admin_id: Admin.first)
  end
end
