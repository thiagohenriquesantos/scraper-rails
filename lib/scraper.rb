require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = 'www.twitter.com/thiago_santos'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  profiles = []
  profile_cards = parsed_page.css('div.ProfileHeaderCard') #card do Twitter
  profile_cards.each do |profile_card|
    profile = {
      nome: profile_cards.css('a.ProfileHeaderCard-nameLink').text,
      user: profile_cards.css('b.u-linkComplex-target').text,
      bio: profile_cards.css('p.ProfileHeaderCard-bio').text
     }
     profiles << profile
  end
  byebug
end

scraper
