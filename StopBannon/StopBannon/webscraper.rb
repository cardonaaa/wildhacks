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
    
    state = ""
    reps = Hash.new
    for i in 0..50
        state = state_list.css("h2")[i+1].text
        puts state_list[i].css("tr").length
        if state_list[i].css("tr")
            state_list[i].css("tr").each do |s|
                name = i.css("td")[1].text.gsub(/\s+/, "")
                party = i.css("td")[2].text
                phone = i.css("td")[4].text
                
                if !/District/.match(name) and !/At-Large/.match(name)
                    p = Politician.new(name, party, phone, state, 'Rep')
                    reps[name] = p
                    puts name
                    puts state
                end
            end
        end
    end

end

webscrap()