class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :handle_name
      t.string :birthday
      t.string :address
      t.text :profile

      t.timestamps
    end
  end
end
