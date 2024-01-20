class Api::V1::LessonHistoryController < ApplicationController
  before_action :set_enrollment
  before_action :set_lesson

  def view_lesson

    @existing_lesson_history = LessonHistory.where(
      lesson_id: @lesson.id, enrollment_id: @enrollment.id
    ).first

    if @existing_lesson_history.present?
      render json: {
        message: "Lesson History already exists!"
      }, status: 400
      return
    end

    @lesson_history = LessonHistory.new(
      lesson_id: @lesson.id, enrollment_id: @enrollment.id
    )

    if @lesson_history.save!
      render json: {
        message: "Lesson History Saved!"
      }, status: :ok
    else
      render json: {
        message: "Lesson History was not saved!"
      }, status: :unprocessable_entity
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find_by(id: params[:lesson_id])

    if @lesson.nil?
      render json: {
        message: "Lesson not found"
      }, status: 404
      return
    end
  end

  def set_enrollment
    @enrollment = Enrollment.find_by(id: params[:enrollment_id])

    if @enrollment.nil?
      render json: {
        message: "Enrollment not found"
      }, status: 404
      return
    end
  end
end
