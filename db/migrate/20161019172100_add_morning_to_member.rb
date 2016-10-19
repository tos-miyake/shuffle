class AddMorningToMember < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :morning, :string
  end
end
