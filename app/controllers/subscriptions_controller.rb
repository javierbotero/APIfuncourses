class SubscriptionsController < ApplicationController
  before_action :authenticate
  include Helpers

  def create
    @user = User.find(params[:current_user_id])
    @subscription = @user.subscriptions.build(course_id: params[:course_id])

    if @subscription.save
      render json: @subscription
    else
      render json: @subscription.errors.full_messages, status: 404
    end
  end

  def update
    @subscription = Subscription.find(params[:id])

    if match_user_ids(@subscription.course.teacher.id) && @subscription.update(confirmed: true)
      render json: 'The subscription was accepted'
    else
      render json: 'You are not allowed to completed this action', status: 404
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])

    if match_user_ids(@subscription.course.teacher.id) || match_user_ids(@subscription.user_id)
      @subscription.destroy

      render json: 'Subscription deleted'
    else
      render json: 'Not possible to delete this subscription', status: 404
    end
  end
end