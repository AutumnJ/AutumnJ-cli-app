class PetsSeekingPeople::Scraper

  def self.scrape_index_page
  	doc = Nokogiri::HTML(open("https://www.aspca.org/adopt-pet/adoptable-cats-your-local-shelter#petfocus_0=&page_0=1&breed_0=&sex_0=&distance_0=25&location_0=60618&action_0=search"))
    binding.pry
  animals = []


  end

  def self.scrape_animal_page(animal_url)

  animal = {}

  end

end 



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

