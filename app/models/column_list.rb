class ColumnList < ActiveRecord::Base
  self.table_name = 'column_list'

  belongs_to :list

  scope :key_map, -> {where(key: true).first}

  validates_uniqueness_of :name,
    :case_sensitive => false,
    :scope => [:list_id],
    :message => "The column already exist."

  validates_length_of :name, :minimum => 5, :message => "Add a name to column"

end
