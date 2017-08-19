class CreateThanks < ActiveRecord::Migration[5.1]
  def change
    create_table :thanks do |t|
      t.string :visitor_name, limit: 100
      t.string :teacher_name, limit: 100
      t.string :school_name, limit: 100
      t.text :body

      t.timestamps
    end
  end
end
