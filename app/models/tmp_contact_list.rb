class TmpContactList < ActiveRecord::Base
  self.table_name = 'tmp_contact_list'
  belongs_to :list

  def self.get_by_key_and_list(key, list, limit = 10)
    where(key: key, list: list).first(limit)
  end

end
