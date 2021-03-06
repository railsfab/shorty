module UrlsHelper
    require 'uri'
    require 'net/http'
    def validate_captcha params
        data = {
            challenge: params[:recaptcha_challenge_field],
            response: params[:recaptcha_response_field],
            privatekey: ENV["SHORTY_RECAPTCHA_SECRET"],
            remoteip: request.remote_ip
        }
        url = "http://www.google.com/recaptcha/api/verify"
        res = Net::HTTP.post_form(URI.parse(url), data)
        return res.body.split("\n")[0] == "true"

    end
end
