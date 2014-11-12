class ColumnList < ActiveRecord::Base
  self.table_name = 'column_list'

  belongs_to :list
end
