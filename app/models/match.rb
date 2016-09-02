class Match < ActiveRecord::Base

	validate :check_same_story

	def check_same_story
  	  errors.add(:match, "Can't create match for the same story") if story_one_id == story_two_id
	end
	
	def prompt_human_review
		story_one_title = Story.find(self.story_one_id).title
		story_two_title = Story.find(self.story_two_id).title
		puts ""
		puts "#{story_one_title}"
		puts ""
		puts "#{story_two_title}"
		puts ""
		puts "Do they match?"
		human_train_input = gets.to_i
		if human_train_input == 1
		  self.human_review = 1
		  self.save
		end
		if human_train_input == 0
		  self.human_review = 0
		  self.save
		end
		if human_train_input != 1 && human_train_input != 0
			puts "invalid input"
		end	
	end

	def info
		puts "#{Story.where(:id => self.story_one_id).first.title} | #{Story.where(:id => self.story_one_id).first.id}"
		puts "#{Story.where(:id => self.story_two_id).first.title} | #{Story.where(:id => self.story_two_id).first.id}"
	end

end
