class CoursesController < ApplicationController
  before_action :authenticate, only: [:create, :update, :destroy]
  include Helpers

  def index
    @courses = Course.all

    render json: @courses
  end

  def create
    @user = User.find(params[:current_user_id])
    @course = @user.courses.build(course_params)

    if @course.save
      render json: @course
    else
      render json: @course.errors.full_messages, status: 404
    end
  end

  def update
    @course = Course.find(params[:id])

    if match_user_ids(@course.teacher.id)
      if @course.update(course_params)
        render json: @course
      else
        render json: @course.errors.full_messages, status: 404
      end
    else
      render json: 'You are not allowed to do this action', status: 404
    end
  end

  def destroy
    @course = Course.find_by(token: params[:token])
    if match_user_ids(@course.teacher.id)
      @course.destroy

      render json: 'Course has been destroyed'
    else
      render json: 'You are not allowed to do this action', status: 404
    end
  end

  private

  def course_params
    params.require(:course).permit(:link, :provider, :title, :content, :status, :dates, :price)
  end
end
