class Api::V1::SubmissionsController < ApplicationController
  before_action :authenticate_user!

  def create
    submissions = params[:submissions]

    if submissions.nil?
      render json: {
        message: "Submissions not found"
      }, status: 404
      return
    end

    submissions.each do |submission|
      @submission = Submission.new(
        user_id: submission[:user_id],
        question_id: submission[:question_id],
        option_id: submission[:option_id]
      )
      @submission.save!
    end

    # check if all submissions were saved
    @submissions = Submission.where(user_id: current_user.id, question_id: submissions.pluck(:question_id))

    if @submissions.count == submissions.count
      render json: {
        message: "Submissions Saved!"
      }, status: :ok
    else
      # delete all submissions if one of them fails

      @submissions.destroy_all

      render json: {
        message: "Submissions was not saved!"
      }, status: :unprocessable_entity
    end

  end
end
