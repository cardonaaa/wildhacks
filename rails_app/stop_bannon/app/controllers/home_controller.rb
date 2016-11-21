class HomeController < ApplicationController
  def index
    @politicians = Politician.order(:last_name)
  end
end
