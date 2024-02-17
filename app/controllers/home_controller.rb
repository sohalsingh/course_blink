class HomeController < ApplicationController
  def index
    if params[:query].present?
      @courses = Course.search_by_title_and_description(params[:query]).order(created_at: :desc).take(9)
      @enrolled_courses = current_user.courses.search_by_title_and_description(params[:query])
    else
      @courses = Course.order(created_at: :desc).take(9)
      @enrolled_courses = current_user.courses
    end
    @allow_search = true
  end
end
