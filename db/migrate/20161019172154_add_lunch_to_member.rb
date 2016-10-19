class AddLunchToMember < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :lunch, :string
  end
end
