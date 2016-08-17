# lib/tasks/fetch_stories.rake

desc 'Fetch all news stories from all newspapers listed in the database.'
task :fetch_stories => :environment do
	puts "Beginning story download for #{Newspaper.count} newspapers..."  
	Newspaper.all.each do |n|
		n.save_new_stories
	end 
end