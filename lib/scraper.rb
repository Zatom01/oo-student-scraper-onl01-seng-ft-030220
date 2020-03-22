require 'open-uri'
require 'nokogiri'
require 'pry'

url="https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"

class Scraper

  @@scraped_students=[]

  def self.scrape_index_page(index_url)
    

    html=open(index_url)
    doc=Nokogiri::HTML(html)
    @element_arr=doc.css('div.student-card')
    @profile={}

    # @url="students/"+element_arr.css('h4.student-name').text.split(" ").join("-")+".html"

    @element_arr.each do |each|

      @profile={:name=>each.css('h4.student-name').text,
      :location=>each.css('p.student-location').text,
      :profile_url=>"students/"+each.css('h4.student-name').text.split(" ").join("-")+".html"}

      @@scraped_students << @profile

    end

    
    return @@scraped_students
  end


end
