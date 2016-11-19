require 'Nokogiri'
require 'json'
require 'open-uri'

class Politician
    def initialize(name, party, phone, state, position)
        @name = name
        @party = party
        @phone = phone
        @state = state
        @position = position
    end
end

def webscrap()
    
    url = 'http://www.house.gov/representatives/'
    parse_page = Nokogiri::HTML(open(url))
    state_list = parse_page.css("tbody")
    
    reps = Hash.new
    (0..55).each do |i|
        state = states[parse_page.css("h2")[i+1].text]
        if state_list[i].css("tr")
            state_list[i].css("tr").each do |s|
                name = s.css("td")[1].text.gsub(/\s+/, "")
                party = s.css("td")[2].text
                phone = s.css("td")[4].text
                
                p = Politician.new(name, party, phone, state, 'Rep')
                reps[name] = p
                puts name

            end
        end
    end
    
    senators_url = 'www.senate.gov/general/contact_information/senators_cfm.cfm'
    senate_page = Nokogiri::HTML(open(url))
    
    for i in (0..300).step(3)
        
        name = senate_page.css("td.contenttext[align='left']")[0].text.split("\n")[0]
        party = senate_page.css("td.contenttext[align='left']")[i].text.split("\n")[2].gsub(/[^0-9A-Za-z ]/, '').split(" ")[0]
        state = senate_page.css("td.contenttext[align='left']")[i].text.split("\n")[2].gsub(/[^0-9A-Za-z ]/, '').split(" ")[1]
        number = senate_page.css("td.contenttext[align='left']")[i+1].text
        
        p = Politician.new(name, party, phone, state, 'Sen')
        reps[name] = p
        puts name
    end
    
    return reps
end

webscrap()