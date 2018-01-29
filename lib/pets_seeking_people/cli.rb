class PetsSeekingPeople::CLI

  def call
  	puts "Welcome! If you're looking for a dog, type 'dog'. If you're looking for a cat, type 'cat'."
  	pet_input = gets.strip.downcase
		puts "What is your zip code?"
		zip_input = gets.strip
		list_pets(pet_input, zip_input)
		menu
	end

	def list_pets(pet_input, zip_input)
		#runs scraper
  	puts "These pets are available for adoption in your area"
  	puts <<~HEREDOC
  		Charlie
  		Rex
  		Earl
  	HEREDOC

	end

	def menu
		puts "Enter the number of the pet you'd like more info on:"
	end

end