class HomeController < ApplicationController
  def index
    @courses = Course.order(created_at: :desc).take(9)
    @enrolled_courses = current_user.courses
  end
end
