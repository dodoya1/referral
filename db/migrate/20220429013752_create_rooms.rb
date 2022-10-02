class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :user_to
      t.string :user_from

      t.timestamps
    end
  end
end
