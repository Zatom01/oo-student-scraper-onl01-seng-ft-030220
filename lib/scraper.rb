require 'open-uri'
require 'nokogiri'
require 'pry'

url="https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"

class Scraper

  @@scraped_students=[]

  def self.scrape_index_page(index_url)
  
    html=open(index_url)
    doc=Nokogiri::HTML(html)
    element_arr=doc.css('div.student-card')

    # @url="students/"+element_arr.css('h4.student-name').text.split(" ").join("-")+".html"

    element_arr.each do |each|
      student_name=each.css('.student-name').text
      student_location=each.css('p.student-location').text
      student_url_profile="students/"+each.css('h4.student-name').text.split(" ").join("-")+".html"
      
      @@scraped_students << {:name=> student_name, :location=> student_location, :profile_url=> student_url_profile}
    end
    @@scraped_students
  end
end 

    # index_page = Nokogiri::HTML(open(index_url))
    # students = []
    # index_page.css("div.roster-cards-container").each do |card|
    #   card.css(".student-card a").each do |student|
    #     student_profile_link = "#{student.attr('href')}"
    #     student_location = student.css('.student-location').text
    #     student_name = student.css('.student-name').text
    #     students << {name: student_name, location: student_location, profile_url: student_profile_link}
    #   end
    # end
    # students
