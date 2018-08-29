class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :creator, foreign_key: { to_table: :users }, null: false
      t.belongs_to :ticket, foregin_key: true, null: false
      t.string :body

      t.timestamps
    end
  end
end
