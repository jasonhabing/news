class Word < ActiveRecord::Base

belongs_to :story

     #Calculates count of words used in recent timeframe.  For example, get_hourly_count(24, 7) will product an array of the count of the word for the last 7 24-hour periods.
	def get_hourly_count(number_of_hours, previous_sets_to_compare)
          daily_numbers = []
          puts "#{daily_numbers} is daily numbers"
          [*1..previous_sets_to_compare].each do |h|
               time_start = Time.now - (number_of_hours*h).hours
               time_end = Time.now - ((number_of_hours*h)-(1*number_of_hours)).hours
               count = Word.where("name = ? AND story_date > ? AND story_date <= ?", self.name, time_start, time_end).count
               puts "#{count} is count"
               daily_numbers << count
          end
          return daily_numbers
     end

     #Calculates t score of a word for a recent timeframe.  For example, get_t_score(24, 7) will get the t-score for the word count in the last 24 hours compared to the previous 7 24 hour periods.
     def get_t_score(hour_time_range, previous_sets_to_compare)
          current_count = Word.where("name = ? AND story_date > ? AND story_date <= ?", self.name, Time.now - hour_time_range.hours, Time.now).count
          word_counts = self.get_hourly_count(hour_time_range, previous_sets_to_compare)
          previous_mean = word_counts.drop(1).mean
          standard_deviation = word_counts.drop(1).standard_deviation
          sample_size = 7
          t_score = (current_count - previous_mean) / (standard_deviation / sample_size.to_f.sqrt)
          puts "details-- word|#{self.name}    daily word counts|#{word_counts}  mean|#{previous_mean}   standard deviation | #{standard_deviation}    sample_size | #{sample_size}   t score | #{t_score}"
          return t_score
     end

end
