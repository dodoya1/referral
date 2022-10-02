class CreateRecommends < ActiveRecord::Migration[6.0]
  def change
    create_table :recommends do |t|
      t.string :user_from
      t.string :user_to
      t.text :content

      t.timestamps
    end
  end
end
