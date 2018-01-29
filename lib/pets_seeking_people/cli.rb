class PetsSeekingPeople::CLI

  def call
  	puts "Welcome! If you're looking for a dog, type 'dog'. If you're looking for a cat, type 'cat'."
  	pet_input = gets.strip.downcase
		puts "What is your zip code?"
		zip_input = gets.strip
		list_pets(pet_input, zip_input)
		menu
		farewell
	end

	def list_pets(pet_input, zip_input)
		#runs scraper
  	puts "These pets are available for adoption in your area"
  	puts <<~HEREDOC
  		1. Charlie
  		2. Rex
  		3. Earl
  	HEREDOC

	end

	def menu
		input = nil
		while input != 'exit'
			puts "Enter the number of the pet you'd like more info on or type 'exit' to exit:"
			input = gets.strip.downcase
			case input
		  when "1"
		  	"Here's their info..."
		#display info on selected animal based on number
			end
		end
	end

	def farewell
		puts "Thanks for considering giving a lovely pet a home! Visit again soon."
		puts " ▼・ᴥ・▼ "

	end

end