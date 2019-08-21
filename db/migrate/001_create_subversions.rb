class CreateSubversions < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :type, :string
    add_column :versions, :parent_id, :integer
  end
end
