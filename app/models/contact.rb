class Contact < ActiveRecord::Base
  self.table_name = 'contact'
  belongs_to :list

  def self.exist_number_on_list(number, list)
    where(number: number, list: list).exists?
  end


end
