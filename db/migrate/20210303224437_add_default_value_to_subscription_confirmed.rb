class AddDefaultValueToSubscriptionConfirmed < ActiveRecord::Migration[6.1]
  def change
    change_column_default :subscriptions, :confirmed, false
    change_column_default :courses, :status, 'Closed'
  end
end
