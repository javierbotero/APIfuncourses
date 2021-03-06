class CoursesController < ApplicationController
  def index
    @courses = Course.all

    render json: @courses
  end

  def create
    @user = User.find(params[:id])
    @course = @user.courses.build(course_params)
  end

  def update
  end

  def delete
  end

  private

  def course_params
    params.require(:course).permit(:link, :provider, :title, :content, :status)
  end
end
