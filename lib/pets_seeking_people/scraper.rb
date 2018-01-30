class PetsSeekingPeople::Scraper

  def self.scrape_index_page(index_url, pet_type_input)
  	doc = Nokogiri::HTML(open(index_url))
    animals = []

  	doc.xpath("//td[@class='rgtkSearchResultsCell']").each do |animal|
  		animal_ID = animal.xpath(".//div[@class='rgtkSearchPetName']/a/@onclick").text.split(",")[1]
  		animals << {
	      		:name => animal.xpath(".//div[@class='rgtkSearchPetName']/a").text,
	      		:breed => animal.xpath(".//div[@class='rgtkSearchPetBreed']").text,
	      		:age => animal.xpath(".//div[@class='rgtkSearchPetBasicInfo']").text.split(" ")[0],
	      		:gender => animal.xpath(".//div[@class='rgtkSearchPetBasicInfo']").text.split(" ")[1],
	      		:animal_url	=> "https://toolkit.rescuegroups.org/j/3/pet1_layout.php?toolkitIndex=0&toolkitKey=#{pet_type_input}&animalID=#{animal_ID.strip}"
  		}
  	end
  	animals
  end

  def self.scrape_animal_page(animal_url)
  	profile_doc = Nokogiri::HTML(open(animal_url))
  	animal = {}
		
		about_animal_array = []
		profile_doc.xpath("//*[@id='rgtkPetInfoIndented_0']/li").each do |li|
			about_animal_array << li.text
		end

		# ------Aesthetically, this is a lot of info to display in the terminal-----
		# detailed_info = []
		# profile_doc.xpath("//*[@id='rgtkPetFieldDescription_0']/div[1]/p"). each do |paragraph|
		# 	detailed_info << paragraph.text
		# end
		# detailed_info.delete_if {|paragraph| paragraph == " "}

		adoption_contact =[]
		adoption_contact << "Organization name: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgName_0']").text}" #org name
  	
	  adoption_address = []
  	if profile_doc.xpath("//*[@id='rgtkPetFieldOrgAddress_0']").text.size > 3
  	  adoption_address << "Address: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgAddress_0']").text}"
  	end
  	if profile_doc.xpath("//*[@id='rgtkPetFieldOrgCitystatezip_0']").text.size > 3
  		adoption_address << "#{profile_doc.xpath("//*[@id='rgtkPetFieldOrgCitystatezip_0']").text}" #org address
  	end
  	adoption_contact << adoption_address.join(", ")


  	if profile_doc.xpath("//*[@id='rgtkPetFieldOrgPhone_0']").text.size > 3
  	  adoption_contact << "Phone: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgPhone_0']").text}" #org phone
  	end

    animal[:info] = about_animal_array
    #animal[:detailed_info] = detailed_info
    animal[:adoption_contact] = adoption_contact.join("; ")
    animal[:adoption_website] = profile_doc.xpath("//*[@id='rgtkPetFieldOrgUrl_0']/a").text #org website
    animal
  end
end 

