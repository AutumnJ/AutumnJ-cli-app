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

  	# could also access in a more unclear way...
    #  animal_number = 1
  	# while animal_number <= 24
  	# 	if doc.xpath("//*[@id='rgtkSearchPetName_#{animal_number}_0']/a").text == nil
  	# 		return animals
  	# 	else 
  	# 		animal_ID = doc.xpath("//*[@id='rgtkSearchPetName_#{animal_number}_0']/a/@onclick").text.split(",")[1]
	  #   	animals << {
	  #   		:name => doc.xpath("//*[@id='rgtkSearchPetName_#{animal_number}_0']/a").text,
	  #   		:breed => doc.xpath("//*[@id='rgtkSearchPetBreed_#{animal_number}_0']").text,
	  #   		:age => doc.xpath("//*[@id='rgtkSearchPetBasicInfo_#{animal_number}_0']").text.split(" ")[0],
	  #   		:gender => doc.xpath("//*[@id='rgtkSearchPetBasicInfo_#{animal_number}_0']").text.split(" ")[1],
	  #   		:animal_url	=> "https://www.aspca.org/adopt-pet/adoptable-cats-your-local-shelter#action_0=pet&animalID_0=#{animal_ID.strip}&petIndex_0=8"
	  #   	}
	  #   	animal_number += 1

  def self.scrape_animal_page #(animal_url)
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

		adoption_contact =[]
		adoption_contact << "Organization name: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgName_0']").text}" #org name
  	adoption_contact << "Address: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgAddress_0']").text}, #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgCitystatezip_0']").text}" #org address
  	adoption_contact << "Phone: #{profile_doc.xpath("//*[@id='rgtkPetFieldOrgPhone_0']").text}" #org phone
  	
  	
    animal[:info] = about_animal_array
    animal[:detailed_info] = detailed_info.join("\n")
    animal[:adoption_contact] = adoption_contact.join("; ")
    animal[:adoption_website] = profile_doc.xpath("//*[@id='rgtkPetFieldOrgUrl_0']/a").text #org website
    animal
    binding.pry
  end

end 

#doc.xpath("//*[@id='rgtkSearchResultsTable_0']//tr") => access row

#doc.xpath("//*[@id='rgtkSearchResultsTable_0']") => search results table
#doc.xpath("//*[@id='rgtkSearchResultsTable_0']/tbody/tr[1]/td[1]") => container (use counter to increment)
#doc.xpath("//*[@id='rgtkSearchResultsTable_0']/tbody/tr[3]/td[1]") => animal 1 in row 2
#three columns across; placeholder row in between each row
#doc.xpath("//*[@id='rgtkSearchPetName_1_0']/a") => NEED INFO FROM ONCLICK
#doc.xpath("//*[@id='rgtkSearchPetName_10_0']/a/@onclick") = gets onclick
# doc.xpath("//*[@id='rgtkSearchPetName_10_0']/a/@onclick").text.split(",")[1] => gets URL input
#doc.xpath("//*[@id='rgtkSearchPetName_1_0']/a").text => animal name
#doc.xpath("//*[@id='rgtkSearchPetBreed_1_0']").text => animal breed
#doc.xpath("//*[@id='rgtkSearchPetBasicInfo_1_0']").text => animal age & gender
#doc.xpath("//*[@id='rgtkSearchPetBasicInfo_1_0']").text.split(" ")[0] => animal age
#doc.xpath("//*[@id='rgtkSearchPetBasicInfo_1_0']").text.split(" ")[1] => animal gender


