class PetsSeekingPeople::Scraper

  def self.scrape_index_page
  	#practice w/dog and cat html files and remove those before publishing
  	doc = Nokogiri::HTML(File.read("./assets/cats.html"))
    binding.pry
  animals = [] # returns an array of hashes
  #access container
  #within each container obtain info on animal
  # animals << {
  	# :name =>
  	# :breed =>
  	# :age =>
  	# :gender =>
  	# :details_url => can I determine this easily? URL - insert animal ID
	#}
	#return animals

  end

  def self.scrape_animal_page(animal_url)

  animal = {}

  end

end 


#//*[@id="rgtkSearchPetName_1_0"]

#//*[@id="rgtkSearchContainer_0"]


	#   pet_1 = self.new
 #  	pet_1.name = "Charlie"
 #  	pet_1.breed = "Domestic Short-hair"
 #  	pet_1.age = "Young"
 #  	pet_1.gender = "Male"
 #  	pet_1.organization_url = "http://www.starfishanimalrescue.com/"

 #  	pet_2 = self.new
 #  	pet_2.name = "Rex"
 #  	pet_2.breed = "Yorkshire Terrier Mix"
 #  	pet_2.age = "Adult"
 #  	pet_2.gender = "Male"
 #  	pet_2.organization_url = "http://www.romprescue.com/"

 #  	[pet_1, pet_2]

