class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :user_id
      t.text :current
      t.text :occupation
      t.text :introduction
      t.text :ability
      t.text :career

      t.timestamps
    end
  end
end
