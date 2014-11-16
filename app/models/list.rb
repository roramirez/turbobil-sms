class List < ActiveRecord::Base
  self.table_name = 'list'


  has_many :campaigns
  belongs_to :customer

  def to_s
    :name
  end


  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      contact = Contact.find_by_id(row["id"]) || Contact.new
      contact.attributes = row.to_hash.slice(*row.to_hash.keys)
      contact.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
