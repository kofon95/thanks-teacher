class AddImagesToThanks < ActiveRecord::Migration[5.1]
  def change
    add_column :thanks, :images, :json, null: false, default: []
  end
end
