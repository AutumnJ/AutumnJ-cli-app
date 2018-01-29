class PetsSeekingPeople::Pets

	attr_accessor :name, :breed, :age, :gender, :organization_url

	def self.available
		#Scrape website and create new available pets based on that

  	pet_1 = self.new
  	pet_1.name = "Charlie"
  	pet_1.breed = "Domestic Short-hair"
  	pet_1.age = "Young"
  	pet_1.gender = "Male"
  	pet_1.organization_url = "http://www.starfishanimalrescue.com/"

  	pet_2 = self.new
  	pet_2.name = "Rex"
  	pet_2.breed = "Yorkshire Terrier Mix"
  	pet_2.age = "Adult"
  	pet_2.gender = "Male"
  	pet_2.organization_url = "http://www.romprescue.com/"

  	[pet_1, pet_2]

	end


end

