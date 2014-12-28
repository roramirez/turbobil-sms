class ColumnList < ActiveRecord::Base
  self.table_name = 'column_list'

  belongs_to :list

  scope :key_map, -> {where(key: true).first}
end
