class TmpContactList < ActiveRecord::Base
  self.table_name = 'tmp_contact_list'
  belongs_to :list

  def self.get_by_key_and_list(key, list, limit = 10)
    if limit == nil
      where(key: key, list: list)
    else
      where(key: key, list: list).first(limit)
    end
  end

end
