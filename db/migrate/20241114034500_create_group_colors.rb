# db/migrate/20241114034500_create_group_colors.rb

class CreateGroupColors < ActiveRecord::Migration[6.0]
  def change
    create_table :group_colors do |t|
      t.integer :group_id, null: false
      t.string :color, null: false, default: "#000000"
      t.integer :rank, null: false, default: 1

      t.timestamps
    end

    add_index :group_colors, :group_id, unique: true
  end
end