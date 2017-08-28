class AddVideoCategory < ActiveRecord::Migration
  def change
    add_column :videos, :category_id, :integer, after: :id
  end
end
