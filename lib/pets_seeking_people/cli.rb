class PetsSeekingPeople::CLI

  attr_accessor :pet_input, :zip_input

  def call
  	puts "Welcome to pets seeking people!"
  	pet_type
  	zip
  	find_available_pets
	    if PetsSeekingPeople::Pets.all == []
	    	puts ""
			  puts "Sad day for you - there are no pets in your area up for adoption. You adopted them all!"
			  farewell
			else
				list_pets
				menu
				farewell
			end
	end

	def pet_type
		puts "If you're looking for a dog, type 'dog'. If you're looking for a cat, type 'cat'."
    @pet_input = gets.strip.downcase
	    if !valid_pet_input?(pet_input)
	    	puts ""
	    	puts "While that's a lovely animal (or a typo), it's not an option."
	  		self.pet_type
	  	end
	end

	def zip
		puts "What is your zip code?"
		@zip_input = gets.strip
		  if !valid_zip_code?(zip_input)
		  	puts ""
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
		animals_array = PetsSeekingPeople::Scraper.scrape_index_page(zip_input, pet_input)
		PetsSeekingPeople::Pets.create_from_collection(animals_array)
	end

	def add_info_about_pet(list_pet)
		  if !list_pet.info 
				info = PetsSeekingPeople::Scraper.scrape_animal_page(list_pet.animal_url)
				list_pet.add_animal_attributes(info)
			end
	end

	def list_pets
			puts ""
  	  puts "---------- These pets are available for adoption in your area: ----------"
  	  puts ""
  	  PetsSeekingPeople::Pets.all.each.with_index(1) do |pet, i|
  		  puts "#{i}. #{pet.name} - #{pet.breed} - #{pet.age} - #{pet.gender}"
		end
	end

	def list_details(list_pet)
		add_info_about_pet(list_pet)
		puts ""
		puts "-------------------  Here's info on #{list_pet.name}:  ---------------------"
		puts ""
		puts "Some deets you should know:"
		list_pet.info.each {|pet_fact| puts "#{pet_fact}"}
		puts ""
		puts "--------------------------------------------------------------------------"
		puts ""
		puts "If you want to adopt #{list_pet.name}, contact:"
		list_pet.adoption_contact.each {|contact| puts "#{contact}"}
		puts ""
		puts "--------------------------------------------------------------------------"
		puts ""
		puts "For more details on #{list_pet.name}, go to: #{list_pet.adoption_website}"
	end

	def menu
		input = nil
		if input == "exit"
			farewell
		else 
			while input != 'exit'
			puts ""
			puts "---------------------------------- Menu ----------------------------------"
			puts "Enter the number of the pet you'd like more info."
			puts "Or type 'list' to see the list of available pets again."
			puts "Or type 'exit' to exit."
			puts "--------------------------------------------------------------------------"
			puts ""
			input = gets.strip.downcase

				if input.to_i > 0 && input.to_i <= PetsSeekingPeople::Pets.all.size
					list_pet = PetsSeekingPeople::Pets.find(input)
					list_details(list_pet)
				elsif input == "list"
					list_pets
				end
			end
		end
	end

	def farewell
		puts ""
		puts "Thanks for considering giving a lovely pet a home! Visit again soon."
		puts " ▼・ᴥ・▼ "
		puts ""
	end

end