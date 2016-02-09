json.array!(@authors) do |author|
  json.extract! author, :id, :title, :description
  json.url author_url(author, format: :json)
end
