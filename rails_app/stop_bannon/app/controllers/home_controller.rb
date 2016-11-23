require 'will_paginate/array'

class HomeController < ApplicationController

  def index

    @politicians = Politician.order(:last_name)

    @states = Hash.new
    @politicians.each do |p|
      if @states.key?(FULL_STATES[p.state])
        @states[FULL_STATES[p.state]].push(p)
      else
        @states[FULL_STATES[p.state]] = [p]
      end
    end
    #TODO sort states
    #@states = @states.sort
  end
end
