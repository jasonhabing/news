# lib/tasks/parse_stories.rake

desc 'Populate words database from stories'
task :parse_stories  => :environment do
	stories_in_queue = Story.where("parsed_date IS NULL")
	if stories_in_queue.count == 0
		puts "no stories in the queue."
 	else
		stories_in_queue.each do |s|
			s.parse
		end
	end
end