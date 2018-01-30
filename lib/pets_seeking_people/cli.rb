# This is the toolkit key for cats as of 1/30/18. It may change. toolkitKey=6REv6Spa
# This is the toolkit key for dogs as of 1/30/18. It may change. toolkitKey=zu8atrEs
# Adjust toolkit keys on line 50 as needed. 

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
		pet_input == "cat" ? pet_type_input = "6REv6Spa" : pet_type_input = "zu8atrEs"
		animals_array = PetsSeekingPeople::Scraper.scrape_index_page("https://toolkit.rescuegroups.org/j/3/grid1_layout.php?&location_0=#{zip_input}&toolkitIndex=0&toolkitKey=#{pet_type_input}", pet_type_input)
		PetsSeekingPeople::Pets.create_from_collection(animals_array)
	end

	def add_info_about_pet(pet_number)
		  search_pet = PetsSeekingPeople::Pets.all[pet_number]
		  if !PetsSeekingPeople::Pets.all[pet_number].info 
				info = PetsSeekingPeople::Scraper.scrape_animal_page(search_pet.animal_url)
				search_pet.add_animal_attributes(info)
			end
	end

	def list_pets
			puts ""
  	  puts "-------These pets are available for adoption in your area:-------"
  	  puts ""
  	  PetsSeekingPeople::Pets.all.each.with_index(1) do |pet, i|
  		  puts "#{i}. #{pet.name} - #{pet.breed} - #{pet.age} - #{pet.gender}"
		end
	end

	def list_details(pet_number)
		add_info_about_pet(pet_number)
		pet = PetsSeekingPeople::Pets.all[pet_number]
		puts ""
		puts "-------------------Here's info on #{pet.name}:-------------------"
		puts ""
		puts "Some deets you should know: #{pet.info}"
		puts ""
		puts "------------------------------------------------------------------"
		puts ""
		puts "If you want to adopt #{pet.name}, contact: #{pet.adoption_contact}"
		puts ""
		puts "------------------------------------------------------------------"
		puts ""
		puts "For more details on #{pet.name}, go to: #{pet.adoption_website}"
	end

	def menu
		input = nil
		if input == "exit"
			farewell
		else 
			while input != 'exit'
			puts ""
			puts "-------------------------------Menu-------------------------------"
			puts "Enter the number of the pet you'd like more info."
			puts "Or type 'list' to see the list of available pets again."
			puts "Or type 'exit' to exit."
			puts "------------------------------------------------------------------"
			puts ""
			input = gets.strip.downcase

				if input.to_i > 0 && input.to_i <= 24
					pet_number = input.to_i-1
					list_details(pet_number)
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