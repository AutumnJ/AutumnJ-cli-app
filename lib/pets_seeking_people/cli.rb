class PetsSeekingPeople::CLI

	#@@pets = []

  def call
  	puts "Welcome! If you're looking for a dog, type 'dog'. If you're looking for a cat, type 'cat'."
    pet_input = gets.strip.downcase
	    if !valid_pet_input?(pet_input)
	  		self.call
	  	end

		puts "What is your zip code?"
		zip_input = gets.strip
		  if !/\A\d+\z/.match(zip_input) || zip_input.size > 5
		   call
		  end
		list_pets(pet_input, zip_input)
		menu
		farewell
	end

	def valid_pet_input?(pet_input)
		pet_input == "cat" || pet_input == "dog"
	end

	def list_pets(pet_input, zip_input)
		#runs scraper w/ different URL depending on pet_input
		# pet_input == "cat" ? url = CATURL : url = DOGURL
		#interpolate URL
		#dog w/ zip: https://www.aspca.org/adopt-pet/adoptable-dogs-your-local-shelter#petfocus_0=&page_0=1&breed_0=&sex_0=&distance_0=25&location_0=60618&action_0=search
		#cat w/ zip: https://www.aspca.org/adopt-pet/adoptable-cats-your-local-shelter#petfocus_0=&page_0=1&breed_0=&sex_0=&distance_0=25&location_0=60618&action_0=search
  	puts "These pets are available for adoption in your area"
  	@pets = PetsSeekingPeople::Pets.available
  	@pets.each.with_index(1) { |pet, i| puts "#{i}. #{pet.name} - #{pet.breed} - #{pet.age}"}
	end

	def menu
		input = nil
		while input != 'exit'
			puts "Enter the number of the pet you'd like more info."
			puts "Or type 'list' to see the list of available pets again."
			puts "Or type 'exit' to exit."
			input = gets.strip.downcase

			if input.to_i > 0 #strings converted to i convert to 0
				puts @pets[input.to_i-1]
			elsif input == "list"
				@pets.each.with_index(1) { |pet, i| puts "#{i}. #{pet.name} - #{pet.breed} - #{pet.age}"}
			else
				puts "Not sure what you want? Type 'list' to see available animals and then adopt them all!"
			end

		end
	end

	def farewell
		puts "Thanks for considering giving a lovely pet a home! Visit again soon."
		puts " ▼・ᴥ・▼ "

	end

end