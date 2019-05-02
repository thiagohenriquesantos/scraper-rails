class Cadastro < ApplicationRecord
   # Validations
  validate :nome, :url_twitter

  after_validation :capture_twitter_metadata, :create_short_url

  private

  def create_short_url
    return if self.short_url.present?

    request = HTTParty.post('https://www.encurtador.com.br/url-encurtada.php', :body => {u: 'www.google.com.br'})
    if (200..299).include?(request.code)
      parsed_page = Nokogiri::HTML(request.body)
      self.short_url = "http://#{parsed_page.css('#shortenurl').first["value"]}"
    end

    #request = HTTParty.post('https://www.encurtador.com.br/url-encurtada.php', :body => {u: "http://google.com.br"})
    #parsed_page = Nokogiri::HTML(request.body)
    #parsed_page.css('#shortenurl').first["value"]
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

  def search
    include PgSearch
  multisearchable against: [:twitter_title, :twitter_description, :twitter_user]
  end
end
