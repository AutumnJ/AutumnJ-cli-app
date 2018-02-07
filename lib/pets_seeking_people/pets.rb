class PetsSeekingPeople::Pets

  attr_accessor :name, :breed, :age, :gender, :animal_url, :info, :detailed_info, :adoption_contact, :adoption_website

	@@all = []

	def initialize(animal_hash)
		animal_hash.each {|key, value| self.send(("#{key}="), value)}
		@@all << self
	end

	def self.create_from_collection(animals_array)
		animals_array.each do |animal|
			PetsSeekingPeople::Pets.new(animal)
		end
	end

	def add_animal_attributes(attributes_hash)
		attributes_hash.each {|key, value| self.send(("#{key}="), value)}
		self
	end

	def self.all
		@@all
	end

	def self.find(input)
		self.all[input.to_i-1]
	end

end

