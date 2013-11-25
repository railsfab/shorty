class UrlsController < ApplicationController
  include UrlsHelper
  def show 
      @url = Url.find_by_short params[:short]
      if not @url
          not_found
      end

      redirect_to @url.url
  end

  def delete
      @url = Url.find_by_secret params[:secret]
      if not @url
          not_found
      end
      @url.delete
      flash[:notice] = "Url #{@url.url} deleted successfully from database"

      redirect_to :urls
  end

  def new
      @url = Url.new
  end

  def create
      @url = Url.new url_params
      captcha_valid = validate_captcha params
      if captcha_valid
        if @url.valid?
            @url.save
            flash[:notice] = "Url #{@url.url} successfully added to database"
            if not session.include? "urls"
                session["urls"] = []
            end
            session["urls"].append  @url.id
            redirect_to :urls
        else
            render :new
        end
      else
        @url.errors[:base] << "Entered CAPTCHA is wrong, please try again"
      render :new
      end
  end

  def edit
  end

  def update
  end

  def index
      @urls = Url.where id: session[:urls]
  end

  private

  def url_params
      puts params
      params.require(:url).permit(:url, :short)
  end

end
