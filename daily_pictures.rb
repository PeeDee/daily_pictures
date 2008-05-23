#!/usr/bin/ruby
require 'rubygems'
require 'camping'
    
Camping.goes :DailyPictures # name of application

module DailyPictures::Controllers # handles url's

  class Index < R '/'
    def get
      @d = Date.today
      render :picture
    end
  end

  class Picture < R '/picture/(\d+)/(\d+)/(\d+)'
    def get(year, month, day)
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
    p "The picture date is: #{@d.to_s}"
    
  end
  
end

if __FILE__ == $0
   puts DailyPictures.run
end