class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :urls
  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return false unless user
    return password == user.password
  end
end
