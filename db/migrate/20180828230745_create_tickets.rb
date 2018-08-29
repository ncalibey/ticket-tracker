class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :name, null: false
      t.string :body
      t.string :status, null: false, default: 'new'
      t.boolean :open, null: false, default: true
      t.belongs_to :project, foreign_key: true, null: false

      t.timestamps
    end
  end
end
