class PagesController < ApplicationController
  def index
    @pages = Page.all
  end
  
  def new
    @page = Page.new
    render :layout => false
  end

  def create
    @page = Page.new(params[:page])
    
    if @page.save
      flash[:notice] = 'Page was successfully created.'
      redirect_to pages_path
    else
      flash[:error] = 'Page was not created.'
      render :action => "new", :layout => false
    end
  end
  
end
