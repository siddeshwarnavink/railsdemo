class AddDateToRockets < ActiveRecord::Migration[7.1]
  def change
    add_column :rockets, :launch_at, :datetime
  end
end
