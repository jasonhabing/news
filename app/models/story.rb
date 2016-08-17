class Story < ActiveRecord::Base

validates :title, length: { maximum: 250 }, presence: true
validates :url, presence: true


end
