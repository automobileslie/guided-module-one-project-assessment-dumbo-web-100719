class CreatePoems < ActiveRecord::Migration[5.2]
  def change
    create_table :poems do |t|
      t.string :title
      t.string :author
      t.boolean :read
      t.integer :place_id
      t.integer :user_id
    end
  end
end
