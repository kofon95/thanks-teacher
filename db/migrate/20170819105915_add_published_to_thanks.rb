class AddPublishedToThanks < ActiveRecord::Migration[5.1]
  def change
    add_column :thanks, :published, :boolean, default: false, null: false
  end
end
