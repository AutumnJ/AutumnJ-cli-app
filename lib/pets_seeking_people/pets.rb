class PetsSeekingPeople::Pets

	attr_accessor :name, :breed, :age, :gender, :organization_url

	def self.available
		puts <<~HEREDOC
  		1. Charlie
  		2. Rex
  		3. Earl
  	HEREDOC

  	pet_1 = self.new
  	pet_1.name = "Charlie"
  	pet_1.breed = "Domestic Short-hair"
  	pet_1.age = "Young"
  	pet_1.gender = "Male"
  	pet_1.organization_url = "http://www.starfishanimalrescue.com/"

  	pet_2


	end


end

