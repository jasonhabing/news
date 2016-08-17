class Newspaper < ActiveRecord::Base

	has_many :stories

	def get_feed
		Feedjira::Feed.fetch_and_parse self.main_rss_feed_url
	end

	def save_new_stories
		puts "Fetching stories for #{self.name}"
		begin
		if self.main_rss_feed_url.present?
			feed = self.get_feed
			puts "Found feed with #{feed.entries.count} entries.  First feed updated on #{feed.entries.first.published}."
			duplicates = 0
			uniques	= 0
			feed.entries.each do |entry|
				if (Story.exists?(:id => entry.id) || Story.exists?(:title => entry.title))  
					duplicates += 1
				else
		      		story = Story.new(
			        :title => entry.title, 
			        :url => entry.id, 
			        :summary => entry.summary,
			        :newspaper_id => self.id, 
			        )
			        story.save
			        uniques += 1
		      	end
			end
			puts "#{duplicates} stories already existed and were not duplicated.  Successfully created #{uniques} unique new stories."
		else
			puts "Did not update stories for #{self.name} - newspaper does not have an RSS feed entered in the database."
		end

		rescue Feedjira::NoParserAvailable
			puts "Can't parse #{self.name} -- ID: #{self.id} due to Feedjira::NoParserAvailable error"
		end
	end

	def show_stories
		news = self.stories
		stories.each do |s|
			puts "#{s.title}"
		end
	end



end
