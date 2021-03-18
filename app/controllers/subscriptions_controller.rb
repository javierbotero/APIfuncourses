class SubscriptionsController < ApplicationController
  before_action :authenticate
  include Helpers

  def create
    @user = User.find(params[:current_user_id])

    unless @user.courses.any?{ |c| c.id == params[:course_id].to_i }
      @subscription = @user.pending_subscriptions.build(course_id: params[:course_id])

      if @subscription.save
        render json: { pending_subscription: @subscription }
      else
        render json: { error: @subscription.errors.full_messages.join(' ') }, status: 404
      end
    else
      render json: { error: 'Trying to be a student in your course looks not good :D' }, status: 404
    end
  end

  def update
    @subscription = Subscription.find(params[:id])

    if match_user_ids(@subscription.course.teacher.id)
      if @subscription.update(confirmed: true)
        render json: { updated_subscription: @subscription }
      else
        render json: { error: @subscription.errors.full_messages.join(' ') }, status: 404
      end
    else
      render json: { error: 'You are not allowed to completed this action' }, status: 404
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])

    if match_user_ids(@subscription.course.teacher.id) || match_user_ids(@subscription.user_id)
      @subscription.destroy

      render json: { response: 'Subscription deleted' }
    else
      render json: { error: 'Not possible to delete this subscription' }, status: 404
    end
  end
end