# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord

    def self.factory (user, long_url)
        shortened_url = ShortenedUrl.new(long_url: long_url,user_id: user.id)
        shortened_url.short_url = ShortenedUrl.random_code
        shortened_url.save!
        shortened_url
    end

    def self.random_code
        random = false
        code = 0 
        until random
            code = SecureRandom.urlsafe_base64
            random = true unless ShortenedUrl.exists?(:short_url => code)
        end
        code
    end
    
    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
end
