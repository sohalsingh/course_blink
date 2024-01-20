class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :enroll, :unenroll, :lessons, :lesson_show]
  before_action :set_lesson, only: [:lesson_show]

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

    def unenroll
     return redirect_to request.referer, alert: "You can not enroll in this course" if !current_user.user?

     return redirect_to request.referer, alert: "You have not enrolled in this course" if !current_user.enrolled_in?(@course)

     current_user.enrollments.find_by(course_id: @course.id).destroy

     redirect_to request.referer, notice: "You have successfully un enrolled from this course"
    end

    def lessons
      @lessons = @course.lessons.order(:created_at)
      @enrollment = Enrollment.find_by(course_id: @course.id, user_id: current_user.id)
    end

    def lesson_show
      @lessons = @course.lessons.order(:created_at)

      # Next lesson after @lesson in @lessons
      @next_lesson = @lessons.where('created_at > ?', @lesson.created_at).order(:created_at).first
      @enrollment = Enrollment.find_by(course_id: @course.id, user_id: current_user.id)
    end

    private

    def set_lesson
      @lesson = Lesson.find_by(id: params[:lesson_id])

      if @lesson.nil?
        return redirect_to 404
      end
    end

    def set_course
      @course = Course.find_by(id: params[:id])

      if @course.nil?
        return redirect_to 404
      end
    end
end
