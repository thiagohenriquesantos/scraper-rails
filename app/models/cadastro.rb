class Cadastro < ApplicationRecord
   # Validations
  validate :nome, :url_twitter

  after_validation :capture_twitter_metadata, :create_short_url

  private

  def create_short_url
    return if self.short_url.present?
    #self.short_url = Googl.shorten(self.url_twitter, "213.57.23.49", "google_api_key")
  end

  def capture_twitter_metadata
    return if self.twitter_title.present?

    request = HTTParty.get(self.url_twitter)
    if (200..299).include?(request.code)
      parsed_page = Nokogiri::HTML(request.body)

      self.twitter_title = parsed_page.css('.ProfileHeaderCard-nameLink.u-textInheritColor').text
      self.twitter_description = parsed_page.css('.ProfileHeaderCard-bio.u-dir').text
      self.twitter_user = parsed_page.css('.ProfileHeaderCard-screennameLink .username.u-dir').text
    end
  end
end
