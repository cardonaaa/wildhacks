require 'csv'
class PoliticiansController < ApplicationController

  def new
  end

  def create(params)
    @politician = Politician.new(params)
    @politician.save
  end

end
