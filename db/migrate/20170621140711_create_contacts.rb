class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :organization
      t.date :birthday
      t.references :user

      t.timestamps
    end
  end
end
