#  This defines methods on top of existing Rails objects such as Array, Float & String


class Array
  
  def sum
    return self.inject(0){|accum, i| accum + i }
  end

  def mean
    return self.sum / self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum + (i - m) ** 2 }
    return sum / (self.length - 1).to_f
  end

  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end

end


class Float
  def sqrt; Math.sqrt(self); end
  def sin; Math.sin(self); end
  def cos; Math.cos(self); end
  def tan; Math.tan(self); end
  def log10; Math.log10(self); end
end

class String

  # Example: "Olympics:".sanitize will return "olympics".  Function removes non-alphanumeric characters and lowercases the string.
  def sanitize
    self.downcase.gsub(/[^a-z0-9\s]/i, '')
  end

  # 
  def get_count(number_of_hours, previous_sets_to_compare)
    daily_numbers = []
    [*1..previous_sets_to_compare+1].each do |h|
     time_start = Time.now - (number_of_hours*h).hours
     time_end = Time.now - ((number_of_hours*h)-(1*number_of_hours)).hours
     word_count = Word.where("name = ? AND story_date > ? AND story_date <= ?", self, time_start, time_end).count
     daily_numbers << word_count
    end
    return daily_numbers
  end

  #Calculates t score of a word for a recent timeframe.  For example, "olmpics".get_t_score(24, 7) will get the t-score for the word count in the last 24 hours compared to the previous 7 24 hour periods.
  def get_t_score(number_of_hours, previous_sets_to_compare)
        current_count = Word.where("name = ? AND story_date > ? AND story_date <= ?", self, Time.now - number_of_hours.hours, Time.now).count
        word_counts = self.get_count(number_of_hours, previous_sets_to_compare)
        previous_mean = word_counts.drop(1).mean
        standard_deviation = word_counts.drop(1).standard_deviation
        sample_size = 7
        t_score = (current_count - previous_mean) / (standard_deviation / sample_size.to_f.sqrt)
        return t_score
  end

  # Example: "olympics".get_stores(24) will get all stories about the Olympics in the last 24 hours.
  def get_stories(number_of_hours)
    date_range_start = Time.now-number_of_hours.hours
    words = Word.where("name = ? and story_date > ?", self, date_range_start)
    stories = []
    words.each do |w|
      stories << w.story
    end 
    return stories
  end

  #  Example: "olympics".get_gravity(24, 10) should return a number indicating how likely it is this word is trending out of the ordinary volume.
  def get_gravity(hour_time_range, previous_sets_to_compare)
    t_score = self.get_t_score(hour_time_range, previous_sets_to_compare)
    current_c = Word.where("name = ? and story_date > ?", self.name, Time.now-24.hours).count
    if current_c > 3
         return t_score
    else
         return 0
    end
  end
  
  # Example: "olympics".get_info(24, 10) will return word counts, t-score & stories for the word over the last 24 hours compared to the last 10 24-hour periods.  This function is for diagnosing keywords.
  def get_info(hour_time_range, previous_sets_to_compare)
    counts = self.get_count(hour_time_range, previous_sets_to_compare)
    stories = self.get_stories(hour_time_range)
    mean = counts.mean
    standard_deviation = counts.standard_deviation
    t_score = self.get_t_score(hour_time_range, previous_sets_to_compare)
    puts ""
    puts "Word: #{self}"
    puts "Counts: #{counts}"
    puts "Mean: #{mean}"
    puts "Standard deviation: #{standard_deviation}"
    puts "T_score: #{t_score}"
    puts ""
    puts "Stories containing '#{self}' in last #{hour_time_range} hours:"
    stories.each do |s|
      puts "#{s.title}"
    end
    puts ""
    puts ""
    return nil
  end
end


