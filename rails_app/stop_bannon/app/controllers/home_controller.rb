class HomeController < ApplicationController

  def index
    full_states = { "Alabama" => "AL" , "Alaska" => "AK", "Arizona" => "AZ", "Arkansas" => "AR",
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
    "West Virginia" => "WV", "Wisconsin" => "WI", "Wyoming" => "WY" }.invert
    @politicians = Politician.order(:last_name)

    @states = Hash.new
    @politicians.each do |p|
      if @states.key?(full_states[p.state])
        @states[full_states[p.state]].push(p)
      else
        @states[full_states[p.state]] = [p]
      end
    end
    #TODO sort states
    #@states = @states.sort
  end
end
