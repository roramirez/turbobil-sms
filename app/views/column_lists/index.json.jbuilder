json.array!(@column_lists) do |column_list|
  json.extract! column_list, :id
  json.url column_list_url(column_list, format: :json)
end
