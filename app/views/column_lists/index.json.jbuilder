json.array!(@column_lists) do |column_list|
  json.extract! column_list, :id, :name
end
