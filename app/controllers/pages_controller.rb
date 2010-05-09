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
  
  def edit
    @page = Page.find(params[:id])
    render :layout => false
  end
  
  def update
    @page = Page.find(params[:id])
    
    if @page.update_attributes(params[:page]) && @page.fetch
      flash[:notice] = 'Page was successfully updated.'
      redirect_to pages_path
    else
      flash[:error] = 'Page was not updated.'
      render :action => "edit", :layout => false
    end
  end
  
end