class HomeController < ApplicationController
  def index
    if params[:query].present?
      @courses = Course.where("title like ?", "%#{params[:query]}%").order(created_at: :desc).take(9)
      @enrolled_courses = current_user.courses.where("title like ?", "%#{params[:query]}%")
    else
      @courses = Course.order(created_at: :desc).take(9)
      @enrolled_courses = current_user.courses
    end
    @allow_search = true
  end
end
