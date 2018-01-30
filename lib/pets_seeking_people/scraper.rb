class PetsSeekingPeople::Scraper

  def self.scrape_index_page #(index_url)
  	#practice w/dog and cat html files and remove those before publishing
  	doc = Nokogiri::HTML(File.read("./assets/cats.html"))
    animals = []

  	doc.xpath("//td[@class='rgtkSearchResultsCell']").each do |animal|
  		animal_ID = animal.xpath(".//div[@class='rgtkSearchPetName']/a/@onclick").text.split(",")[1]
  		animals << {
	      		:name => animal.xpath(".//div[@class='rgtkSearchPetName']/a").text,
	      		:breed => animal.xpath(".//div[@class='rgtkSearchPetBreed']").text,
	      		:age => animal.xpath(".//div[@class='rgtkSearchPetBasicInfo']").text.split(" ")[0],
	      		:gender => animal.xpath(".//div[@class='rgtkSearchPetBasicInfo']").text.split(" ")[1],
	      		:animal_url	=> "https://www.aspca.org/adopt-pet/adoptable-cats-your-local-shelter#action_0=pet&animalID_0=#{animal_ID.strip}&petIndex_0=8"
  		}
  	end
  	animals
  end

  	# could also access each element directly, assuming 24 cells in table
    #  animal_number = 1
  	#  while animal_number <= 24
  	#    if doc.xpath("//*[@id='rgtkSearchPetName_#{animal_number}_0']/a").text == nil
  	# 		 return animals
  	# 	 else 
  	# 		 animal_ID = doc.xpath("//*[@id='rgtkSearchPetName_#{animal_number}_0']/a/@onclick").text.split(",")[1]
	  #   	 animals << {
	  #   		 :name => doc.xpath("//*[@id='rgtkSearchPetName_#{animal_number}_0']/a").text,
	  #   		 :breed => doc.xpath("//*[@id='rgtkSearchPetBreed_#{animal_number}_0']").text,
	  #   		 :age => doc.xpath("//*[@id='rgtkSearchPetBasicInfo_#{animal_number}_0']").text.split(" ")[0],
	  #   		 :gender => doc.xpath("//*[@id='rgtkSearchPetBasicInfo_#{animal_number}_0']").text.split(" ")[1],
	  #   		 :animal_url	=> "https://www.aspca.org/adopt-pet/adoptable-cats-your-local-shelter#action_0=pet&animalID_0=#{animal_ID.strip}&petIndex_0=8"
	  #   	}
	  #   	animal_number += 1

  def self.scrape_animal_page #(animal_url)
  	#update so this scrapes webpage 
  	profile_doc = Nokogiri::HTML(File.read("./assets/cat_instance.html"))
  	animal = {}
		
		about_animal_array = []
		profile_doc.xpath("//*[@id='rgtkPetInfoIndented_0']/li").each do |li|
			about_animal_array << li.text
		end

		detailed_info = []
		profile_doc.xpath("//*[@id='rgtkPetFieldDescription_0']/div[1]/p"). each do |paragraph|
			detailed_info << paragraph.text
		end
		detailed_info.delete_if {|paragraph| paragraph == " "}

		adoption_contact =[]
		adoption_contact << "Organization name: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgName_0']").text}" #org name
  	adoption_contact << "Address: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgAddress_0']").text}, #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgCitystatezip_0']").text}" #org address
  	adoption_contact << "Phone: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgPhone_0']").text}" #org phone
  	
  	
    animal[:info] = about_animal_array
    animal[:detailed_info] = detailed_info
    animal[:adoption_contact] = adoption_contact.join("; ")
    animal[:adoption_website] = profile_doc.xpath("//*[@id='rgtkPetFieldOrgUrl_0']/a").text #org website
    animal
  end
end 

