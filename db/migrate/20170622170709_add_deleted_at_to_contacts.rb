class AddDeletedAtToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :deleted_at, :timestamp
  end
end
