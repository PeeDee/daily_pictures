#!/usr/bin/ruby
require 'rubygems'
require 'camping'
    
Camping.goes :DailyPictures # name of application

module DailyPictures::Controllers # handles url's

  # handle root url, eg. http://localhost:3301/
  class Index < R '/' 
    def get
      @date = Date.today
      render :picture
    end
  end
 
  # handle specific date, eg. http://localhost:3301/picture/2006/10/20
  # also handle just year, or just year and month
  class Picture < R '/picture/(\d+)/(\d+)/(\d+)', '/picture/(\d+)/(\d+)', '/picture/(\d+)'
    def get(year = "2008", month = "01", day = "01")
      @date = Date.new(year.to_i, month.to_i, day.to_i)
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
    require 'redcloth' # http://hobix.com/textile/ 
    r = RedCloth.new "h1=. Pictures\n\n"
    r << "p=. *The picture date* is: _#{@date.to_s}_\n\n"
    #r << picture_links
    6.downto(0) do |i|
      d = @date - i
      r << "p=. !#{d.strftime(DailyPictureSource)}!\n\n" 
    end
    #r << picture_links
    r.to_html
  end 
  
  def picture_links
    # Prev Week  Prev Day  From x to y Next Week Next Day
    ""
  end
end

if __FILE__ == $0
   puts DailyPictures.run
end

