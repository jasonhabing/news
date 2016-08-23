# lib/tasks/diagnose.rake

desc 'Run diagnostics on the story fetching job'
task :diagnose => :environment do

	puts "Total Stories --- #{Story.all.count}"
	puts ""

	Newspaper.all.each do |n|
		if n.stories.exists?
			added_date = n.stories.last.created_at
		else
			added_date = "never fetched a story."
		end

		puts "#{n.name}"
		puts "Total Stories: #{n.stories.count}"
		if added_date == "never fetched a story."
			puts "Last Story Added: Never added a story".red
		else
			if added_date < 2.hours.ago
			puts "Last Story Added: #{added_date}".red
			else
			puts "Last Story Added: #{added_date}"
			end
		end
		puts ""
	end

end