class PagesController < ApplicationController
  before_action :require_creator, only: [:home]
  def home; end

  def about; end

  private
  def require_creator
    access_denied_homepage if logged_in?
  end
end
