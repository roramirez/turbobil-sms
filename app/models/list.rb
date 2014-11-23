class List < ActiveRecord::Base
  self.table_name = 'list'


  has_many :campaigns
  has_many :column_list
  has_many :contact
  belongs_to :customer

  def to_s
    :name
  end


  def import(file, key=nil)
    spreadsheet = open_spreadsheet(file)
    if !key
      key = SecureRandom.hex(64)
    end
    (1..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      tmp_contact_list = TmpContactList.new
      tmp_contact_list.content = row.to_json
      tmp_contact_list.key = key
      tmp_contact_list.list_id = id
      tmp_contact_list.save!
    end
    key
  end

  private
  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
