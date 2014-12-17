class Contact < ActiveRecord::Base
  self.table_name = 'contact'

  has_many :sms_queues
  has_many :outgoings

  belongs_to :list

  def self.exist_number_on_list(number, list)
    where(number: number, list: list).exists?
  end

  def convert_message_text(text, columns_hash)
    columns_hash.each_key do |k, m|
      columns_hash[k] = data[columns_hash[k.to_s].to_s]
    end
    keys = text.scan(/:[A-z]+:/)
    keys.each do | key_msg|
      k = key_msg.upcase.gsub(':', '')
      if columns_hash[k]
        text = text.gsub(key_msg, columns_hash[k])
      end
    end
    text
  end

end
