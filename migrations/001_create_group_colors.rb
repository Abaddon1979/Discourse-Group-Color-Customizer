# lib/discourse_group_color_customizer/migrations/001_create_group_colors.rb

# name: create-group-colors
# about: Adds group_colors table
# authors: Abaddon
# date: 2025-11-15

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
