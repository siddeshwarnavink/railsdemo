class CreateRockets < ActiveRecord::Migration[7.1]
  def change
    create_table :rockets do |t|
      t.string :Name
      t.float :Price
      t.string :Image

      t.timestamps
    end
  end
end
