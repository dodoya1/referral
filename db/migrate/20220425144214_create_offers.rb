class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.text :content
      t.string :user_id
      t.string :setting
      t.text :title

      t.timestamps
    end
  end
end
