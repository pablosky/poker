class AddFieldsToCroupier < ActiveRecord::Migration[5.0]
  def change
    create_table :croupiers do |t|
      t.string :token
      t.text :cards
    end
  end
end
