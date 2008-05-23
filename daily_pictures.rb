#!/usr/bin/ruby
require 'rubygems'
require 'camping'
    
Camping.goes :Daily # name of application

module Daily::Controllers # handles url's
  class Index < R '/'
    def get
      @d = Date.today
      render :picture
    end
  end
end

module Daily::Views # handles views

  def layout
    html do
      head do
        title { "Daily Pictures" }
      end
      body { self << yield }
    end
  end

  def picture
    p "The current date is: #{@d.to_s}"
  end
  
end

if __FILE__ == $0
   puts Daily.run
end