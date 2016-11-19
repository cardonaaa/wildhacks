require 'Nokogiri'
require 'json'
require 'open-uri'

states = { "Alabama" => "AL" , "Alaska" => "AK", "Arizona" => "AZ", "Arkansas" => "AR",
"California" => "CA" , "Colorado" => "CO",  "Connecticut" => "CT", "Delaware" => "DE",
"District Of Columbia" => "DC", "Florida" => "FL", "Georgia" => "GA", "Hawaii" => "HI",
"Idaho" => "ID", "Illinois" => "IL", "Indiana" => "IN", "Iowa" => "IA", "Kansas" => "KS",
"Kentucky" => "KY", "Louisiana" => "LA", "Maine" => "ME", "Maryland" => "MD",
"Massachusetts" => "MA", "Michigan" => "MI", "Minnesota" => "MN", "Mississippi" => "MS",
"Missouri" => "MO", "Montana" => "MT", "Nebraska" => "NE", "Nevada" => "NV",
"New Hampshire" => "NH", "New Jersey" => "NJ", "New Mexico" => "NM", "New York" => "NY",
"North Carolina" => "NC", "North Dakota" => "ND", "Ohio" => "OH", "Oklahoma" => "OK",
"Oregon" => "OR", "Pennsylvania" => "PA", "Puerto Rico" => "PR", "Rhode Island" => "RI",
"South Carolina" => "SC", "South Dakota" => "SD", "Tennessee" => "TN", "Texas" => "TX",
"Utah" => "UT",  "Vermont" => "VT", "Virginia" => "VA", "Washington" => "WA",
"West Virginia" => "WV", "Wisconsin" => "WI", "Wyoming" => "WY" }

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

def jstreet_webscrap()
    url = 'http://jstreet.org/members-congress-condemned-bannons-appointment/'
    parse_page = Nokogiri::HTML(open(url))
    table = parse_page.css("nav.tableOfContents li")
    table.each { |li|
        temp = li.text.strip()[5..-1]
    }
end

jstreet_webscrap()