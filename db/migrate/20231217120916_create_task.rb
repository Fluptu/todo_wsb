# frozen_string_literal: true

class CreateTask < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :body
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
