class PetsSeekingPeople::CLI

	attr_accessor :pet_input, :zip_input

	#@@pets = []

  def call
  	puts "Welcome to pets seeking people!"
  	pet_type
  	zip
  	find_available_pets
  	add_info_about_pets
		list_pets
		menu
		farewell
	end

	def pet_type
		puts "If you're looking for a dog, type 'dog'. If you're looking for a cat, type 'cat'."
    @pet_input = gets.strip.downcase
	    if !valid_pet_input?(pet_input)
	    	puts "While that's a lovely animal (or a typo), it's not an option."
	  		self.pet_type
	  	end
	end

	def zip
		puts "What is your zip code?"
		@zip_input = gets.strip
		  if !valid_zip_code?(zip_input)
		  	puts "Oops, not a valid zip!"
		    self.zip
		  end
	end

	def valid_pet_input?(pet_input)
		pet_input == "cat" || pet_input == "dog"
	end

	def valid_zip_code?(zip_input)
    /\A\d+\z/.match(zip_input) && zip_input.size == 5
	end

	def find_available_pets
		animals_array = Scraper.scrape_index_page("./assets/dogs.html")
		#animals_array = Scraper.scrape_index_page("https://www.aspca.org/adopt-pet/adoptable-#{pet_type+"s"}-your-local-shelter#petfocus_0=&page_0=1&breed_0=&sex_0=&distance_0=25&location_0=#{zip_input}&action_0=search")
		Pets.create_from_collection(animals_array)
	end

	def add_info_about_pets
		Pets.all.each do |pet|
			info = Scraper.scrape_animal_page(animal.animal_url)
			pet.add_animal_attributes(info)
		end
	end

	def list_pets
  	puts "These pets are available for adoption in your area"
  	Pets.all.each.with_index(1) do |pet, i|
  		puts "#{i}. #{pet.name} - #{pet.breed} - #{pet.age} - #{pet.gender}"}
		end
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