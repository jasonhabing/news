class Newspaper < ActiveRecord::Base

	has_many :stories

	def get_feed
		Feedjira::Feed.fetch_and_parse self.main_rss_feed_url
	end

	def save_new_stories
		puts "Fetching stories for #{self.name}"
		if self.main_rss_feed_url.present?
			feed = self.get_feed
			puts "Found feed with #{feed.entries.count} entries.  First feed updated on #{feed.entries.first.published}."
			feed.entries.each do |entry|
				unless Story.exists?(:id => entry.id)
		      	unless Story.exists?(:title => entry.title)  
		      		story = Story.new(
			        :title => entry.title, 
			        :url => entry.id, 
			        :summary => entry.summary,
			        :newspaper_id => self.id, 
			        )
			        story.save
			        puts "saved news story #{story.title} "
		      	end
		      	end
			end
		else
			puts "Did not update stories for #{self.name} - newspaper does not have an RSS feed."
		end
	end

	def show_stories
		news = self.stories
		stories.each do |s|
			puts "#{s.title}"
		end
	end

	

end
