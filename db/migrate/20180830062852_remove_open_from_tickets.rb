class RemoveOpenFromTickets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tickets, :open
  end
end
