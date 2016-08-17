# lib/tasks/fetch_stories.rake

desc 'Fetch all news stories from all newspapers listed in the database.'
task :fetch_stories => :environment do
	puts "Beginning story download for #{Newspaper.count} newspapers..."  
	Newspapers.each do |newspaper|
		puts "Beginning download for #{newspaper.name}"
		feed = Feedjira::Feed.fetch_and_parse newspaper.main_rss_feed_url
		feed.entries.each do |entry|
			story = Story.new 
			story.title = entry.title
			story.url = entry.id
			story.summary = entry.content.scan(/<p>([^<>]*)<\/p>/imu).flatten[0]
			story.newspaper_id = newspaper.id
			story.save
		end
	end 
end