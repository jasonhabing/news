# lib/tasks/create_matches.rake

desc 'Create matches with algorithm'
task :create_matches  => :environment do
	stories_to_match = 100
	stories = Story.last(stories_to_match)
	story_match_scores = []
	checked = 0
	stories.each do |s|
		stories.each do |s1|
			unless s.same_story?(s1) || s.same_newspaper?(s1)
				s.algorithm_test(s1)
			end
		end
		checked = checked + 1
		puts "#{checked} of #{stories.count} checked"
	end
end