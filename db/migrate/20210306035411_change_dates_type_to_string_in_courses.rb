class ChangeDatesTypeToStringInCourses < ActiveRecord::Migration[6.1]
  def change
    change_column :courses, :dates, :string
  end
end
