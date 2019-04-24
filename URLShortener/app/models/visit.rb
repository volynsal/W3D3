class Visit < ApplicationRecord

    def self.record_visit!(user, shortened_url)
        new_visit = Visit.new(user: user.id, shortened_url: shortened_url)
        
        new_visit.save!
        new_visit
    end

end