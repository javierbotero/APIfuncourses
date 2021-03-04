class AddDefultStatusToUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :status, 'Student'
  end
end
