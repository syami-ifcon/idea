class AddForeignKeyListToUser < ActiveRecord::Migration[5.2]
  def change
  	add_reference :lists, :user, index: true
  end
end
