class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :link
      t.string :provider
      t.string :title
      t.text :content
      t.integer :teacher_id
      t.string :status
      t.datetime :dates
      t.integer :price

      t.timestamps
    end
  end
end
