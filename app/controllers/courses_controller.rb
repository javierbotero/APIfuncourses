class CoursesController < ApplicationController
  def index
    @courses = Course.all

    render json: @courses
  end

  def create
    @user = User.find(params[:id])
    @course = @user.courses.build(course_params)

    if @course.save
      render json: @course
    else
      render json: @course.errors.full_messages, status: 404
    end
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors.full_messages, status: 404
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    render json: 'Course has been destroyed'
  end

  private

  def course_params
    params.require(:course).permit(:link, :provider, :title, :content, :status, :dates, :price)
  end
end
