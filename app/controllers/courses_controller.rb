class CoursesController < ApplicationController
  before_action :authenticate, only: %i[create update destroy]
  include Helpers

  def index
    @courses = Course.all

    render json: { courses: @courses }
  end

  def create
    @user = User.find(params[:current_user_id])
    @course = @user.courses.build(course_params)
    if params[:main] && params[:main][:io]
      @course.main.attach(
        io: StringIO.new(Base64.decode64(params[:main][:io])),
        filename: params[:main][:filename],
        content_type: 'image/jpg'
      )
    end
    images_to_blobs(@course, params[:images]) if params[:images].length.positive? && !params[:images][0].is_a?(String)
    if @course.save
      render json: { course: @course }
    else
      render json: { error: @course.errors.full_messages.join(' ') }, status: 404
    end
  end

  def update
    @course = Course.find(params[:id])

    if match_user_ids(@course.teacher.id)
      if @course.update(course_params)
        render json: { course: @course }
      else
        render json: { error: @course.errors.full_messages.join(' ') }, status: 404
      end
    else
      render json: { error: 'You are not allowed to do this action' }, status: 404
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if match_user_ids(@course.teacher.id)
      @course.destroy

      render json: { response: 'Course has been destroyed' }
    else
      render json: { error: 'You are not allowed to do this action' }, status: 404
    end
  end

  private

  def course_params
    params.require(:course).permit(:link, :provider, :title, :content, :status, :dates, :price)
  end
end
