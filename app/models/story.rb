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

	def get_common_words(story)
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
			return common_words
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
				word_t_score = Word.where(:name => c).last.name.get_t_score(24, 10)
				common_word_t_scores << word_t_score
			end
		end
		return common_word_t_scores
	end

	def similar(story)
		common_words = self.get_common_words(story)
		story_length_mean = ((self.title.split.size)+(story.title.split.size))/2
		rarity_boost = 1
		common_words.each do |c|
 		  score = 1.01**((0.0306-c.frequency(48))/0.0005)  #0.03 should be replaced with most frequent word frequency
 		  rarity_boost = rarity_boost * score
		end
		score = (common_words.count).to_f / (story_length_mean).to_f * rarity_boost.to_f
	end	

	# Story.get_words_by_t_score(10) will return a hash with t_scores for the last 10 hours.
	def get_all_t_scores(lookback_window)
		stories = Story.where("created_at > ?", Time.now - lookback_window.hours)
		words_and_t_scores = Hash.new
		total_stories_to_process = stories.count
		puts "Calculating t_scores for #{total_stories_to_process} stories..."
		completed_stories = 0
		stories.each do |s| 
			s.words.each do |w|
				words_and_t_scores[w.name] = w.name.get_t_score(24, 10)
			end
			completed_stories += 1  
			puts "Completed #{completed_stories} of #{total_stories_to_process} total stories to process."
		end
		words_and_t_scores = words_and_t_scores.sort_by {|k,v| v}.reverse
		return words_and_t_scores
	end
	
end





