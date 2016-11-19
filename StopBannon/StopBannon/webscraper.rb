require 'Nokogiri'
require 'json'
require 'open-uri'
require 'csv'

$states = { "Alabama" => "AL" , "Alaska" => "AK", "Arizona" => "AZ", "Arkansas" => "AR",
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
        @denounced = false
    end
end

$all_politicians = []

def webscrap()
    
    url = 'http://www.house.gov/representatives/'
    parse_page = Nokogiri::HTML(open(url))
    state_list = parse_page.css("tbody")
    
    reps = Hash.new
    (0..55).each do |i|
        state = $states[parse_page.css("h2")[i+1].text]
        if state_list[i].css("tr")
            state_list[i].css("tr").each do |s|
                name = s.css("td")[1].text.gsub(/\s+/, "")
                party = s.css("td")[2].text
                phone = s.css("td")[4].text
                
                p = Politician.new(name, party, phone, state, 'Rep')
                reps[name] = p
                puts name
                $all_politicians.push([name, party, phone, state, 'Rep', false])

            end
        end
    end
    
    senators_url = 'http://www.senate.gov/senators/contact/'
    senate_page = Nokogiri::HTML(open(senators_url))
    
    for i in (0..299).step(3)
        name = senate_page.css("td.contenttext[align='left']")[i].text.split("\n")[0]
        party = senate_page.css("td.contenttext[align='left']")[i].text.split("\n")[2].gsub(/[^0-9A-Za-z ]/, '').split(" ")[0]
        state = senate_page.css("td.contenttext[align='left']")[i].text.split("\n")[2].gsub(/[^0-9A-Za-z ]/, '').split(" ")[1]
        phone = senate_page.css("td.contenttext[align='left']")[i+1].text
        
        p = Politician.new(name, party, phone, state, 'Sen')
        reps[name] = p
        puts name
        $all_politicians.push([name, party, phone, state, 'Sen', false])
    end
    
    return reps
end

def jstreet_webscrap()
    url = 'http://jstreet.org/members-congress-condemned-bannons-appointment/'
    parse_page = Nokogiri::HTML(open(url))
    table = parse_page.css("nav.tableOfContents li")
    table.each { |li|
        temp = li.text.strip()[5..-1]
    }
end

def write_to_file()
    webscrap()
    csv_string = $all_politicians.map(&:to_csv).join
    file = 'politicians.csv'
    IO.write(file, csv_string)
end

# jstreet_webscrap()
write_to_file()
