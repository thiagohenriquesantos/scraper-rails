json.extract! cadastro, :id, :nome, :url_twitter, :created_at, :updated_at
json.url cadastro_url(cadastro, format: :json)
