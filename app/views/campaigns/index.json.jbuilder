json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :status_text, :created_at, :updated_at
  json.url campaign_url(campaign, format: :json)
end
