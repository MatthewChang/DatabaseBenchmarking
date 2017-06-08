class AddStiTable < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :type
      t.boolean :active
      t.string :name
      t.integer :number
      t.text :extra
      t.jsonb :data
    end

    create_table :bases do |t|
      t.string :type
      t.boolean :active
      t.string :name
      t.integer :number
      t.text :extra
      t.references :data_item
    end

    create_table :data_items do |t|
      t.string :title
      t.integer :value
      t.integer :store_id
    end

    create_table :single_tables do |t|
      t.string :type
      t.string :name
      t.boolean :active
      t.integer :number
      t.string :title
      t.integer :value
      t.text :extra
      t.references :data_item
      t.integer :store_id
      #100.times do |e|
        #t.integer SecureRandom.hex.to_s
      #end
    end

    add_index :bases, :data_item_id, using: :btree
    add_index :single_tables, :active, using: :btree
    add_index :bases, :active, using: :btree
    add_index :products, :active, using: :btree
  end
end
