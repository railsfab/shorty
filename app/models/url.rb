class Url < ActiveRecord::Base
    validates :url, presence: true
    validate :url, :url_validation

    validates :short, uniqueness: {
        message: ": Short string you have entered is already taken,
         please enter some other or leave it empty to create random one for you"
    }
    
    before_save :create_short
    before_save :create_secret

    private

    def url_validation
        if self.url.index("http://") != 0 and self.url.index("https://") != 0
            errors[:base] << "Url should start with http or https"
        end
    end

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
