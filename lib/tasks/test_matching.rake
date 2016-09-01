# lib/tasks/test_matching.rake

desc 'Test matching algorithm'
task :test_matching  => :environment do
	stories_to_match = 100
	stories = Story.last(stories_to_match)
	story_match_scores = []
	checked = 0
	stories.each do |s|
		puts "#{checked} / #{stories_to_match} checked"
		stories.each do |s1|
			score = s.similar(s1)
			score_info = []
			score_info << s.title
			score_info << s1.title
			score_info << score	
			story_match_scores << score_info
		end
		checked = checked + 1
	end
	sorted_match_rates = story_match_scores.sort {|a,b| a[2] <=> b[2]}

	sorted_match_rates.each do |s|
		puts ""
		puts "#{s[0]}"
		puts "#{s[1]}"
		puts "#{s[2]}"
	end

end