class DialsController < ApplicationController
  def index
    @pages = Page.all
  end
end
