class Url < ActiveRecord::Base
    validates :url, presence: true

    validates :short, uniqueness: true
    
    before_save :create_short
    before_save :create_secret

    private

    def create_short
        short = self.short
        if short
            if short.strip() != ""
                return
            end
        end
        short = rand(36**4).to_s(36)
        while Url.find_by(short: short)
            short = rand(36**4).to_s(36)
        end
        self.short = short
    end

    def create_secret
        secret = self.secret
        if secret
            if secret.strip() != ""
                return
            end
        end
        secret = rand(36**4).to_s(36)
        while Url.find_by(secret: secret)
            secret = rand(36**4).to_s(36)
        end
        self.secret = secret
    end

end
