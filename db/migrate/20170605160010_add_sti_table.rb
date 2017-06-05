class AddStiTable < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :type
      t.string :name
      t.integer :number
      t.jsonb :data
    end

    create_table :bases do |t|
      t.string :type
      t.string :name
      t.integer :number
      t.references :data_item
    end

    create_table :data_items do |t|
      t.string :title
      t.integer :value
      t.integer :store_id
    end

    add_index :bases, :data_item_id
  end
end
