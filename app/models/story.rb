class Story < ActiveRecord::Base

validates :title, length: { maximum: 250 }, presence: true
validates :url, presence: true
has_many :words

	def parse
		if self.parsed_date.present?
			puts "this story has already been parsed."
		else
			words = self.title.split(" ")
			words.each do |w|
				word = Word.new
				word.name = w.sanitize #removes non-alphanumeric characters
				word.story_id = self.id
				word.story_date = self.created_at
				word.save
				puts "added word: #{Word.last.name}"
			end
			self.parsed_date = Time.now
			self.save
		end
	end

	#gets the number of common words between two stories, then calculates the t-score for each of those words.  High t-scores should mean the probably of these words randomly occurring is very low.
	def get_common_word_scores(story)
		if parsed_date == nil
			self.parse
		end
		story_one_words = self.title.split(" ").map!(&:sanitize)
		story_two_words = story.title.split(" ").map!(&:sanitize)
		common_words = story_one_words & story_two_words
		if common_words == nil
			return nil
			puts "no common words"
		else
			common_word_t_scores = []
			common_words.each do |c|
				word_t_score = Word.where(:name => c).last.get_t_score(24, 10)
				common_word_t_scores << word_t_score
			end
		end
		return common_word_t_scores
	end

	def get_similarity_ranking(story)
		word_scores = self.get_common_word_scores(story)

		#need to finish this method	
	end

end





