# lib/tasks/top_stories.rake

desc 'Get top stories based on t_value of words'
task :top_stories  => :environment do
	lookback = Time.now-24.hours
	words = Word.where("story_date > ?", lookback)
	words_and_gravity =  Hash.new
	puts "Calculating t_scores..."
	total_words_to_process = words.count
	completed_words = 0
	words.each do |w|
		words_and_gravity[w.name] = w.get_gravity(24, 10)
		completed_words += 1 
		completed_word_percentage = (completed_words/total_words_to_process.to_f*100) 
		puts "#{completed_word_percentage}"
	end
  	words_and_gravity = words_and_gravity.sort_by {|k,v| v}.reverse
	words_and_gravity.each do |w|
		puts "#{w[0]} -- #{w[1]}"
	end
end