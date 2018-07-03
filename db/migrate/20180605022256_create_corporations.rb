class CreateCorporations < ActiveRecord::Migration[5.1]
  def change
    create_table :corporations do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
