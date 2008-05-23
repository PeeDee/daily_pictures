#!/usr/bin/ruby
require 'rubygems'
require 'camping'
    
Camping.goes :DailyPictures # name of application

module DailyPictures::Controllers # handles url's

  # handle root url, eg. http://localhost:3301/
  class Index < R '/' 
    def get
      @d = Date.today
      render :picture
    end
  end
 
  # handle specific date, eg. http://localhost:3301/picture/2006/10/20
  # also handle just year, or just year and month
  class Picture < R '/picture/(\d+)/(\d+)/(\d+)', '/picture/(\d+)/(\d+)', '/picture/(\d+)'
    def get(year = "2008", month = "12", day = "01")
      @d = Date.new(year.to_i, month.to_i, day.to_i)
      render :picture
    end
  end

end

module DailyPictures::Views # handles views

  def layout
    html do
      head do
        title { "Daily Pictures" }
      end
      body { self << yield }
    end
  end

  def picture
    "<p>The picture date is: #{@d.to_s}</p>"
    
  end
  
end

if __FILE__ == $0
   puts DailyPictures.run
end