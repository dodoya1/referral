class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :requesting_id
      t.string :requested_id

      t.timestamps
    end
  end
end
