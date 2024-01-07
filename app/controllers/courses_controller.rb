class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :enroll, :lessons]

    def index
        @courses = Course.all
    end

    def show
    end


    def enroll
     return redirect_to request.referer, alert: "You can not enroll in this course" if !current_user.user?

     return redirect_to request.referer, alert: "You are already enrolled in this course" if current_user.enrolled_in?(@course)

     current_user.enrollments.create(course: @course)

     redirect_to request.referer, notice: "You have successfully enrolled in this course"

    end

    def lessons

    end

    private

    def set_course
      @course = Course.find_by(id: params[:id])

      if @course.nil?
        return redirect_to 404
      end
    end
end
