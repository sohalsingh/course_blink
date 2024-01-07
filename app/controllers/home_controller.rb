class HomeController < ApplicationController
  def index
    @courses = Course.order(created_at: :desc).take(9)
  end
end
