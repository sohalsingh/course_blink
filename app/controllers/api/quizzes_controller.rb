class Api::QuizzesController < ApplicationController
    before_action :set_lesson

    def generate_quiz
      @quiz = @lesson.quizzes.create
      render json: @quiz, status: :created
    end
  
    private
  
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end
end
