class UrlsController < ApplicationController
  def show
      @url = Url.find_by_short params[:short]
  end

  def delete
  end

  def new
      @url = Url.new
  end

  def create
      @url = Url.new url_params
      if @url.valid?
          @url.save
          if not session.include? "urls"
              session["urls"] = []
          end
          session["urls"].append  @url.id
          redirect_to :urls
      else
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
