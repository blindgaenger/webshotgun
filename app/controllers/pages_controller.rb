class PagesController < ApplicationController
  def index
    @pages = Page.all
  end
  
  def new
    @page = Page.new
    render :layout => false
  end

  def show
    @page = Page.find(params[:id])
    
    if stale?(:last_modified => @page.updated_at)
      render :layout => false  
    else
      response['Cache-Control'] = 'public, max-age=1'
    end
  end

  def create
    @page = Page.new(params[:page])
    
    if @page.save
      flash[:notice] = 'Page was successfully created.'
      redirect_to root_path
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
    
    if @page.update_attributes(params[:page]) && @page.refresh #TODO
      flash[:notice] = 'Page was successfully updated.'
      redirect_to root_path
    else
      flash[:error] = 'Page was not updated.'
      render :action => "edit", :layout => false
    end
  end
  
  def delete
    @page = Page.find(params[:id])
    render :layout => false
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to root_path
  end
  
  def refresh
    @page = Page.find(params[:id])
    @page.refresh
    head :ok
  end
  
  def image
    @page = Page.find(params[:id])
    
    render :content_type => 'image/png', :text => Proc.new {|response, output|
      output.write @page.image
    }
  end
  
end