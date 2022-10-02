class CreateConnects < ActiveRecord::Migration[6.0]
  def change
    create_table :connects do |t|
      t.string :connecting_id
      t.string :connected_id

      t.timestamps
    end
  end
end
