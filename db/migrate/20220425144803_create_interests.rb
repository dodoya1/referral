class CreateInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :interests do |t|
      t.string :offer_id
      t.string :user_id

      t.timestamps
    end
  end
end
