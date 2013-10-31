class Url < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  validates :long_url, format: { with: /\Ahttps?:\/\/.+\.\w{2,6}/, message: "invalid url"}

  before_save :url_shortener

  def url_shortener
    array = []
    array << ('1'..'10').to_a
    array << ('a'..'z').to_a
    array << ('A'..'Z').to_a
    array.flatten!
    short_url = []
    4.times do |i|
      short_url << array.sample
    end
    self.short_url ||= short_url.join('')
  end
end
