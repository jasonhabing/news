class Story < ActiveRecord::Base

validates :title, length: { maximum: 250 }, presence: true
validates :url, presence: true
has_many :words

def parse
	if self.parsed_date.present?
		puts "this story has already been parsed."
	else
		words = self.title.downcase.split(" ")
		words.each do |w|
			word = Word.new
			word.name = w.gsub(/[^a-z0-9\s]/i, '') #removes non-alphanumeric characters
			word.story_id = self.id
			word.story_date = self.created_at
			word.save
			puts "added word: #{Word.last.name}"
		end
		self.parsed_date = Time.now
		self.save
	end
end




end





