# lib/tasks/test_matching.rake

desc 'Test matching algorithm'
task :test_matching  => :environment do
	stories_to_match = 200
	stories = Story.last(stories_to_match)
	story_match_scores = []
	checked = 0
	stories.each do |s|
		puts "#{checked} / #{stories_to_match} checked"
			stories.each do |s1|
				unless s == s1
					newspapers = []
					newspapers << s.newspaper_id
					newspapers << s1.newspaper_id
					common_words = s.get_common_words(s1)
					common_word_scores = []
					common_words.each do |c|
						common_word_scores << c.frequency(48)
					end
					score = s.similar(s1)
					score_info = []
					score_info << s.title
					score_info << s1.title
					score_info << score	
					score_info << common_words
					score_info << common_word_scores
					score_info << newspapers
					story_match_scores << score_info
				end
			end
		checked = checked + 1
	end
	sorted_match_rates = story_match_scores.sort {|a,b| a[2] <=> b[2]}

	sorted_match_rates.each do |s|
		puts ""
		puts "#{s[0]}"
		puts "#{s[1]}"
		puts "#{s[2]}"
		puts "#{s[3]}"
		puts "#{s[4]}"
		puts "#{s[5]}"
	end

end