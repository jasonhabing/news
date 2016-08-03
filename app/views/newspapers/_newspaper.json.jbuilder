json.extract! newspaper, :id, :name, :website, :main_rss_feed_url, :circulation, :owner, :created_at, :updated_at
json.url newspaper_url(newspaper, format: :json)