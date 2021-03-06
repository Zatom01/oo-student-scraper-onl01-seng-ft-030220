require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper
  
  def self.scrape_index_page(url)
    index_page = Nokogiri::HTML(open(url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location,profile_url: student_profile_link}
      end
    end
    students
  end 
  
  def self.scrape_profile_page(profile_url)
    profile={}
    doc=Nokogiri::HTML(open(profile_url))
    doc.css("div.social-icon-container a").each do |link|
      if link.attribute("href").value.include?("twitter")
        profile[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        profile[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        profile[:github] = link.attribute("href").value
      else
        profile[:blog] = link.attribute("href").value
      end
    end

    profile[:profile_quote] = doc.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    profile[:bio] = doc.css("div.main-wrapper.profile .description-holder p").text

    profile
    
  end 
end 

    
# @@scraped_students=[]

#   def self.scrape_index_page(index_url)
  
#     html=open(index_url)
#     doc=Nokogiri::HTML(html)
#     element_arr=doc.css('div.student-card')

#     # @url="students/"+element_arr.css('h4.student-name').text.split(" ").join("-")+".html"

#     element_arr.each do |each|
#       student_name=each.css('.student-name').text
#       student_location=each.css('p.student-location').text
#       student_url_profile="students/"+each.css('h4.student-name').text.split(" ").join("-")+".html"
      
#       @@scraped_students << {:name=> student_name, :location=> student_location, :profile_url=> student_url_profile}
#     end
#     @@scraped_students
#   end