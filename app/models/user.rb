class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.gsub(/\s+/, '-').downcase
  end

  def self.find_by_slug(slug)
    User.all.select{|user| user.slug == slug}[0]
  end
end
