class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def username=(username)
    self.slug = username.downcase.gsub(/[^a-z0-9\s]/, '').gsub(' ', '-')
    super(username)
  end
end
