json.extract! story, :id, :title, :url, :published, :summary, :newspaper_id, :created_at, :updated_at
json.url story_url(story, format: :json)