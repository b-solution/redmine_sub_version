class RemoveSubversions < ActiveRecord::Migration[5.2]
  def change
    remove_column :versions, :type, :string

  end
end
